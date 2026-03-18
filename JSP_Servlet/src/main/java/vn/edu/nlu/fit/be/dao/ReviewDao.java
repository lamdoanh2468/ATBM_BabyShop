package vn.edu.nlu.fit.be.dao;

import java.util.*;

public class ReviewDao extends BaseDao {
    public boolean addReview(int accountId, int productId, String comment) {
        String sql = "INSERT INTO reviews (account_id, product_id, comment, created_at) " +
                "VALUES (:accountId, :productId, :comment, NOW())";
        return jdbi.withHandle(handle ->
                handle.createUpdate(sql).bind("accountId", accountId)
                        .bind("productId", productId)
                        .bind("comment", comment)
                        .execute() > 0);
    }

    public List<Map<String, Object>> getReviewsByProductId(int productId) {
        String sql = "SELECT r.*, a.username FROM reviews r " +
                "JOIN accounts a ON r.account_id = a.account_id " +
                "WHERE r.product_id = :productId ORDER BY r.created_at DESC";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("productId", productId)
                        .mapToMap().list());
    }
}
