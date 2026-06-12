package vn.edu.nlu.fit.be.controller;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.nlu.fit.be.model.Account;
import vn.edu.nlu.fit.be.model.UserCertificate;
import vn.edu.nlu.fit.be.service.CertificateService;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "SecurityKeyController", urlPatterns = {
        "/security-key",
        "/security-key/create",
        "/security-key/revoke",
        "/security-key/lost-key",
        "/security-key/reissue",
        "/security-key/download-private-key",
        "/security-key/download-sign-app"
})
public class SecurityKeyController extends HttpServlet {

    private final CertificateService certificateService = new CertificateService();
    private final Gson gson = new Gson();

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

        if ("/security-key/download-sign-app".equals(path)) {
            downloadSignApp(request, response);
            return;
        }

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

        UserCertificate activeCert = certificateService
                .getActiveCertByAccountId(account.getAccountId())
                .orElse(null);

        request.setAttribute("hasCertificate", activeCert != null);
        request.setAttribute("certificate", activeCert);
        request.setAttribute("canDownloadPrivateKey",
                certificateService.hasPendingPrivateKey(account.getAccountId()));

        request.getRequestDispatcher("/security-key.jsp").forward(request, response);
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
                        "message", "Bạn cần đăng nhập lại"
                ));
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
                        "User created new key"
                );

                certificateService.createNewCertAccount(account.getAccountId());

                response.sendRedirect(request.getContextPath() + "/security-key?created=1");
                return;
            }

            if ("/security-key/revoke".equals(path)) {
                certificateService.revokeActiveCertByLostKey(
                        account.getAccountId(),
                        "User reported lost private key"
                );

                certificateService.createNewCertAccount(account.getAccountId());

                response.sendRedirect(request.getContextPath() + "/security-key?revoked=1");
                return;
            }

            if (ajax) {
                writeJson(response, HttpServletResponse.SC_NOT_FOUND, Map.of(
                        "success", false,
                        "message", "Endpoint không tồn tại"
                ));
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            if (ajax) {
                writeJson(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, Map.of(
                        "success", false,
                        "message", "Không thể xử lý khóa bảo mật: " + e.getMessage()
                ));
            } else {
                request.setAttribute("error", "Không thể xử lý khóa bảo mật: " + e.getMessage());
                request.getRequestDispatcher("/security-key.jsp").forward(request, response);
            }
        }
    }

    private void handleReissuePrivateKey(HttpServletRequest request,
                                         HttpServletResponse response,
                                         Account account,
                                         boolean ajax) throws Exception {
        certificateService.revokeActiveCertByLostKey(
                account.getAccountId(),
                "User reported lost private key while signing order"
        );

        certificateService.createNewCertAccount(account.getAccountId());

        if (ajax) {
            Map<String, Object> result = new HashMap<>();
            result.put("success", true);
            result.put("message", "Đã cấp lại private key mới. Vui lòng tải và lưu ở nơi an toàn.");
            result.put("privateKeyUrl", request.getContextPath() + "/security-key/download-private-key");
            result.put("signToolUrl", request.getContextPath() + "/security-key/download-sign-app");

            writeJson(response, HttpServletResponse.SC_OK, result);
        } else {
            response.sendRedirect(request.getContextPath() + "/security-key?revoked=1");
        }
    }

    private void downloadSignApp(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String filePath = "/WEB-INF/downloads/OrderSignApp.zip";

        try (InputStream inputStream = getServletContext().getResourceAsStream(filePath)) {
            if (inputStream == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy file OrderSignApp.zip");
                return;
            }

            response.setContentType("application/zip");
            response.setHeader(
                    "Content-Disposition",
                    "attachment; filename=\"OrderSignApp.zip\""
            );

            inputStream.transferTo(response.getOutputStream());
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