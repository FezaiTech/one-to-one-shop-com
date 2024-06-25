package com.example.one;

import com.example.one.beans.SellerBean;
import com.example.one.beans.UserBean;
import com.example.one.service.SellerService;
import com.example.one.service.UserService;
import com.example.one.service.operations.SellerOperations;
import com.example.one.service.operations.UserOperations;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "updateUserServlet", value = {"/update-user-servlet","/new-seller-servlet","/update-seller-servlet"})
public class UpdateUserAndSellerServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        if ("/update-user-servlet".equals(action)) {
            handleUserUpdate(request, response);
        } else if ("/new-seller-servlet".equals(action)) {
            handleNewSellerUpdate(request, response);
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



    private void handleNewSellerUpdate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userId = Integer.parseInt(request.getParameter("sellerUserId"));

        String storeName = request.getParameter("seller-name");
        String storeNo = request.getParameter("seller-no");

        SellerBean newSeller = new SellerBean();
        newSeller.setUserId(userId);
        newSeller.setStoreName(storeName);
        newSeller.setStoreNumber(storeNo);

        SellerService daos = new SellerOperations();
        String updateStatusSeller = daos.addSeller(newSeller);

        UserService dao = new UserOperations();
        String updateStatusUser = dao.updateUserForSeller(userId, true);

        if ("ok".equals(updateStatusUser) && "ok".equals(updateStatusSeller)) {
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

        int sellerId = Integer.parseInt(request.getParameter("userId"));
        String storeName = request.getParameter("seller-name");
        String storeNo = request.getParameter("seller-no");

        SellerBean updateSeller = new SellerBean();
        updateSeller.setStoreName(storeName);
        updateSeller.setStoreNumber(storeNo);

        SellerService dao = new SellerOperations();
        String updateSellerStatus = dao.updateSeller(sellerId,updateSeller);

        if ("ok".equals(updateSellerStatus)) {
            response.setContentType("text/html");
            try (PrintWriter out = response.getWriter()) {
                out.println("<script type='text/javascript'>");
                out.println("alert('Bilgiler kaydedildi');");
                out.println("window.location.href = document.referrer;"); // Aynı sayfaya yönlendirme
                out.println("</script>");
            }
        } else {
            response.setContentType("text/html");
            try (PrintWriter out = response.getWriter()) {
                out.println("<script type='text/javascript'>");
                out.println("alert('Bir hata meydana geldi.');");
                out.println("window.location.href = document.referrer;"); // Aynı sayfaya yönlendirme
                out.println("</script>");
            }
        }
    }

}