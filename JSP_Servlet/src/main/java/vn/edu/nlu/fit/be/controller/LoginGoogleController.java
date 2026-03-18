package vn.edu.nlu.fit.be.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.nlu.fit.be.model.Account;
import vn.edu.nlu.fit.be.service.AccountService;
import vn.edu.nlu.fit.be.util.HttpUtil;
import vn.edu.nlu.fit.be.util.JsonUtil;

import java.io.IOException;

@WebServlet(name = "LoginGoogleController", value = "/login-google")
public class LoginGoogleController extends HttpServlet {

    private String CLIENT_ID;
    private String CLIENT_SECRET;
    private String REDIRECT_URI;

    private final AccountService accountService = new AccountService();

    @Override
    public void init() {
        CLIENT_ID = getServletContext().getInitParameter("GOOGLE_CLIENT_ID");
        CLIENT_SECRET = getServletContext().getInitParameter("GOOGLE_CLIENT_SECRET");
        REDIRECT_URI = getServletContext().getInitParameter("GOOGLE_REDIRECT_URI");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String code = req.getParameter("code");
        if (code == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // 1. Exchange code → access_token
        String tokenResponse = HttpUtil.post(
                "https://oauth2.googleapis.com/token",
                "code=" + code +
                        "&client_id=" + CLIENT_ID +
                        "&client_secret=" + CLIENT_SECRET +
                        "&redirect_uri=" + REDIRECT_URI +
                        "&grant_type=authorization_code"
        );

        String accessToken = JsonUtil.get(tokenResponse, "access_token");

        // 2. Get user info
        String userInfo = HttpUtil.get(
                "https://www.googleapis.com/oauth2/v2/userinfo?access_token=" + accessToken
        );

        String email = JsonUtil.get(userInfo, "email");
        String name = JsonUtil.get(userInfo, "name");

        // 3. Login / Register
        Account acc = accountService.loginWithGoogle(email, name);

        if (acc == null) {
            resp.sendRedirect(req.getContextPath() + "/login?error=blocked");
            return;
        }

        // 4. Session
        HttpSession session = req.getSession(true);
        session.setAttribute("USER", acc);
        session.setMaxInactiveInterval(30 * 60);

        resp.sendRedirect("home");
    }
}