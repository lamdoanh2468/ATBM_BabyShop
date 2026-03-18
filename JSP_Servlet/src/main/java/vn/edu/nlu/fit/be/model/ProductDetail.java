package vn.edu.nlu.fit.be.model;

public class ProductDetail {
    private int productDetailId;
    private int productId;
    private String detailImage;
    private String description;

    //Constructor

    public ProductDetail() {}

    public ProductDetail(int productDetailId, String description, String detailImage, int productId) {
        this.productDetailId = productDetailId;
        this.description = description;
        this.detailImage = detailImage;
        this.productId = productId;
    }

    //Getters & Setters

    public int getProductDetailId() {
        return productDetailId;
    }

    public void setProductDetailId(int productDetailId) {
        this.productDetailId = productDetailId;
    }

    public String getDescription() {
        return description;
    }

    public void setProductDescription(String productDescription) {
        this.description = productDescription;
    }

    public String getDetailImage() {
        return detailImage;
    }

    public void setDetailImage(String detailImg) {
        this.detailImage = detailImg;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }
}
