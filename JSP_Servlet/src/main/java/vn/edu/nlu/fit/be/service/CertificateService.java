package vn.edu.nlu.fit.be.service;

import vn.edu.nlu.fit.be.dao.CertificateDao;
import vn.edu.nlu.fit.be.model.Certificate;
import vn.edu.nlu.fit.be.service.util.CryptoUtil;

import java.nio.file.Files;
import java.nio.file.Path;
import java.security.KeyPair;
import java.security.cert.X509Certificate;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

public class CertificateService {

    private final CertificateDao dao = new CertificateDao();
    private final Path privateKeyDir = Path.of("JSP_Servlet", "data", "private_keys");

    public List<Certificate> findRevokedByAccountId(int accountId) {
        return dao.findRevokedByAccountId(accountId);
    }

    public Certificate getActiveCertByAccountId(int accountId) {
        return dao.findActiveByAccountId(accountId);
    }

    public void revokeActiveCertByLostKey(int accountId, String reason) {
        Certificate cert = dao.findActiveByAccountId(accountId);
        if (cert != null) {
            dao.revoke((int) cert.getCertificateId(), reason);
        }
    }

    public void createNewCertAccount(int accountId) {
        try {
            KeyPair kp = CryptoUtil.generateRsaKeyPair(2048);
            X509Certificate cert = CryptoUtil.generateSelfSignedCertificate(kp, "CN=account-" + accountId, 365);

            Certificate model = new Certificate();
            model.setAccountId(accountId);
            model.setPublicKeyPem("-----BEGIN PUBLIC KEY-----\n" + java.util.Base64.getEncoder().encodeToString(kp.getPublic().getEncoded()) + "\n-----END PUBLIC KEY-----\n");
            model.setCertificatePem(CryptoUtil.toPemCertificate(cert));
            model.setSerialNumber(Long.toString(cert.getSerialNumber().longValue()));
            model.setStatus("Active");
            model.setIssuedAt(new Timestamp(new Date().getTime()));
            model.setExpiredAt(new Timestamp(cert.getNotAfter().getTime()));

            long id = dao.insert(model);
            model.setCertificateId(id);

            // write private key to temporary file for one-time download
            Files.createDirectories(privateKeyDir);
            Path pemPath = privateKeyDir.resolve("account_" + accountId + "_private.pem");
            Files.writeString(pemPath, CryptoUtil.toPemPrivateKey(kp.getPrivate()));
        } catch (Exception e) {
            throw new RuntimeException("Cannot create certificate: " + e.getMessage(), e);
        }
    }

    public String getActiveCertPem(int accountId) {
        Certificate c = dao.findActiveByAccountId(accountId);
        return c == null ? null : c.getCertificatePem();
    }

    public void ensureActiveCert(int accountId) {
        Certificate c = dao.findActiveByAccountId(accountId);
        if (c == null) {
            createNewCertAccount(accountId);
        }
    }
}
