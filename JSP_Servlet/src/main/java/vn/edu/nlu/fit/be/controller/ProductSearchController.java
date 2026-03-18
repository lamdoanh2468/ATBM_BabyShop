package vn.edu.nlu.fit.be.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.nlu.fit.be.model.Category;
import vn.edu.nlu.fit.be.model.Product;
import vn.edu.nlu.fit.be.service.CategoryService;
import vn.edu.nlu.fit.be.service.ProductService;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "SearchController", value = "/search")
public class ProductSearchController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String keyword = request.getParameter("keyword");
        String sort = request.getParameter("sort");
        ProductService productService = new ProductService();
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
        totalProducts = productService.countTotalProductsBy(null, keyword);
        if (sort != null) {
            products = productService.getProducts(null, null, sort, keyword, pageIndex, pageSize);
        } else {
            products = productService.getProducts(null, null, null, keyword, pageIndex, pageSize);
        }
        //Thêm số lượng đã bán
        Map<Integer, Integer> soldMap = productService.getSoldMap(products);
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);


        request.setAttribute("products", products);
        request.setAttribute("soldMap", soldMap);
        request.setAttribute("currentPage", pageIndex);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentSort", sort);
        request.setAttribute("keyword", keyword);

        request.getRequestDispatcher("productList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}