package com.example.one;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "userServlet", value = {"/register-servlet", "/login-servlet"})
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            DatabaseConnection.createTables();
        } catch (SQLException | ClassNotFoundException e) {
            throw new ServletException("Error initializing database", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        if ("/register-servlet".equals(action)) {
            handleRegister(request, response);
        } else if ("/login-servlet".equals(action)) {
            handleLogin(request, response);
        }
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        DatabaseOperations dbOperations = null;
        try {
            dbOperations = new DatabaseOperations(DatabaseConnection.initializeDatabase());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        boolean emailExists = false;
        try {
            emailExists = dbOperations.checkEmailExists(email);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        if (emailExists) {
            response.setContentType("text/html");
            try (PrintWriter out = response.getWriter()) {
                out.println("<script type='text/javascript'>");
                out.println("alert('Bu e-posta zaten kayıtlı. Lütfen giriş yapın.');");
                out.println("window.location.href = 'login.jsp?email=" + email + "';");
                out.println("</script>");
            }
        } else {
            boolean query = dbOperations.insertUser(name,surname,phone,email,password,false);
            if (query) {
                response.sendRedirect("home.jsp");
            } else {
                response.setContentType("text/html");
                try (PrintWriter out = response.getWriter()) {
                    out.println("<script type='text/javascript'>");
                    out.println("alert('Bir hata meydana geldi.');");
                    out.println("</script>");
                }
            }
        }
    }



    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection conn = DatabaseConnection.initializeDatabase()) {
            String query = DatabaseOperations.loginUser(email, password);

            if ("ok".equals(query)) {
                response.sendRedirect("home.jsp");
            } else {
                response.setContentType("text/html");
                try (PrintWriter out = response.getWriter()) {
                    out.println("<script type='text/javascript'>");
                    out.println("alert(\"" + query + "\");");
                    out.println("window.location.href = 'login.jsp" + (query.equals("E-posta hatalı") ? "" : "?email=" + email) + "';");
                    out.println("</script>");
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            throw new ServletException("Database error", e);
        }
    }


}
