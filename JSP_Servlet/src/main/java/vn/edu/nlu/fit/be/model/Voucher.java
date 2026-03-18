package vn.edu.nlu.fit.be.model;

import java.sql.Date;

public class Voucher {

    private int voucherId;
    private String voucherCode;
    private String voucherName;
    private String voucherImage;
    private String description;
    private int discountAmount;
    private Date startDate;
    private Date endDate;

    //Constructor

    public Voucher() {}

    public Voucher(int voucherId, Date endDate, Date startDate, int discountAmount, String description, String voucherImage, String voucherName, String voucherCode) {
        this.voucherId = voucherId;
        this.endDate = endDate;
        this.startDate = startDate;
        this.discountAmount = discountAmount;
        this.description = description;
        this.voucherImage = voucherImage;
        this.voucherName = voucherName;
        this.voucherCode = voucherCode;
    }

    // Getters & Setters

    public int getVoucherId() {
        return voucherId;
    }

    public void setVoucherId(int voucherId) {
        this.voucherId = voucherId;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public int getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(int discountAmount) {
        this.discountAmount = discountAmount;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getVoucherImage() {
        return voucherImage;
    }

    public void setVoucherImage(String voucherImage) {
        this.voucherImage = voucherImage;
    }

    public String getVoucherName() {
        return voucherName;
    }

    public void setVoucherName(String voucherName) {
        this.voucherName = voucherName;
    }

    public String getVoucherCode() {
        return voucherCode;
    }

    public void setVoucherCode(String voucherCode) {
        this.voucherCode = voucherCode;
    }
}