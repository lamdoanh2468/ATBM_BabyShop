package vn.edu.nlu.fit.be.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.nlu.fit.be.model.Account;
import vn.edu.nlu.fit.be.service.CertificateService;

import java.io.IOException;

@WebServlet(name = "CertificateController", urlPatterns = {
        "/certificate",
        "/certificate/download",
        "/certificate/report-lost-key"
})
public class CertController extends HttpServlet {

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

        if ("/certificate/download".equals(path)) {
            downloadCertificate(response, account);
            return;
        }

        request.setAttribute("certificate", certificateService.getActiveCertByAccountId(account.getAccountId()));
        request.setAttribute("revokedCertificates", certificateService.findRevokedByAccountId(account.getAccountId()));
        request.getRequestDispatcher("/security-key.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("USER") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Account account = (Account) session.getAttribute("USER");
        String path = request.getServletPath();

        if ("/certificate/report-lost-key".equals(path)) {
            String reason = request.getParameter("reason");
            certificateService.revokeActiveCertByLostKey(account.getAccountId(), reason);
            try {
                certificateService.createNewCertAccount(account.getAccountId());
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
            request.setAttribute("message", "Đã báo mất private key. Certificate cũ bị revoke và certificate mới đã được tạo.");
            doGet(request, response);
            return;
        }

        response.sendError(HttpServletResponse.SC_NOT_FOUND);
    }

    private void downloadCertificate(HttpServletResponse response, Account account) throws IOException {
        String certificatePem = certificateService.getActiveCertPem(account.getAccountId());
        if (certificatePem == null || certificatePem.isBlank()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "User chưa có certificate hợp lệ");
            return;
        }

        byte[] bytes = certificatePem.getBytes(java.nio.charset.StandardCharsets.UTF_8);
        response.setContentType("application/x-pem-file; charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment; filename=\"certificate_account_" + account.getAccountId() + ".pem\"");
        response.setContentLength(bytes.length);
        response.getOutputStream().write(bytes);
    }
}
