package com.example.one;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;

import com.example.one.beans.CustomerBean;
import com.example.one.beans.ProductBean;
import com.example.one.beans.SellerBean;
import com.example.one.beans.UserBean;
import com.example.one.service.CustomerService;
import com.example.one.service.ProductService;
import com.example.one.service.SellerService;
import com.example.one.service.UserService;
import com.example.one.service.operations.CustomerOperations;
import com.example.one.service.operations.ProductOperations;
import com.example.one.service.operations.SellerOperations;
import com.example.one.service.operations.UserOperations;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import javax.swing.plaf.IconUIResource;

@WebServlet(name = "sellerPopupServlet", urlPatterns = {"/addToProductServlet","/addToCustomerServlet"})
@MultipartConfig(maxFileSize = 16177215)
public class AddProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        if (action.equals("/addToProductServlet")){
            handleAddToProductServlet(request, response);
        } else if (action.equals("/addToCustomerServlet")) {
            handleAddToCustomerServlet(request, response);
        }
    }
    private void handleAddToCustomerServlet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("customer-email");
        UserBean user = null ;

        UserService userService = new UserOperations();
        user = userService.getUserDetails(email);

        if (user != null){
            CustomerService customerService = new CustomerOperations();
            CustomerBean customerBean = new CustomerBean();

            HttpSession session = request.getSession(false);
            String userEmail = (session != null) ? (String) session.getAttribute("userEmail") : null;

            SellerService sellerService = new SellerOperations() ;
            SellerBean mySeller = sellerService.getSellerDetails(userService.getUserDetails(userEmail).getId()); //satıcının bilgileriniden sellerId ye ulaştık

            customerBean.setSellerId(mySeller.getId());
            customerBean.setUserId(user.getId());

            String result = customerService.addCustomer(customerBean);

            if (result.equals("ok")){
                response.sendRedirect("store-management.jsp");
            }else {
                try (PrintWriter out = response.getWriter()) {
                    out.println("<html><body>");
                    out.println("<script type='text/javascript'>");
                    out.println("alert('Bir hata meydana geldi.');");
                    out.println("window.location.href = 'store-management.jsp';");
                    out.println("</script>");
                    out.println("</body></html>");
                } catch (IOException e) {
                    throw new RuntimeException(e);
                }
            }
        }else {
            try (PrintWriter out = response.getWriter()) {
                out.println("<html><body>");
                out.println("<script type='text/javascript'>");
                out.println("alert('Böyle Bir kullanıcı Yok Geçerli bir Eposta giriniz.');");
                out.println("window.location.href = 'store-management.jsp';");
                out.println("</script>");
                out.println("</body></html>");
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }

    }

    private void handleAddToProductServlet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String productName = request.getParameter("product-brand");
        String productDetail = request.getParameter("product-detail");
        String productCategory = request.getParameter("product-category");
        String productAmountStr = request.getParameter("product-amount");
        Part filePart = request.getPart("product-img");
        InputStream inputStream = null;
        BigDecimal productAmount = null;

        if (productAmountStr != null && !productAmountStr.isEmpty()) {
            try {
                productAmount = new BigDecimal(productAmountStr);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        if (filePart != null) {
            inputStream = filePart.getInputStream();
            System.out.println("evet yükledik");
        }
        System.out.println("YAzdırmayı deniyoruz.");
        System.out.println(inputStream + "KAAN");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        String userEmail = (String) session.getAttribute("userEmail");
        UserService daou = new UserOperations();
        UserBean userInfo = daou.getUserDetails(userEmail);
        SellerService daos = new SellerOperations();
        int sellerId = daos.getSellerDetails(userInfo.getId()).getId();


        ProductBean pb = new ProductBean();

        pb.setCategory(productCategory);
        pb.setName(productName);
        pb.setDescription(productDetail);
        pb.setPrice(productAmount);
        pb.setImage(inputStream);
        pb.setSellerId(sellerId);

        ProductService ps = new ProductOperations();
        String g = ps.addProduct(pb);

        if (g.equals("ok")){
            response.sendRedirect("store-management.jsp");
        } else {
            try (PrintWriter out = response.getWriter()) {
                out.println("<html><body>");
                out.println("<script type='text/javascript'>");
                out.println("alert('Bir hata meydana geldi.');");
                out.println("window.location.href = 'store-management.jsp';");
                out.println("</script>");
                out.println("</body></html>");
            }
        }
    }

}
