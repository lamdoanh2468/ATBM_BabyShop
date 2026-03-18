package vn.edu.nlu.fit.be.DB;

import org.jdbi.v3.core.Jdbi;

import java.sql.*;

public class DBConnect {
    public static Jdbi jdbi;

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Tạo URL MySQL
            String url = "jdbc:mysql://" +
                    DBProperties.host + ":" +
                    DBProperties.port + "/" +
                    DBProperties.dbname + "?" +
                    DBProperties.option;

            System.out.println("🔌 MySQL URL: " + url);

            jdbi = Jdbi.create(url, DBProperties.user, DBProperties.password);

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("❌ Không thể kết nối JDBI: " + e.getMessage());
        }
    }

    // Trả về 1 instance duy nhất dùng cho toàn project
    public static Jdbi get() {
        return jdbi;
    }

    // Test nhanh
    public static void main(String[] args) {
        try {
            String now = jdbi.withHandle(handle ->
                    handle.createQuery("SELECT NOW()").mapTo(String.class).one()
            );
            System.out.println("⏳ DB Time = " + now);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
