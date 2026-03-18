package vn.edu.nlu.fit.be.dao;
import vn.edu.nlu.fit.be.model.AccountStatus;
import java.util.List;
import vn.edu.nlu.fit.be.model.Account;

import java.util.Optional;

public class AccountDao extends BaseDao {
    public boolean existsByEmail(String email) {
        return jdbi.withHandle(h ->
                h.createQuery("""
                    SELECT 1
                    FROM accounts
                    WHERE email = :email
                """)
                        .bind("email", email)
                        .mapTo(Integer.class)
                        .findOne()
                        .isPresent()
        );
    }

    public Optional<Account> findByUsernameOrEmail(String key) {
        return jdbi.withHandle(h ->
                h.createQuery("""
                    SELECT *
                    FROM accounts
                    WHERE username = :k OR email = :k
                """)
                        .bind("k", key)
                        .mapToBean(Account.class)
                        .findOne()
        );
    }

    public int insert(Account a) {
        return jdbi.withHandle(h ->
                h.createUpdate("""
                    INSERT INTO accounts
                    (profile_id, email, username, password, status, role)
                    VALUES (:pid, :email, :username, :pw, :status, :role)
                """)
                        .bind("pid", a.getProfileId())
                        .bind("email", a.getEmail())
                        .bind("username", a.getUsername())
                        .bind("pw", a.getPassword())
                        .bind("status", a.getStatus().name())
                        .bind("role", a.getRole())
                        .execute()
        );
    }
    public boolean updatePassword(int accountId, String hashedPassword) {
        return jdbi.withHandle(h ->
                h.createUpdate("""
                UPDATE accounts
                SET password = :pw
                WHERE account_id = :id
            """)
                        .bind("pw", hashedPassword)
                        .bind("id", accountId)
                        .execute()
        ) > 0;
    }
    //Admin
    public boolean updateStatus(int id, AccountStatus status) {
        return jdbi.withHandle(h ->
                h.createUpdate("""
            UPDATE accounts
            SET status = :status
            WHERE account_id = :id
        """)
                        .bind("status", status.name())
                        .bind("id", id)
                        .execute()
        ) > 0;
    }

    public List<Account> findAll() {
        return jdbi.withHandle(h ->
                h.createQuery("""
                SELECT *
                FROM accounts
                ORDER BY account_id DESC
            """)
                        .mapToBean(Account.class)
                        .list()
        );
    }

    public List<Account> search(String keyword) {
        String kw = "%" + keyword + "%";
        return jdbi.withHandle(h ->
                h.createQuery("""
                SELECT *
                FROM accounts
                WHERE username LIKE :kw
                   OR email LIKE :kw
                ORDER BY account_id DESC
            """)
                        .bind("kw", kw)
                        .mapToBean(Account.class)
                        .list()
        );
    }
    public Optional<Account> findByEmail(String email) {
        return jdbi.withHandle(h ->
                h.createQuery("""
                SELECT *
                FROM accounts
                WHERE email = :email
            """)
                        .bind("email", email)
                        .mapToBean(Account.class)
                        .findOne()
        );
    }
    public boolean deleteById(int accountId) {
        return jdbi.withHandle(h ->
                h.createUpdate("""
            DELETE FROM accounts
            WHERE account_id = :id
        """)
                        .bind("id", accountId)
                        .execute()
        ) > 0;
    }
    public Optional<Account> findById(int id) {
        return jdbi.withHandle(h ->
                h.createQuery("""
            SELECT *
            FROM accounts
            WHERE account_id = :id
        """)
                        .bind("id", id)
                        .mapToBean(Account.class)
                        .findOne()
        );
    }
    public boolean update(Account a) {
        return jdbi.withHandle(h ->
                h.createUpdate("""
                UPDATE accounts
                SET email = :email,
                    username = :username,
                    password = :password
                WHERE account_id = :id
            """)
                        .bind("email", a.getEmail())
                        .bind("username", a.getUsername())
                        .bind("password", a.getPassword())
                        .bind("id", a.getAccountId())
                        .execute()
        ) > 0;
    }
}
