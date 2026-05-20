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
        "/admin/orders/status",
        "/admin/orders/detail",
        "/admin/orders/edit"
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

        if (path.equals("/admin/orders/detail")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Order order = service.getById(id);
            List<OrderDetail> details = orderDetailDao.getOrderDetailsByOrderId(id);
            req.setAttribute("order", order);
            req.setAttribute("orderDetails", details);
            req.getRequestDispatcher("/admin_order_detail.jsp").forward(req, resp);
            return;
        }

        if (path.equals("/admin/orders/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Order order = service.getById(id);
            List<OrderDetail> details = orderDetailDao.getOrderDetailsByOrderId(id);
            req.setAttribute("order", order);
            req.setAttribute("orderDetails", details);
            req.getRequestDispatcher("/admin_order_form.jsp").forward(req, resp);
            return;
        }

        // ===== LOAD ORDER LIST =====
        List<Order> orders = service.getAll();
        req.setAttribute("orders", orders);

        req.getRequestDispatcher("/admin_orders.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("USER") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Account acc = (Account) session.getAttribute("USER");
        if (acc.getRole() <= 0) {
            resp.sendRedirect(req.getContextPath() + "/403.jsp");
            return;
        }

        String path = req.getServletPath();
        if (path.equals("/admin/orders/edit")) {
            int orderId = Integer.parseInt(req.getParameter("orderId"));

            Order order = new Order();
            order.setOrderId(orderId);
            order.setDeliveryAddress(req.getParameter("deliveryAddress"));
            order.setPaymentMethod(PaymentMethod.valueOf(req.getParameter("paymentMethod")));
            order.setStatusOrder(OrderStatus.valueOf(req.getParameter("status")));

            service.updateOrder(order);
            resp.sendRedirect(req.getContextPath() + "/admin/orders/detail?id=" + orderId);
            return;
        }

        doGet(req, resp);
    }
}
