package vn.edu.nlu.fit.be.model;

import java.sql.Timestamp;

public class Account {

    private int accountId;
    private int profileId;
    private String email;
    private String username;   // dùng làm tên hiển thị
    private String password;
    private AccountStatus status;
    private int role;
    private Timestamp createdAt;

    public Account() {}
    // dùng cho admin_settings.jsp
    public String getFullName() {
        return username;
    }

    public void setFullName(String fullName) {
        this.username = fullName;
    }

    /* ================= Getter / Setter gốc ================= */

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public int getProfileId() {
        return profileId;
    }

    public void setProfileId(int profileId) {
        this.profileId = profileId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public AccountStatus getStatus() {
        return status;
    }

    public void setStatus(AccountStatus status) {
        this.status = status;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
