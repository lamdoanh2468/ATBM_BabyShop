package vn.edu.nlu.fit.be.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.nlu.fit.be.model.Account;
import vn.edu.nlu.fit.be.model.Brand;
import vn.edu.nlu.fit.be.model.Contact;
import vn.edu.nlu.fit.be.service.BrandService;
import vn.edu.nlu.fit.be.service.ContactService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminBrandController", value = "/admin/brands")
public class AdminBrandController extends HttpServlet {
    private final BrandService brandService = new BrandService();

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
        String idParam = request.getParameter("id");

        if ("edit".equals(action) && idParam != null) {
            int id = Integer.parseInt(idParam);
            Brand brandToEdit = brandService.getBrandById(id);
            request.setAttribute("brandToEdit", brandToEdit);
        }

        List<Brand> brandList = brandService.loadMoreBrands();
        request.setAttribute("brandList", brandList);

        request.getRequestDispatcher("/admin_brands.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        switch (action) {
            case "add":
                Brand newBrand = new Brand();
                newBrand.setBrandName(request.getParameter("brandName"));
                newBrand.setBrandLogo(request.getParameter("brandLogo"));
                newBrand.setBrandDescription(request.getParameter("brandDescription"));
                brandService.addBrand(newBrand);
                break;

            case "edit":
                Brand editBrand = new Brand();
                editBrand.setBrandId(Integer.parseInt(request.getParameter("brandId")));
                editBrand.setBrandName(request.getParameter("brandName"));
                editBrand.setBrandLogo(request.getParameter("brandLogo"));
                editBrand.setBrandDescription(request.getParameter("brandDescription"));
                brandService.updateBrand(editBrand);
                break;

            case "delete":
                int brandId = Integer.parseInt(request.getParameter("brandId"));
                brandService.deleteBrand(brandId);
                break;
        }

        response.sendRedirect(request.getContextPath() + "/admin/brands");
    }
}