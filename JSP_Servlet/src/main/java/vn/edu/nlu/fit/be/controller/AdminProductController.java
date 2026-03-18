package vn.edu.nlu.fit.be.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import vn.edu.nlu.fit.be.dao.BrandDao;
import vn.edu.nlu.fit.be.dao.AdminCategoryDao;
import vn.edu.nlu.fit.be.model.Account;
import vn.edu.nlu.fit.be.model.Category;
import vn.edu.nlu.fit.be.model.Product;
import vn.edu.nlu.fit.be.service.AdminProductService;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/products")
public class AdminProductController extends HttpServlet {

    private final AdminProductService productService = new AdminProductService();
    private final AdminCategoryDao categoryDao = new AdminCategoryDao();
    private final BrandDao brandDao = new BrandDao();

    /* ================= CHECK ADMIN ================= */
    private boolean checkAdmin(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("USER") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return false;
        }

        Account acc = (Account) session.getAttribute("USER");
        if (acc.getRole() <= 0) {
            resp.sendRedirect(req.getContextPath() + "/403.jsp");
            return false;
        }
        return true;
    }

    /* ================= GET ================= */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if (!checkAdmin(req, resp)) return;

        String action = req.getParameter("action");

        // ===== LIST =====
        List<Product> products = productService.getAllProducts();
        req.setAttribute("products", products);

        // ===== COMMON DATA =====
        req.setAttribute("categories", categoryDao.findAll());
        req.setAttribute("brands", brandDao.getBrands());

        List<Category> categories = categoryDao.findAll();
        Map<Integer, String> categoryMap = new HashMap<>();
        for (Category c : categories) {
            categoryMap.put(c.getCategoryId(), c.getCategoryName());
        }
        req.setAttribute("categoryMap", categoryMap);



        // ===== EDIT =====
        if ("edit".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            Product product = productService.getById(id);
            req.setAttribute("product", product);
        }

        req.getRequestDispatcher("/admin_products.jsp").forward(req, resp);
    }

    /* ================= POST ================= */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if (!checkAdmin(req, resp)) return;

        req.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");

        switch (action) {
            case "create" -> create(req, resp);
            case "update" -> update(req, resp);
            case "delete" -> delete(req, resp);
            default -> resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }

    /* ================= CREATE ================= */
    private void create(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        Product p = buildProductFromRequest(req);
        productService.insert(p);

        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }

    /* ================= UPDATE ================= */
    private void update(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        Product p = buildProductFromRequest(req);
        p.setProductId(Integer.parseInt(req.getParameter("productId")));

        productService.update(p);
        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }

    /* ================= DELETE ================= */
    private void delete(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        productService.delete(id);

        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }

    /* ================= MAP FORM → PRODUCT ================= */
    private Product buildProductFromRequest(HttpServletRequest req) {

        Product p = new Product();

        p.setProductName(req.getParameter("productName"));
        p.setProductPrice(Integer.parseInt(req.getParameter("productPrice")));
        p.setCategoryId(Integer.parseInt(req.getParameter("categoryId")));
        p.setBrandId(Integer.parseInt(req.getParameter("brandId")));

        p.setProductSize(req.getParameter("productSize"));
        p.setProductMaterial(req.getParameter("productMaterial"));

        // IMAGE URL (KHÔNG UPLOAD FILE)
        p.setProductImage(req.getParameter("productImage"));

        return p;
    }
}
