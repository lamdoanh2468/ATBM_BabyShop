package vn.edu.nlu.fit.be.dao;

import vn.edu.nlu.fit.be.model.SignatureAuditLog;

public class SignatureAuditDao extends BaseDao {

    public long insert(SignatureAuditLog log) {
        String sql = """
            INSERT INTO signature_audit_logs
                (order_id, account_id, certificate_id, action, result, message, created_at)
            VALUES
                (:orderId, :accountId, :certificateId, :action, :result, :message, NOW())
        """;

        return jdbi.withHandle(handle ->
                handle.createUpdate(sql)
                        .bind("orderId", log.getOrderId())
                        .bind("accountId", log.getAccountId())
                        .bind("certificateId", log.getCertificateId())
                        .bind("action", log.getAction())
                        .bind("result", log.getResult())
                        .bind("message", log.getMessage())
                        .executeAndReturnGeneratedKeys("audit_id")
                        .mapTo(Long.class)
                        .one()
        );
    }

    public java.util.List<SignatureAuditLog> findByOrderId(long orderId) {
        String sql = "SELECT * FROM signature_audit_logs WHERE order_id = :orderId ORDER BY created_at DESC";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("orderId", orderId)
                        .mapToBean(SignatureAuditLog.class)
                        .list()
        );
    }
}
