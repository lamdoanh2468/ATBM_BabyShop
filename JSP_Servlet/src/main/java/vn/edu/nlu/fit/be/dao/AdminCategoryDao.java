package vn.edu.nlu.fit.be.dao;

import vn.edu.nlu.fit.be.model.Category;

import java.util.List;

public class AdminCategoryDao extends BaseDao {

    // ===== READ =====
    public List<Category> findAll() {
        String sql = """
       SELECT
           category_id    AS categoryId,
           category_name  AS categoryName,
           category_image AS categoryImage,
           description
       FROM categories
        ORDER BY category_id DESC
    """;

        return jdbi.withHandle(h ->
                h.createQuery(sql)
                        .mapToBean(Category.class)
                        .list()
        );
    }


    public Category findById(int id) {
        String sql = """
        SELECT 
            category_id    AS categoryId,
            category_name  AS categoryName,
            category_image AS categoryImage,
            description
        FROM categories
        WHERE category_id = :id
    """;

        return jdbi.withHandle(h ->
                h.createQuery(sql)
                        .bind("id", id)
                        .mapToBean(Category.class)
                        .findOne()
                        .orElse(null)
        );
    }

    // ===== CREATE =====
    public boolean insert(Category c) {
        String sql = """
        INSERT INTO categories (category_name, category_image, description)
        VALUES (:name, :img, :desc)
    """;

        return jdbi.withHandle(h ->
                h.createUpdate(sql)
                        .bind("name", c.getCategoryName())
                        .bind("img", c.getCategoryImage())
                        .bind("desc", c.getDescription())
                        .execute()
        ) > 0;
    }

    // ===== UPDATE =====
    public boolean update(Category c) {
        String sql = """
            UPDATE categories
            SET category_name = :name
            WHERE category_id = :id
        """;

        return jdbi.withHandle(h ->
                h.createUpdate(sql)
                        .bind("id", c.getCategoryId())
                        .bind("name", c.getCategoryName())
                        .execute()
        ) > 0;
    }

    // ===== DELETE =====
    public boolean delete(int id) {
        return jdbi.withHandle(h ->
                h.createUpdate("DELETE FROM categories WHERE category_id = :id")
                        .bind("id", id)
                        .execute()
        ) > 0;
    }
}
