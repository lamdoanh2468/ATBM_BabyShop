package vn.edu.nlu.fit.be.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.nlu.fit.be.model.*;
import vn.edu.nlu.fit.be.model.CartItem.CartItem;
import vn.edu.nlu.fit.be.service.*;

import java.io.IOException;

@WebServlet(name = "OrderController", value = "/order")
public class OrderController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        VoucherService voucherService = new VoucherService();
        OrdersService ordersService = new OrdersService();
        StockProductService spService = new StockProductService();
        Account account = (Account) session.getAttribute("USER");
        if (account == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getTotalQuantity() == 0) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        request.setCharacterEncoding("UTF-8");

        String deliveryAddress = request.getParameter("deliveryAddress");
        String paymentMethodStr = request.getParameter("paymentMethod");
        String voucherCode = request.getParameter("voucherCode");
        if (voucherCode == null || voucherCode.trim().isEmpty()) {
            voucherCode = (String) session.getAttribute("voucherCode");
        }
        String action = request.getParameter("action");

        // Validate địa chỉ giao hàng (chỉ khi không phải action voucher)
        if (action == null && (deliveryAddress == null || deliveryAddress.trim().isEmpty())) {
            request.setAttribute("error", "Vui lòng nhập địa chỉ giao hàng");
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
            return;
        }


        PaymentMethod paymentMethod;
        try {
            paymentMethod = PaymentMethod.valueOf(paymentMethodStr);
        } catch (Exception e) {
            paymentMethod = PaymentMethod.COD;
        }

        //===== Áp dụng phần voucher =====
        int totalPrice = cart.getTotalPrice();
        int discount = 0;
        Integer discountAmount = (Integer) session.getAttribute("discountAmount");
        if (discountAmount != null) {
            discount = discountAmount;
        }
        int discountSafe = Math.min(discount, totalPrice);
        totalPrice = totalPrice - discountSafe;
        if ("applyVoucher".equals(action)) {
            Voucher v = voucherService.findByCode(voucherCode);
            if (v == null) {
                request.setAttribute("voucherError", "Mã voucher không hợp lệ");
                request.getRequestDispatcher("/cart.jsp").forward(request, response);
                return;
            }
            // Lưu vào session
            session.setAttribute("discountAmount", v.getDiscountAmount());
            session.setAttribute("voucherCode", voucherCode);
            session.setAttribute("finalPrice", totalPrice);
            session.setAttribute("deliveryAddress", deliveryAddress);
            session.setAttribute("paymentMethod", paymentMethod);
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
            return;
        }
        if ("removeVoucher".equals(action)) {
            // Lưu vào session
            session.removeAttribute("discountAmount");
            session.removeAttribute("voucherCode");
            session.setAttribute("deliveryAddress", deliveryAddress);
            session.setAttribute("paymentMethod", paymentMethod);
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
            return;
        }
        // Xử lý voucher an toàn, tránh NullPointerException
        Voucher voucher = null;
        if (voucherCode != null && !voucherCode.trim().isEmpty()) {
            voucher = voucherService.findByCode(voucherCode);
        }

        // =====================
        Integer voucherId = (voucher != null) ? voucher.getVoucherId() : null;

        // đảm bảo không âm
        if (spService.checkAvailable(cart)) {
            int orderId = ordersService.createOrderFromCart(account, cart, deliveryAddress, paymentMethod, voucherId, totalPrice);
            for (CartItem item : cart.getItems()) {
                int productId = item.getProduct().getProductId();
                int quantity = item.getQuantity();
                spService.updateStockProduct(productId, quantity);
            }
            ordersService.updateStatus(orderId,OrderStatus.Pending);
            // clear cart và session attributes
            cart.removeAllItems();
            session.setAttribute("cart", cart);
            session.removeAttribute("discountAmount");
            session.removeAttribute("voucherCode");
            session.removeAttribute("finalPrice");
            session.removeAttribute("deliveryAddress");
            session.removeAttribute("paymentMethod");

            // redirect về cart kèm orderId
            response.sendRedirect(request.getContextPath() + "/cart?paid=1&orderId=" + orderId);
        } else {
            // Lấy danh sách sản phẩm không đủ hàng để hiển thị cho user
            java.util.List<String> outOfStockProducts = spService.getOutOfStockProducts(cart);
            String errorMessage = "Không đủ số lượng tồn kho cho: " + String.join(", ", outOfStockProducts);
            session.setAttribute("stockError", errorMessage);
            response.sendRedirect(request.getContextPath() + "/cart?paid=0");
        }

    }
}