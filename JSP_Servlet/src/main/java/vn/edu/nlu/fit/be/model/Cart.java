package vn.edu.nlu.fit.be.model;

import vn.edu.nlu.fit.be.model.CartItem.CartItem;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;

public class Cart implements Serializable {
    Map<Integer, CartItem> data;

    public Cart() {
        data = new HashMap<>();
    }

    public void addItem(Product product, int quantity) {
        if (quantity <= 0) quantity = 1;
        if (get(product.getProductId()) != null)
            data.get(product.getProductId()).updateQuantity(quantity);
        else
            data.put(product.getProductId(), new CartItem(quantity, product.getProductPrice(), product));
    }

    public boolean updateItem(int productId, int quantity) {
        if (get(productId) == null) return false;
        if (quantity <= 0) quantity = 1;
        data.get(productId).setQuantity(quantity);
        return true;
    }

    public CartItem removeItem(int productId) {
        if (get(productId) == null) return null;
        return data.remove(productId);
    }

    public List<CartItem> removeAllItems() {
        ArrayList<CartItem> cartItems = new ArrayList<>(data.values());
        data.clear();
        return cartItems;
    }

    public List<CartItem> getItems() {
        return new ArrayList<>(data.values());
    }

    public CartItem get(int productId) {
        return data.get(productId);
    }

    public int getTotalQuantity() {
        int total = 0;
        for (CartItem item : data.values()) {
            total += item.getQuantity();
        }
        return total;
    }

    public int getTotalPrice() {
        int total = 0;
        for (CartItem item : data.values()) {
            total += item.getQuantity() * item.getPrice();
        }
        return total;
    }

}
