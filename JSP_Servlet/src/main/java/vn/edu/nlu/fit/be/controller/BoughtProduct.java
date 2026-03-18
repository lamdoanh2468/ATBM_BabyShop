package vn.edu.nlu.fit.be.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.nlu.fit.be.model.Account;
import vn.edu.nlu.fit.be.model.OrderDetail;
import vn.edu.nlu.fit.be.service.OrdersService;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "BoughtProduct", value = "/bought-product")
public class BoughtProduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Account acc = (Account) session.getAttribute("USER");
        if (acc == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        OrdersService ods = new OrdersService();
        // 1) Lấy danh sách order + items
        Map<Integer, List<OrderDetail>> boughts =
                ods.getPurchasedProductsByAccount(acc.getAccountId());

        // 2) Lấy discount theo từng orderId (tái sử dụng getDiscountAmountFromVoucher)
        Map<Integer, Integer> discounts =
                ods.getDiscountAmountOrders(boughts.keySet());

        request.setAttribute("BOUGHTS", boughts);
        request.setAttribute("DISCOUNTS", discounts);
        request.getRequestDispatcher("/bought_product.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}