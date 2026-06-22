package vn.edu.nlu.fit.be.controller;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.edu.nlu.fit.be.dto.SignVerifyResult;
import vn.edu.nlu.fit.be.dto.SignedOrderReq;
import vn.edu.nlu.fit.be.model.Account;
import vn.edu.nlu.fit.be.service.SignVerifyService;

import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "SignUploadController", value = "/upload-signature")
@MultipartConfig(
        maxFileSize = 1024 * 1024,
        maxRequestSize = 2 * 1024 * 1024
)
public class SignUploadController extends HttpServlet {

    private static final String STATUS_INVALID_REQUEST = "INVALID_REQUEST";
    private static final String STATUS_SIGNATURE_INVALID = "SIGNATURE_INVALID";
    private static final String STATUS_CERTIFICATE_INVALID = "CERTIFICATE_INVALID";
    private static final String STATUS_TAMPERED = "TAMPERED";

    private final Gson gson = new Gson();
    private final SignVerifyService verifyService = new SignVerifyService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("USER") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.getRequestDispatcher("/upload-signature.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        boolean ajax = isAjax(request);
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("USER") == null) {
            if (ajax) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                writeJson(response, false, "Bạn cần đăng nhập lại", Map.of("status", STATUS_INVALID_REQUEST));
            } else {
                response.sendRedirect(request.getContextPath() + "/login");
            }
            return;
        }

        Account account = (Account) session.getAttribute("USER");

        try {
            SignedOrderReq signedOrder = readSignedOrder(request);
            SignVerifyResult result = verifyService.verifySignedOrder(signedOrder, account.getAccountId());

            if (ajax) {
                String status = result.isSuccess() ? "VERIFIED" : resolveFailureStatus(result.getMessage());

                Map<String, Object> data = new HashMap<>();
                data.put("verified", result.isSuccess());
                data.put("status", status);
                data.put("orderId", signedOrder.getOrderId());
                data.put("orderHash", signedOrder.getOrderHash());
                data.put("signingUrl", request.getContextPath()
                        + "/order-sign/order-json?orderId=" + signedOrder.getOrderId());
                data.put("signToolUrl", request.getContextPath() + "/signing-tool/download");

                if (result.isSuccess()
                        || STATUS_TAMPERED.equals(status)
                        || STATUS_CERTIFICATE_INVALID.equals(status)) {
                    clearSigningSession(request.getSession(false));
                }

                writeJson(
                        response,
                        result.isSuccess(),
                        result.isSuccess()
                                ? "Chữ ký hợp lệ. Đơn hàng đã được xác minh."
                                : buildFailureMessage(status, result.getMessage()),
                        data
                );
                return;
            }

            request.setAttribute("verifyResult", result);
            request.getRequestDispatcher("/upload-signature.jsp").forward(request, response);
        } catch (Exception e) {
            if (ajax) {
                writeJson(response, false, "Không thể xác thực chữ ký: " + e.getMessage(), Map.of(
                        "status", STATUS_INVALID_REQUEST
                ));
            } else {
                request.setAttribute("error", "Không thể xác thực chữ ký: " + e.getMessage());
                request.getRequestDispatcher("/upload-signature.jsp").forward(request, response);
            }
        }
    }

    private SignedOrderReq readSignedOrder(HttpServletRequest request) throws IOException, ServletException {
        Part filePart = request.getPart("signedOrderFile");

        if (filePart == null || filePart.getSize() == 0) {
            throw new IllegalArgumentException("Vui lòng upload file signed_order.json");
        }

        if (!isJsonFile(filePart)) {
            throw new IllegalArgumentException("File không hợp lệ. Chỉ chấp nhận file .json");
        }

        try (InputStreamReader reader = new InputStreamReader(filePart.getInputStream(), StandardCharsets.UTF_8)) {
            SignedOrderReq signedOrder = gson.fromJson(reader, SignedOrderReq.class);
            if (signedOrder == null) {
                throw new IllegalArgumentException("File JSON không đúng định dạng");
            }
            return signedOrder;
        }
    }

    private String resolveFailureStatus(String message) {
        String normalized = message == null ? "" : message.toLowerCase();

        if (normalized.contains("hash mismatch")
                || normalized.contains("order data has been changed")) {
            return STATUS_TAMPERED;
        }

        if (normalized.contains("certificate")
                || normalized.contains("no certificate")) {
            return STATUS_CERTIFICATE_INVALID;
        }

        if (normalized.contains("signature")) {
            return STATUS_SIGNATURE_INVALID;
        }

        return STATUS_INVALID_REQUEST;
    }

    private String buildFailureMessage(String status, String originalMessage) {
        if (STATUS_SIGNATURE_INVALID.equals(status)) {
            return "Chữ ký không hợp lệ. Vui lòng tải lại dữ liệu đơn hàng, ký lại rồi upload file chữ ký mới.";
        }

        if (STATUS_TAMPERED.equals(status)) {
            return "Dữ liệu đơn hàng không khớp với snapshot ban đầu. Đơn hàng không thể tiếp tục xử lý.";
        }

        if (STATUS_CERTIFICATE_INVALID.equals(status)) {
            return "Chứng thư không hợp lệ hoặc không thuộc tài khoản hiện tại. Vui lòng kiểm tra lại chứng thư/private key.";
        }

        return originalMessage == null || originalMessage.isBlank()
                ? "File chữ ký không hợp lệ. Vui lòng kiểm tra lại."
                : originalMessage;
    }

    private boolean isAjax(HttpServletRequest request) {
        return "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
    }

    private void writeJson(HttpServletResponse response,
                           boolean success,
                           String message,
                           Map<String, Object> data) throws IOException {
        response.setContentType("application/json;charset=UTF-8");

        Map<String, Object> result = new HashMap<>();
        result.put("success", success);
        result.put("message", message);

        if (data != null) {
            result.putAll(data);
        }

        response.getWriter().write(gson.toJson(result));
    }

    private boolean isJsonFile(Part filePart) {
        String submittedFileName = filePart.getSubmittedFileName();
        String contentType = filePart.getContentType();

        return (submittedFileName != null && submittedFileName.toLowerCase().endsWith(".json"))
                || "application/json".equalsIgnoreCase(contentType);
    }

    private void clearSigningSession(HttpSession session) {
        if (session == null) {
            return;
        }

        session.removeAttribute("showSignPopup");
        session.removeAttribute("signOrderId");
        session.removeAttribute("signOrderHash");
        session.removeAttribute("signingUrl");
        session.removeAttribute("signToolUrl");
        session.removeAttribute("privateKeyUrl");
        session.removeAttribute("hasActiveCert");
    }
}
