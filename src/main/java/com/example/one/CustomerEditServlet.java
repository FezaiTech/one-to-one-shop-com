package com.example.one;

import com.example.one.service.CustomerService;
import com.example.one.service.operations.CustomerOperations;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "customerEditServlet", urlPatterns = {"/seller-customer-delete"})
public class CustomerEditServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int customerID = Integer.parseInt(request.getParameter("customerId"));
        CustomerService customerService = new CustomerOperations();

        String result = customerService.deleteCustomer(customerID);
        System.out.println(customerID);
        System.out.println(result);
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
