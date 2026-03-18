package vn.edu.nlu.fit.be.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.edu.nlu.fit.be.dao.AdminCategoryDao;
import vn.edu.nlu.fit.be.model.Account;
import vn.edu.nlu.fit.be.model.Category;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/categories")
public class AdminCategoryController extends HttpServlet {

    private final AdminCategoryDao categoryDao = new AdminCategoryDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // ===== CHECK ADMIN =====
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

        // ===== LOAD DATA =====
        List<Category> categories = categoryDao.findAll();

        req.setAttribute("categories", categories);

        req.getRequestDispatcher("/admin_categories.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("create".equals(action)) {
            Category c = new Category();
            c.setCategoryName(req.getParameter("categoryName"));
            c.setCategoryImage(req.getParameter("categoryImage"));
            c.setDescription(req.getParameter("description"));
            categoryDao.insert(c);
        }

        if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            categoryDao.delete(id);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/categories");
    }
}
