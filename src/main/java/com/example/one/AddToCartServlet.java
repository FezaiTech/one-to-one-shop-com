package com.example.one;

import com.example.one.beans.CartBean;
import com.example.one.service.CartService;
import com.example.one.service.operations.CartOperations;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/addToCartServlet")
public class AddToCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        System.out.println("Servlet Sepet çalıştı");
        int productId = Integer.parseInt(request.getParameter("productId"));
        int count = Integer.parseInt(request.getParameter("count"));

        CartService cartService = new CartOperations();
        CartBean newItem = cartService.addItemToCart(productId, count);

        System.out.println(newItem);

        HttpSession session = request.getSession();

        List<CartBean> cartItems = (List<CartBean>) session.getAttribute("cartItems");

        if (cartItems == null) {
            cartItems = new ArrayList<>();
        }

        cartItems.add(newItem);
        session.setAttribute("cartItems", cartItems);

        System.out.println(cartItems);

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("Ürün başarıyla sepete eklendi!");
    }
}
