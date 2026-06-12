package vn.edu.nlu.fit.be.controller;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.nlu.fit.be.dto.OrderToSignRes;
import vn.edu.nlu.fit.be.dto.SignPackageRes;
import vn.edu.nlu.fit.be.model.Account;
import vn.edu.nlu.fit.be.model.Cart;
import vn.edu.nlu.fit.be.model.CartItem.CartItem;
import vn.edu.nlu.fit.be.model.PaymentMethod;
import vn.edu.nlu.fit.be.model.Voucher;
import vn.edu.nlu.fit.be.service.*;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "OrderController", value = "/order")
public class OrderController extends HttpServlet {

    private final VoucherService voucherService = new VoucherService();
    private final OrdersService ordersService = new OrdersService();
    private final StockProductService stockProductService = new StockProductService();
    private final OrderSigningService orderSigningService = new OrderSigningService();
    private final CertificateService certificateService = new CertificateService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/cart");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("USER") == null) {
            if (ajax) {
                writeJson(response, false, "Bạn cần đăng nhập trước khi thanh toán", null);
            } else {
                response.sendRedirect(request.getContextPath() + "/login");
            }
            return;
        }

        Account account = (Account) session.getAttribute("USER");
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null || cart.getTotalQuantity() == 0) {
            if (ajax) {
                writeJson(response, false, "Giỏ hàng đang trống", null);
            } else {
                response.sendRedirect(request.getContextPath() + "/cart");
            }
            return;
        }

        String action = request.getParameter("orderAction");
        String deliveryAddress = trimToNull(request.getParameter("deliveryAddress"));
        String voucherCode = trimToNull(request.getParameter("voucherCode"));
        if (voucherCode == null) {
            voucherCode = (String) session.getAttribute("voucherCode");
        }

        PaymentMethod paymentMethod = parsePaymentMethod(request.getParameter("paymentMethod"));

        if ("applyVoucher".equals(action)) {
            applyVoucher(request, response, session, deliveryAddress, paymentMethod, voucherCode);
            return;
        }

        if ("removeVoucher".equals(action)) {
            removeVoucher(request, response, session, deliveryAddress, paymentMethod);
            return;
        }

        if (deliveryAddress == null) {
            if (ajax) {
                writeJson(response, false, "Vui lòng nhập địa chỉ giao hàng", null);
            } else {
                request.setAttribute("error", "Vui lòng nhập địa chỉ giao hàng");
                request.getRequestDispatcher("/cart.jsp").forward(request, response);
            }
            return;
        }
        if (!stockProductService.checkAvailable(cart)) {
            var outOfStockProducts = stockProductService.getOutOfStockProducts(cart);
            String message = "Không đủ số lượng tồn kho cho: " + String.join(", ", outOfStockProducts);

            if (ajax) {
                writeJson(response, false, message, null);
            } else {
                session.setAttribute("stockError", message);
                response.sendRedirect(request.getContextPath() + "/cart?paid=0");
            }
            return;
        }

        Voucher voucher = voucherCode == null ? null : voucherService.findByCode(voucherCode);
        Integer voucherId = voucher == null ? null : voucher.getVoucherId();
        int finalPrice = calculateFinalPrice(cart, session);

        try {
            certificateService.ensureActiveCert(account.getAccountId());

            int orderId = ordersService.createOrderFromCart(
                    account,
                    cart,
                    deliveryAddress,
                    paymentMethod,
                    voucherId,
                    finalPrice);

            for (CartItem item : cart.getItems()) {
                stockProductService.updateStockProduct(item.getProduct().getProductId(), item.getQuantity());
            }

            // Tạo key/certificate nếu user chưa có certificate hợp lệ.
            // Lưu snapshot bất biến vào ORDER_SIGNS và sinh SHA-256 orderHash.
            orderSigningService.createOrderSignSnapshot(orderId, account.getAccountId());
            OrderToSignRes orderToSign = orderSigningService.getOrderToSign(orderId, account.getAccountId());
            SignPackageRes signingPackage = orderSigningService.getSigningPackage(orderId, account.getAccountId());

            String orderHash = orderToSign == null ? "" : orderToSign.getOrderHash();

            session.setAttribute("showSignPopup", true);
            session.setAttribute("signOrderId", orderId);
            session.setAttribute("signOrderHash", orderHash);
            session.setAttribute("signingUrl", signingPackage.getSigningUrl());

            if (certificateService.hasPendingPrivateKey(account.getAccountId())) {
                session.setAttribute("privateKeyUrl", "/security-key/download-private-key");
            } else {
                session.removeAttribute("privateKeyUrl");
            }

            clearCartSession(session, cart);

            if (ajax) {
                Map<String, Object> data = new HashMap<>();
                data.put("orderId", orderId);
                data.put("orderHash", orderHash);
                data.put("signingUrl", request.getContextPath() + signingPackage.getSigningUrl());
                data.put("signToolUrl", request.getContextPath() + "/security-key/download-sign-app");

                if (certificateService.hasPendingPrivateKey(account.getAccountId())) {
                    data.put("privateKeyUrl", request.getContextPath() + "/security-key/download-private-key");
                }

                writeJson(response, true, "Tạo đơn hàng chờ ký thành công", data);
                return;
            }

            response.sendRedirect(request.getContextPath() + "/cart?waitingSignature=1");
        } catch (Exception e) {
            if (ajax) {
                writeJson(response, false, "Không thể tạo đơn hàng cần ký: " + e.getMessage(), null);
            } else {
                request.setAttribute("error", "Không thể tạo đơn hàng cần ký: " + e.getMessage());
                request.getRequestDispatcher("/cart.jsp").forward(request, response);
            }
        }
    }

    private void applyVoucher(HttpServletRequest request, HttpServletResponse response, HttpSession session,
                              String deliveryAddress, PaymentMethod paymentMethod, String voucherCode)
            throws ServletException, IOException {
        if (voucherCode == null) {
            request.setAttribute("voucherError", "Vui lòng nhập mã voucher");
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
            return;
        }

        Voucher voucher = voucherService.findByCode(voucherCode);
        if (voucher == null) {
            request.setAttribute("voucherError", "Mã voucher không hợp lệ");
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
            return;
        }

        session.setAttribute("discountAmount", voucher.getDiscountAmount());
        session.setAttribute("voucherCode", voucherCode);
        session.setAttribute("deliveryAddress", deliveryAddress);
        session.setAttribute("paymentMethod", paymentMethod);
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }

    private void removeVoucher(HttpServletRequest request, HttpServletResponse response, HttpSession session,
                               String deliveryAddress, PaymentMethod paymentMethod)
            throws ServletException, IOException {
        session.removeAttribute("discountAmount");
        session.removeAttribute("voucherCode");
        session.removeAttribute("finalPrice");
        session.setAttribute("deliveryAddress", deliveryAddress);
        session.setAttribute("paymentMethod", paymentMethod);
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }

    private int calculateFinalPrice(Cart cart, HttpSession session) {
        int totalPrice = cart.getTotalPrice();
        Integer discountAmount = (Integer) session.getAttribute("discountAmount");
        int discount = discountAmount == null ? 0 : Math.min(discountAmount, totalPrice);
        return totalPrice - discount;
    }

    private PaymentMethod parsePaymentMethod(String value) {
        try {
            return PaymentMethod.valueOf(value);
        } catch (Exception e) {
            return PaymentMethod.COD;
        }
    }

    private String trimToNull(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        return value.trim();
    }

    private void clearCartSession(HttpSession session, Cart cart) {
        cart.removeAllItems();
        session.setAttribute("cart", cart);
        session.removeAttribute("discountAmount");
        session.removeAttribute("voucherCode");
        session.removeAttribute("finalPrice");
        session.removeAttribute("deliveryAddress");
        session.removeAttribute("paymentMethod");
    }

    private void writeJson(HttpServletResponse response, boolean success, String message, Map<String, Object> data)
            throws IOException {
        response.setContentType("application/json;charset=UTF-8");

        Map<String, Object> result = new HashMap<>();
        result.put("success", success);
        result.put("message", message);

        if (data != null) {
            result.putAll(data);
        }

        response.getWriter().write(new Gson().toJson(result));
    }
}
