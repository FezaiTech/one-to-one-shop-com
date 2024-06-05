package com.example.one;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "homeServlet", urlPatterns = {"/home-servlet"})
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            //response.sendRedirect("login.jsp");
        } else {
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }
    }
}
