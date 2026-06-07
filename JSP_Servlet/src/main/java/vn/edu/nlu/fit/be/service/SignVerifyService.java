package vn.edu.nlu.fit.be.service;

import vn.edu.nlu.fit.be.dao.CertificateDao;
import vn.edu.nlu.fit.be.dao.OrderSignDao;
import vn.edu.nlu.fit.be.dao.OrderSignatureDao;
import vn.edu.nlu.fit.be.dto.SignVerifyResult;
import vn.edu.nlu.fit.be.dto.SignedOrderReq;
import vn.edu.nlu.fit.be.model.OrderSign;
import vn.edu.nlu.fit.be.model.OrderSignature;
import vn.edu.nlu.fit.be.model.OrderStatus;
import vn.edu.nlu.fit.be.model.UserCertificate;

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

    //Constants
    private static final String DEFAULT_CA_CERT_RESOURCE = "ca/ca_certificate.pem";
    private static final String CA_CERT_PATH_PROPERTY = "furniro.ca.cert.path";
    private static final String DEFAULT_SIGNATURE_ALGORITHM = "SHA256withRSA";
    private static final Set<String> ALLOWED_SIGNATURE_ALGORITHMS = Set.of(
            "SHA256withRSA"
    );
    private final OrdersService ordersService = new OrdersService();

    private final OrderSignDao orderSignDao = new OrderSignDao();
    private final CertificateDao certificateDao = new CertificateDao();
    private final OrderSignatureDao signatureDao = new OrderSignatureDao();

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

    private void verifyCertSignedByCa(
            X509Certificate userCert,
            X509Certificate caCert
    ) throws Exception {
        userCert.checkValidity();

        TrustAnchor trustAnchor = new TrustAnchor(caCert, null);

        PKIXParameters params = new PKIXParameters(java.util.Set.of(trustAnchor));
        params.setRevocationEnabled(false);

        CertificateFactory cf = CertificateFactory.getInstance("X.509");
        CertPath certPath = cf.generateCertPath(List.of(userCert));

        CertPathValidator validator = CertPathValidator.getInstance("PKIX");
        validator.validate(certPath, params);
    }

    private void verifyCertStatusForOrder(
            UserCertificate cert,
            OrderSign orderSign
    ) {
        String status = cert.getStatus().toString();

        if ("ACTIVE".equals(status)) {
            return;
        }

        if ("LOST_KEY".equals(status)) {
            if (cert.getLostAt() == null) {
                throw new SecurityException("Lost-key certificate does not contain lostAt");
            }
            /*
             * Nếu đơn hàng được tạo sau thời điểm báo mất khóa
             * thì không cho verify bằng key cũ nữa.
             */
            if (orderSign.getCreatedAt().after(cert.getLostAt())) {
                throw new SecurityException("Order was created after key was reported lost");
            }
            /*
             * Đơn tạo trước thời điểm mất khóa vẫn có thể verify lịch sử.
             */
            return;
        }

        if ("REVOKED".equals(status)) {
            throw new SecurityException("Certificate has been revoked");
        }

        throw new SecurityException("Certificate is not valid for verification");
    }

    private void persistSignatureRecord(SignedOrderReq req, int accountId, OrderSign sign, String status, String
            message) throws Exception {
        try {
            String rawAlgo = req.getSignatureAlgorithm();
            OrderSignature orderSign = new OrderSignature();
            orderSign.setOrderId(req.getOrderId());
            orderSign.setAccountId(accountId);
            orderSign.setCertificateId(req.getCertificateId());
            orderSign.setOrderHash(req.getOrderHash());
            orderSign.setSignatureValue(req.getSignatureValue());

            orderSign.setSignatureAlgorithm(
                    rawAlgo == null || rawAlgo.isBlank()
                            ? DEFAULT_SIGNATURE_ALGORITHM
                            : rawAlgo.trim()
            );

            orderSign.setSignedPayloadJson(null);
            orderSign.setVerifyStatus(status);
            orderSign.setVerifyMessage(message);
            signatureDao.insert(orderSign);
        } catch (Exception e) {
            throw new Exception("Failed to persist signature record: " + e.getMessage());
        }
    }


    private X509Certificate parsePemCertificate(String pem) throws Exception {
        String base64 = pem.replace("-----BEGIN CERTIFICATE-----", "").replace("-----END CERTIFICATE-----", "").replaceAll("\\s+", "");
        byte[] der = Base64.getDecoder().decode(base64);
        CertificateFactory cf = CertificateFactory.getInstance("X.509");
        return (X509Certificate) cf.generateCertificate(new ByteArrayInputStream(der));
    }


    public SignVerifyResult verifySignedOrder(SignedOrderReq signedOrder, int accountId) throws Exception {
        SignVerifyResult res = new SignVerifyResult();
        try {
            validateSignedOrderRequest(signedOrder);
        } catch (Exception e) {
            res.setSuccess(false);
            res.setMessage("Invalid request: " + e.getMessage());
            return res;
        }

        OrderSign sign = orderSignDao.findByOrderId(signedOrder.getOrderId());
        if (sign == null) {
            res.setSuccess(false);
            res.setMessage("No sign snapshot found for order");
            return res;
        }
        if (sign.getAccountId() != accountId) {
            res.setSuccess(false);
            res.setMessage("Order does not belong to this account");
            return res;
        }

        if (!sign.getOrderHash().equals(signedOrder.getOrderHash())) {
            res.setSuccess(false);
            res.setMessage("Order hash mismatch");
            persistSignatureRecord(
                    signedOrder,
                    accountId,
                    sign,
                    "FAIL_HASH_MISMATCH",
                    "Order hash does not match snapshot"
            );
            return res;
        }

        Optional<UserCertificate> certOpt = certificateDao.findByCertIdAccID(signedOrder.getCertificateId(), accountId);
        if (certOpt.isEmpty()) {
            res.setSuccess(false);
            res.setMessage("No certificate for account");
            persistSignatureRecord(
                    signedOrder,
                    accountId,
                    sign,
                    "FAIL_NO_CERT",
                    "No certificate"
            );
            return res;
        }

        UserCertificate userCert = certOpt.get();

        try {
            X509Certificate x509 = parsePemCertificate(userCert.getCertificatePem());

            X509Certificate caCert = loadCACertificate();

            verifyCertSignedByCa(x509, caCert);
            verifyCertToAccount(x509, accountId);
            verifyCertStatusForOrder(userCert, sign);

            String algorithm = resolveSignaAlgo(signedOrder.getSignatureAlgorithm());

            Signature verifier = Signature.getInstance(algorithm);
            verifier.initVerify(x509.getPublicKey());

            byte[] payload = sign.getOrderHash()
                    .getBytes(StandardCharsets.UTF_8);

            verifier.update(payload);

            byte[] signBytes = Base64.getDecoder()
                    .decode(signedOrder.getSignatureValue());

            boolean isVerifiedOK = verifier.verify(signBytes);

            if (isVerifiedOK) {
                res.setSuccess(true);
                res.setMessage("Signature verified");

                persistSignatureRecord(
                        signedOrder,
                        accountId,
                        sign,
                        "VERIFIED",
                        "OK"
                );

                orderSignDao.updateStatus(sign.getOrderSignId(), "VERIFIED");
                ordersService.updateStatus(signedOrder.getOrderId(), OrderStatus.PENDING);

            } else {
                res.setSuccess(false);
                res.setMessage("Signature verification failed");

                persistSignatureRecord(
                        signedOrder,
                        accountId,
                        sign,
                        "FAIL_INVALID_SIG",
                        "Invalid signature"
                );
                orderSignDao.updateStatus(sign.getOrderSignId(), "FAIL_INVALID_SIGNATURE");
                ordersService.updateStatus(signedOrder.getOrderId(), OrderStatus.SIGNATURE_INVALID);
            }

            return res;
        } catch (Exception e) {
            res.setSuccess(false);
            res.setMessage("Verification error: " + e.getMessage());

            persistSignatureRecord(
                    signedOrder,
                    accountId,
                    sign,
                    "FAIL_ERROR",
                    e.getMessage()
            );

            return res;
        }
    }

    private String resolveSignaAlgo(String signAlgo) {
        if (signAlgo == null || signAlgo.isBlank()) {
            return DEFAULT_SIGNATURE_ALGORITHM;
        }

        String normalizedAlgo = signAlgo.trim();

        if (!ALLOWED_SIGNATURE_ALGORITHMS.contains(normalizedAlgo)) {
            throw new SecurityException("Unsupported signature algorithm: " + normalizedAlgo);
        }

        return normalizedAlgo;
    }

    private X509Certificate loadCACertificate() throws Exception {
        String caCertPath = System.getProperty(CA_CERT_PATH_PROPERTY);

        // Create CA certificate from file if you don't have it
        if (caCertPath != null && !caCertPath.isBlank()) {
            try (InputStream in = Files.newInputStream(Path.of(caCertPath))) {
                String pem = new String(in.readAllBytes(), StandardCharsets.UTF_8);
                return parsePemCertificate(pem);
            }
        }

        ClassLoader classLoader = Thread.currentThread().getContextClassLoader();

        try (InputStream in = classLoader.getResourceAsStream(DEFAULT_CA_CERT_RESOURCE)) {
            if (in == null) {
                throw new IllegalStateException(
                        "CA certificate not found in classpath: " + DEFAULT_CA_CERT_RESOURCE
                );
            }

            String pem = new String(in.readAllBytes(), StandardCharsets.UTF_8);
            return parsePemCertificate(pem);
        }
    }

}

