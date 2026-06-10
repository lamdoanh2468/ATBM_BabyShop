package vn.edu.nlu.fit.be.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.nlu.fit.be.model.Account;
import vn.edu.nlu.fit.be.model.UserCertificate;
import vn.edu.nlu.fit.be.service.CertificateService;

import java.io.IOException;

@WebServlet(name = "SecurityKeyController", urlPatterns = {
        "/security-key",
        "/security-key/create",
        "/security-key/revoke",
        "/security-key/download-private-key"
})
public class SecurityKeyController extends HttpServlet {

    private final CertificateService certificateService = new CertificateService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("USER") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        Account account = (Account) session.getAttribute("USER");
        String path = request.getServletPath();

        UserCertificate activeCert = certificateService.getActiveCertByAccountId(account.getAccountId()).orElse(null);
        request.setAttribute("hasCertificate", activeCert != null);
        request.setAttribute("certificate", activeCert);
        request.setAttribute("canDownloadPrivateKey", certificateService.hasPendingPrivateKey(account.getAccountId()));

        if ("/security-key/download-private-key".equals(path)) {
            try {
                certificateService.downloadPrivateKey(account.getAccountId(), response);
            } catch (Exception e) {
                if (!response.isCommitted()) {
                    response.sendRedirect(request.getContextPath() + "/security-key?downloadError=1");
                }
            }
            return;
        }
        request.getRequestDispatcher("/security-key.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("USER") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Account account = (Account) session.getAttribute("USER"); // Changed from 'acc' to 'account'
        String path = request.getServletPath();

        try {
            if ("/security-key/create".equals(path)) {
                certificateService.revokeActiveCertByLostKey(
                        account.getAccountId(),
                        "User created new key");

                certificateService.createNewCertAccount(account.getAccountId());

                response.sendRedirect(request.getContextPath() + "/security-key?created=1");
                return;
            }

            if ("/security-key/revoke".equals(path)) {
                certificateService.revokeActiveCertByLostKey(
                        account.getAccountId(),
                        "User reported lost private key");
                certificateService.createNewCertAccount(account.getAccountId());
                response.sendRedirect(request.getContextPath() + "/security-key?revoked=1");
                return;
            }

            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        } catch (Exception e) {
            request.setAttribute("error", "Không thể xử lý khóa bảo mật: " + e.getMessage());
            request.getRequestDispatcher("/security-key.jsp").forward(request, response);
        }
    }
}