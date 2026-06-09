package vn.edu.nlu.fit.be.service;

import jakarta.servlet.http.HttpServletResponse;
import vn.edu.nlu.fit.be.dao.CertificateDao;
import vn.edu.nlu.fit.be.model.Certificate;
import vn.edu.nlu.fit.be.model.UserCertificate;
import vn.edu.nlu.fit.be.util.CryptoUtil;

import java.io.IOException;
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

    private static final String DATA_DIR_PROPERTY = "babyshop.data.dir";
    private final CertificateDao dao = new CertificateDao();
    private final Path dataDir = resolveDataDir();
    private final Path caDir = dataDir.resolve("ca");
    private final Path caCertPath = caDir.resolve("ca_certificate.pem");
    private final Path caPrivateKeyPath = caDir.resolve("ca_private_key.pem");
    private final Path privateKeyDir = dataDir.resolve("private_keys");

    public static Path resolveDataDir() {
        String configuredDataDir = System.getProperty(DATA_DIR_PROPERTY);
        if (configuredDataDir != null && !configuredDataDir.isBlank()) {
            return Path.of(configuredDataDir).toAbsolutePath().normalize();
        }

        Path workingDir = Path.of("").toAbsolutePath().normalize();
        if (Files.exists(workingDir.resolve("src").resolve("main").resolve("webapp"))) {
            return workingDir.resolve("data");
        }
        if (Files.exists(workingDir.resolve("JSP_Servlet"))) {
            return workingDir.resolve("JSP_Servlet").resolve("data");
        }
        return workingDir.resolve("data");
    }

    public List<UserCertificate> findRevokedByAccountId(int accountId) {
        return dao.findRevokedByAccountId(accountId);
    }

    public Optional<UserCertificate> getActiveCertByAccountId(int accountId) {
        return dao.findActiveByAccountId(accountId);
    }

    public void revokeActiveCertByLostKey(int accountId, String reason) {
        Optional<UserCertificate> cert = dao.findActiveByAccountId(accountId);
        cert.ifPresent(
                userCertificate -> dao.markLostKeyById(userCertificate.getCertificateId(), reason));
    }

    public void createNewCertAccount(int accountId) throws Exception {

        ensureLocalCa();
        KeyPair userKeyPair = CryptoUtil.generateRsaKeyPair(2048);
        X509Certificate caCert = CryptoUtil.loadCertificate(caCertPath);
        PrivateKey caPrivateKey = CryptoUtil.loadPrivateKey(caPrivateKeyPath);
        X509Certificate userCert = CryptoUtil.genCertSignedByCA(
                userKeyPair.getPublic(),
                caPrivateKey,
                caCert,
                "CN=account-" + accountId + ", UID=" + accountId,
                365);

        Certificate certificate = new Certificate();
        certificate.setAccountId(accountId);
        certificate.setPublicKeyPem(CryptoUtil.toPemPublicKey(userKeyPair.getPublic()));
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

    private void ensureLocalCa() throws Exception {
        if (Files.exists(caCertPath) && Files.exists(caPrivateKeyPath)) {
            return;
        }

        Files.createDirectories(caDir);
        KeyPair caKeyPair = CryptoUtil.generateRsaKeyPair(2048);
        X509Certificate caCert = CryptoUtil.genSelfSignedCA(caKeyPair, "CN=BabyShop Local CA", 3650);

        Files.writeString(caCertPath, CryptoUtil.toPemCertificate(caCert));
        Files.writeString(caPrivateKeyPath, CryptoUtil.toPemPrivateKey(caKeyPair.getPrivate()));
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

    public boolean hasPendingPrivateKey(int accountId) {
        Path pemPath = privateKeyDir.resolve("account_" + accountId + "_private.pem");
        return Files.exists(pemPath);
    }

    public void downloadPrivateKey(int accountId, HttpServletResponse response) throws IOException {
        Path pemPath = privateKeyDir.resolve("account_" + accountId + "_private.pem");

        if (!Files.exists(pemPath)) {
            throw new IOException("Private key not found or already downloaded");
        }

        response.reset();
        response.setContentType("application/octet-stream");
        response.setHeader(
                "Content-Disposition",
                "attachment; filename=\"account_" + accountId + "_private.pem\"");
        response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0");
        response.setContentLengthLong(Files.size(pemPath));

        boolean sent = false;

        try {
            Files.copy(pemPath, response.getOutputStream());
            response.getOutputStream().flush();
            sent = true;
        } finally {
            if (sent) {
                Files.deleteIfExists(pemPath);
            }
        }
    }
}
