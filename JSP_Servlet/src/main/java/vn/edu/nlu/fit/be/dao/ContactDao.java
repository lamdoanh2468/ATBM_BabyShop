package vn.edu.nlu.fit.be.dao;

import vn.edu.nlu.fit.be.model.Contact;
import vn.edu.nlu.fit.be.dao.BaseDao;

import java.util.List;

import static vn.edu.nlu.fit.be.DB.DBConnect.jdbi;

public class ContactDao extends BaseDao {
    public int insertContact(Contact contact) {
        String sql = "INSERT INTO contacts (account_id, full_name, phone, email, address, message) " +
                "VALUES (:accountId, :fullName, :phone, :email, :address, :message)";
        return jdbi.withHandle(handle ->
                handle.createUpdate(sql)
                        .bindBean(contact)
                        .execute());
    }
    public List<Contact> LoadContactLatest() {
        String sql = """
        SELECT
            contact_id AS contactId,
            account_id AS accountId,
            full_name AS fullName,
            phone,
            email,
            address,
            message
        FROM contacts
        ORDER BY contact_id DESC
    """;

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .mapToBean(Contact.class)
                        .list()
        );
    }
    public Contact findById(int id) {
        String sql = "SELECT * FROM contacts WHERE contact_id = :id";
        return jdbi.withHandle(h ->
                h.createQuery(sql)
                        .bind("id", id)
                        .mapToBean(Contact.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public void deleteById(int id) {
        String sql = "DELETE FROM contacts WHERE contact_id = :id";
        jdbi.withHandle(h ->
                h.createUpdate(sql)
                        .bind("id", id)
                        .execute()
        );
    }
}

