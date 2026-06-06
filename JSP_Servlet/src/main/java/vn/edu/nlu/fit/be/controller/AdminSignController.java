package vn.edu.nlu.fit.be.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.nlu.fit.be.model.Account;
import vn.edu.nlu.fit.be.service.AdminSignService;
import vn.edu.nlu.fit.be.service.OrdersService;

import java.io.IOException;

@WebServlet(name = "AdminSignController", urlPatterns = {
        "/admin-sign",
        "/admin-sign/detail",
        "/admin-sign/reverify",
        "/admin-sign/revoke-certificate"
})
public class AdminSignController extends HttpServlet {

    private final AdminSignService adminSignService = new AdminSignService();
    private final OrdersService ordersService = new OrdersService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request, response)) {
            return;
        }

        String path = request.getServletPath();
        if ("/admin-sign/detail".equals(path)) {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            request.setAttribute("order", ordersService.getOrderById(orderId));
            request.setAttribute("orderSign", adminSignService.getOrderSignByOrderId(orderId));
            request.setAttribute("certificate", adminSignService.getCertificateByOrderId(orderId));
            request.setAttribute("verifyLogs", adminSignService.getVerifyLogs(orderId));
            request.getRequestDispatcher("/admin_sign_detail.jsp").forward(request, response);
            return;
        }

        request.setAttribute("waitingOrders", adminSignService.getWaitingSignOrders());
        request.setAttribute("invalidOrders", adminSignService.getInvalidSignOrders());
        request.setAttribute("tamperedOrders", adminSignService.getTamperedOrders());
        request.setAttribute("revokedCertificates", adminSignService.getRecentRevokedCerts());
        request.getRequestDispatcher("/admin_sign.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        if (!isAdmin(request, response)) {
            return;
        }

        String path = request.getServletPath();
        if ("/admin-sign/reverify".equals(path)) {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            try {
                adminSignService.reverifyOrder(orderId);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
            response.sendRedirect(request.getContextPath() + "/admin-sign/detail?orderId=" + orderId);
            return;
        }

        if ("/admin-sign/revoke-certificate".equals(path)) {
            int certificateId = Integer.parseInt(request.getParameter("certificateId"));
            String reason = request.getParameter("reason");
            adminSignService.revokeCert(certificateId, reason);
            response.sendRedirect(request.getContextPath() + "/admin-sign");
            return;
        }

        response.sendError(HttpServletResponse.SC_NOT_FOUND);
    }

    private boolean isAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("USER") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }

        Account account = (Account) session.getAttribute("USER");
        if (account.getRole() <= 0) {
            response.sendRedirect(request.getContextPath() + "/403.jsp");
            return false;
        }
        return true;
    }
}
