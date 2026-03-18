package vn.edu.nlu.fit.be.controller;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.nlu.fit.be.dao.AdminOverviewDao;
import vn.edu.nlu.fit.be.dto.RecentOrderDto;
import vn.edu.nlu.fit.be.dto.RevenueByMonth;
import vn.edu.nlu.fit.be.model.Account;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/overview")
public class AdminOverviewController extends HttpServlet {

    private final AdminOverviewDao dao = new AdminOverviewDao();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // Chưa login
        if (session == null || session.getAttribute("USER") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Account acc = (Account) session.getAttribute("USER");

        // Không phải admin
        if (acc.getRole() <= 0) {
            resp.sendRedirect(req.getContextPath() + "/403.jsp");
            return;
        }

        /* ================== DATA ================== */

        req.setAttribute("totalRevenue", dao.getTotalRevenue());
        req.setAttribute("totalOrders", dao.getTotalOrders());
        req.setAttribute("totalCustomers", dao.getTotalCustomers());
        req.setAttribute("totalProducts", dao.getTotalProducts());

        //Revenue by month
        List<RevenueByMonth> revenueByMonth = dao.getRevenueByMonth();
        req.setAttribute("revenueByMonthJson", gson.toJson(revenueByMonth));

        //Orders by category
        var ordersByCategory = dao.getOrdersByCategory();
        req.setAttribute("ordersByCategoryJson", gson.toJson(ordersByCategory));

        //Recent orders
        List<RecentOrderDto> recentOrders = dao.getRecentOrders(5);
        req.setAttribute("recentOrders", recentOrders);

        req.getRequestDispatcher("/admin_overview.jsp")
                .forward(req, resp);
    }
}
