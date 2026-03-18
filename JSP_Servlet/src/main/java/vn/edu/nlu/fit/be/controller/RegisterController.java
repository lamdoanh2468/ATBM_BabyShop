package vn.edu.nlu.fit.be.controller;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.nlu.fit.be.service.AccountService;
import vn.edu.nlu.fit.be.util.EmailUtil;
import vn.edu.nlu.fit.be.util.OTPUtil;

import java.io.IOException;

@WebServlet(name = "RegisterController", value = "/register")
public class RegisterController extends HttpServlet {

    private final AccountService service = new AccountService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String pass = req.getParameter("password");
        String confirm = req.getParameter("confirmPassword");

        if (!pass.equals(confirm)) {
            req.setAttribute("error", "Mật khẩu không khớp!");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        //Sinh OTP
        String otp = OTPUtil.generateOTP();
        long otpTime = System.currentTimeMillis();

        // 📧 Gửi email
        EmailUtil.sendOTP(email, otp);

        // 💾 Lưu session
        HttpSession session = req.getSession();
        session.setAttribute("OTP", otp);
        session.setAttribute("OTP_TIME", otpTime);
        session.setAttribute("REGISTER_USERNAME", username);
        session.setAttribute("REGISTER_EMAIL", email);
        session.setAttribute("REGISTER_PASS", pass);

        resp.sendRedirect(req.getContextPath() + "/verify-otp");
    }
}