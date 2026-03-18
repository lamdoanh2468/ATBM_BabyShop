package vn.edu.nlu.fit.be.model;

import java.sql.Date;
import java.sql.Timestamp;

public class Profile {

    private int profileId;
    private String fullName;
    private String email;
    private String phone;
    private String address;
    private Gender gender;
    private String avatarUrl;
    private Date birthDate;
    private Timestamp updatedAt;

    //Constructor

    public Profile() {}

    public Profile(int profileId, Timestamp updatedAt, Date birthDate, String avatarUrl, Gender gender, String address, String phone, String email, String fullName) {
        this.profileId = profileId;
        this.updatedAt = updatedAt;
        this.birthDate = birthDate;
        this.avatarUrl = avatarUrl;
        this.gender = gender;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.fullName = fullName;
    }

    // Getters & Setters

    public int getProfileId() {
        return profileId;
    }

    public void setProfileId(int profileId) {
        this.profileId = profileId;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public String getAvatarUrl() {
        return avatarUrl;
    }

    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }

    public Gender getGender() {
        return gender;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
}
