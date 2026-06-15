package vn.edu.nlu.fit.be.service;

import vn.edu.nlu.fit.be.dao.CertificateDao;
import vn.edu.nlu.fit.be.dao.OrderSignDao;
import vn.edu.nlu.fit.be.dao.OrderSignatureDao;
import vn.edu.nlu.fit.be.dto.SignVerifyResult;
import vn.edu.nlu.fit.be.dto.SignedOrderReq;
import vn.edu.nlu.fit.be.model.OrderSign;
import vn.edu.nlu.fit.be.model.OrderSignature;
import vn.edu.nlu.fit.be.model.OrderStatus;
import vn.edu.nlu.fit.be.model.Certificate;

import javax.naming.ldap.LdapName;
import javax.naming.ldap.Rdn;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.security.Signature;
import java.security.cert.*;
import java.util.Base64;
import java.util.List;
import java.util.Optional;
import java.util.Set;

public class SignVerifyService {

    private static final String DEFAULT_CA_CERT_RESOURCE = "ca/ca_certificate.pem";
    private static final String CA_CERT_PATH_PROPERTY = "furniro.ca.cert.path";
    private static final String DEFAULT_SIGNATURE_ALGORITHM = "SHA256withRSA";
    private static final Set<String> ALLOWED_SIGNATURE_ALGORITHMS = Set.of("SHA256withRSA");

    private final OrdersService ordersService = new OrdersService();
    private final OrderSigningService orderSigningService = new OrderSigningService();
    private final OrderSignDao orderSignDao = new OrderSignDao();
    private final CertificateDao certificateDao = new CertificateDao();
    private final OrderSignatureDao signatureDao = new OrderSignatureDao();

    public SignVerifyResult verifySignedOrder(SignedOrderReq signedOrder, int accountId) throws Exception {
        SignVerifyResult result = new SignVerifyResult();

        try {
            validateSignedOrderRequest(signedOrder);
        } catch (Exception e) {
            return fail(result, "Invalid request: " + e.getMessage());
        }

        OrderSign sign = orderSignDao.findByOrderId(signedOrder.getOrderId());
        if (sign == null) {
            return fail(result, "No sign snapshot found for order");
        }

        if (sign.getAccountId() != accountId) {
            return fail(result, "Order does not belong to this account");
        }

        if (!sign.getOrderHash().equals(signedOrder.getOrderHash())) {
            persistAndMark(
                    signedOrder,
                    accountId,
                    sign,
                    "FAIL_HASH_MISMATCH",
                    "Order hash does not match stored snapshot",
                    "TAMPERED",
                    OrderStatus.TAMPERED
            );
            return fail(result, "Order hash mismatch");
        }

        Optional<Certificate> certOpt = certificateDao.findByCertIdAccID(signedOrder.getCertificateId(), accountId);
        if (certOpt.isEmpty()) {
            persistAndMark(
                    signedOrder,
                    accountId,
                    sign,
                    "FAIL_NO_CERT",
                    "No certificate for account",
                    "CERTIFICATE_INVALID",
                    OrderStatus.CERTIFICATE_INVALID
            );
            return fail(result, "No certificate for account");
        }

        Certificate userCert = certOpt.get();
        X509Certificate x509;

        try {
            x509 = validateCertificate(userCert, sign, accountId);
        } catch (Exception e) {
            persistAndMark(
                    signedOrder,
                    accountId,
                    sign,
                    "FAIL_CERTIFICATE_INVALID",
                    e.getMessage(),
                    "CERTIFICATE_INVALID",
                    OrderStatus.CERTIFICATE_INVALID
            );
            return fail(result, "Certificate invalid: " + e.getMessage());
        }

        try {
            if (!verifySignature(signedOrder, sign, x509)) {
                persistAndMark(
                        signedOrder,
                        accountId,
                        sign,
                        "FAIL_INVALID_SIGNATURE",
                        "Invalid signature",
                        "SIGNATURE_INVALID",
                        OrderStatus.SIGNATURE_INVALID
                );
                return fail(result, "Signature verification failed");
            }
        } catch (Exception e) {
            persistAndMark(
                    signedOrder,
                    accountId,
                    sign,
                    "FAIL_SIGNATURE_ERROR",
                    e.getMessage(),
                    "SIGNATURE_INVALID",
                    OrderStatus.SIGNATURE_INVALID
            );
            return fail(result, "Signature verification error: " + e.getMessage());
        }

        String currentOrderHash = orderSigningService.calculateCurrentOrderHash(
                signedOrder.getOrderId(),
                accountId,
                sign.getSnapshotJson()
        );

        String currentSnapshot = orderSigningService.buildCurrentSnapshotForDebug(
                signedOrder.getOrderId(),
                accountId,
                sign.getSnapshotJson()
        );
        System.out.println("SNAPSHOT DEBUG:");
        System.out.println("storedSnapshot=" + sign.getSnapshotJson());
        System.out.println("currentSnapshot=" + currentSnapshot);
        System.out.println("CURRENT HASH DEBUG:");
        System.out.println("storedHash=" + sign.getOrderHash());
        System.out.println("currentHash=" + currentOrderHash);
        System.out.println("hashMatched=" + sign.getOrderHash().equals(currentOrderHash));

        if (!sign.getOrderHash().equals(currentOrderHash)) {
            persistAndMark(
                    signedOrder,
                    accountId,
                    sign,
                    "FAIL_TAMPERED",
                    "Current order data does not match original snapshot hash",
                    "TAMPERED",
                    OrderStatus.TAMPERED
            );
            return fail(result, "Order data has been changed");
        }

        persistAndMark(
                signedOrder,
                accountId,
                sign,
                "VERIFIED",
                "OK",
                "VERIFIED",
                OrderStatus.VERIFIED
        );

        result.setSuccess(true);
        result.setMessage("Signature verified");
        return result;
    }

