package vn.edu.nlu.fit.be.model;

public class Contact {

    private int contactId;
    private int accountId;
    private String fullName;
    private String phone;
    private String email;
    private String address;
    private String message;

    //Constructor

    public Contact() {
    }

    public Contact(int contactId, int accountId, String fullName, String phone, String email, String address, String message) {
        this.contactId = contactId;
        this.accountId = accountId;
        this.fullName = fullName;
        this.phone = phone;
        this.email = email;
        this.address = address;
        this.message = message;
    }

    // Getters & Setters

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public int getContactId() {
        return contactId;
    }

    public void setContactId(int contactId) {
        this.contactId = contactId;
    }
}