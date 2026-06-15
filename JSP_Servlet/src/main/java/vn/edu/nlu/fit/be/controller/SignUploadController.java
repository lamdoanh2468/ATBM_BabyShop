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
                writeJson(response, false, "Bạn cần đăng nhập lại", null);
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
                Map<String, Object> data = new HashMap<>();
                data.put("verified", result.isSuccess());
                writeJson(
                        response,
                        result.isSuccess(),
                        result.isSuccess()
                                ? "Chữ ký hợp lệ. Đơn hàng đã được xác minh."
                                : "Chữ ký không hợp lệ hoặc dữ liệu đơn hàng đã bị thay đổi.",
                        data
                );
                if (result.isSuccess()) {
                    clearSigningSession(request.getSession(false));
                }
                return;
            }

            request.setAttribute("verifyResult", result);
            request.getRequestDispatcher("/upload-signature.jsp").forward(request, response);
        } catch (Exception e) {
            if (ajax) {
                writeJson(response, false, "Không thể xác thực chữ ký: " + e.getMessage(), null);
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
    }
}
