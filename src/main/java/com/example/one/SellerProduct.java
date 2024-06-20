package com.example.one;

import com.example.one.service.ProductService;
import com.example.one.service.operations.ProductOperations;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "sellerProductServlet", urlPatterns = {"/seller-product-edit","/seller-product-delete"})
public class SellerProduct extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        if ("/seller-product-edit".equals(action)) {
            handleEdit(request, response);
        } else if ("/seller-product-delete".equals(action)) {
            handleDelete(request, response);
        }
    }

    private void handleEdit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        ProductService productService = new ProductOperations();

        String result = productService.removeProduct(productId);
        if (result.equals("ok")){
            response.sendRedirect("store-management.jsp");
        }else {
            response.setContentType("text/html");
            try (PrintWriter out = response.getWriter()) {
                out.println("<script type='text/javascript'>");
                out.println("alert(\"" + result + "\");");
                out.println("Bir hata meydana geldi");
                out.println("</script>");
            }
        }
    }
}
