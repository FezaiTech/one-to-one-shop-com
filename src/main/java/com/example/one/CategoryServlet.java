package com.example.one;

import com.example.one.beans.ProductBean;
import com.example.one.service.ProductService;
import com.example.one.service.operations.ProductOperations;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "categoryServlet", urlPatterns = {"/category-servlet"})
public class CategoryServlet extends HttpServlet {

    /*query*/
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String categoryName = request.getParameter("categoryName");
        ProductService dao = new ProductOperations();
        List<ProductBean> resultProducts = dao.getAllProductsByCategory(categoryName,100);
        if (resultProducts != null) {
            request.setAttribute("resultProducts", resultProducts);
            request.setAttribute("categoryName", categoryName);
            RequestDispatcher dispatcher = request.getRequestDispatcher("category.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect("error.jsp");
        }
    }
}