package vn.edu.nlu.fit.be.controller;

import vn.edu.nlu.fit.be.dao.OrderDetailDao;
import vn.edu.nlu.fit.be.model.*;
import vn.edu.nlu.fit.be.service.OrdersService;
import vn.edu.nlu.fit.be.service.StockProductService;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {
        "/admin/orders",
        "/admin/orders/status"
})
public class AdminOrderController extends HttpServlet {

    private OrdersService service = new OrdersService();
    private StockProductService stockService = new StockProductService();
    private OrderDetailDao orderDetailDao = new OrderDetailDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);

        //chưa login
        if (session == null || session.getAttribute("USER") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Account acc = (Account) session.getAttribute("USER");

        //không phải admin
        if (acc.getRole() <= 0) {
            resp.sendRedirect(req.getContextPath() + "/403.jsp");
            return;
        }
        String path = req.getServletPath();

        // ===== AJAX UPDATE STATUS =====
        if (path.equals("/admin/orders/status")) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                OrderStatus newStatus = OrderStatus.valueOf(req.getParameter("status"));

                // Cập nhật trạng thái đơn hàng trước
                boolean statusUpdated = service.updateStatus(id, newStatus);

                if (!statusUpdated) {
                    resp.setContentType("text/plain");
                    resp.getWriter().write("FAIL");
                    return;
                }

                // Xử lý stock (nếu có lỗi thì vẫn coi như thành công vì status đã update)
                boolean stockUpdated = true;
                try {
                    List<OrderDetail> details = orderDetailDao.getOrderDetailsByOrderId(id);

                    if (newStatus == OrderStatus.Done) {
                        // Khi Done: cập nhật sold_quantity cho từng sản phẩm
                        for (OrderDetail detail : details) {
                            if (!stockService.updateSoldQuantity(detail.getProductId(), detail.getQuantity())) {
                                stockUpdated = false;
                            }
                        }
                    } else if (newStatus == OrderStatus.Cancelled) {
                        // Khi Cancelled: hoàn lại stock (tăng total_quantity)
                        for (OrderDetail detail : details) {
                            if (!stockService.restoreStock(detail.getProductId(), detail.getQuantity())) {
                                stockUpdated = false;
                            }
                        }
                    }
                } catch (Exception stockEx) {
                    stockEx.printStackTrace();
                    stockUpdated = false;
                }

                resp.setContentType("text/plain");
                if (stockUpdated) {
                    resp.getWriter().write("OK");
                } else {
                    resp.getWriter().write("PARTIAL");
                }
            } catch (Exception e) {
                e.printStackTrace();
                resp.setContentType("text/plain");
                resp.getWriter().write("FAIL: " + e.getMessage());
            }
            return;
        }

        // ===== LOAD ORDER LIST =====
        List<Order> orders = service.getAll();
        req.setAttribute("orders", orders);

        req.getRequestDispatcher("/admin_orders.jsp").forward(req, resp);
    }
}
