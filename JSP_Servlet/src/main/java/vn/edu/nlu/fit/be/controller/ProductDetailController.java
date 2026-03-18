package vn.edu.nlu.fit.be.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.nlu.fit.be.model.Brand;
import vn.edu.nlu.fit.be.model.Category;
import vn.edu.nlu.fit.be.model.Product;
import vn.edu.nlu.fit.be.service.*;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ProductDetailController", value = "/product-detail")
public class ProductDetailController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductService ps = new ProductService();
        StockProductService sps = new StockProductService();
        CategoryService cs = new CategoryService();
        BrandService bs = new BrandService();
        ReviewService rs = new ReviewService();
        //Lấy productId sản phẩm từ trang product list
        int productId = Integer.parseInt(request.getParameter("product_id"));
        Product product = ps.getProductById(productId);
        request.setAttribute("product", product);

        //Lấy loại sản phẩm
        int categoryId = product.getCategoryId();
        Category category = cs.getCategoryById(categoryId);
        request.setAttribute("category", category);

        //Lấy tên thương hiệu
        int brandId = product.getBrandId();
        Brand brand = bs.getBrandById(brandId);
        request.setAttribute("brand", brand);

        //Lấy số lượng đã bán
        int soldQuantity = ps.getTotalSoldQuantity(productId);
        boolean isAvailable = sps.checkProductAvailable(productId);
        request.setAttribute("soldQuantity", soldQuantity);
        request.setAttribute("isAvailable", isAvailable);

        //Lấy danh sách hình ảnh sản phẩm
        List<String> productImages = ps.getImagesListInProduct(productId);
        request.setAttribute("productImages", productImages);

        //Lấy ra chi tiết gồm mô tả và hình ảnh sản phẩm
        List<Map<String, Object>> getProductDetails = ps.getProductDetails(productId);
        request.setAttribute("details", getProductDetails);

        //Lấy ra bình luận về sản phẩm
        List<Map<String, Object>> reviewsByProductId = rs.getReviewsByProductId(productId);
        request.setAttribute("reviewList", reviewsByProductId);
        //Chuyển đến trang product detail
        request.getRequestDispatcher("productDetail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}