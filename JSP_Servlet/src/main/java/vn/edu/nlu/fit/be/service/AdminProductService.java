package vn.edu.nlu.fit.be.service;

import vn.edu.nlu.fit.be.dao.ProductDao;
import vn.edu.nlu.fit.be.model.Product;

import java.util.List;

public class AdminProductService {

    private final ProductDao productDao = new ProductDao();

    /* ===== LIST + SEARCH ===== */

    public List<Product> getAll(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return productDao.findAll();
        }
        return productDao.search(keyword);
    }

    public Product getById(int id) {
        return productDao.findById(id);
    }

    /* ===== CRUD ===== */

    public boolean insert(Product p) {
        return productDao.insert(p) > 0;
    }

    public boolean update(Product p) {
        return productDao.update(p);
    }

    public boolean delete(int id) {
        return productDao.delete(id);
    }
    // Lấy toàn bộ product cho trang admin
    public List<Product> getAllProducts() {
        return productDao.getAllProducts();
    }

    // Tìm kiếm theo tên (admin)
    public List<Product> search(String keyword) {
        return productDao.searchByName(keyword);
    }
}
