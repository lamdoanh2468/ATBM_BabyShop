package vn.edu.nlu.fit.be.model;

import java.sql.Timestamp;

public class UserCertificate {
    private int certificateId;
    private int accountId;
    private String publicKeyPem;
    private String certificatePem;
    private CertificateStatus status;
    private Timestamp createdAt;
    private Timestamp expiresAt;
    private Timestamp lostAt;
    private Timestamp revokedAt;
    private String revokeReason;

    public int getCertificateId() {
        return certificateId;
    }

    public void setCertificateId(int certificateId) {
        this.certificateId = certificateId;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public String getPublicKeyPem() {
        return publicKeyPem;
    }

    public void setPublicKeyPem(String publicKeyPem) {
        this.publicKeyPem = publicKeyPem;
    }

    public String getCertificatePem() {
        return certificatePem;
    }

    public void setCertificatePem(String certificatePem) {
        this.certificatePem = certificatePem;
    }

    public CertificateStatus getStatus() {
        return status;
    }

    public void setStatus(CertificateStatus status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getExpiresAt() {
        return expiresAt;
    }

    public void setExpiresAt(Timestamp expiresAt) {
        this.expiresAt = expiresAt;
    }

    public Timestamp getLostAt() {
        return lostAt;
    }
    public Timestamp getRevokedAt() {
        return revokedAt;
    }

    public void setLostAt(Timestamp lostAt) {
        this.lostAt = lostAt;
    }
    public void setRevokedAt(Timestamp revokedAt) {
        this.revokedAt = revokedAt;
    }

    public String getRevokeReason() {
        return revokeReason;
    }

    public void setRevokeReason(String revokeReason) {
        this.revokeReason = revokeReason;
    }
}
