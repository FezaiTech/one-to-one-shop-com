package com.example.one;

import com.example.one.beans.ProductBean;
import com.example.one.service.OrderService;
import com.example.one.service.ProductService;
import com.example.one.service.operations.OrderOperations;
import com.example.one.service.operations.ProductOperations;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;

@WebServlet(name = "sellerProductServlet", urlPatterns = {"/seller-delivered-order","/seller-cancelled-order","/seller-marked-tracked","/seller-product-edit","/seller-product-delete"})
public class StoreManagemenServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        if ("/seller-product-edit".equals(action)) {
            handleEdit(request, response);
        } else if ("/seller-product-delete".equals(action)) {
            handleDelete(request, response);
        } else if (("/seller-cancelled-order").equals(action)) {
            handleSellerCanceled(request, response);
        } else if ("/seller-marked-tracked".equals(action)) {
            handleSellerMarkedtracker(request, response);
        } else if ("/seller-delivered-order".equals(action)) {
            handleSellerDelivered(request, response);
        }
    }

    private void handleSellerDelivered(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        OrderService orderService = new OrderOperations();
        String status = orderService.updateOrderStatus(orderId, "2");
        if (status.equals("ok")){
            response.sendRedirect("store-management.jsp");
        }else {
            response.setContentType("text/html");
            try (PrintWriter out = response.getWriter()) {
                out.println("<script type='text/javascript'>");
                out.println("alert(\"" + status + "\");");
                out.println("Bir hata meydana geldi");
                out.println("</script>");
            }
        }

    }

    private  void handleSellerCanceled(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        OrderService orderService = new OrderOperations();
        String status = orderService.updateOrderStatus(orderId, "4");
        if (status.equals("ok")){
            response.sendRedirect("store-management.jsp");
        }else {
            response.setContentType("text/html");
            try (PrintWriter out = response.getWriter()) {
                out.println("<script type='text/javascript'>");
                out.println("alert(\"" + status + "\");");
                out.println("Bir hata meydana geldi");
                out.println("</script>");
            }
        }
    }

    private void handleSellerMarkedtracker(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        OrderService orderService = new OrderOperations();
        String status = orderService.updateOrderStatus(orderId, "1");
        if (status.equals("ok")){
            response.sendRedirect("store-management.jsp");
        }else {
            response.setContentType("text/html");
            try (PrintWriter out = response.getWriter()) {
                out.println("<script type='text/javascript'>");
                out.println("alert(\"" + status + "\");");
                out.println("Bir hata meydana geldi");
                out.println("</script>");
            }
        }
    }
    private void handleEdit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));

        String name = request.getParameter("name-form");
        String category = request.getParameter("category-form");
        String date = request.getParameter("date-form");
        String price = request.getParameter("price-form");
        String detail = request.getParameter("detail-form");

        ProductService productService = new ProductOperations();
        ProductBean oldProduct = productService.getProductDetails(productId);

        ProductBean newProduct = new ProductBean();
        newProduct.setId(productId);
        newProduct.setName(name);
        newProduct.setCategory(category);
        newProduct.setAddedDate(oldProduct.getAddedDate());
        newProduct.setPrice(new BigDecimal(price));
        newProduct.setDescription(detail);
        newProduct.setImage(oldProduct.getImage());
        newProduct.setSellerId(oldProduct.getSellerId());

        String result = productService.updateProduct(productId, newProduct);

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

    private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        ProductService productService = new ProductOperations();

        String result = productService.removeProduct(productId);
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
