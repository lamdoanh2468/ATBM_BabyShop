package vn.edu.nlu.fit.be.service.util;

import org.bouncycastle.asn1.x500.X500Name;
import org.bouncycastle.cert.X509CertificateHolder;
import org.bouncycastle.cert.X509v3CertificateBuilder;
import org.bouncycastle.cert.jcajce.JcaX509CertificateConverter;
import org.bouncycastle.cert.jcajce.JcaX509v3CertificateBuilder;
import org.bouncycastle.jce.provider.BouncyCastleProvider;
import org.bouncycastle.operator.ContentSigner;
import org.bouncycastle.operator.jcajce.JcaContentSignerBuilder;

import java.io.StringWriter;
import java.math.BigInteger;
import java.security.GeneralSecurityException;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.SecureRandom;
import java.security.Security;
import java.security.cert.X509Certificate;
import java.util.Base64;
import java.util.Date;

public class CryptoUtil {

    private static final String KEY_ALGORITHM = "RSA";
    private static final String SIGNATURE_ALGORITHM = "SHA256withRSA";
    private static final String PROVIDER = "BC";

    static {
        if (Security.getProvider(PROVIDER) == null) {
            Security.addProvider(new BouncyCastleProvider());
        }
    }

    public static KeyPair generateRsaKeyPair(int bits) throws GeneralSecurityException {
        KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance(KEY_ALGORITHM);
        keyPairGenerator.initialize(bits, new SecureRandom());
        return keyPairGenerator.generateKeyPair();
    }

    public static X509Certificate generateSelfSignedCertificate(KeyPair keyPair, String dn, int days)
            throws Exception {

        long now = System.currentTimeMillis();
        Date from = new Date(now);
        Date to = new Date(now + days * 86_400_000L);
        BigInteger serialNumber = new BigInteger(64, new SecureRandom());

        X500Name subject = new X500Name(dn);

        X509v3CertificateBuilder certificateBuilder =
                new JcaX509v3CertificateBuilder(
                        subject,
                        serialNumber,
                        from,
                        to,
                        subject,
                        keyPair.getPublic()
                );

        ContentSigner signer = new JcaContentSignerBuilder(SIGNATURE_ALGORITHM)
                .setProvider(PROVIDER)
                .build(keyPair.getPrivate());

        X509CertificateHolder certificateHolder = certificateBuilder.build(signer);

        X509Certificate certificate = new JcaX509CertificateConverter()
                .setProvider(PROVIDER)
                .getCertificate(certificateHolder);

        certificate.verify(keyPair.getPublic());

        return certificate;
    }

    public static String toPemPrivateKey(PrivateKey key) {
        String b64 = Base64.getEncoder().encodeToString(key.getEncoded());

        StringWriter writer = new StringWriter();
        writer.append("-----BEGIN PRIVATE KEY-----\n");
        writer.append(wrap(b64));
        writer.append("-----END PRIVATE KEY-----\n");

        return writer.toString();
    }

    public static String toPemCertificate(X509Certificate certificate) throws Exception {
        String b64 = Base64.getEncoder().encodeToString(certificate.getEncoded());

        StringWriter writer = new StringWriter();
        writer.append("-----BEGIN CERTIFICATE-----\n");
        writer.append(wrap(b64));
        writer.append("-----END CERTIFICATE-----\n");

        return writer.toString();
    }

    private static String wrap(String value) {
        StringBuilder builder = new StringBuilder();

        int index = 0;
        while (index < value.length()) {
            int end = Math.min(index + 64, value.length());
            builder.append(value, index, end).append('\n');
            index = end;
        }

        return builder.toString();
    }
}