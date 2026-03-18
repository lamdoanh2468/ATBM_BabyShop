package vn.edu.nlu.fit.be.model;

public class Stock {
    private int stockId;
    private String stockName;
    private String stockAddress;
    private int productCount; // tổng số sản phẩm trong kho

    public Stock() {}

    public Stock(int stockId, String stockName, String stockAddress) {
        this.stockId = stockId;
        this.stockName = stockName;
        this.stockAddress = stockAddress;
    }

    // Getters & Setters
    public int getStockId() { return stockId; }
    public void setStockId(int stockId) { this.stockId = stockId; }

    public String getStockName() { return stockName; }
    public void setStockName(String stockName) { this.stockName = stockName; }

    public String getStockAddress() { return stockAddress; }
    public void setStockAddress(String stockAddress) { this.stockAddress = stockAddress; }

    public int getProductCount() { return productCount; }
    public void setProductCount(int productCount) { this.productCount = productCount; }
}
