package vn.edu.nlu.fit.be.dao;

import vn.edu.nlu.fit.be.model.Stock;
import java.util.List;

public class StockDao extends BaseDao {

    // Lấy danh sách tất cả kho
    public List<Stock> getAllStocks() {
        String sql = "SELECT * FROM stocks";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .mapToBean(Stock.class)
                        .list()
        );
    }

    // Thêm kho mới
    public boolean addStock(Stock stock) {
        String sql = "INSERT INTO stocks (stock_name, stock_address) VALUES (:name, :address)";
        return jdbi.withHandle(handle ->
                handle.createUpdate(sql)
                        .bind("name", stock.getStockName())
                        .bind("address", stock.getStockAddress())
                        .execute()
        ) > 0;
    }

    // Lấy 1 kho theo ID (PHỤC VỤ EDIT)
    public Stock getStockById(int id) {
        String sql = "SELECT * FROM stocks WHERE stock_id = :id";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("id", id)
                        .mapToBean(Stock.class)
                        .findOne()
                        .orElse(null)
        );
    }

    // Cập nhật kho
    public boolean updateStock(Stock stock) {
        String sql = """
                UPDATE stocks
                SET stock_name = :name,
                    stock_address = :address
                WHERE stock_id = :id
                """;

        return jdbi.withHandle(handle ->
                handle.createUpdate(sql)
                        .bind("name", stock.getStockName())
                        .bind("address", stock.getStockAddress())
                        .bind("id", stock.getStockId())
                        .execute()
        ) > 0;
    }

    // Xóa kho
    public boolean deleteStock(int id) {
        String sql = "DELETE FROM stocks WHERE stock_id = :id";
        return jdbi.withHandle(handle ->
                handle.createUpdate(sql)
                        .bind("id", id)
                        .execute()
        ) > 0;
    }

    // Tổng số sản phẩm trong kho
    public int getTotalProductsInStock(int stockId) {
        String sql = """
                SELECT COALESCE(SUM(total_quantity - sold_quantity), 0)
                FROM stock_products
                WHERE stock_id = :sid
                """;

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("sid", stockId)
                        .mapTo(Integer.class)
                        .one()
        );
    }
}
