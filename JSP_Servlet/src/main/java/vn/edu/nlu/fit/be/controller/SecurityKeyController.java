package vn.edu.nlu.fit.be.controller;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.nlu.fit.be.model.Account;
import vn.edu.nlu.fit.be.model.Certificate;
import vn.edu.nlu.fit.be.service.CertificateService;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "SecurityKeyController", urlPatterns = {
        "/security-key",
        "/security-key/create",
        "/security-key/revoke",
        "/security-key/lost-key",
        "/security-key/reissue",
        "/security-key/status",
        "/security-key/download-private-key"
})
public class SecurityKeyController extends HttpServlet {

    private final CertificateService certificateService = new CertificateService();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("USER") == null) {
            if (isAjax(request)) {
                writeJson(response, HttpServletResponse.SC_UNAUTHORIZED, Map.of(
                        "success", false,
                        "message", "Bạn cần đăng nhập lại"));
            } else {
                response.sendRedirect(request.getContextPath() + "/login");
            }
            return;
        }

        Account account = (Account) session.getAttribute("USER");
        String path = request.getServletPath();

        if ("/security-key/download-private-key".equals(path)) {
            downloadPrivateKey(request, response, account);
            return;
        }

        if ("/security-key/status".equals(path)) {
            writeSecurityKeyStatus(request, response, account);
            return;
        }

        showSecurityKeyPage(request, response, account);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        boolean ajax = isAjax(request);

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("USER") == null) {
            if (ajax) {
                writeJson(response, HttpServletResponse.SC_UNAUTHORIZED, Map.of(
                        "success", false,
                        "message", "Bạn cần đăng nhập lại"));
            } else {
                response.sendRedirect(request.getContextPath() + "/login");
            }
            return;
        }

        Account account = (Account) session.getAttribute("USER");
        String path = request.getServletPath();

        try {
            if ("/security-key/reissue".equals(path)) {
                handleReissuePrivateKey(request, response, account, ajax);
                return;
            }

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

            if (ajax) {
                writeJson(response, HttpServletResponse.SC_NOT_FOUND, Map.of(
                        "success", false,
                        "message", "Endpoint không tồn tại"));
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            if (ajax) {
                writeJson(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, Map.of(
                        "success", false,
                        "message", "Không thể xử lý khóa bảo mật: " + e.getMessage()));
            } else {
                request.setAttribute("error", "Không thể xử lý khóa bảo mật: " + e.getMessage());
                showSecurityKeyPage(request, response, account);
            }
        }
    }

    private void showSecurityKeyPage(HttpServletRequest request,
                                     HttpServletResponse response,
                                     Account account) throws ServletException, IOException {
        try {
            Certificate activeCert = certificateService
                    .getActiveCertByAccountId(account.getAccountId())
                    .orElse(null);

            List<Certificate> revokedCertificates;

            try {
                revokedCertificates = certificateService.findRevokedByAccountId(account.getAccountId());
            } catch (Exception e) {
                System.out.println(e.getMessage());
                revokedCertificates = java.util.Collections.emptyList();
                request.setAttribute("error", "Không thể tải lịch sử chứng thư: " + e.getMessage());
            }

            request.setAttribute("hasCertificate", activeCert != null);
            request.setAttribute("certificate", activeCert);
            request.setAttribute("revokedCertificates", revokedCertificates);
            request.setAttribute("canDownloadPrivateKey",
                    certificateService.hasPendingPrivateKey(account.getAccountId()));

            request.getRequestDispatcher("/security-key.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println(e.getMessage());
            request.setAttribute("error", "Không thể tải trang khóa bảo mật: " + e.getMessage());
            request.setAttribute("hasCertificate", false);
            request.setAttribute("certificate", null);
            request.setAttribute("revokedCertificates", java.util.Collections.emptyList());
            request.setAttribute("canDownloadPrivateKey", false);

            request.getRequestDispatcher("/security-key.jsp").forward(request, response);
        }
    }

    private void writeSecurityKeyStatus(HttpServletRequest request,
                                        HttpServletResponse response,
                                        Account account) throws IOException {
        try {
            boolean hasActiveCert = certificateService
                    .getActiveCertByAccountId(account.getAccountId())
                    .isPresent();
            boolean hasPendingPrivateKey = certificateService.hasPendingPrivateKey(account.getAccountId());

            if (!hasPendingPrivateKey) {
                HttpSession session = request.getSession(false);
                if (session != null) {
                    session.removeAttribute("privateKeyUrl");
                    session.setAttribute("hasActiveCert", hasActiveCert);
                }
            }

            Map<String, Object> result = new HashMap<>();
            result.put("success", true);
            result.put("hasActiveCert", hasActiveCert);
            result.put("hasPendingPrivateKey", hasPendingPrivateKey);
            result.put("privateKeyDownloaded", hasActiveCert && !hasPendingPrivateKey);
            result.put("privateKeyUrl", hasPendingPrivateKey
                    ? request.getContextPath() + "/security-key/download-private-key"
                    : "");

            writeJson(response, HttpServletResponse.SC_OK, result);
        } catch (Exception e) {
            writeJson(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, Map.of(
                    "success", false,
                    "message", "Không thể kiểm tra trạng thái private key: " + e.getMessage()));
        }
    }

    private void downloadPrivateKey(HttpServletRequest request,
                                    HttpServletResponse response,
                                    Account account) throws IOException {
        try {
            certificateService.downloadPrivateKey(account.getAccountId(), response);
        } catch (IOException e) {
            if (!response.isCommitted()) {
                response.sendRedirect(request.getContextPath() + "/security-key?downloadError=1");
            }
        }
    }

    private void handleReissuePrivateKey(HttpServletRequest request,
                                         HttpServletResponse response,
                                         Account account,
                                         boolean ajax) throws Exception {
        certificateService.revokeActiveCertByLostKey(
                account.getAccountId(),
                "User reported lost private key while signing order");
        certificateService.createNewCertAccount(account.getAccountId());

        if (ajax) {
            Map<String, Object> result = new HashMap<>();
            result.put("success", true);
            result.put("message", "Đã cấp lại private key mới. Vui lòng tải và lưu ở nơi an toàn.");
            result.put("privateKeyUrl", request.getContextPath() + "/security-key/download-private-key");
            result.put("signToolUrl", request.getContextPath() + "/signing-tool/download");
            result.put("hasActiveCert", true);
            result.put("hasPendingPrivateKey", true);

            writeJson(response, HttpServletResponse.SC_OK, result);
        } else {
            response.sendRedirect(request.getContextPath() + "/security-key?revoked=1");
        }
    }

    private boolean isAjax(HttpServletRequest request) {
        return "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
    }

    private void writeJson(HttpServletResponse response, int status, Object body)
            throws IOException {
        response.setStatus(status);
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(gson.toJson(body));
    }
}
