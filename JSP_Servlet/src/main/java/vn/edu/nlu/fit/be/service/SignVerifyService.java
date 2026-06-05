package vn.edu.nlu.fit.be.service;

import vn.edu.nlu.fit.be.dao.CertificateDao;
import vn.edu.nlu.fit.be.dao.OrderSignDao;
import vn.edu.nlu.fit.be.dao.OrderSignatureDao;
import vn.edu.nlu.fit.be.dto.SignVerifyResult;
import vn.edu.nlu.fit.be.dto.SignedOrderReq;
import vn.edu.nlu.fit.be.model.Certificate;
import vn.edu.nlu.fit.be.model.OrderSign;
import vn.edu.nlu.fit.be.model.OrderSignature;

import java.io.ByteArrayInputStream;
import java.security.PublicKey;
import java.security.Signature;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import java.util.Base64;

public class SignVerifyService {

    private final OrderSignDao orderSignDao = new OrderSignDao();
    private final CertificateDao certificateDao = new CertificateDao();
    private final OrderSignatureDao signatureDao = new OrderSignatureDao();

    public SignVerifyResult verifySignedOrder(SignedOrderReq signedOrder, int accountId) {
        SignVerifyResult res = new SignVerifyResult();

        OrderSign sign = orderSignDao.findByOrderId(signedOrder.getOrderId());
        if (sign == null) {
            res.setSuccess(false);
            res.setMessage("No sign snapshot found for order");
            return res;
        }

        if (!sign.getOrderHash().equals(signedOrder.getOrderHash())) {
            res.setSuccess(false);
            res.setMessage("Order hash mismatch");
            // persist signature record with failure
            persistSignatureRecord(signedOrder, accountId, sign, "FAIL_HASH_MISMATCH", "Order hash does not match snapshot");
            return res;
        }

        Certificate cert = certificateDao.findActiveByAccountId(accountId);
        if (cert == null) {
            res.setSuccess(false);
            res.setMessage("No active certificate for account");
            persistSignatureRecord(signedOrder, accountId, sign, "FAIL_NO_CERT", "No active certificate");
            return res;
        }

        try {
            X509Certificate x509 = parsePemCertificate(cert.getCertificatePem());
            PublicKey pk = x509.getPublicKey();

            String alg = signedOrder.getSignatureAlgorithm();
            if (alg == null || alg.isEmpty()) alg = "SHA256withRSA";

            Signature verifier = Signature.getInstance(alg);
            verifier.initVerify(pk);
            byte[] payload = signedOrder.getOrderHash().getBytes(java.nio.charset.StandardCharsets.UTF_8);
            verifier.update(payload);

            byte[] sigBytes = Base64.getDecoder().decode(signedOrder.getSignatureValue());
            boolean ok = verifier.verify(sigBytes);

            if (ok) {
                res.setSuccess(true);
                res.setMessage("Signature verified");
                persistSignatureRecord(signedOrder, accountId, sign, "VERIFIED", "OK");
                orderSignDao.updateStatus(sign.getOrderSignId(), "VERIFIED");
            } else {
                res.setSuccess(false);
                res.setMessage("Signature verification failed");
                persistSignatureRecord(signedOrder, accountId, sign, "FAIL_INVALID_SIG", "Invalid signature");
            }
            return res;
        } catch (Exception e) {
            res.setSuccess(false);
            res.setMessage("Verification error: " + e.getMessage());
            persistSignatureRecord(signedOrder, accountId, sign, "FAIL_ERROR", e.getMessage());
            return res;
        }
    }

    private void persistSignatureRecord(SignedOrderReq req, int accountId, OrderSign sign, String status, String message) {
        try {
            OrderSignature s = new OrderSignature();
            s.setOrderId(req.getOrderId());
            s.setAccountId(accountId);
            Certificate c = certificateDao.findActiveByAccountId(accountId);
            s.setCertificateId(c == null ? 0 : c.getCertificateId());
            s.setOrderHash(req.getOrderHash());
            s.setSignatureValue(req.getSignatureValue());
            s.setSignatureAlgorithm(req.getSignatureAlgorithm());
            s.setSignedPayloadJson(null);
            s.setVerifyStatus(status);
            s.setVerifyMessage(message);
            signatureDao.insert(s);
        } catch (Exception ignored) {
        }
    }

    private X509Certificate parsePemCertificate(String pem) throws Exception {
        String base64 = pem.replaceAll("-----BEGIN CERTIFICATE-----", "").replaceAll("-----END CERTIFICATE-----", "").replaceAll("\\s+", "");
        byte[] der = Base64.getDecoder().decode(base64);
        CertificateFactory cf = CertificateFactory.getInstance("X.509");
        return (X509Certificate) cf.generateCertificate(new ByteArrayInputStream(der));
    }
}
