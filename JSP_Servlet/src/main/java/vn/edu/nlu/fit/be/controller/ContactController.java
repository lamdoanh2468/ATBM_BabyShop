package vn.edu.nlu.fit.be.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.nlu.fit.be.model.Account;
import vn.edu.nlu.fit.be.service.ContactService;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "ContactController", value = "/contact")
public class ContactController extends HttpServlet {
    private final ContactService contactService = new ContactService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/contact.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        HttpSession session = request.getSession(false);
        Account acc = (Account) session.getAttribute("USER");


        if (acc == null) {
            PrintWriter out = response.getWriter();
            out.print("{\"status\":\"error\",\"message\":\"Bạn cần đăng nhập để gửi liên hệ.\"}");
            out.flush();
            return;
        }
        PrintWriter out = response.getWriter();

        String fullName = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String opinion = request.getParameter("message");

        // Basic validation
        if (fullName == null || fullName.isBlank() ||
                phone == null || phone.isBlank() ||
                email == null || email.isBlank() ||
                opinion == null || opinion.isBlank()) {
            out.print("{\"status\":\"error\",\"message\":\"Vui lòng nhập đầy đủ thông tin\"}");
            out.flush();
            return;
        }

        try {
            boolean success = contactService.createContact(acc.getAccountId(), fullName, phone, email, address == null ? "" : address, opinion);
            if (success) {
                out.print("{\"status\":\"success\",\"message\":\"Liên hệ của bạn đã được gửi. Chúng tôi sẽ liên lạc với bạn sớm nhất\"}");
            } else {
                out.print("{\"status\":\"error\",\"message\":\"Có lỗi xảy ra trong quá trình gửi liên hệ. Vui lòng thử lại sau.\"}");
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log error to server console
            String errorMsg = e.getMessage() != null ? e.getMessage().replace("\"", "'") : "Unknown Error";
            out.print("{\"status\":\"error\",\"message\":\"Lỗi máy chủ: " + errorMsg + "\"}");
        }
        out.flush();
    }
}
