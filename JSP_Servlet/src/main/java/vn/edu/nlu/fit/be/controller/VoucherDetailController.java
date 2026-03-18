package vn.edu.nlu.fit.be.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.nlu.fit.be.model.Voucher;
import vn.edu.nlu.fit.be.service.VoucherService;

import java.io.IOException;

@WebServlet(name = "VoucherDetailController", value = "/voucher-detail")
public class VoucherDetailController extends HttpServlet {
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

        String idStr = request.getParameter("id");

        if (idStr == null) {
            response.sendRedirect(request.getContextPath() + "/voucher-list");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/voucher-list");
            return;
        }

        Voucher voucher = voucherService.findById(id);

        if (voucher == null) {
            request.setAttribute("error", "Voucher không tồn tại");
            request.getRequestDispatcher("/voucher_detail.jsp")
                    .forward(request, response);
            return;
        }

        request.setAttribute("voucher", voucher);
        request.getRequestDispatcher("/voucher_detail.jsp")
                .forward(request, response);
    }
}