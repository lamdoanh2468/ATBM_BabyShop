package vn.edu.nlu.fit.be.dao;

import vn.edu.nlu.fit.be.DB.DBConnect;
import vn.edu.nlu.fit.be.model.FavoriteProduct;
import vn.edu.nlu.fit.be.model.Product;

import java.util.List;

public class FavoriteProductDao extends BaseDao {
    // 1. Kiểm tra đã yêu thích chưa
    public boolean exists(int accountId, int productId) {
        String sql = """
            SELECT 1
            FROM favorite_products
            WHERE account_id = :aid
              AND product_id = :pid
        """;

        return jdbi.withHandle(h ->
                h.createQuery(sql)
                        .bind("aid", accountId)
                        .bind("pid", productId)
                        .mapTo(Integer.class)
                        .findFirst()
                        .isPresent()
        );
    }

    // 2. Thêm yêu thích
    public int insert(int accountId, int productId) {
        String sql = """
            INSERT INTO favorite_products (account_id, product_id)
            VALUES (:aid, :pid)
        """;

        return jdbi.withHandle(h ->
                h.createUpdate(sql)
                        .bind("aid", accountId)
                        .bind("pid", productId)
                        .execute()
        );
    }

    // 3. Xóa yêu thích
    public int delete(int accountId, int productId) {
        String sql = """
            DELETE FROM favorite_products
            WHERE account_id = :aid
              AND product_id = :pid
        """;

        return jdbi.withHandle(h ->
                h.createUpdate(sql)
                        .bind("aid", accountId)
                        .bind("pid", productId)
                        .execute()
        );
    }

    // 4. Lấy danh sách yêu thích của account
    public List<Product> findByAccountId(int accountId) {
        String sql = """
        SELECT p.*
        FROM favorite_products fp
        JOIN products p ON fp.product_id = p.product_id
        WHERE fp.account_id = :aid
        ORDER BY fp.created_at DESC
    """;

        return jdbi.withHandle(h ->
                h.createQuery(sql)
                        .bind("aid", accountId)
                        .mapToBean(Product.class)
                        .list()
        );
    }

}
