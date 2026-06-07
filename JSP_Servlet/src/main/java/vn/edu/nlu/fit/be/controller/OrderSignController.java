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
import vn.edu.nlu.fit.be.dto.SignPackageRes;
import vn.edu.nlu.fit.be.model.Account;
import vn.edu.nlu.fit.be.service.OrderSigningService;
import vn.edu.nlu.fit.be.service.OrdersService;

import java.io.IOException;
import java.nio.charset.StandardCharsets;

@WebServlet(name = "OrderSignController", urlPatterns = {
        "/order-sign",
        "/order-sign/package",
        "/order-sign/order-json",
        "/order-sign/private-key",
        "/order-sign/tool"
})
public class OrderSignController extends HttpServlet {

    private final Gson gson = new Gson();
    private final OrdersService ordersService = new OrdersService();
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
            request.getRequestDispatcher("/order-sign.jsp").forward(request, response);
            return;
        }

        int orderId = parseOrderId(request);
        if (!ordersService.isOwner(orderId, account.getAccountId())) {
            response.sendRedirect(request.getContextPath() + "/error/403.jsp");
            return;
        }

        switch (path) {
            case "/order-sign/package" -> showSigningPackage(request, response, orderId, account);
            case "/order-sign/order-json" -> downloadOrderToSignJson(response, orderId, account);
            case "/order-sign/private-key" -> downloadPrivateKeyOnce(response, orderId, account);
            case "/order-sign/tool" -> downloadSigningTool(response);
            default -> response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    private void showSigningPackage(HttpServletRequest request, HttpServletResponse response, int orderId, Account account)
            throws ServletException, IOException {
        SignPackageRes signingPackage = orderSigningService.getSigningPackage(orderId, account.getAccountId());
        request.setAttribute("signingPackage", signingPackage);
        request.setAttribute("orderId", orderId);
        request.getRequestDispatcher("/order-sign.jsp").forward(request, response);
    }

    private void downloadOrderToSignJson(HttpServletResponse response, int orderId, Account account) throws IOException {
        OrderToSignRes payload = orderSigningService.getOrderToSign(orderId, account.getAccountId());
        writeDownload(
                response,
                "application/json; charset=UTF-8",
                "order_to_sign_" + orderId + ".json",
                gson.toJson(payload).getBytes(StandardCharsets.UTF_8)
        );
    }

    private void downloadPrivateKeyOnce(HttpServletResponse response, int orderId, Account account) throws IOException {
        String privateKeyPem = orderSigningService.consumePrivateKeyPem(orderId, account.getAccountId());
        if (privateKeyPem == null || privateKeyPem.isBlank()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Private key chỉ được tải một lần hoặc user đã có key trước đó");
            return;
        }

        writeDownload(
                response,
                "application/x-pem-file; charset=UTF-8",
                "private_key_account_" + account.getAccountId() + ".pem",
                privateKeyPem.getBytes(StandardCharsets.UTF_8)
        );
    }

    private void downloadSigningTool(HttpServletResponse response) throws IOException {
        byte[] jarBytes = orderSigningService.loadSigningTool();
        writeDownload(response, "application/zip", "signing-tool.zip", jarBytes);
    }

    private int parseOrderId(HttpServletRequest request) {
        return Integer.parseInt(request.getParameter("orderId"));
    }

    private void writeDownload(HttpServletResponse response, String contentType, String filename, byte[] bytes)
            throws IOException {
        response.setContentType(contentType);
        response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
        response.setContentLength(bytes.length);
        try (ServletOutputStream out = response.getOutputStream()) {
            out.write(bytes);
        }
    }
}
