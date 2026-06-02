package vn.edu.nlu.fit.be.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.nlu.fit.be.dao.OrderDetailDao;
import vn.edu.nlu.fit.be.model.Account;
import vn.edu.nlu.fit.be.model.Order;
import vn.edu.nlu.fit.be.model.OrderDetail;
import vn.edu.nlu.fit.be.model.OrderStatus;
import vn.edu.nlu.fit.be.service.OrdersService;
import vn.edu.nlu.fit.be.service.StockProductService;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {
        "/admin/orders",
        "/admin/orders/status"
})
public class AdminOrderController extends HttpServlet {

    private final OrdersService ordersService = new OrdersService();
    private final StockProductService stockService = new StockProductService();
    private final OrderDetailDao orderDetailDao = new OrderDetailDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request, response)) {
            return;
        }

        if ("/admin/orders/status".equals(request.getServletPath())) {
            updateStatus(request, response);
            return;
        }

        List<Order> orders = ordersService.getAll();
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/admin_orders.jsp").forward(request, response);
    }

    private void updateStatus(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/plain; charset=UTF-8");

        try {
            int orderId = Integer.parseInt(request.getParameter("id"));
            OrderStatus newStatus = OrderStatus.valueOf(request.getParameter("status"));

            if (newStatus == OrderStatus.DONE) {
                if (!ordersService.isVerified(orderId)) {
                    response.getWriter().write("FAIL: Đơn hàng chưa verify chữ ký nên không được chuyển sang trạng thái thành công");
                    return;
                }
            }

            boolean statusUpdated = ordersService.updateStatus(orderId, newStatus);
            if (!statusUpdated) {
                response.getWriter().write("FAIL");
                return;
            }

            boolean stockUpdated = updateStockByStatus(orderId, newStatus);
            response.getWriter().write(stockUpdated ? "OK" : "PARTIAL");
        } catch (Exception e) {
            response.getWriter().write("FAIL: " + e.getMessage());
        }
    }

    private boolean updateStockByStatus(int orderId, OrderStatus newStatus) {
        try {
            List<OrderDetail> details = orderDetailDao.getOrderDetailsByOrderId(orderId);
            boolean success = true;

            if (newStatus == OrderStatus.DONE) {
                for (OrderDetail detail : details) {
                    if (!stockService.updateSoldQuantity(detail.getProductId(), detail.getQuantity())) {
                        success = false;
                    }
                }
            } else if (newStatus == OrderStatus.CANCELLED || newStatus == OrderStatus.CERTIFICATE_INVALID
                    || newStatus == OrderStatus.SIGNATURE_INVALID || newStatus == OrderStatus.TAMPERED) {
                for (OrderDetail detail : details) {
                    if (!stockService.restoreStock(detail.getProductId(), detail.getQuantity())) {
                        success = false;
                    }
                }
            }
            return success;
        } catch (Exception e) {
            return false;
        }
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
