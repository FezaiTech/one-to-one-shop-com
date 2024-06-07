package com.example.one;

import com.example.one.beans.CartBean;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;

@WebServlet(name = "cartUpdate",value = {"/updateCartServlet","/removeCartServlet"})
public class UpdateCartServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        if ("/updateCartServlet".equals(action)) {
            handleUpdate(request, response);
        } else if ("/removeCartServlet".equals(action)) {
            handleRemove(request, response);
        }
    }
    private void handleUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int newQuantity = Integer.parseInt(request.getParameter("newQuantity"));

        HttpSession session = request.getSession();
        List<CartBean> cartItems = (List<CartBean>) session.getAttribute("cartItems");

        if (cartItems != null) {
            for (Iterator<CartBean> iterator = cartItems.iterator(); iterator.hasNext();) {
                CartBean item = iterator.next();
                if (item.getProductId() == productId) {
                    if (newQuantity <= 0) {
                        iterator.remove();
                    } else {
                        item.setCount(newQuantity);
                    }
                    break;
                }
            }
            session.setAttribute("cartItems", cartItems);
        }

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("Sepet başarıyla güncellendi!");
    }

    private void handleRemove(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("cartItems"); // Sepet verilerini temizler

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("Sepet başarıyla temizlendi!");
    }
}
