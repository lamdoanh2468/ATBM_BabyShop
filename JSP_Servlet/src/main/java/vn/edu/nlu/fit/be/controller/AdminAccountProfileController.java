package vn.edu.nlu.fit.be.controller;
import com.google.gson.Gson;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import vn.edu.nlu.fit.be.model.Account;
import vn.edu.nlu.fit.be.model.AccountStatus;
import vn.edu.nlu.fit.be.model.Profile;
import vn.edu.nlu.fit.be.service.AccountService;
import vn.edu.nlu.fit.be.service.ProfileService;
import vn.edu.nlu.fit.be.dao.ProfileDao;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/accounts/profile")
public class AdminAccountProfileController extends HttpServlet {

    private final AccountService accountService = new AccountService();
    private final ProfileDao profileDao = new ProfileDao();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        String idRaw = req.getParameter("accountId");
        if (idRaw == null) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        int accountId = Integer.parseInt(idRaw);

        Account acc = accountService.findById(accountId);
        if (acc == null) {
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        Profile profile = profileDao.findById(acc.getProfileId())
                .orElse(null);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(gson.toJson(profile));
    }
}