    private X509Certificate validateCertificate(Certificate userCert,
                                                OrderSign sign,
                                                int accountId) throws Exception {
        X509Certificate userX509 = parsePemCertificate(userCert.getCertificatePem());
        X509Certificate caX509 = loadCACertificate();

        verifyCertSignedByCa(userX509, caX509);
        verifyCertToAccount(userX509, accountId);
        verifyCertStatusForOrder(userCert, sign);

        return userX509;
    }

    private boolean verifySignature(SignedOrderReq signedOrder,
                                    OrderSign sign,
                                    X509Certificate userCertificate) throws Exception {
        String algorithm = resolveSignAlgo(signedOrder.getSignatureAlgorithm());

        Signature verifier = Signature.getInstance(algorithm);
        verifier.initVerify(userCertificate.getPublicKey());
        verifier.update(sign.getOrderHash().getBytes(StandardCharsets.UTF_8));

        byte[] signatureBytes = Base64.getMimeDecoder().decode(signedOrder.getSignatureValue().trim());
        boolean verified = verifier.verify(signatureBytes);

        System.out.println("VERIFY DEBUG:");
        System.out.println("orderId=" + signedOrder.getOrderId());
        System.out.println("certificateId=" + signedOrder.getCertificateId());
        System.out.println("dbHash=" + sign.getOrderHash());
        System.out.println("fileHash=" + signedOrder.getOrderHash());
        System.out.println("signatureBytes=" + signatureBytes.length);
        System.out.println("verified=" + verified);

        return verified;
    }

    private void validateSignedOrderRequest(SignedOrderReq req) {
        if (req == null) {
            throw new IllegalArgumentException("Signed order request must not be null");
        }
        if (req.getOrderId() <= 0) {
            throw new IllegalArgumentException("Invalid order ID");
        }
        if (req.getOrderHash() == null || req.getOrderHash().isBlank()) {
            throw new IllegalArgumentException("Order hash must not be blank");
        }
        if (req.getSignatureValue() == null || req.getSignatureValue().isBlank()) {
            throw new IllegalArgumentException("Signature value must not be blank");
        }
        if (req.getCertificateId() <= 0) {
            throw new IllegalArgumentException("Invalid certificate ID");
        }
    }

    private void verifyCertToAccount(X509Certificate cert, int accountId) throws Exception {
        String subject = cert.getSubjectX500Principal().getName();
        LdapName ldapName = new LdapName(subject);

        for (Rdn rdn : ldapName.getRdns()) {
            if ("UID".equalsIgnoreCase(rdn.getType())) {
                int certAccountId = Integer.parseInt(rdn.getValue().toString());
                if (certAccountId != accountId) {
                    throw new SecurityException("Certificate does not belong to this account");
                }
                return;
            }
        }

        throw new SecurityException("Certificate does not contain account ID");
    }

    private void verifyCertSignedByCa(X509Certificate userCert, X509Certificate caCert) throws Exception {
        userCert.checkValidity();

        TrustAnchor trustAnchor = new TrustAnchor(caCert, null);
        PKIXParameters params = new PKIXParameters(Set.of(trustAnchor));
        params.setRevocationEnabled(false);

        CertificateFactory cf = CertificateFactory.getInstance("X.509");
        CertPath certPath = cf.generateCertPath(List.of(userCert));

        CertPathValidator validator = CertPathValidator.getInstance("PKIX");
        validator.validate(certPath, params);
    }

