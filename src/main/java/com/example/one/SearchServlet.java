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
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "searchServlet", urlPatterns = {"/search-servlet"})
public class SearchServlet extends HttpServlet {

    /*query*/

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       String searchQuery = request.getParameter("query");
        ProductService dao = new ProductOperations();
        List<ProductBean> resultProducts = dao.searchAllProducts(searchQuery);
        if (resultProducts != null) {
            request.setAttribute("resultProducts", resultProducts);
            request.setAttribute("searchQuery", searchQuery);
            RequestDispatcher dispatcher = request.getRequestDispatcher("search.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect("error.jsp");
        }
    }
}
