package vn.edu.nlu.fit.be.model;

import java.sql.Timestamp;

public class CertificateRevocation {

    private long revocationId;
    private long certificateId;
    private long accountId;
    private Timestamp revokedAt;
    private String reason;
    private Timestamp effectiveFrom;
    private Long createdBy;

    public CertificateRevocation() {}

    public long getRevocationId() {
        return revocationId;
    }

    public void setRevocationId(long revocationId) {
        this.revocationId = revocationId;
    }

    public long getCertificateId() {
        return certificateId;
    }

    public void setCertificateId(long certificateId) {
        this.certificateId = certificateId;
    }

    public long getAccountId() {
        return accountId;
    }

    public void setAccountId(long accountId) {
        this.accountId = accountId;
    }

    public Timestamp getRevokedAt() {
        return revokedAt;
    }

    public void setRevokedAt(Timestamp revokedAt) {
        this.revokedAt = revokedAt;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public Timestamp getEffectiveFrom() {
        return effectiveFrom;
    }

    public void setEffectiveFrom(Timestamp effectiveFrom) {
        this.effectiveFrom = effectiveFrom;
    }

    public Long getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(Long createdBy) {
        this.createdBy = createdBy;
    }
}
