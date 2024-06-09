package com.example.one;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.sql.Connection;
import java.sql.SQLException;

import com.example.one.beans.ProductBean;
import com.example.one.beans.SellerBean;
import com.example.one.beans.UserBean;
import com.example.one.service.ProductService;
import com.example.one.service.SellerService;
import com.example.one.service.UserService;
import com.example.one.service.operations.ProductOperations;
import com.example.one.service.operations.SellerOperations;
import com.example.one.service.operations.UserOperations;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/addToProductServlett")
public class AddToProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productName = "afafas";
        String productCategory = "afas";
        String productDetail = "ada";
        BigDecimal productAmount = BigDecimal.valueOf(123);
        /*
        String productName = request.getParameter("product-brand");
        String productCategory = request.getParameter("product-category");
        String productDetail = request.getParameter("product-detail");
        BigDecimal productAmount = BigDecimal.valueOf(Long.parseLong(request.getParameter("product-amount")));
         */

        //Part filePart = request.getPart("file");
        //String fileName = String.valueOf(getFileName(filePart));
/*
        File uploads = new File("uploads"); // Kaydedilecek klasör
        if (!uploads.exists()) {
            uploads.mkdir();
        }
        File file = new File(uploads, fileName);
        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, file.toPath());
        }
 */
    /*
        HttpSession session = (HttpSession) request.getSession();
        String userEmail = (session != null) ? (String) session.getAttribute("userEmail") : null;
        UserService daou = new UserOperations();
        UserBean userInfo = daou.getUserDetails(userEmail);
        boolean isSeller = userInfo.getSellerStatus();
        SellerBean sellerr;

        if(isSeller){
            SellerService daos = new SellerOperations();
            sellerr = daos.getSellerDetails(userInfo.getId());
        }else {
            //demekki satıcı değil izinsiz giriş.
            return;
        }

     */

        ProductService productService = new ProductOperations();
        ProductBean newItem = new ProductBean();
        newItem.setSellerId(1);
        newItem.setName(productName);
        newItem.setDescription(productDetail);
        newItem.setCategory(productCategory);
        newItem.setPrice(productAmount);
        newItem.setImage(null);

        String g = productService.addProduct(newItem);

        if (g.equals("ok")){
            response.sendRedirect("home.jsp");
        }else{
            response.setContentType("text/html");
            try (PrintWriter out = response.getWriter()) {
                out.println(g);
                out.println("<p>SELAMM</p>");
            }
        }
    }
    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] items = contentDisposition.split(";");
        for (String item : items) {
            if (item.trim().startsWith("filename")) {
                return item.substring(item.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}
