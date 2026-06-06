package vn.edu.nlu.fit.be.dao;

import vn.edu.nlu.fit.be.model.Certificate;
import vn.edu.nlu.fit.be.model.CertificateStatus;
import vn.edu.nlu.fit.be.model.UserCertificate;

import java.util.List;
import java.util.Optional;

public class CertificateDao extends BaseDao {

    public Optional<UserCertificate> findByAccountId(int accountId) {
        String sql = """
                SELECT certificate_id, account_id, public_key_pem, certificate_pem, status,
                       created_at, expires_at,lost_at, revoked_at, revoke_reason
                FROM certificates
                WHERE account_id = :accountId
                ORDER BY certificate_id DESC
                LIMIT 1
                """;
        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("accountId", accountId)
                .mapToBean(UserCertificate.class)
                .findOne());
    }

    public Optional<UserCertificate> findActiveByAccountId(int accountId) {
        String sql = """
                SELECT certificate_id, account_id, public_key_pem, certificate_pem, status,
                       created_at, expires_at, revoked_at,lost_at, revoke_reason
                FROM certificates
                WHERE account_id = :accountId
                  AND status = 'ACTIVE'
                  AND expires_at > NOW()
                ORDER BY certificate_id DESC
                LIMIT 1
                """;

        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("accountId", accountId)
                .mapToBean(UserCertificate.class)
                .findOne());
    }

    public Optional<UserCertificate> findByCertIdAccID(int certificateId, int accountId) {
        String sql = """
                SELECT certificate_id, account_id, public_key_pem, certificate_pem, status,
                       created_at, expires_at, revoked_at, lost_at, revoke_reason
                FROM certificates
                WHERE certificate_id = :certificateId
                  AND account_id = :accountId
                """;
        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("certificateId", certificateId)
                .bind("accountId", accountId)
                .mapToBean(UserCertificate.class)
                .findOne());
    }

    public List<UserCertificate> findRevokedByAccountId(int accountId) {
        String sql = """
                SELECT certificate_id, account_id, public_key_pem, certificate_pem, status,
                       created_at, expires_at, revoked_at, lost_at, revoke_reason
                FROM certificates
                WHERE account_id = :accountId
                  AND status = 'REVOKED'
                ORDER BY revoked_at DESC
                """;

        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("accountId", accountId)
                .mapToBean(UserCertificate.class)
                .list());
    }


    public int create(int accountId, String publicKeyPem, String certificatePem) {
        String sql = """
                INSERT INTO certificates
                    (account_id, public_key_pem, certificate_pem, status, created_at, expires_at)
                VALUES
                    (:accountId, :publicKeyPem, :certificatePem, 'ACTIVE', NOW(), DATE_ADD(NOW(), INTERVAL 365 DAY))
                """;

        return jdbi.withHandle(handle -> handle.createUpdate(sql)
                .bind("accountId", accountId)
                .bind("publicKeyPem", publicKeyPem)
                .bind("certificatePem", certificatePem)
                .executeAndReturnGeneratedKeys("certificate_id")
                .mapTo(Integer.class)
                .one());
    }

    public boolean revokeActiveByAccountId(int accountId, String reason) {
        String sql = """
                UPDATE certificates
                SET status = 'REVOKED', revoked_at = NOW(), revoke_reason = :reason
                WHERE account_id = :accountId
                  AND status = 'ACTIVE'
                """;

        return jdbi.withHandle(handle -> handle.createUpdate(sql)
                .bind("accountId", accountId)
                .bind("reason", reason)
                .execute()) > 0;
    }

    public boolean revokeById(int certificateId, String reason) {
        String sql = """
                UPDATE certificates
                SET status = 'REVOKED', revoked_at = NOW(), revoke_reason = :reason
                WHERE certificate_id = :certificateId
                  AND status = 'ACTIVE'
                """;

        return jdbi.withHandle(handle -> handle.createUpdate(sql)
                .bind("certificateId", certificateId)
                .bind("reason", reason)
                .execute()) > 0;
    }

    public boolean isUsable(UserCertificate certificate) {
        return certificate != null && certificate.getStatus() == CertificateStatus.ACTIVE;
    }

    public long createCertificate(Certificate model) {
        return jdbi.withHandle(handle -> handle.createUpdate("""
                        INSERT INTO certificates (account_id, public_key_pem, certificate_pem, status, created_at, expires_at)
                        VALUES (:accountId, :publicKeyPem, :certificatePem, 'ACTIVE', NOW(), DATE_ADD(NOW(), INTERVAL 365 DAY))
                        """)
                .bind("accountId", model.getAccountId())
                .bind("publicKeyPem", model.getPublicKeyPem())
                .bind("certificatePem", model.getCertificatePem())
                .executeAndReturnGeneratedKeys("certificate_id")
                .mapTo(Long.class)
                .one());
    }

    public List<Certificate> findRecentRevoked(int i) {
        return jdbi.withHandle(handle -> handle.createQuery("""
                        SELECT certificate_id, account_id, public_key_pem, certificate_pem, status, created_at, expires_at, revoked_at, revoke_reason
                        FROM certificates
                        WHERE status = 'REVOKED'
                        ORDER BY revoked_at DESC
                        LIMIT :i
                        """)
                .bind("i", i)
                .mapToBean(Certificate.class)
                .list());
    }
}