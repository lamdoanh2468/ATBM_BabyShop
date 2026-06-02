package vn.edu.nlu.fit.be.controller;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import vn.edu.nlu.fit.be.dto.SignVerifyResult;
import vn.edu.nlu.fit.be.dto.SignedOrderReq;
import vn.edu.nlu.fit.be.model.Account;
import vn.edu.nlu.fit.be.service.SignVerifyService;

import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;

@WebServlet(name = "SignUploadController", value = "/signature-upload")
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
        request.getRequestDispatcher("/signature_upload.jsp").forward(request, response);
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
        Part filePart = request.getPart("signedOrderFile");
        if (filePart == null || filePart.getSize() == 0) {
            request.setAttribute("error", "Vui lòng upload file signed_order.json");
            request.getRequestDispatcher("/signature_upload.jsp").forward(request, response);
            return;
        }

        if (!isJsonFile(filePart)) {
            request.setAttribute("error", "File không hợp lệ. Chỉ chấp nhận signed_order.json");
            request.getRequestDispatcher("/signature_upload.jsp").forward(request, response);
            return;
        }

        try (InputStreamReader reader = new InputStreamReader(filePart.getInputStream(), StandardCharsets.UTF_8)) {
            SignedOrderReq signedOrder = gson.fromJson(reader, SignedOrderReq.class);
            SignVerifyResult result = verifyService.verifySignedOrder(signedOrder, account.getAccountId());

            request.setAttribute("verifyResult", result);
            if (result.isSuccess()) {
                request.getRequestDispatcher("/signature_success.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("/signature_upload.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Không thể xác thực chữ ký: " + e.getMessage());
            request.getRequestDispatcher("/signature_upload.jsp").forward(request, response);
        }
    }

    private boolean isJsonFile(Part filePart) {
        String submittedFileName = filePart.getSubmittedFileName();
        String contentType = filePart.getContentType();
        return (submittedFileName != null && submittedFileName.toLowerCase().endsWith(".json"))
                || "application/json".equalsIgnoreCase(contentType);
    }
}
