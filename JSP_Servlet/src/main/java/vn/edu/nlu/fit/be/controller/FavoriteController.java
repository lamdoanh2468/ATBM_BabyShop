package vn.edu.nlu.fit.be.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.nlu.fit.be.model.Account;
import vn.edu.nlu.fit.be.model.FavoriteProduct;
import vn.edu.nlu.fit.be.model.Product;
import vn.edu.nlu.fit.be.service.FavoriteProductService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "FavoriteServlet", value = "/my-favorite")
public class FavoriteController extends HttpServlet {
    private final FavoriteProductService favoriteService = new FavoriteProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Account acc = (Account) session.getAttribute("USER");


        if (acc == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }


        //Add favorite products
        String action = request.getParameter("action");
        if ("add".equals(action)) {
            String prodIdStr = request.getParameter("product_id");

            if (prodIdStr != null && !prodIdStr.isEmpty()) {
                int productId = Integer.parseInt(prodIdStr);
                favoriteService.toggle(acc.getAccountId(), productId);
            }
            response.sendRedirect(request.getContextPath() + "/my-favorite");
            return;
        }
        List<Product> favorites =
                favoriteService.getFavorites(acc.getAccountId());
        request.setAttribute("FAVORITES", favorites);

        request.getRequestDispatcher("/favorite.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        String productIdStr = req.getParameter("product_id");

        Account acc = (Account) req.getSession().getAttribute("USER");
        if (acc == null) {
            resp.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        if (productIdStr != null && !productIdStr.isEmpty()) {
            int productId = Integer.parseInt(productIdStr);
            // Nếu là AJAX toggle (như code cũ của bạn)
            if (action == null) {
                boolean liked = favoriteService.toggle(acc.getAccountId(), productId);
                resp.setContentType("application/json");
                resp.getWriter().write("{\"liked\": " + liked + "}");
                return;
            }
            // Nếu là Form submit từ trang JSP (xóa)
            if ("remove".equals(action)) {
                favoriteService.toggle(acc.getAccountId(), productId);
                resp.sendRedirect(req.getContextPath() + "/my-favorite");
            }
        }

    }
}