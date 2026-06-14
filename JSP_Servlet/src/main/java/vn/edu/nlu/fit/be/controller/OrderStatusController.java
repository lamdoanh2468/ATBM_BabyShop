package vn.edu.nlu.fit.be.controller;

import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.nlu.fit.be.model.Account;
import vn.edu.nlu.fit.be.model.Order;
import vn.edu.nlu.fit.be.service.OrdersService;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/order/status")
public class OrderStatusController extends HttpServlet {
    private final OrdersService ordersService = new OrdersService();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);

        response.setContentType("application/json;charset=UTF-8");

        if (session == null || session.getAttribute("USER") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"success\":false,\"message\":\"UNAUTHORIZED\"}");
            return;
        }

        Account account = (Account) session.getAttribute("USER");
        int orderId = Integer.parseInt(request.getParameter("orderId"));

        if (!ordersService.isOwner(orderId, account.getAccountId())) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            response.getWriter().write("{\"success\":false,\"message\":\"FORBIDDEN\"}");
            return;
        }

        Order order = ordersService.getById(orderId);

        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        result.put("orderId", orderId);
        result.put("status", order.getStatusOrder().name());

        response.getWriter().write(gson.toJson(result));
    }
}