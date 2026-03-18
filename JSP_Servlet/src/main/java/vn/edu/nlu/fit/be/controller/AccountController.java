package vn.edu.nlu.fit.be.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import vn.edu.nlu.fit.be.model.Account;
import vn.edu.nlu.fit.be.model.AccountStatus;
import vn.edu.nlu.fit.be.service.AccountService;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {
        "/admin/accounts",
        "/admin/accounts/status",
        "/admin/accounts/add",
        "/admin/accounts/delete"
})
public class AccountController extends HttpServlet {

    private final AccountService service = new AccountService();

    /* ======================= GET ======================= */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // chưa login
        if (session == null || session.getAttribute("USER") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Account admin = (Account) session.getAttribute("USER");

        // không phải admin
        if (admin.getRole() <= 0) {
            resp.sendRedirect(req.getContextPath() + "/403.jsp");
            return;
        }

        String path = req.getServletPath();

        // ===== LOAD ACCOUNT LIST =====
        if (path.equals("/admin/accounts")) {

            String keyword = req.getParameter("search");
            List<Account> accounts;

            if (keyword != null && !keyword.trim().isEmpty()) {
                accounts = service.search(keyword);
            } else {
                accounts = service.getAll();
            }

            req.setAttribute("accounts", accounts);
            RequestDispatcher rd =
                    req.getRequestDispatcher("/admin_accounts.jsp");
            rd.forward(req, resp);
        }
    }

    /* ======================= POST ======================= */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("USER") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Account admin = (Account) session.getAttribute("USER");

        if (admin.getRole() <= 0) {
            resp.sendRedirect(req.getContextPath() + "/403.jsp");
            return;
        }

        String path = req.getServletPath();

        // ===== UPDATE STATUS (KHÔNG AJAX) =====
        if (path.equals("/admin/accounts/status")) {

            int id = Integer.parseInt(req.getParameter("id"));
            AccountStatus status =
                    AccountStatus.valueOf(req.getParameter("status"));

            service.updateStatus(id, status);

            resp.sendRedirect(req.getContextPath() + "/admin/accounts");
            return;
        }

        // ===== DELETE =====
        if (path.equals("/admin/accounts/delete")) {

            int id = Integer.parseInt(req.getParameter("id"));

            // không cho tự xóa chính mình
            if (admin.getAccountId() == id) {
                resp.sendRedirect(req.getContextPath()
                        + "/admin/accounts?error=self-delete");
                return;
            }

            service.delete(id);
            resp.sendRedirect(req.getContextPath() + "/admin/accounts");
            return;
        }

        // ===== ADD =====
        if (path.equals("/admin/accounts/add")) {

            String email = req.getParameter("email");
            String username = req.getParameter("username");
            String password = req.getParameter("password");
            int role = Integer.parseInt(req.getParameter("role"));

            Account a = new Account();
            a.setEmail(email);
            a.setUsername(username);
            a.setPassword(password); // Service sẽ hash
            a.setRole(role);
            a.setStatus(AccountStatus.Active);

            service.add(a);
            resp.sendRedirect(req.getContextPath() + "/admin/accounts");
        }
    }
}
