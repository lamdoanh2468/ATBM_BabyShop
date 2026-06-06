package vn.edu.nlu.fit.be.service;

import vn.edu.nlu.fit.be.dao.CertificateDao;
import vn.edu.nlu.fit.be.model.Certificate;
import vn.edu.nlu.fit.be.model.UserCertificate;
import vn.edu.nlu.fit.be.util.CryptoUtil;

import java.nio.file.Files;
import java.nio.file.Path;
import java.security.KeyPair;
import java.security.PrivateKey;
import java.security.cert.X509Certificate;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Optional;

public class CertificateService {

    private final CertificateDao dao = new CertificateDao();
    private final Path privateKeyDir = Path.of("JSP_Servlet", "data", "private_keys");

    public List<UserCertificate> findRevokedByAccountId(int accountId) {
        return dao.findRevokedByAccountId(accountId);
    }

    public Optional<UserCertificate> getActiveCertByAccountId(int accountId) {
        return dao.findActiveByAccountId(accountId);
    }

    public void revokeActiveCertByLostKey(int accountId, String reason) {
        Optional<UserCertificate> cert = dao.findActiveByAccountId(accountId);
        if (cert.isPresent()) {
            dao.revokeById(cert.get().getCertificateId(), reason);
        }
    }

    public void createNewCertAccount(int accountId) throws Exception {

            KeyPair userKeyPair = CryptoUtil.generateRsaKeyPair(2048);
            X509Certificate caCert = CryptoUtil.loadCertificate(
                    Path.of("JSP_Servlet", "data", "ca", "ca_certificate.pem")
            );
            PrivateKey caPrivateKey = CryptoUtil.loadPrivateKey(
                    Path.of("JSP_Servlet", "data", "ca", "ca_private_key.pem")
            );
            X509Certificate userCert = CryptoUtil.genCertSignedByCA(
                    userKeyPair.getPublic(),
                    caPrivateKey,
                    caCert,
                    "CN=account-" + accountId + ", UID=" + accountId,
                    365
            );

            Certificate certificate = new Certificate();
            certificate.setAccountId(accountId);
            certificate.setPublicKeyPem(
                    "-----BEGIN PUBLIC KEY-----\n" + java.util.Base64.getEncoder().encodeToString(userKeyPair.getPublic().getEncoded())
                            + "\n-----END PUBLIC KEY-----\n");
            certificate.setCertificatePem(CryptoUtil.toPemCertificate(userCert));
            certificate.setSerialNumber(Long.toString(userCert.getSerialNumber().longValue()));
            certificate.setStatus("Active");
            certificate.setIssuedAt(new Timestamp(new Date().getTime()));
            certificate.setExpiredAt(new Timestamp(userCert.getNotAfter().getTime()));

            long id = dao.createCertificate(certificate);
            certificate.setCertificateId(id);

            // write private key to temporary file for one-time download
            Files.createDirectories(privateKeyDir);
            Path pemPath = privateKeyDir.resolve("account_" + accountId + "_private.pem");
            Files.writeString(pemPath, CryptoUtil.toPemPrivateKey(userKeyPair.getPrivate()));

    }

    public String getActiveCertPem(int accountId) {
        Optional<UserCertificate> c = dao.findActiveByAccountId(accountId);
        return c.map(UserCertificate::getCertificatePem).orElse(null);
    }

    public void ensureActiveCert(int accountId) throws Exception {
        Optional<UserCertificate> c = dao.findActiveByAccountId(accountId);
        if (c.isEmpty()) {
            createNewCertAccount(accountId);
        }
    }
}
