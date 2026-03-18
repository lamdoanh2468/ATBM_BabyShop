package vn.edu.nlu.fit.be.controller;

import vn.edu.nlu.fit.be.model.Account;
import vn.edu.nlu.fit.be.model.Voucher;
import vn.edu.nlu.fit.be.service.VoucherService;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;
import java.util.List;
@WebServlet("/admin/vouchers")
public class AdminVoucherController extends HttpServlet {

    private final VoucherService service = new VoucherService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

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

        String action = req.getParameter("action");

        if ("edit".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            Voucher v = service.findById(id);
            req.setAttribute("voucherToEdit", v);
        }

        List<Voucher> vouchers = service.getAll();
        req.setAttribute("vouchers", vouchers);

        req.getRequestDispatcher("/admin_vouchers.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        if ("delete".equals(action)) {

            int id = Integer.parseInt(req.getParameter("id"));
            service.delete(id);

        } else if ("edit".equals(action)) {
            Voucher v = new Voucher();
            v.setVoucherId(Integer.parseInt(req.getParameter("id"))); // ⭐ QUAN TRỌNG
            v.setVoucherCode(req.getParameter("voucherCode"));
            v.setVoucherImage(req.getParameter("voucherImage"));
            v.setVoucherName(req.getParameter("voucherName"));
            v.setDiscountAmount(Integer.parseInt(req.getParameter("discountAmount")));
            v.setStartDate(Date.valueOf(req.getParameter("startDate")));
            v.setEndDate(Date.valueOf(req.getParameter("endDate")));
            v.setDescription(req.getParameter("description"));
            service.update(v);

        } else {
            Voucher v = new Voucher();
            v.setVoucherCode(req.getParameter("voucherCode"));
            v.setVoucherImage(req.getParameter("voucherImage"));
            v.setVoucherName(req.getParameter("voucherName"));
            v.setDiscountAmount(Integer.parseInt(req.getParameter("discountAmount")));
            v.setStartDate(Date.valueOf(req.getParameter("startDate")));
            v.setEndDate(Date.valueOf(req.getParameter("endDate")));
            v.setDescription(req.getParameter("description"));
            service.insert(v);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/vouchers");
    }
}

