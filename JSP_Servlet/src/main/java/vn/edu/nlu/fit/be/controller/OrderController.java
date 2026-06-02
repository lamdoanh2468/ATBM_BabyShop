package vn.edu.nlu.fit.be.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.nlu.fit.be.model.Account;
import vn.edu.nlu.fit.be.model.Cart;
import vn.edu.nlu.fit.be.model.CartItem.CartItem;
import vn.edu.nlu.fit.be.model.OrderStatus;
import vn.edu.nlu.fit.be.model.PaymentMethod;
import vn.edu.nlu.fit.be.model.Voucher;
import vn.edu.nlu.fit.be.service.CertificateService;
import vn.edu.nlu.fit.be.service.OrderSigningService;
import vn.edu.nlu.fit.be.service.OrdersService;
import vn.edu.nlu.fit.be.service.StockProductService;
import vn.edu.nlu.fit.be.service.VoucherService;

import java.io.IOException;

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

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("USER") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Account account = (Account) session.getAttribute("USER");
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getTotalQuantity() == 0) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        String action = request.getParameter("action");
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
            request.setAttribute("error", "Vui lòng nhập địa chỉ giao hàng");
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
            return;
        }

        if (!stockProductService.checkAvailable(cart)) {
            var outOfStockProducts = stockProductService.getOutOfStockProducts(cart);
            session.setAttribute("stockError", "Không đủ số lượng tồn kho cho: " + String.join(", ", outOfStockProducts));
            response.sendRedirect(request.getContextPath() + "/cart?paid=0");
            return;
        }

        Voucher voucher = voucherCode == null ? null : voucherService.findByCode(voucherCode);
        Integer voucherId = voucher == null ? null : voucher.getVoucherId();
        int finalPrice = calculateFinalPrice(cart, session);

        try {
            int orderId = ordersService.createOrderFromCart(
                    account,
                    cart,
                    deliveryAddress,
                    paymentMethod,
                    voucherId,
                    finalPrice
            );

            for (CartItem item : cart.getItems()) {
                stockProductService.updateStockProduct(item.getProduct().getProductId(), item.getQuantity());
            }

            // Flow ATBM: đơn mới tạo chưa được xem là thanh toán thành công.
            // Nó phải chờ user ký orderHash bằng private key.
            ordersService.updateStatus(orderId, OrderStatus.WAITING_SIGNATURE);

            // Tạo key/certificate nếu user chưa có certificate hợp lệ.
            certificateService.ensureActiveCert(account.getAccountId());

            // Lưu snapshot bất biến vào ORDER_SIGNS và sinh SHA-256 orderHash.
            orderSigningService.createOrderSignSnapshot(orderId, account.getAccountId());

            clearCartSession(session, cart);
            response.sendRedirect(request.getContextPath() + "/order-sign/package?orderId=" + orderId);
        } catch (Exception e) {
            request.setAttribute("error", "Không thể tạo đơn hàng cần ký: " + e.getMessage());
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
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
}
