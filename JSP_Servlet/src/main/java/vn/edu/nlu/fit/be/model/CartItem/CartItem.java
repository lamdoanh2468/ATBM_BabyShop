package vn.edu.nlu.fit.be.model.CartItem;

import vn.edu.nlu.fit.be.model.Product;

import java.io.Serializable;

public class CartItem implements Serializable {
    private int quantity;
    private int price;
    private Product product;

    public CartItem() {
    }

    public CartItem(int quantity, int price, Product product) {
        this.quantity = quantity;
        this.price = price;
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public void updateQuantity(int quantity) {
        this.quantity += quantity;
    }
}
