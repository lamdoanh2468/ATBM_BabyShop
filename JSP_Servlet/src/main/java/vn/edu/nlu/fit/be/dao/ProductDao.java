package vn.edu.nlu.fit.be.dao;

import org.jdbi.v3.core.statement.Query;
import vn.edu.nlu.fit.be.model.*;

import java.util.*;
import org.jdbi.v3.core.statement.Update;

public class ProductDao extends BaseDao {
    List<Product> products = new ArrayList<>();

    public List<Product> getProductList() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM products").mapToBean(Product.class).list());
    }

    public Product getProductById(int id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM products WHERE product_id = :id")
                        .bind("id", id)
                        .mapToBean(Product.class)
                        .findOne()
                        .orElse(null))
                ;
    }

    public List<Product> getProductsBy(Integer categoryId, String[] brandNames, String sortType, String keyword, Integer limit, Integer offset) {
        StringBuilder sqlQuery = new StringBuilder("SELECT p.*,SUM(sp.sold_quantity) as total_sold");
        sqlQuery.append(" FROM products p");

        //Join table
        sqlQuery.append(" LEFT JOIN stock_products sp ON p.product_id = sp.product_id ");
        sqlQuery.append(" LEFT JOIN brands b ON p.brand_id = b.brand_id");
        sqlQuery.append(" WHERE 1=1 "); // để dùng AND cho dễ dàng

        if (categoryId != null) {
            sqlQuery.append(" AND p.category_id = :catId");
        }
        if (keyword != null && !keyword.isEmpty()) {
            sqlQuery.append(" AND LOWER(p.product_name) LIKE LOWER(:keyword)");
        }
        if (brandNames != null && brandNames.length > 0) {
            sqlQuery.append(" AND b.brand_name IN (<brandNames>)");
        }

        // Nhóm theo product id
        sqlQuery.append(" GROUP BY p.product_id");

        if (sortType != null) {
            switch (sortType) {
                case "price_asc":
                    sqlQuery.append(" ORDER BY p.product_price ASC ");
                    break;
                case "price_desc":
                    sqlQuery.append(" ORDER BY p.product_price DESC ");
                    break;
                case "oldest":
                    sqlQuery.append(" ORDER BY p.created_at ASC ");
                    break;
                case "latest":
                    sqlQuery.append(" ORDER BY p.created_at DESC ");
                    break;
                case "best_selling":
                    sqlQuery.append(" ORDER BY total_sold DESC ");
                    break;
                default:
                    sqlQuery.append(" ORDER BY p.product_id DESC ");
            }

        }
        if (limit != null) {
            sqlQuery.append(" LIMIT :limit");
        }
        if (offset != null) {
            sqlQuery.append(" OFFSET :offset");
        }
        return jdbi.withHandle(handle -> {
                    Query query = handle.createQuery(sqlQuery.toString());
                    if (categoryId != null) {
                        query.bind("catId", categoryId);
                    }
                    if (keyword != null && !keyword.isEmpty()) {
                        query.bind("keyword", "%" + keyword + "%");
                    }
                    if (brandNames != null && brandNames.length > 0) {
                        query.bindList("brandNames", Arrays.asList(brandNames));
                    }
                    //Bind tham số limit và offset cho phân trang
                    if (limit != null) {
                        query.bind("limit", limit);

                    }
                    if (offset != null) {
                        query.bind("offset", offset);

                    }
                    return query.mapToBean(Product.class).list();
                }
        );
    }


    public int countTotalProductsBy(Integer categoryId, String[] brands, String keyword) {
        StringBuilder sqlQuery = new StringBuilder("SELECT COUNT(p.product_id) FROM products p");
        sqlQuery.append(" LEFT JOIN brands b ON p.brand_id = b.brand_id");
        sqlQuery.append(" WHERE 1=1");

        if (categoryId != null) {
            sqlQuery.append(" AND p.category_id = :catId");
        }
        if (keyword != null && !keyword.isEmpty()) {
            sqlQuery.append(" AND LOWER(p.product_name) LIKE LOWER(:keyword)");
        }
        if (brands != null && brands.length > 0) {
            sqlQuery.append(" AND b.brand_name IN(<brand_name>)");
        }


        return jdbi.withHandle(handle -> {
                    Query query = handle.createQuery(sqlQuery.toString());
                    if (categoryId != null) {
                        query.bind("catId", categoryId);
                    }
                    if (keyword != null && !keyword.isEmpty()) {
                        query.bind("keyword", "%" + keyword + "%");
                    }
                    if (brands != null && brands.length > 0) {
                        query.bindList("brand_name", brands);
                    }
                    return query.mapTo(Integer.class).one();
                }
        );
    }

    public int getTotalSoldQuantity(int productId) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT SUM(sold_quantity) FROM stock_products" +
                                " WHERE product_id = :id")
                        .bind("id", productId)
                        .mapTo(Integer.class).one()
        );
    }


