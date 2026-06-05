package vn.edu.nlu.fit.be.dao;

import vn.edu.nlu.fit.be.model.Certificate;

import java.util.List;

public class CertificateDao extends BaseDao {

    public Certificate findActiveByAccountId(int accountId) {
        String sql = """
            SELECT * FROM certificates
            WHERE account_id = :accountId AND status = 'Active'
            ORDER BY issued_at DESC LIMIT 1
        """;

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("accountId", accountId)
                        .mapToBean(Certificate.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public List<Certificate> findRevokedByAccountId(int accountId) {
        String sql = """
            SELECT * FROM certificates
            WHERE account_id = :accountId AND status = 'Revoked'
            ORDER BY revoked_at DESC
        """;

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("accountId", accountId)
                        .mapToBean(Certificate.class)
                        .list()
        );
    }

    public java.util.List<Certificate> findRecentRevoked(int limit) {
        String sql = "SELECT * FROM certificates WHERE status = 'Revoked' ORDER BY revoked_at DESC LIMIT :limit";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("limit", limit)
                        .mapToBean(Certificate.class)
                        .list()
        );
    }

    public long insert(Certificate cert) {
        String sql = """
            INSERT INTO certificates
                (account_id, public_key_pem, certificate_pem, serial_number, status, issued_at, expired_at, created_at)
            VALUES
                (:accountId, :publicKeyPem, :certificatePem, :serialNumber, :status, :issuedAt, :expiredAt, NOW())
        """;

        return jdbi.withHandle(handle ->
                handle.createUpdate(sql)
                        .bind("accountId", cert.getAccountId())
                        .bind("publicKeyPem", cert.getPublicKeyPem())
                        .bind("certificatePem", cert.getCertificatePem())
                        .bind("serialNumber", cert.getSerialNumber())
                        .bind("status", cert.getStatus())
                        .bind("issuedAt", cert.getIssuedAt())
                        .bind("expiredAt", cert.getExpiredAt())
                        .executeAndReturnGeneratedKeys("certificate_id")
                        .mapTo(Long.class)
                        .one()
        );
    }

    public void revoke(int certificateId, String reason) {
        String sql = """
            UPDATE certificates
            SET status = 'Revoked', revoked_at = NOW(), revoke_reason = :reason
            WHERE certificate_id = :id
        """;

        jdbi.withHandle(handle ->
                handle.createUpdate(sql)
                        .bind("reason", reason)
                        .bind("id", certificateId)
                        .execute()
        );
    }
}
