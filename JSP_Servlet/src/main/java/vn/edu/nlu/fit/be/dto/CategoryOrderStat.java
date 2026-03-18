package vn.edu.nlu.fit.be.dto;

public class CategoryOrderStat {
    private String categoryName;
    private int totalOrders;

    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }

    public int getTotalOrders() { return totalOrders; }
    public void setTotalOrders(int totalOrders) { this.totalOrders = totalOrders; }
}
