package com.example.one;

import com.example.one.beans.UserBean;
import com.example.one.service.UserService;
import com.example.one.service.operations.UserOperations;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet(name = "updateUserServlet", value = {"/update-user-servlet","/update-seller-servlet"})
public class UpdateUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        if ("/update-user-servlet".equals(action)) {
            handleUserUpdate(request, response);
        } else if ("/update-seller-servlet".equals(action)) {
            handleSellerUpdate(request, response);
        }
    }

    private void handleUserUpdate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userId = Integer.parseInt(request.getParameter("userId"));
        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        boolean sellerStatus = Boolean.parseBoolean(request.getParameter("sellerStatus"));

        UserBean updateUser = new UserBean();
        updateUser.setName(name);
        updateUser.setSurname(surname);
        updateUser.setPhone(phone);
        updateUser.setEmail(email);
        updateUser.setPassword(password);
        updateUser.setSellerStatus(sellerStatus);


        UserService dao = new UserOperations();
        String updateStatus = dao.updateUserDetails(userId, updateUser);

        if ("ok".equals(updateStatus)) {
            response.sendRedirect("profile.jsp");
        } else {
            response.setContentType("text/html");
            try (PrintWriter out = response.getWriter()) {
                out.println("<script type='text/javascript'>");
                out.println("alert('Bir hata meydana geldi.');");
                out.println("</script>");
            }
        }
    }



    private void handleSellerUpdate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
