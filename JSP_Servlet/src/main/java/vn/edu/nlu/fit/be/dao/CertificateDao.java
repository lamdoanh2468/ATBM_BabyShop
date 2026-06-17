package vn.edu.nlu.fit.be.dao;

import vn.edu.nlu.fit.be.model.Certificate;

import java.util.List;
import java.util.Optional;

public class CertificateDao extends BaseDao {

    private static final String CERTIFICATE_COLUMNS = """
            certificate_id AS certificateId,
            account_id AS accountId,
            public_key_pem AS publicKeyPem,
            certificate_pem AS certificatePem,
            serial_number AS serialNumber,
            status AS status,
            issued_at AS issuedAt,
            expires_at AS expiredAt,
            lost_at AS lostAt,
            revoked_at AS revokedAt,
            revoke_reason AS revokeReason
            """;

    public Optional<Certificate> findActiveByAccountId(int accountId) {
        String sql = """
                SELECT %s
                FROM certificates
                WHERE account_id = :accountId
                  AND status = 'ACTIVE'
                  AND expires_at > NOW()
                ORDER BY certificate_id DESC
                LIMIT 1
                """.formatted(CERTIFICATE_COLUMNS);

        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("accountId", accountId)
                .mapToBean(Certificate.class)
                .findOne());
    }

    public Optional<Certificate> findByCertIdAccID(int certificateId, int accountId) {
        String sql = """
                SELECT %s
                FROM certificates
                WHERE certificate_id = :certificateId
                  AND account_id = :accountId
                """.formatted(CERTIFICATE_COLUMNS);

        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("certificateId", certificateId)
                .bind("accountId", accountId)
                .mapToBean(Certificate.class)
                .findOne());
    }

    public List<Certificate> findRevokedByAccountId(int accountId) {
        String sql = """
                SELECT %s
                FROM certificates
                WHERE account_id = :accountId
                  AND status IN ('REVOKED', 'LOST_KEY', 'EXPIRED')
                ORDER BY COALESCE(revoked_at, lost_at, issued_at) DESC
                """.formatted(CERTIFICATE_COLUMNS);

        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("accountId", accountId)
                .mapToBean(Certificate.class)
                .list());
    }

    public Integer createCertificate(Certificate model) {
        return jdbi.withHandle(handle -> handle.createUpdate("""
                    INSERT INTO certificates (
                        account_id,
                        public_key_pem,
                        certificate_pem,
                        serial_number,
                        status,
                        issued_at,
                        expires_at
                    )
                    VALUES (
                        :accountId,
                        :publicKeyPem,
                        :certificatePem,
                        :serialNumber,
                        :status,
                        :issuedAt,
                        :expiredAt
                    )
                    """)
                .bind("accountId", model.getAccountId())
                .bind("publicKeyPem", model.getPublicKeyPem())
                .bind("certificatePem", model.getCertificatePem())
                .bind("serialNumber", model.getSerialNumber())
                .bind("status", model.getStatus().name())
                .bind("issuedAt", model.getIssuedAt())
                .bind("expiredAt", model.getExpiredAt())
                .executeAndReturnGeneratedKeys("certificate_id")
                .mapTo(Integer.class)
                .one());
    }

    public boolean revokeActiveByAccountId(int accountId, String reason) {
        String sql = """
                UPDATE certificates
                SET status = 'REVOKED',
                    revoked_at = NOW(),
                    revoke_reason = :reason
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
                SET status = 'REVOKED',
                    revoked_at = NOW(),
                    revoke_reason = :reason
                WHERE certificate_id = :certificateId
                  AND status = 'ACTIVE'
                """;

        return jdbi.withHandle(handle -> handle.createUpdate(sql)
                .bind("certificateId", certificateId)
                .bind("reason", reason)
                .execute()) > 0;
    }

    public boolean markLostKeyById(int certificateId, String reason) {
        String sql = """
                UPDATE certificates
                SET status = 'LOST_KEY',
                    lost_at = NOW(),
                    revoked_at = NOW(),
                    revoke_reason = :reason
                WHERE certificate_id = :certificateId
                  AND status = 'ACTIVE'
                """;

        return jdbi.withHandle(handle -> handle.createUpdate(sql)
                .bind("certificateId", certificateId)
                .bind("reason", reason)
                .execute()) > 0;
    }

    public List<Certificate> findRecentRevoked(int limit) {
        String sql = """
                SELECT %s
                FROM certificates
                WHERE status IN ('REVOKED', 'LOST_KEY', 'EXPIRED')
                ORDER BY COALESCE(revoked_at, lost_at, issued_at) DESC
                LIMIT :limit
                """.formatted(CERTIFICATE_COLUMNS);

        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("limit", limit)
                .mapToBean(Certificate.class)
                .list());
    }
}