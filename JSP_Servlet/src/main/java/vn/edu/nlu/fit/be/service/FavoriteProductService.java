package vn.edu.nlu.fit.be.service;

import vn.edu.nlu.fit.be.dao.FavoriteProductDao;
import vn.edu.nlu.fit.be.model.FavoriteProduct;
import vn.edu.nlu.fit.be.model.Product;

import java.util.List;

public class FavoriteProductService {
    private final FavoriteProductDao dao = new FavoriteProductDao();

    // yêu thích
    public boolean toggle(int accountId, int productId) {
        if (dao.exists(accountId, productId)) {
            dao.delete(accountId, productId);
            return false; // bỏ yêu thích
        } else {
            dao.insert(accountId, productId);
            return true; // thêm yêu thích
        }
    }

    // Danh sách yêu thích của user
    public List<Product> getFavorites(int accountId) {
        return dao.findByAccountId(accountId);
    }

    // Kiểm tra 1 sản phẩm có được yêu thích không
    public boolean isFavorite(int accountId, int productId) {
        return dao.exists(accountId, productId);
    }
}
