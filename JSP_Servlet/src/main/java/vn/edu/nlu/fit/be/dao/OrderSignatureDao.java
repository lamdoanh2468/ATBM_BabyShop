package vn.edu.nlu.fit.be.dao;

import vn.edu.nlu.fit.be.model.OrderSignature;

public class OrderSignatureDao extends BaseDao {

    public long insert(OrderSignature sig) {
        String sql = """
            INSERT INTO order_signatures
                (order_id, account_id, certificate_id, order_hash, signature_value, signature_algorithm, signed_payload_json, uploaded_at, verify_status, verify_message)
            VALUES
                (:orderId, :accountId, :certificateId, :orderHash, :signatureValue, :signatureAlgorithm, :signedPayloadJson, NOW(), :verifyStatus, :verifyMessage)
        """;

        return jdbi.withHandle(handle ->
                handle.createUpdate(sql)
                        .bind("orderId", sig.getOrderId())
                        .bind("accountId", sig.getAccountId())
                        .bind("certificateId", sig.getCertificateId())
                        .bind("orderHash", sig.getOrderHash())
                        .bind("signatureValue", sig.getSignatureValue())
                        .bind("signatureAlgorithm", sig.getSignatureAlgorithm())
                        .bind("signedPayloadJson", sig.getSignedPayloadJson())
                        .bind("verifyStatus", sig.getVerifyStatus())
                        .bind("verifyMessage", sig.getVerifyMessage())
                        .executeAndReturnGeneratedKeys("signature_id")
                        .mapTo(Long.class)
                        .one()
        );
    }

    public OrderSignature findLatestByOrderId(int orderId) {
        String sql = "SELECT * FROM order_signatures WHERE order_id = :orderId ORDER BY uploaded_at DESC LIMIT 1";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("orderId", orderId)
                        .mapToBean(OrderSignature.class)
                        .findOne().orElse(null)
        );
    }
}
