package vn.edu.nlu.fit.be.dao;

import vn.edu.nlu.fit.be.model.StockProduct;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class StockProductDao extends BaseDao {
    public List<StockProduct> getStockProducts() {
        return jdbi.withHandle(handle -> handle.createQuery("SELECT * FROM stock_products").mapToBean(StockProduct.class).list());
    }

    public boolean checkAvailable(int productId) {
        String sql = """
                    SELECT SUM(total_quantity)
                    FROM stock_products
                    WHERE product_id = :pid
                """;

        int available = jdbi.withHandle(handle -> handle.createQuery(sql).bind("pid", productId).mapTo(Integer.class).one());

        return available > 0;
    }

    public Integer findStockIdWithEnoughQuantity(int productId, int qty) {
        String sql = """
                    SELECT stock_id
                    FROM stock_products
                    WHERE product_id = :pid
                      AND total_quantity >= :qty
                    ORDER BY total_quantity DESC
                    LIMIT 1
                """;

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("pid", productId)
                        .bind("qty", qty)
                        .mapTo(Integer.class)
                        .findOne()
                        .orElse(null)
        );
    }
    public boolean reserveProduct(int productId, int stockId, int qty) {
        String sql = """
        UPDATE stock_products
        SET total_quantity = total_quantity - :qty
        WHERE product_id = :pid
          AND stock_id = :sid
          AND total_quantity >= :qty
    """;

        int updated = jdbi.withHandle(h ->
                h.createUpdate(sql)
                        .bind("qty", qty)
                        .bind("pid", productId)
                        .bind("sid", stockId)
                        .execute()
        );

        return updated == 1;
    }

    //Dành cho admin
    public boolean increaseSoldQuantity(int productId, int stockId, int quantity) {
        String sql = """
                    UPDATE stock_products
                    SET sold_quantity = sold_quantity + :qty
                    WHERE product_id = :pid AND stock_id = :sid
                """;
        return jdbi.withHandle(handle ->
                handle.createUpdate(sql)
                        .bind("qty", quantity)
                        .bind("pid", productId)
                        .bind("sid", stockId)
                        .execute()
        ) > 0;
    }

    public StockProduct getProductInStock(int productId) {
        for (StockProduct st : getStockProducts()) {
            if (st.getProductId() == productId) {
                return st;
            }
        }
        return null;
    }

    /**
     * Lấy tổng số lượng tồn kho của sản phẩm
     */
    public int getTotalAvailableQuantity(int productId) {
        String sql = """
                    SELECT COALESCE(SUM(total_quantity), 0)
                    FROM stock_products
                    WHERE product_id = :pid
                """;

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("pid", productId)
                        .mapTo(Integer.class)
                        .one()
        );
    }

    public int getTotalSoldQuantity(int stockProductId) {
        return jdbi.withHandle(handle -> handle.createQuery("SELECT SUM(sold_quantity) FROM stock_products WHERE stock_product_id = :id").bind("id", stockProductId).mapTo(Integer.class).findOne().orElse(0));
    }

    public int getTotalImportedByProductId(int productId) {
        return jdbi.withHandle(handle -> handle.createQuery("SELECT SUM(total_quantity) FROM stock_products WHERE product_id = :id").bind("id", productId).mapTo(Integer.class).findOne().orElse(null));
    }
    public boolean confirmOrder(int productId, int stockId, int qty) {
        String sql = """
        UPDATE stock_products
        SET sold_quantity = sold_quantity + :qty
        WHERE product_id = :pid
          AND stock_id = :sid
    """;

        int updated = jdbi.withHandle(h ->
                h.createUpdate(sql)
                        .bind("qty", qty)
                        .bind("pid", productId)
                        .bind("sid", stockId)
                        .execute()
        );

        return updated == 1;
    }
    public boolean cancelOrder(int productId, int stockId, int qty) {
        String sql = """
        UPDATE stock_products
        SET total_quantity = total_quantity + :qty
        WHERE product_id = :pid
          AND stock_id = :sid
    """;

        int updated = jdbi.withHandle(h ->
                h.createUpdate(sql)
                        .bind("qty", qty)
                        .bind("pid", productId)
                        .bind("sid", stockId)
                        .execute()
        );

        return updated == 1;
    }

}
