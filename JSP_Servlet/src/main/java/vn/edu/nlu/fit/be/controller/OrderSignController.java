package vn.edu.nlu.fit.be.controller;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.nlu.fit.be.dto.OrderToSignRes;
import vn.edu.nlu.fit.be.model.Account;
import vn.edu.nlu.fit.be.model.Order;
import vn.edu.nlu.fit.be.model.OrderStatus;
import vn.edu.nlu.fit.be.service.CertificateService;
import vn.edu.nlu.fit.be.service.OrderSigningService;
import vn.edu.nlu.fit.be.service.OrdersService;

import java.io.IOException;
import java.nio.charset.StandardCharsets;

@WebServlet(name = "OrderSignController", urlPatterns = {
        "/order-sign",
        "/order-sign/order-json"
})
public class OrderSignController extends HttpServlet {

    private final Gson gson = new Gson();
    private final OrdersService ordersService = new OrdersService();
    private final CertificateService certificateService = new CertificateService();
    private final OrderSigningService orderSigningService = new OrderSigningService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("USER") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Account account = (Account) session.getAttribute("USER");
        String path = request.getServletPath();

        if ("/order-sign".equals(path)) {
            showOrderSignPage(request, response, account);
            return;
        }

        if ("/order-sign/order-json".equals(path)) {
            downloadOrderToSignJson(request, response, account);
            return;
        }

        response.sendError(HttpServletResponse.SC_NOT_FOUND);
    }

    private void showOrderSignPage(HttpServletRequest request,
                                   HttpServletResponse response,
                                   Account account) throws ServletException, IOException {
        Integer orderId = parseOrderIdOrNull(request);

        if (orderId != null) {
            Order order = ordersService.getById(orderId);
            if (!ordersService.isOwner(orderId, account.getAccountId())) {
                response.sendRedirect(request.getContextPath() + "/error/403.jsp");
                return;
            }
            if (order.getStatusOrder() != OrderStatus.WAITING_SIGNATURE) {
                response.sendRedirect(request.getContextPath() + "/bought-product");
                return;
            }

            OrderToSignRes orderToSign = orderSigningService.getOrderToSign(orderId, account.getAccountId());
            request.setAttribute("orderId", orderId);
            request.setAttribute("orderToSign", orderToSign);
        }

        request.setAttribute("canDownloadPrivateKey", certificateService.hasPendingPrivateKey(account.getAccountId()));
        request.getRequestDispatcher("/order-sign.jsp").forward(request, response);
    }

    private void downloadOrderToSignJson(HttpServletRequest request,
                                         HttpServletResponse response,
                                         Account account) throws IOException {
        Integer orderId = parseOrderIdOrNull(request);

        if (orderId == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing orderId");
            return;
        }
        Order order = ordersService.getById(orderId);

        if (!canDownloadSigningPayload(order.getStatusOrder())) {
            response.sendRedirect(request.getContextPath() + "/bought-product");
            return;
        }

        OrderToSignRes payload = orderSigningService.getOrderToSign(orderId, account.getAccountId());
        if (payload == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Order signing payload not found");
            return;
        }

        writeDownload(
                response,
                "application/json; charset=UTF-8",
                "order_to_sign_" + orderId + ".json",
                gson.toJson(payload).getBytes(StandardCharsets.UTF_8)
        );
    }

    private Integer parseOrderIdOrNull(HttpServletRequest request) {
        String value = request.getParameter("orderId");
        if (value == null || value.isBlank()) {
            return null;
        }

        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            return null;
        }
    }

    private void writeDownload(HttpServletResponse response,
                               String contentType,
                               String filename,
                               byte[] bytes) throws IOException {
        response.setContentType(contentType);
        response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
        response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0");
        response.setContentLength(bytes.length);

        try (ServletOutputStream out = response.getOutputStream()) {
            out.write(bytes);
        }
    }
    private boolean canDownloadSigningPayload(OrderStatus status) {
        return status == OrderStatus.WAITING_SIGNATURE
                || status == OrderStatus.SIGNATURE_INVALID;
    }

}