package vn.edu.nlu.fit.be.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.nlu.fit.be.dto.CheckoutSignResult;
import vn.edu.nlu.fit.be.model.Account;
import vn.edu.nlu.fit.be.model.Cart;
import vn.edu.nlu.fit.be.model.PaymentMethod;
import vn.edu.nlu.fit.be.model.Voucher;
import vn.edu.nlu.fit.be.service.CheckoutSigningService;
import vn.edu.nlu.fit.be.service.VoucherService;

@WebServlet(name = "OrderController", value = "/order")
public class OrderController extends HttpServlet {

    private final Gson gson = new Gson();
    private final VoucherService voucherService = new VoucherService();
    private final CheckoutSigningService checkoutSigningService = new CheckoutSigningService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/cart");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        boolean ajax = isAjax(request);
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
        String voucherCode = resolveVoucherCode(request, session);
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
            handleCheckoutError(request, response, ajax, "Vui lòng nhập địa chỉ giao hàng");
            return;
        }

        Voucher voucher = voucherCode == null ? null : voucherService.findByCode(voucherCode);
        Integer voucherId = voucher == null ? null : voucher.getVoucherId();
        int finalPrice = calculateFinalPrice(cart, session);

        try {
            CheckoutSignResult result = checkoutSigningService.checkoutAndPrepareSigning(
                    account,
                    cart,
                    deliveryAddress,
                    paymentMethod,
                    voucherId,
                    finalPrice
            );

            setSigningSession(session, result);
            clearCartSession(session, cart);

            if (ajax) {
                writeJson(response, true, "Tạo đơn hàng chờ ký thành công", buildAjaxData(request, result));
                return;
            }

            response.sendRedirect(request.getContextPath() + "/cart?waitingSignature=1");
        } catch (Exception e) {
            handleCheckoutError(request, response, ajax, "Không thể tạo đơn hàng cần ký: " + e.getMessage());
        }
    }

    private String resolveVoucherCode(HttpServletRequest request, HttpSession session) {
        String voucherCode = trimToNull(request.getParameter("voucherCode"));
        if (voucherCode == null) {
            voucherCode = (String) session.getAttribute("voucherCode");
        }
        return voucherCode;
    }

    private void applyVoucher(HttpServletRequest request,
                              HttpServletResponse response,
                              HttpSession session,
                              String deliveryAddress,
                              PaymentMethod paymentMethod,
                              String voucherCode) throws ServletException, IOException {
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

    private void removeVoucher(HttpServletRequest request,
                               HttpServletResponse response,
                               HttpSession session,
                               String deliveryAddress,
                               PaymentMethod paymentMethod) throws ServletException, IOException {
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

    private void setSigningSession(HttpSession session, CheckoutSignResult result) {
        session.setAttribute("showSignPopup", true);
        session.setAttribute("signOrderId", result.getOrderId());
        session.setAttribute("signOrderHash", result.getOrderHash());
        session.setAttribute("signingUrl", result.getSigningUrl());
        session.setAttribute("signToolUrl", result.getSignToolUrl());

        if (result.hasPrivateKeyUrl()) {
            session.setAttribute("privateKeyUrl", result.getPrivateKeyUrl());
        } else {
            session.removeAttribute("privateKeyUrl");
        }
    }

    private Map<String, Object> buildAjaxData(HttpServletRequest request, CheckoutSignResult result) {
        Map<String, Object> data = new HashMap<>();
        String contextPath = request.getContextPath();

        data.put("orderId", result.getOrderId());
        data.put("orderHash", result.getOrderHash());
        data.put("signingUrl", contextPath + result.getSigningUrl());
        data.put("signToolUrl", contextPath + result.getSignToolUrl());

        if (result.hasPrivateKeyUrl()) {
            data.put("privateKeyUrl", contextPath + result.getPrivateKeyUrl());
        }
        data.put("hasActiveCert", result.isHasActiveCert());

        return data;
    }

    private void handleCheckoutError(HttpServletRequest request,
                                     HttpServletResponse response,
                                     boolean ajax,
                                     String message) throws ServletException, IOException {
        if (ajax) {
            writeJson(response, false, message, null);
        } else {
            request.setAttribute("error", message);
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
        }
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

    private boolean isAjax(HttpServletRequest request) {
        return "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
    }

    private void writeJson(HttpServletResponse response,
                           boolean success,
                           String message,
                           Map<String, Object> data) throws IOException {
        response.setContentType("application/json;charset=UTF-8");

        Map<String, Object> result = new HashMap<>();
        result.put("success", success);
        result.put("message", message);

        if (data != null) {
            result.putAll(data);
        }

        response.getWriter().write(gson.toJson(result));
    }
}
