package com.example.one;

import com.example.one.service.OrderService;
import com.example.one.service.operations.OrderOperations;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet(name = "orderServlet", urlPatterns = {"/customer-order-cancellation","/seller-order-cancellation","/seller-order-cargo"})
public class OrderServlet extends HttpServlet {
    /* order update for customer: order cancellation, order cargo tracking, order rating */

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String newStatus = request.getParameter("newStatus");
        OrderService dao = new OrderOperations();

        String query = dao.updateOrderStatus(orderId,newStatus);
        if ("ok".equals(query)) {
            response.sendRedirect("orders.jsp");
        } else {
            response.setContentType("text/html");
            try (PrintWriter out = response.getWriter()) {
                out.println("<script type='text/javascript'>");
                out.println("alert(\"" + query + "\");");
                out.println("Bir hata meydana geldi");
                out.println("</script>");
            }
        }
    }
}
