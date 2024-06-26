package com.example.one;
import com.example.one.beans.ProductBean;
import com.example.one.service.ProductService;
import com.example.one.service.operations.ProductOperations;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int sellerId = Integer.parseInt(request.getParameter("sellerId"));

        // Assumes you have a service to get products by seller ID
        ProductService productService = new ProductOperations(); // or however you obtain an instance of ProductService
        List<ProductBean> storeProducts = productService.getAllProductsBySellerid(sellerId);

        // Set the product list as an attribute in the request
        request.setAttribute("storeProducts", storeProducts);

        // Forward the request to the JSP page
        RequestDispatcher dispatcher = request.getRequestDispatcher("products.jsp");
        try {
            dispatcher.forward(request, response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
