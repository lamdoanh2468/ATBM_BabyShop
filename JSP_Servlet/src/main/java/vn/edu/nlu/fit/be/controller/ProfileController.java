package vn.edu.nlu.fit.be.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.nlu.fit.be.model.Account;
import vn.edu.nlu.fit.be.model.Gender;
import vn.edu.nlu.fit.be.model.Profile;
import vn.edu.nlu.fit.be.service.ProfileService;

import java.io.IOException;
import java.sql.Date;

@WebServlet(name = "ProfileController", value = "/profile")
public class ProfileController extends HttpServlet {
    private final ProfileService profileService = new ProfileService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        Account user = (Account) session.getAttribute("USER");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Profile profile = profileService.findById(user.getProfileId());
        req.setAttribute("PROFILE", profile);

        req.getRequestDispatcher("/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        HttpSession session = req.getSession(false);
        Account user = (Account) session.getAttribute("USER");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Profile profile = new Profile();
        profile.setProfileId(user.getProfileId());
        profile.setFullName(req.getParameter("fullName"));
        profile.setPhone(req.getParameter("phone"));
        profile.setAddress(req.getParameter("address"));
        profile.setGender(Gender.valueOf(req.getParameter("gender")));
        profile.setBirthDate(Date.valueOf(req.getParameter("birthDate")));

        profileService.update(profile);

        resp.sendRedirect(req.getContextPath() + "/profile");
    }
}