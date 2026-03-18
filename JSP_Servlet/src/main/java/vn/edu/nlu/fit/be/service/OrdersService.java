package vn.edu.nlu.fit.be.service;

import vn.edu.nlu.fit.be.dao.OrdersDao;
import vn.edu.nlu.fit.be.model.*;
import vn.edu.nlu.fit.be.model.CartItem.CartItem;

import java.util.*;

public class OrdersService {

    private OrdersDao dao = new OrdersDao();


    public List<Order> getAll() {
        return dao.getAllOrders();
    }

    public boolean updateStatus(int orderId, OrderStatus status) {
        return dao.updateStatus(orderId, status);
    }

    public Map<Integer, List<OrderDetail>> getPurchasedProductsByAccount(int accountId) {
        return dao.getPurchasedProductsByAccount(accountId);
    }

    public Map<Integer, Integer> getDiscountAmountOrders(Set<Integer> orderIds) {

        Map<Integer, Integer> result = new HashMap<>();

        for (int orderId : orderIds) {
            int discountAmount = dao.getDiscountAmountFromVoucher(orderId);
            result.put(orderId, discountAmount);
        }

        return result;
    }

    public int createOrderFromCart(Account account, Cart cart, String deliveryAddress, PaymentMethod paymentMethod, Integer voucherId, int totalPrice) {

        if (account == null) throw new IllegalArgumentException("Account is null");
        if (cart == null || cart.getTotalQuantity() == 0) throw new IllegalArgumentException("Cart is empty");
        if (deliveryAddress == null || deliveryAddress.trim().isEmpty())
            throw new IllegalArgumentException("Delivery address is empty");

        Order o = new Order();
        o.setAccountId(account.getAccountId());
        o.setVoucherId(voucherId == null ? 0 : voucherId);
        o.setStatusOrder(OrderStatus.Pending);
        o.setTotalAmount(totalPrice);
        o.setDeliveryAddress(deliveryAddress.trim());
        o.setPaymentMethod(paymentMethod);

        // Convert cart items -> order details
        List<OrderDetail> details = new ArrayList<>();

        for (CartItem item : cart.getItems()) {
            OrderDetail d = new OrderDetail();
            d.setProductId(item.getProduct().getProductId());
            d.setUnitPrice(item.getPrice());
            d.setQuantity(item.getQuantity());
            details.add(d);
        }

        // Transaction: insert order + insert details
        return dao.createOrderWithDetails(o, details);
    }

    public void confirmOrder(int orderId, String status) {
        dao.updateOrderStatus(orderId, status);
    }
}

