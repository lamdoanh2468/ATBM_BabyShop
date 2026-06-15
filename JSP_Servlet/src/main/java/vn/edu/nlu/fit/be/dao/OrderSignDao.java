package vn.edu.nlu.fit.be.dao;

import vn.edu.nlu.fit.be.model.OrderSign;

public class OrderSignDao extends BaseDao {

    public long insert(OrderSign sign) {
        String sql = """
                    INSERT INTO order_signs
                        (order_id, account_id, snapshot_json, order_hash, hash_algorithm, status, created_at)
                    VALUES
                        (:orderId, :accountId, :snapshotJson, :orderHash, :hashAlgorithm, :status, NOW())
                """;

        return jdbi.withHandle(handle ->
                handle.createUpdate(sql)
                        .bind("orderId", sign.getOrderId())
                        .bind("accountId", sign.getAccountId())
                        .bind("snapshotJson", sign.getSnapshotJson())
                        .bind("orderHash", sign.getOrderHash())
                        .bind("hashAlgorithm", sign.getHashAlgorithm())
                        .bind("status", sign.getStatus())
                        .executeAndReturnGeneratedKeys("order_sign_id")
                        .mapTo(Long.class)
                        .one()
        );
    }

    public OrderSign findByOrderId(int orderId) {
        String sql = "SELECT * FROM order_signs WHERE order_id = :orderId ORDER BY created_at DESC LIMIT 1";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("orderId", orderId)
                        .mapToBean(OrderSign.class)
                        .findOne().orElse(null)
        );
    }

    public OrderSign findLatestWaitingByAccountId(long accountId) {
        String sql = """
                    SELECT *
                    FROM order_signs
                    WHERE account_id = :accountId
                      AND status = 'WAITING_SIGNATURE'
                    ORDER BY created_at DESC
                    LIMIT 1
                """;

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("accountId", accountId)
                        .mapToBean(OrderSign.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public java.util.List<OrderSign> findByStatus(String status) {
        String sql = "SELECT * FROM order_signs WHERE status = :status ORDER BY created_at DESC";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("status", status)
                        .mapToBean(OrderSign.class)
                        .list()
        );
    }

    public boolean updateStatus(long orderSignId, String status) {
        String sql = """
                    UPDATE order_signs
                    SET status = :status,
                        verified_at = CASE WHEN :status = 'VERIFIED' THEN NOW() ELSE verified_at END
                    WHERE order_sign_id = :id
                """;
        return jdbi.withHandle(handle ->
                handle.createUpdate(sql).bind("status", status).bind("id", orderSignId).execute()
        ) > 0;
    }
    public OrderSign findByOrderIdAndAccountId(long orderId, long accountId) {
        String sql = """
        SELECT *
        FROM order_signs
        WHERE order_id = :orderId
          AND account_id = :accountId
        ORDER BY created_at DESC
        LIMIT 1
    """;

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("orderId", orderId)
                        .bind("accountId", accountId)
                        .mapToBean(OrderSign.class)
                        .findOne()
                        .orElse(null)
        );

    }

}
