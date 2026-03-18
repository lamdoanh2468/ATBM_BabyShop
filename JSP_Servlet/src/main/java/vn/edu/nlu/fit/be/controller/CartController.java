package vn.edu.nlu.fit.be.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.nlu.fit.be.model.Account;
import vn.edu.nlu.fit.be.model.Cart;
import vn.edu.nlu.fit.be.model.Product;
import vn.edu.nlu.fit.be.model.Voucher;
import vn.edu.nlu.fit.be.service.ProductService;
import vn.edu.nlu.fit.be.service.VoucherService;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Date;

@WebServlet(name = "CartController", value = "/cart")
public class CartController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("USER");
        if (account == null) {
            // Lưu URL hiện tại (bao gồm query string) để quay lại sau khi đăng nhập
            String currentUrl = request.getRequestURL().toString();
            String queryString = request.getQueryString();
            if (queryString != null) {
                currentUrl += "?" + queryString;
            }
            String encodedUrl = URLEncoder.encode(currentUrl, StandardCharsets.UTF_8);
            safeRedirect(response, request.getContextPath() + "/login?returnUrl=" + encodedUrl);
            return;
        }
        Cart cart = (Cart) session.getAttribute("cart");
        //Kiểm tra giỏ hàng tồn tại chưa
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        String action = request.getParameter("action");
        String productIdParam = request.getParameter("product_id");
        String quantityParam = request.getParameter("quantity");
        if (productIdParam != null) {
            int productId = Integer.parseInt(productIdParam);
            int quantity = (quantityParam != null && !quantityParam.isEmpty()) ? Integer.parseInt(quantityParam) : 1;
            ProductService ps = new ProductService();
            Product product = ps.getProductById(productId);
            if (product == null) {
                safeRedirect(response, "productList.jsp");
                return;
            }
            switch (action) {
                case "add":
                    cart.addItem(product, quantity);
                    session.setAttribute("cart", cart);
                    String returnUrl = request.getParameter("returnUrl");

                    if (returnUrl != null && !returnUrl.isEmpty()) {
                        safeRedirect(response, returnUrl);
                    } else {
                        safeRedirect(response, request.getContextPath() + "/product-list");
                    }
                    return;

                case "remove":
                    cart.removeItem(productId);
                    session.setAttribute("cart", cart);
                    safeRedirect(response, request.getContextPath() + "/cart");
                    return;
                case "buy_now":
                    cart.addItem(product,quantity);
                    session.setAttribute("cart", cart);
                    safeRedirect(response, request.getContextPath() + "/cart");
                    return;

            }
        }
        if ("remove_all".equals(action)) {
            cart.removeAllItems();
            session.setAttribute("cart", cart);
            safeRedirect(response, request.getContextPath() + "/cart");
            return;
        }

        //XEM GIỎ HÀNG
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        
        Account account = (Account) session.getAttribute("USER");
        if (account == null) {
            // Lưu URL cart để quay lại sau khi đăng nhập
            String returnUrl = request.getContextPath() + "/cart";
            String encodedUrl = URLEncoder.encode(returnUrl, StandardCharsets.UTF_8);
            safeRedirect(response, request.getContextPath() + "/login?returnUrl=" + encodedUrl);
            return;
        }

        String action = request.getParameter("action");

        if ("applyVoucher".equals(action)) {
            String voucherCode = request.getParameter("voucherCode");
            
            if (voucherCode == null || voucherCode.trim().isEmpty()) {
                session.setAttribute("voucherError", "Vui lòng nhập mã voucher!");
                session.removeAttribute("appliedVoucher");
                session.removeAttribute("voucherCode");
                safeRedirect(response, request.getContextPath() + "/cart");
                return;
            }

            VoucherService voucherService = new VoucherService();
            Voucher voucher = voucherService.findByCode(voucherCode.trim());

            if (voucher == null) {
                session.setAttribute("voucherError", "Mã voucher không tồn tại!");
                session.removeAttribute("appliedVoucher");
                session.removeAttribute("voucherCode");
                safeRedirect(response, request.getContextPath() + "/cart");
                return;
            }

            // Check voucher validity (date range)
            Date today = new Date(System.currentTimeMillis());
            if (voucher.getStartDate() != null && today.before(voucher.getStartDate())) {
                session.setAttribute("voucherError", "Mã voucher chưa có hiệu lực!");
                session.removeAttribute("appliedVoucher");
                session.removeAttribute("voucherCode");
                safeRedirect(response, request.getContextPath() + "/cart");
                return;
            }
            if (voucher.getEndDate() != null && today.after(voucher.getEndDate())) {
                session.setAttribute("voucherError", "Mã voucher đã hết hạn!");
                session.removeAttribute("appliedVoucher");
                session.removeAttribute("voucherCode");
                safeRedirect(response, request.getContextPath() + "/cart");
                return;
            }

            // Voucher is valid - save to session
            session.setAttribute("appliedVoucher", voucher);
            session.setAttribute("voucherCode", voucherCode.trim());
            session.removeAttribute("voucherError");
            session.setAttribute("voucherSuccess", "Áp dụng mã \"" + voucherCode.trim() + "\" thành công!");
            
            safeRedirect(response, request.getContextPath() + "/cart");
            return;
        }

        if ("removeVoucher".equals(action)) {
            session.removeAttribute("appliedVoucher");
            session.removeAttribute("voucherCode");
            session.removeAttribute("voucherError");
            session.removeAttribute("voucherSuccess");
            safeRedirect(response, request.getContextPath() + "/cart");
            return;
        }

        // Default: redirect back to cart
        safeRedirect(response, request.getContextPath() + "/cart");
    }

    private void safeRedirect(HttpServletResponse response, String url) {
        response.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", url);
    }
}