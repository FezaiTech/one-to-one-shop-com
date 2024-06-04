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

        try (Connection conn = DatabaseConnection.initializeDatabase()) {
            // Email kontrolü
            String checkEmailQuery = "SELECT * FROM users WHERE email = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkEmailQuery);
            checkStmt.setString(1, email);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // E-posta zaten kayıtlıysa
                response.setContentType("text/html");
                try (PrintWriter out = response.getWriter()) {
                    out.println("<script type='text/javascript'>");
                    out.println("alert('Bu e-posta zaten kayıtlı. Lütfen giriş yapın.');");
                    out.println("window.location.href = 'login.jsp?email=" + email + "';");
                    out.println("</script>");
                }
            } else {
                // E-posta kayıtlı değilse yeni kullanıcı ekle
                String query = "INSERT INTO users (name, surname, phone, email, password) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement pstmt = conn.prepareStatement(query);
                pstmt.setString(1, name);
                pstmt.setString(2, surname);
                pstmt.setString(3, phone);
                pstmt.setString(4, email);
                pstmt.setString(5, password);
                int rows = pstmt.executeUpdate();

                if (rows > 0) {
                    response.sendRedirect("home.jsp");
                } else {
                    response.setContentType("text/html");
                    try (PrintWriter out = response.getWriter()) {
                        out.println("<h1>Registration Failed</h1>");
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            throw new ServletException("Database error", e);
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection conn = DatabaseConnection.initializeDatabase()) {
            String query = "SELECT * FROM users WHERE email = ? AND password = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                response.sendRedirect("home.jsp");
            } else {
                response.setContentType("text/html");
                try (PrintWriter out = response.getWriter()) {
                    out.println("<script type='text/javascript'>");
                    out.println("alert('Hatalı kullanıcı adı veya şifre');");
                    out.println("location='/login.jsp';");
                    out.println("</script>");
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            throw new ServletException("Database error", e);
        }
    }
}
