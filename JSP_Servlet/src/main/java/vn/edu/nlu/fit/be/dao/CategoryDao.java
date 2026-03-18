package vn.edu.nlu.fit.be.dao;

import vn.edu.nlu.fit.be.DB.DBConnect;
import vn.edu.nlu.fit.be.model.Category;

import java.util.ArrayList;
import java.util.List;

public class CategoryDao extends BaseDao {
    List<Category> categories = new ArrayList<>();

    public List<Category> getCategoryList() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM categories").mapToBean(Category.class).list());
    }

    public Category getCategoryById(int id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM categories WHERE category_id = :id")
                        .bind("id",id)
                        .mapToBean(Category.class)
                        .findFirst()
                        .orElse(null));
    }

    public List<Category> findAllCategory() {
        String sql = """
                    SELECT category_id        AS categoryId,
                           category_name      AS categoryName,
                           category_image       AS categoryImage,
                           description AS categoryDescription
                    FROM categories
                """;

        return jdbi.withHandle(h ->
                h.createQuery(sql)
                        .mapToBean(Category.class)
                        .list()
        );
    }
}