    private void verifyCertStatusForOrder(Certificate cert, OrderSign orderSign) {
        String status = cert.getStatus() == null ? "" : cert.getStatus().toString().trim().toUpperCase();

        if ("ACTIVE".equals(status)) {
            return;
        }

        if ("LOST_KEY".equals(status)) {
            if (cert.getLostAt() == null) {
                throw new SecurityException("Lost-key certificate does not contain lostAt");
            }
            if (orderSign.getCreatedAt() != null && orderSign.getCreatedAt().after(cert.getLostAt())) {
                throw new SecurityException("Order was created after key was reported lost");
            }
            return;
        }

        if ("REVOKED".equals(status)) {
            throw new SecurityException("Certificate has been revoked");
        }

        throw new SecurityException("Certificate is not valid for verification");
    }

    private void persistAndMark(SignedOrderReq req,
                                int accountId,
                                OrderSign sign,
                                String verifyStatus,
                                String verifyMessage,
                                String orderSignStatus,
                                OrderStatus orderStatus) throws Exception {
        persistSignatureRecord(req, accountId, sign, verifyStatus, verifyMessage);
        orderSignDao.updateStatus(sign.getOrderSignId(), orderSignStatus);
        ordersService.updateStatus(req.getOrderId(), orderStatus);
    }

    private void persistSignatureRecord(SignedOrderReq req,
                                        int accountId,
                                        OrderSign sign,
                                        String status,
                                        String message) throws Exception {
        try {
            String rawAlgo = req.getSignatureAlgorithm();

            OrderSignature orderSignature = new OrderSignature();
            orderSignature.setOrderId(req.getOrderId());
            orderSignature.setAccountId(accountId);
            orderSignature.setCertificateId(req.getCertificateId());
            orderSignature.setOrderHash(req.getOrderHash());
            orderSignature.setSignatureValue(req.getSignatureValue());
            orderSignature.setSignatureAlgorithm(
                    rawAlgo == null || rawAlgo.isBlank()
                            ? DEFAULT_SIGNATURE_ALGORITHM
                            : rawAlgo.trim()
            );
            orderSignature.setSignedPayloadJson(null);
            orderSignature.setVerifyStatus(status);
            orderSignature.setVerifyMessage(message);

            signatureDao.insert(orderSignature);
        } catch (Exception e) {
            throw new Exception("Failed to persist signature record: " + e.getMessage(), e);
        }
    }

    private X509Certificate parsePemCertificate(String pem) throws Exception {
        String base64 = pem
                .replace("-----BEGIN CERTIFICATE-----", "")
                .replace("-----END CERTIFICATE-----", "")
                .replaceAll("\\s+", "");
        byte[] der = Base64.getDecoder().decode(base64);

        CertificateFactory cf = CertificateFactory.getInstance("X.509");
        return (X509Certificate) cf.generateCertificate(new ByteArrayInputStream(der));
    }

    private String resolveSignAlgo(String signAlgo) {
        if (signAlgo == null || signAlgo.isBlank()) {
            return DEFAULT_SIGNATURE_ALGORITHM;
        }

        String normalizedAlgo = signAlgo.trim().replace("-", "");
        if (!ALLOWED_SIGNATURE_ALGORITHMS.contains(normalizedAlgo)) {
            throw new SecurityException("Unsupported signature algorithm: " + normalizedAlgo);
        }

        return normalizedAlgo;
    }

    private X509Certificate loadCACertificate() throws Exception {
        String caCertPath = System.getProperty(CA_CERT_PATH_PROPERTY);

        if (caCertPath != null && !caCertPath.isBlank()) {
            try (InputStream in = Files.newInputStream(Path.of(caCertPath))) {
                return parsePemCertificate(new String(in.readAllBytes(), StandardCharsets.UTF_8));
            }
        }

        Path localCaCertPath = CertificateService.resolveDataDir()
                .resolve("ca")
                .resolve("ca_certificate.pem");
        if (Files.exists(localCaCertPath)) {
            try (InputStream in = Files.newInputStream(localCaCertPath)) {
                return parsePemCertificate(new String(in.readAllBytes(), StandardCharsets.UTF_8));
            }
        }

        ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
        try (InputStream in = classLoader.getResourceAsStream(DEFAULT_CA_CERT_RESOURCE)) {
            if (in == null) {
                throw new IllegalStateException("CA certificate not found in classpath: " + DEFAULT_CA_CERT_RESOURCE);
            }
            return parsePemCertificate(new String(in.readAllBytes(), StandardCharsets.UTF_8));
        }
    }

    private SignVerifyResult fail(SignVerifyResult result, String message) {
        result.setSuccess(false);
        result.setMessage(message);
        return result;
    }
}
