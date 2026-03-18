package vn.edu.nlu.fit.be.model;

import java.io.Serializable;

public class ProductListImg implements Serializable {

    private int productImgId;
    private int productId;
    private String productImg;

    //Constructor

    public ProductListImg() {}

    public ProductListImg(int productImgId, String productImg, int productId) {
        this.productImgId = productImgId;
        this.productImg = productImg;
        this.productId = productId;
    }

    //Setters & Getters

    public int getProductImgId() {
        return productImgId;
    }

    public void setProductImgId(int productImgId) {
        this.productImgId = productImgId;
    }

    public String getProductImg() {
        return productImg;
    }

    public void setProductImg(String productImg) {
        this.productImg = productImg;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }
}
