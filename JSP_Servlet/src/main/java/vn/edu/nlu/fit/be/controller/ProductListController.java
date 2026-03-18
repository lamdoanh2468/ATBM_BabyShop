package vn.edu.nlu.fit.be.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.nlu.fit.be.model.*;
import vn.edu.nlu.fit.be.service.*;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import vn.edu.nlu.fit.be.model.Product;
import vn.edu.nlu.fit.be.service.StockProductService;

@WebServlet(name = "ProductListController", value = "/product-list")
public class ProductListController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        ProductService ps = new ProductService();
        CategoryService cs = new CategoryService();
        BrandService bs = new BrandService();
        StockProductService ss = new StockProductService();
        List<Product> products;

        //Phân trang trước tiên
        int pageIndex = 1;
        int pageSize = 20;
        int totalProducts = 0;

        String pageStr = request.getParameter("page");
        if (pageStr != null) {
            try {
                pageIndex = Integer.parseInt(pageStr);

            } catch (NumberFormatException nfe) {
                pageIndex = 1;
            }
        }

        // Lấy tham số từ url
        String categoryIdToStr = request.getParameter("category_id");
        String[] brands = request.getParameterValues("brand");
        String sort = request.getParameter("sort");

        //* Chia làm hai: không lọc theo category và lọc theo category
        Integer categoryId = null;
        if (categoryIdToStr != null && !categoryIdToStr.isEmpty()) {
            categoryId = Integer.parseInt(categoryIdToStr);
        }
        totalProducts = ps.countTotalProductsBy(categoryId, brands, null);
        products = ps.getProducts(categoryId, brands, sort, null, pageIndex, pageSize);


        List<Category> categories = cs.getCategoryList();
        List<Brand> totalBrands = bs.getBrands();

        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

        //Lấy số lượng đã bán
        Map<Integer, Integer> soldMap = ps.getSoldMap(products);

        // Lưu vào trong request
        request.setAttribute("products", products);
        request.setAttribute("soldMap", soldMap);
        request.setAttribute("categories", categories);
        request.setAttribute("brands", totalBrands);
        //- phân trang
        request.setAttribute("currentPage", pageIndex);
        request.setAttribute("totalPages", totalPages);

        request.setAttribute("currentCategoryId", categoryIdToStr);
        request.setAttribute("currentSort", sort);
        request.setAttribute("currentBrand", brands);

        request.getRequestDispatcher("productList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}