package com.example.one;

import com.example.one.beans.ProductBean;
import com.example.one.beans.SellerBean;
import com.example.one.beans.UserBean;
import com.example.one.service.ProductService;
import com.example.one.service.SellerService;
import com.example.one.service.UserService;
import com.example.one.service.operations.ProductOperations;
import com.example.one.service.operations.SellerOperations;
import com.example.one.service.operations.UserOperations;
import jakarta.servlet.annotation.WebServlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.nio.file.Files;
import javax.servlet.http.Part;
import java.io.File;
import java.sql.Connection;
import jakarta.servlet.http.HttpSession;

@WebServlet("/addToProductServlett")
public class AddToProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productName = request.getParameter("product-brand");
        String productCategory = request.getParameter("product-category");
        String productDetail = request.getParameter("product-detail");
        BigDecimal productAmount = BigDecimal.valueOf(Long.parseLong(request.getParameter("product-category")));
        Part filePart = request.getPart("file");
        String fileName = String.valueOf(getFileName(filePart));

        File uploads = new File("uploads"); // Kaydedilecek klasör
        if (!uploads.exists()) {
            uploads.mkdir();
        }
        File file = new File(uploads, fileName);
        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, file.toPath());
        }

        HttpSession session = (HttpSession) request.getSession();
        String userEmail = (session != null) ? (String) session.getAttribute("userEmail") : null;

        UserService daou = new UserOperations();
        UserBean userInfo = daou.getUserDetails(userEmail);
        boolean isSeller = ((UserBean) userInfo).getSellerStatus();
        SellerBean seller = null;
        if(isSeller){
            SellerService daos = new SellerOperations();
            seller = daos.getSellerDetails(userInfo.getId());
        }else {
            //demekki satıcı değil izinsiz giriş.
            return;
        }
        ProductService productService = new ProductOperations();
        assert seller != null;
        ProductBean newItem = new ProductBean(seller.getId(),productName,productDetail,productCategory,productAmount,filePart.getInputStream());
        productService.addProduct(newItem);
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
