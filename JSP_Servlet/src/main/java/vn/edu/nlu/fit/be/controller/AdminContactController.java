package vn.edu.nlu.fit.be.controller;

import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.nlu.fit.be.model.Account;
import vn.edu.nlu.fit.be.model.Contact;
import vn.edu.nlu.fit.be.service.ContactService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminContactController", value = "/admin/contacts")
public class AdminContactController extends HttpServlet {
    private final ContactService contactService = new ContactService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        //chưa login
        if (session == null || session.getAttribute("USER") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Account acc = (Account) session.getAttribute("USER");

        //không phải admin
        if (acc.getRole() <= 0) {
            response.sendRedirect(request.getContextPath() + "/403.jsp");
            return;
        }
        String action = request.getParameter("action");

        //XOÁ CONTACT
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            contactService.deleteContact(id);

            // redirect để tránh xoá lại khi refresh
            response.sendRedirect(request.getContextPath() + "/admin/contacts");
            return;
        }

        //XEM CHI TIẾT CONTACT
        if ("view".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Contact selectedContact = contactService.getContactById(id);
            request.setAttribute("selectedContact", selectedContact);
        }

        //LOAD DANH SÁCH
        List<Contact> contactList = contactService.loadMoreContacts();
        request.setAttribute("contactList", contactList);

        request.getRequestDispatcher("/admin_contacts.jsp").forward(request, response);
    }
}