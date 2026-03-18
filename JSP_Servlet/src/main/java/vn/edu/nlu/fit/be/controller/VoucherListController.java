package vn.edu.nlu.fit.be.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.nlu.fit.be.model.Voucher;
import vn.edu.nlu.fit.be.service.VoucherService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "VoucherListController", value = "/voucher-list")
public class VoucherListController extends HttpServlet {

    private VoucherService voucherService;

    @Override
    public void init() {
        voucherService = new VoucherService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // ===== PHÂN TRANG =====
        int pageIndex = 1;
        int pageSize = 12;
        int totalVouchers;

        String pageStr = request.getParameter("page");
        if (pageStr != null) {
            try {
                pageIndex = Integer.parseInt(pageStr);
                if (pageIndex < 1) pageIndex = 1;
            } catch (NumberFormatException e) {
                pageIndex = 1;
            }
        }

        // ===== DATA =====
        List<Voucher> vouchers = voucherService.getByPage(pageIndex, pageSize);
        totalVouchers = voucherService.countAll();

        int totalPage = (int) Math.ceil((double) totalVouchers / pageSize);

        // ===== SET ATTRIBUTE =====
        request.setAttribute("vouchers", vouchers);
        request.setAttribute("currentPage", pageIndex);
        request.setAttribute("totalPage", totalPage);

        // ===== FORWARD =====
        request.getRequestDispatcher("/voucher_list.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
