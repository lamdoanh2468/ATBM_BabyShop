package vn.edu.nlu.fit.be.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.nlu.fit.be.util.EmailUtil;
import vn.edu.nlu.fit.be.util.OTPUtil;

import java.io.IOException;

@WebServlet(name = "ResendOTPController", value = "/resend-otp")
public class ResendOTPController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String email = (String) session.getAttribute("REGISTER_EMAIL");

        if (email == null) {
            // Nếu không tìm thấy email trong session (hết hạn hoặc truy cập trái phép)
            // Redirect về trang đăng ký hoặc hiển thị lỗi
            req.setAttribute("error", "Phiên làm việc đã hết hạn, vui lòng đăng ký lại!");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        // Sinh OTP mới
        String newOtp = OTPUtil.generateOTP();
        long newOtpTime = System.currentTimeMillis();

        // Gửi email
        EmailUtil.sendOTP(email, newOtp);

        // Cập nhật session
        session.setAttribute("OTP", newOtp);
        session.setAttribute("OTP_TIME", newOtpTime);

        // Thông báo cho người dùng
        req.setAttribute("message", "Đã gửi lại mã OTP mới qua email!");
        req.getRequestDispatcher("/verify-otp.jsp").forward(req, resp);
    }
}
