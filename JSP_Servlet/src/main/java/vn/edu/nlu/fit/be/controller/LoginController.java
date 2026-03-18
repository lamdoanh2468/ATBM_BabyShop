package vn.edu.nlu.fit.be.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.nlu.fit.be.model.Account;
import vn.edu.nlu.fit.be.service.AccountService;

import java.io.IOException;

@WebServlet(name = "LoginController", value = "/login")
public class LoginController extends HttpServlet {

    private final AccountService service = new AccountService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String clientId = getServletContext().getInitParameter("GOOGLE_CLIENT_ID");
        String redirectUri = getServletContext().getInitParameter("GOOGLE_REDIRECT_URI");
        req.setAttribute("GOOGLE_CLIENT_ID", clientId);
        req.setAttribute("GOOGLE_REDIRECT_URI", redirectUri);
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String key = req.getParameter("username");
        String password = req.getParameter("password");

        Account acc;
        try {
            acc = service.login(key, password);
        } catch (IllegalStateException e) {
            // Tài khoản bị khoá
            req.setAttribute("error", e.getMessage());
            req.setAttribute("returnUrl", req.getParameter("returnUrl"));
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        if (acc == null) {
            req.setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu!");
            req.setAttribute("returnUrl", req.getParameter("returnUrl"));
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        HttpSession session = req.getSession(true);
        session.setAttribute("USER", acc);
        session.setMaxInactiveInterval(30 * 60); // 30 phút

        // kiểm tra role
        if (acc.getRole() == 1) {
            // admin
            safeRedirect(resp, req.getContextPath() + "/admin/overview");
            return;
        }

        // user (role = 0)
        String returnUrl = req.getParameter("returnUrl");
        if (returnUrl == null || returnUrl.isBlank()) {
            Object ru = session.getAttribute("returnUrl");
            returnUrl = (ru != null) ? ru.toString() : null;
            session.removeAttribute("returnUrl");
        }

        if (returnUrl != null) {
            safeRedirect(resp, returnUrl);
        } else {
            safeRedirect(resp, req.getContextPath() + "/");
        }
    }

    private void safeRedirect(HttpServletResponse response, String url) {
        response.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", url);
    }
}