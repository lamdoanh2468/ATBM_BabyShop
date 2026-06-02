package vn.edu.nlu.fit.be.service;

import java.security.cert.Certificate;

public class CertificateService {
    public Certificate findRevokedByAccountId(int accountId) {
    }

    public Certificate getActiveCertByAccountId(int accountId) {
    }

    public void revokeActiveCertByLostKey(int accountId, String reason) {
    }

    public void createNewCertAccount(int accountId) {
    }

    public String getActiveCertPem(int accountId) {
        return null;
    }

    public void ensureActiveCert(int accountId) {
    }
}
