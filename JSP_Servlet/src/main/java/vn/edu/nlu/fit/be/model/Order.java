package vn.edu.nlu.fit.be.model;

import java.sql.Timestamp;

public class Order {

    private int orderId;
    private int accountId;
    private int voucherId;

    private OrderStatus statusOrder;
    private int subtotalAmount;
    private int discountAmount;
    private int totalAmount;
    private String deliveryAddress;
    private PaymentMethod paymentMethod;
    private Timestamp orderDate;
    private String username;


    public Order() {
    }

    public Order(int orderId, Timestamp orderDate, PaymentMethod paymentMethod, String deliveryAddress, int subtotalAmount, int discountAmount, int totalAmount, OrderStatus statusOrder, int voucherId, int accountId) {
        this.orderId = orderId;
        this.orderDate = orderDate;
        this.paymentMethod = paymentMethod;
        this.deliveryAddress = deliveryAddress;
        this.subtotalAmount = subtotalAmount;
        this.discountAmount = discountAmount;
        this.totalAmount = totalAmount;
        this.statusOrder = statusOrder;
        this.voucherId = voucherId;
        this.accountId = accountId;

    }

    public int getSubtotalAmount() {
        return subtotalAmount;
    }

    public void setSubtotalAmount(int subtotalAmount) {
        this.subtotalAmount = subtotalAmount;
    }

    public int getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(int discountAmount) {
        this.discountAmount = discountAmount;
    }

    //Constructor

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    // Getters & Setters

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public int getVoucherId() {
        return voucherId;
    }

    public void setVoucherId(int voucherId) {
        this.voucherId = voucherId;
    }

    public OrderStatus getStatusOrder() {
        return statusOrder;
    }

    public void setStatusOrder(OrderStatus statusOrder) {
        this.statusOrder = statusOrder;
    }

    public int getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(int totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getDeliveryAddress() {
        return deliveryAddress;
    }

    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }

    public PaymentMethod getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(PaymentMethod paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

}
