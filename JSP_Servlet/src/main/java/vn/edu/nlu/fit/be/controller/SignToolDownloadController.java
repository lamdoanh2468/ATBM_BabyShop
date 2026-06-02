package vn.edu.nlu.fit.be.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.edu.nlu.fit.be.model.Account;
import vn.edu.nlu.fit.be.service.OrderSigningService;

import java.io.IOException;

@WebServlet(name = "SigningToolDownloadController", value = "/signing-tool/download")
public class SignToolDownloadController extends HttpServlet {

    private final OrderSigningService orderSigningService = new OrderSigningService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Account acc = session == null ? null : (Account) session.getAttribute("USER");

        if (acc == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        downloadSigningTool(response);
    }

    private void downloadSigningTool(HttpServletResponse response) throws IOException {
        byte[] zipBytes = orderSigningService.loadSigningTool();

        writeDownload(
                response,
                "application/zip",
                "signing-tool.zip",
                zipBytes
        );
    }

    private void writeDownload(
            HttpServletResponse response,
            String contentType,
            String fileName,
            byte[] data
    ) throws IOException {
        response.setContentType(contentType);
        response.setHeader(
                "Content-Disposition",
                "attachment; filename=\"" + fileName + "\""
        );
        response.setContentLength(data.length);

        response.getOutputStream().write(data);
        response.getOutputStream().flush();
    }
}