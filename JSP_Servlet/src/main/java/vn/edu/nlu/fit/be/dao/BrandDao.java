package vn.edu.nlu.fit.be.dao;

import vn.edu.nlu.fit.be.model.Brand;
import vn.edu.nlu.fit.be.model.Contact;

import java.util.List;

public class BrandDao extends BaseDao {
    public List<Brand> getBrands() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM brands").mapToBean(Brand.class).list());
    }
    public Brand getBrandById(int id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM brands WHERE brand_id = :id")
                        .bind("id",id)
                        .mapToBean(Brand.class)
                        .findFirst()
                        .orElse(null));
    }
    public List<Brand> LoadBrandLatest() {
        String sql = """
        SELECT
            *
        FROM brands
        ORDER BY brand_id DESC
    """;

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .mapToBean(Brand.class)
                        .list()
        );
    }

    public void insertBrand(Brand brand) {
        String sql = """
            INSERT INTO brands (brand_name, brand_logo, description)
            VALUES (:name, :logo, :description)
        """;

        jdbi.useHandle(handle ->
                handle.createUpdate(sql)
                        .bind("name", brand.getBrandName())
                        .bind("logo", brand.getBrandLogo())
                        .bind("description", brand.getBrandDescription())
                        .execute()
        );
    }
    public void deleteBrand(int id) {
        jdbi.useHandle(handle ->
                handle.createUpdate("DELETE FROM brands WHERE brand_id = :id")
                        .bind("id", id)
                        .execute()
        );
    }

    public void updateBrand(Brand brand) {
        jdbi.useHandle(handle ->
                handle.createUpdate("""
            UPDATE brands
            SET brand_name = :name,
                brand_logo = :logo,
                description = :description
            WHERE brand_id = :id
        """)
                        .bind("id", brand.getBrandId())
                        .bind("name", brand.getBrandName())
                        .bind("logo", brand.getBrandLogo())
                        .bind("description", brand.getBrandDescription())
                        .execute()
        );
    }
}
