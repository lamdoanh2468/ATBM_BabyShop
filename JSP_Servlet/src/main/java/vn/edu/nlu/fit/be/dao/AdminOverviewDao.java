package vn.edu.nlu.fit.be.dao;

import vn.edu.nlu.fit.be.DB.DBConnect;
import vn.edu.nlu.fit.be.dto.*;

import java.util.List;

import static vn.edu.nlu.fit.be.DB.DBConnect.jdbi;

public class AdminOverviewDao extends BaseDao{

    public int getTotalRevenue() {
        return jdbi.withHandle(h ->
                h.createQuery("""
            SELECT COALESCE(SUM(total_amount), 0)
            FROM orders
            WHERE status = 'Done'
        """)
                        .mapTo(Integer.class)
                        .one()
        );
    }


    public int getTotalOrders() {
        return jdbi.withHandle(h ->
                h.createQuery("SELECT COUNT(*) FROM orders")
                        .mapTo(Integer.class)
                        .one()
        );
    }

    public int getTotalCustomers() {
        return jdbi.withHandle(h ->
                h.createQuery("SELECT COUNT(*) FROM accounts")
                        .mapTo(Integer.class)
                        .one()
        );
    }

    public int getTotalProducts() {
        return jdbi.withHandle(h ->
                h.createQuery("SELECT COUNT(*) FROM products")
                        .mapTo(Integer.class)
                        .one()
        );
    }

    public List<RevenueByMonth> getRevenueByMonth() {
        return jdbi.withHandle(h ->
                h.createQuery("""
                    SELECT MONTH(order_date) AS month,
                           SUM(total_amount) AS revenue
                    FROM orders
                    WHERE status = 'Done'
                    GROUP BY MONTH(order_date)
                    ORDER BY month
                """)
                        .mapToBean(RevenueByMonth.class)
                        .list()
        );
    }

    public List<CategoryOrderStat> getOrdersByCategory() {
        return jdbi.withHandle(h ->
                h.createQuery("""
                    SELECT c.category_name AS categoryName,
                           COUNT(o.order_id) AS totalOrders
                    FROM orders o
                    JOIN order_details od ON o.order_id = od.order_id
                    JOIN products p ON od.product_id = p.product_id
                    JOIN categories c ON p.category_id = c.category_id
                    GROUP BY c.category_name
                """)
                        .mapToBean(CategoryOrderStat.class)
                        .list()
        );
    }

    public List<RecentOrderDto> getRecentOrders(int limit) {
        return jdbi.withHandle(h ->
                h.createQuery("""
                    SELECT o.order_id AS orderId,
                           a.username,
                           o.total_amount AS totalAmount,
                           o.order_date AS orderDate,
                           o.status AS statusOrder
                    FROM orders o
                    JOIN accounts a ON o.account_id = a.account_id
                    ORDER BY o.order_date DESC
                    LIMIT :limit
                """)
                        .bind("limit", limit)
                        .mapToBean(RecentOrderDto.class)
                        .list()
        );
    }
}
