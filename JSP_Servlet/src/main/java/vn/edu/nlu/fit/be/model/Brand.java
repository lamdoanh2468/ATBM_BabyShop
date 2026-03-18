package vn.edu.nlu.fit.be.model;

public class Brand {
    private int brandId;
    private String brandName;
    private String brandLogo;
    private String brandDescription;

    //Constructor

    public Brand() {}

    public Brand(int brandId, String brandDescription, String brandLogo, String brandName) {
        this.brandId = brandId;
        this.brandDescription = brandDescription;
        this.brandLogo = brandLogo;
        this.brandName = brandName;
    }

    //Getters & Setters

    public int getBrandId() {
        return brandId;
    }

    public void setBrandId(int brandId) {
        this.brandId = brandId;
    }

    public String getBrandDescription() {
        return brandDescription;
    }

    public void setBrandDescription(String brandDescription) {
        this.brandDescription = brandDescription;
    }

    public String getBrandLogo() {
        return brandLogo;
    }

    public void setBrandLogo(String brandLogo) {
        this.brandLogo = brandLogo;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }
}
