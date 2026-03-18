package vn.edu.nlu.fit.be.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import vn.edu.nlu.fit.be.model.Account;
import vn.edu.nlu.fit.be.dao.AccountDao;

import java.io.IOException;

@WebServlet("/admin/settings")
public class AdminSettingController extends HttpServlet {

    private AccountDao accountDao = new AccountDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // chưa login
        if (session == null || session.getAttribute("USER") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        Account acc = (Account) session.getAttribute("USER");

        // không phải admin
        if (acc.getRole() <= 0) {
            resp.sendRedirect(req.getContextPath() + "/403.jsp");
            return;
        }

        // đưa admin xuống jsp
        req.setAttribute("admin", acc);

        req.getRequestDispatcher("/admin_settings.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("USER") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String action = req.getParameter("action");

        // ===== LOGOUT =====
        if ("logout".equals(action)) {
            session.invalidate();
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        // ===== UPDATE ADMIN INFO =====
        if ("update".equals(action)) {
            Account acc = (Account) session.getAttribute("USER");

            String fullName = req.getParameter("fullName");
            String email = req.getParameter("email");
            String password = req.getParameter("password");

            acc.setFullName(fullName);
            acc.setEmail(email);

            // chỉ update password nếu admin nhập
            if (password != null && !password.isBlank()) {
                acc.setPassword(password); // nếu có hash thì hash tại đây
            }

            accountDao.update(acc);

            // cập nhật lại session
            session.setAttribute("USER", acc);

            resp.sendRedirect(req.getContextPath() + "/admin/settings");
        }
    }
}
