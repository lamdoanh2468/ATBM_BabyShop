package vn.edu.nlu.fit.be.dao;

import vn.edu.nlu.fit.be.model.Brand;
import vn.edu.nlu.fit.be.model.Voucher;

import java.util.List;

public class VoucherDao extends BaseDao {

    // ===== ADMIN: lấy toàn bộ voucher =====
    public List<Voucher> getAll() {
        return jdbi.withHandle(handle ->
                handle.createQuery("""
                        SELECT *
                        FROM vouchers
                        ORDER BY voucher_id DESC
                """)
                        .mapToBean(Voucher.class)
                        .list()
        );
    }

    // ===== INSERT =====
    public void insert(Voucher v) {
        String sql = """
            INSERT INTO vouchers
            (voucher_code, voucher_name, voucher_image, description,
             discount_amount, start_date, end_date)
            VALUES (:code, :name, :image, :desc, :discount, :start, :end)
        """;

        jdbi.useHandle(handle ->
                handle.createUpdate(sql)
                        .bind("code", v.getVoucherCode())
                        .bind("name", v.getVoucherName())
                        .bind("image", v.getVoucherImage())
                        .bind("desc", v.getDescription())
                        .bind("discount", v.getDiscountAmount())
                        .bind("start", v.getStartDate())
                        .bind("end", v.getEndDate())
                        .execute()
        );
    }

    // ===== UPDATE =====
    public void update(Voucher v) {
        String sql = """
            UPDATE vouchers
            SET voucher_code   = :code,
                voucher_name   = :name,
                voucher_image  = :image,
                description    = :desc,
                discount_amount = :discount,
                start_date     = :start,
                end_date       = :end
            WHERE voucher_id = :id
        """;

        jdbi.useHandle(handle ->
                handle.createUpdate(sql)
                        .bind("code", v.getVoucherCode())
                        .bind("name", v.getVoucherName())
                        .bind("image", v.getVoucherImage())
                        .bind("desc", v.getDescription())
                        .bind("discount", v.getDiscountAmount())
                        .bind("start", v.getStartDate())
                        .bind("end", v.getEndDate())
                        .bind("id", v.getVoucherId())
                        .execute()
        );
    }

    // ===== DELETE =====
    public void delete(int id) {
        jdbi.useHandle(handle ->
                handle.createUpdate("DELETE FROM vouchers WHERE voucher_id = :id")
                        .bind("id", id)
                        .execute()
        );
    }

    // ===== FIND =====
    public Voucher findById(int id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("""
                        SELECT *
                        FROM vouchers
                        WHERE voucher_id = :id
                """)
                        .bind("id", id)
                        .mapToBean(Voucher.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public Voucher findByCode(String code) {
        return jdbi.withHandle(handle ->
                handle.createQuery("""
                        SELECT *
                        FROM vouchers
                        WHERE voucher_code = :code
                """)
                        .bind("code", code)
                        .mapToBean(Voucher.class)
                        .findOne()
                        .orElse(null)
        );
    }

    // ===== USER APPLY =====
    public int getDiscountAmount(String code) {
        return jdbi.withHandle(handle ->
                handle.createQuery("""
                        SELECT discount_amount
                        FROM vouchers
                        WHERE voucher_code = :code
                """)
                        .bind("code", code)
                        .mapTo(Integer.class)
                        .one()
        );
    }

    // ===== PAGINATION =====
    public List<Voucher> getByPage(int page, int pageSize) {
        int offset = (page - 1) * pageSize;

        return jdbi.withHandle(handle ->
                handle.createQuery("""
                        SELECT *
                        FROM vouchers
                        ORDER BY voucher_id DESC
                        LIMIT :limit OFFSET :offset
                """)
                        .bind("limit", pageSize)
                        .bind("offset", offset)
                        .mapToBean(Voucher.class)
                        .list()
        );
    }

    public int countAll() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT COUNT(*) FROM vouchers")
                        .mapTo(Integer.class)
                        .one()
        );
    }
}