// ================= ADMIN =================

    public List<Product> getAllForAdmin() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM products ORDER BY product_id DESC")
                        .mapToBean(Product.class)
                        .list()
        );
    }

    public void insertProduct(Product p) {
        String sql = """
        INSERT INTO products
        (product_name, product_price, product_img, product_size,
         product_material, brand_id, category_id, created_product)
        VALUES (?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)
    """;

        jdbi.useHandle(handle ->
                handle.createUpdate(sql)
                        .bind(0, p.getProductName())
                        .bind(1, p.getProductPrice())
                        .bind(2, p.getProductImage())
                        .bind(3, p.getProductSize())
                        .bind(4, p.getProductMaterial())
                        .bind(5, p.getBrandId())
                        .bind(6, p.getCategoryId())
                        .execute()
        );
    }

    public void updateProduct(Product p) {
        String sql = """
        UPDATE products SET
            product_name = ?,
            product_price = ?,
            product_img = ?,
            product_size = ?,
            product_material = ?,
            brand_id = ?,
            category_id = ?
        WHERE product_id = ?
    """;

        jdbi.useHandle(handle ->
                handle.createUpdate(sql)
                        .bind(0, p.getProductName())
                        .bind(1, p.getProductPrice())
                        .bind(2, p.getProductImage())
                        .bind(3, p.getProductSize())
                        .bind(4, p.getProductMaterial())
                        .bind(5, p.getBrandId())
                        .bind(6, p.getCategoryId())
                        .bind(7, p.getProductId())
                        .execute()
        );
    }

    public void deleteProduct(int productId) {
        jdbi.useHandle(handle ->
                handle.createUpdate("DELETE FROM products WHERE product_id = :id")
                        .bind("id", productId)
                        .execute());
    }

    public List<String> getImagesListInProduct(int productId) {
        return jdbi.withHandle(
                handle ->
                        handle.createQuery("SELECT img.image FROM product_images img" +

                                        " JOIN products p ON img.product_id = p.product_id" +
                                        " WHERE img.product_id =:id")
                                .bind("id", productId)
                                .mapTo(String.class)
                                .list()
        );
    }

    public List<Map<String, Object>> getProductDetails(int productId) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT detail_image, description FROM product_details WHERE product_id = :id ORDER BY product_detail_id ASC")

                        .bind("id", productId)
                        .mapToMap()
                        .list()
        );
    }

    //Lay ra 20 san pham moi nhat trang home
    public List<Product> getLatestProductsByCategory(int categoryId, int limit) {
        String sql = """
        SELECT
            p.product_id        AS productId,
            p.category_id       AS categoryId,
            p.brand_id          AS brandId,

            p.product_image     AS productImage,
            p.product_name      AS productName,
            p.product_price     AS productPrice,
            p.product_size      AS productSize,
            p.product_material  AS productMaterial,
            p.created_at        AS createdProduct

        FROM products p
        WHERE p.category_id = :catId
        ORDER BY p.created_at DESC
        LIMIT :limit
    """;

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("catId", categoryId)
                        .bind("limit", limit)
                        .mapToBean(Product.class)
                        .list()
        );
    }

    public List<Product> findAll() {
        String sql = """
            SELECT *
            FROM products
            ORDER BY product_id DESC
        """;

        return jdbi.withHandle(h ->
                h.createQuery(sql)
                        .mapToBean(Product.class)
                        .list()
        );
    }

    public List<Product> search(String keyword) {
        String sql = """
            SELECT *
            FROM products
            WHERE product_name LIKE :kw
            ORDER BY product_id DESC
        """;

        return jdbi.withHandle(h ->
                h.createQuery(sql)
                        .bind("kw", "%" + keyword + "%")
                        .mapToBean(Product.class)
                        .list()
        );
    }

    public Product findById(int id) {
        String sql = """
            SELECT *
            FROM products
            WHERE product_id = :id
        """;

        return jdbi.withHandle(h ->
                h.createQuery(sql)
                        .bind("id", id)
                        .mapToBean(Product.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public int insert(Product p) {
        String sql = """
            INSERT INTO products
            (product_name, product_price, category_id, brand_id,
             product_image, product_size, product_material)
            VALUES
            (:name, :price, :category, :brand,
             :image, :size, :material)
        """;

        return jdbi.withHandle(h ->
                h.createUpdate(sql)
                        .bind("name", p.getProductName())
                        .bind("price", p.getProductPrice())
                        .bind("category", p.getCategoryId())
                        .bind("brand", p.getBrandId())
                        .bind("image", p.getProductImage())
                        .bind("size", p.getProductSize())
                        .bind("material", p.getProductMaterial())
                        .execute()
        );
    }
    public boolean update(Product p) {
        String baseSql = """
        UPDATE products
        SET product_name = :name,
            product_price = :price,
            category_id = :category,
            brand_id = :brand,
            product_size = :size,
            product_material = :material
            ${IMAGE}
        WHERE product_id = :id
    """;

        boolean hasImage = p.getProductImage() != null;

        String finalSql = hasImage
                ? baseSql.replace("${IMAGE}", ", product_image = :image")
                : baseSql.replace("${IMAGE}", "");

        return jdbi.withHandle(h -> {
            Update u = h.createUpdate(finalSql)
                    .bind("id", p.getProductId())
                    .bind("name", p.getProductName())
                    .bind("price", p.getProductPrice())
                    .bind("category", p.getCategoryId())
                    .bind("brand", p.getBrandId())
                    .bind("size", p.getProductSize())
                    .bind("material", p.getProductMaterial());

            if (hasImage) {
                u.bind("image", p.getProductImage());
            }

            return u.execute();
        }) > 0;
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM products WHERE product_id = :id";

        return jdbi.withHandle(h ->
                h.createUpdate(sql)
                        .bind("id", id)
                        .execute()
        ) > 0;
    }
    // ===== ADMIN SIMPLE LIST =====
    public List<Product> getAllProducts() {
        return findAll();
    }

    public List<Product> searchByName(String keyword) {
        return search(keyword);
    }
}

