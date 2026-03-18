package vn.edu.nlu.fit.be.controller;

import vn.edu.nlu.fit.be.dao.StockDao;
import vn.edu.nlu.fit.be.model.Account;
import vn.edu.nlu.fit.be.model.Stock;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
@WebServlet(name = "AdminStockController", value = "/admin/stocks")
public class AdminStockController extends HttpServlet {

    private final StockDao stockDao = new StockDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("USER") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Account acc = (Account) session.getAttribute("USER");
        if (acc.getRole() <= 0) {
            resp.sendRedirect(req.getContextPath() + "/403.jsp");
            return;
        }

        String action = req.getParameter("action");

        // load list kho
        List<Stock> stocks = stockDao.getAllStocks();
        for (Stock s : stocks) {
            s.setProductCount(stockDao.getTotalProductsInStock(s.getStockId()));
        }
        req.setAttribute("stocks", stocks);

        // EDIT
        if ("edit".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            Stock stock = stockDao.getStockById(id);
            req.setAttribute("stockToEdit", stock);
        }

        req.getRequestDispatcher("/admin_stocks.jsp").forward(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        String action = req.getParameter("action");

        if ("add".equals(action)) {
            String name = req.getParameter("name");
            String address = req.getParameter("address");

            if (name != null && address != null) {
                Stock stock = new Stock();
                stock.setStockName(name);
                stock.setStockAddress(address);
                stockDao.addStock(stock);
            }

        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            String name = req.getParameter("name");
            String address = req.getParameter("address");

            Stock stock = new Stock();
            stock.setStockId(id);
            stock.setStockName(name);
            stock.setStockAddress(address);

            stockDao.updateStock(stock);

        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));

            // (nâng cao) có thể check còn sản phẩm không
            stockDao.deleteStock(id);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/stocks");
    }
}

