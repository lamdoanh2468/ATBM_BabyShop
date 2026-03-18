package vn.edu.nlu.fit.be.dao;

import org.jdbi.v3.core.Jdbi;
import vn.edu.nlu.fit.be.DB.DBConnect;

public abstract class BaseDao {
    // Đối tượng Jdbi dùng chung cho tất cả các DAO con
    protected Jdbi jdbi;

    public BaseDao() {
        // Lấy instance Jdbi từ class DBConnect
        this.jdbi = DBConnect.get();
    }

}

