package vn.edu.nlu.fit.be.controller;

import java.io.IOException;
import java.io.InputStream;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "SigningToolDownloadController", value = "/signing-tool/download")
public class SignToolDownloadController extends HttpServlet {

    private static final String SIGNING_TOOL_PATH = "/WEB-INF/downloads/OrderSignApp.zip";
    private static final String SIGNING_TOOL_FILE_NAME = "OrderSignApp.zip";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("USER") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        downloadSigningTool(response);
    }

    private void downloadSigningTool(HttpServletResponse response) throws IOException {
        try (InputStream inputStream = getServletContext().getResourceAsStream(SIGNING_TOOL_PATH)) {
            if (inputStream == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy file " + SIGNING_TOOL_FILE_NAME);
                return;
            }

            response.setContentType("application/zip");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + SIGNING_TOOL_FILE_NAME + "\"");
            response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0");
            inputStream.transferTo(response.getOutputStream());
        }
    }
}
