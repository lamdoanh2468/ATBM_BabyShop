package vn.edu.nlu.fit.be.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.nlu.fit.be.model.Account;
import vn.edu.nlu.fit.be.service.ReviewService;

import java.io.IOException;

@WebServlet(name = "AddReviewController", value = "/add-review")
public class AddReviewController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        //Check login
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("USER");

        String productIdStr = request.getParameter("product_id");
        int productId = Integer.parseInt(productIdStr);

        //Lưu vị trí vô trang sản phẩm cụ thể
        String returnDetailed = "product-detail?product_id=" + productIdStr;
        session.setAttribute("redirectAfterLogin", returnDetailed);

        if (account == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        try {

            String comment = request.getParameter("comment");
            int accountId = account.getAccountId();

            ReviewService reviewService = new ReviewService();
            reviewService.addReview(accountId, productId, comment);

            response.sendRedirect("product-detail?product_id=" + productId);

        } catch (Exception e) {
            e.printStackTrace();
            // Nếu lỗi thì quay về trang chủ hoặc trang lỗi
            response.sendRedirect("home.jsp");
        }


    }
}