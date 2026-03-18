package vn.edu.nlu.fit.be.controller;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.nlu.fit.be.service.AccountService;

import java.io.IOException;

@WebServlet(name = "VerifyOTPController", value = "/verify-otp")
public class VerifyOTPController extends HttpServlet {
    private final AccountService service = new AccountService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/verify-otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        String inputOtp = req.getParameter("otp");

        String sessionOtp = (String) session.getAttribute("OTP");
        Long otpTime = (Long) session.getAttribute("OTP_TIME");

        if (sessionOtp == null || otpTime == null) {
            req.setAttribute("error", "OTP không hợp lệ!");
            req.getRequestDispatcher("/verify-otp.jsp").forward(req, resp);
            return;
        }

        //Kiểm tra 60s
        if (System.currentTimeMillis() - otpTime > 60000) {
            req.setAttribute("error", "OTP đã hết hạn!");
            req.getRequestDispatcher("/verify-otp.jsp").forward(req, resp);
            return;
        }

        if (!sessionOtp.equals(inputOtp)) {
            req.setAttribute("error", "OTP không đúng!");
            req.getRequestDispatcher("/verify-otp.jsp").forward(req, resp);
            return;
        }

        //OTP OK → tạo tài khoản
        String username = (String) session.getAttribute("REGISTER_USERNAME");
        String email = (String) session.getAttribute("REGISTER_EMAIL");
        String pass = (String) session.getAttribute("REGISTER_PASS");

        service.register(username, email, pass);

        session.invalidate();
        resp.sendRedirect(req.getContextPath() + "/login");
    }
}