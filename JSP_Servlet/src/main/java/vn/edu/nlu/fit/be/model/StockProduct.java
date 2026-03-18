package vn.edu.nlu.fit.be.model;

import java.sql.Timestamp;

public class StockProduct {
    private int stockProductId;
    private int stockId;
    private int productId;
    private int totalQuantity;
    private int soldQuantity;
    private Timestamp totalUpdated;

    //Constructor

    public StockProduct() {}

    public StockProduct(int stockProductId, int productId, int stockId, Timestamp totalUpdated, int soldQuantity, int totalQuantity) {
        this.stockProductId = stockProductId;
        this.totalUpdated = totalUpdated;
        this.soldQuantity = soldQuantity;
        this.totalQuantity = totalQuantity;
        this.productId = productId;
        this.stockId = stockId;
    }

    //Getters and Setters

    public int getStockProductId() {
        return stockProductId;
    }

    public void setStockProductId(int stockProductId) {
        this.stockProductId = stockProductId;
    }

    public Timestamp getTotalUpdated() {
        return totalUpdated;
    }

    public void setTotalUpdated(Timestamp totalUpdated) {
        this.totalUpdated = totalUpdated;
    }

    public int getSoldQuantity() {
        return soldQuantity;
    }

    public void setSoldQuantity(int soldQuantity) {
        this.soldQuantity = soldQuantity;
    }

    public int getTotalQuantity() {
        return totalQuantity;
    }

    public void setTotalQuantity(int totalQuantity) {
        this.totalQuantity = totalQuantity;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getStockId() {
        return stockId;
    }

    public void setStockId(int stockId) {
        this.stockId = stockId;
    }
}
