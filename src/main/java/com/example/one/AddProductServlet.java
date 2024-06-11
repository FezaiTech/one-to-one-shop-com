package com.example.one;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.math.BigDecimal;

import com.example.one.beans.ProductBean;
import com.example.one.service.ProductService;
import com.example.one.service.operations.ProductOperations;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/addToProductServlet")
@MultipartConfig(maxFileSize = 16177215)
public class AddProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productName = request.getParameter("product-brand");
        String productDetail = request.getParameter("product-detail");
        String productCategory = request.getParameter("product-category");
        String productAmountStr = request.getParameter("product-amount");
        BigDecimal productAmount = null;

        if (productAmountStr != null && !productAmountStr.isEmpty()) {
            try {
                productAmount = new BigDecimal(productAmountStr);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        Part part = request.getPart("product-img");
        InputStream inputStream = part.getInputStream();
        InputStream prodImage = inputStream;

        ProductService productService = new ProductOperations();
        ProductBean newItem = new ProductBean();
        newItem.setSellerId(1);/*GET ID*/
        newItem.setName(productName);
        newItem.setDescription(productDetail);
        newItem.setCategory(productCategory);
        newItem.setPrice(productAmount);
        newItem.setImage(prodImage);

        String g = productService.addProduct(newItem);

        if (g.equals("ok")){
            response.sendRedirect("store-management.jsp");
        } else {
            response.setContentType("text/html");
            try (PrintWriter out = response.getWriter()) {
                out.println(g);
            }
        }
    }

}
