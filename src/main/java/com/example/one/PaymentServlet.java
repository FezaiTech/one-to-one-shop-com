package com.example.one;

import com.example.one.beans.*;
import com.example.one.service.CustomerService;
import com.example.one.service.OrderService;
import com.example.one.service.ProductService;
import com.example.one.service.UserService;
import com.example.one.service.operations.CustomerOperations;
import com.example.one.service.operations.OrderOperations;
import com.example.one.service.operations.ProductOperations;
import com.example.one.service.operations.UserOperations;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "paymentServlet", urlPatterns = {"/payment-servlet"})
public class PaymentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleAddOrder(request, response);
    }

    private void handleAddOrder(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userEmail = (String) session.getAttribute("userEmail");
        UserService daou = new UserOperations();
        UserBean userInfo = daou.getUserDetails(userEmail);

        String paymentMethod = "Kredi/Banka Kartı";
        if(request.getParameter("card") != null){
            paymentMethod = request.getParameter("card");
        } else if (request.getParameter("door") != null) {
            paymentMethod = request.getParameter("door");
        } else if (request.getParameter("eft") != null) {
            paymentMethod = request.getParameter("eft");
        }

        String address = "Türkiye";
        if(request.getParameter("address") != null){
            address = request.getParameter("address");
        } else if (request.getParameter("address-door") != null) {
            address = request.getParameter("address-door");
        } else if (request.getParameter("address-eft") != null) {
            address = request.getParameter("address-eft");
        }

        OrderService dao = new OrderOperations();
        int lastOrderNumber = dao.getLastOrderNumber();
        int newOrderNumber = lastOrderNumber + 1;

        Map<CartBean, ProductBean> productMap = new HashMap<>();
        List<CartBean> cartItems = (List<CartBean>) session.getAttribute("cartItems");
        ProductService daop = new ProductOperations();

        if (cartItems != null) {
            for (CartBean cartItem : cartItems) {
                int productId = cartItem.getProductId();
                if (!productMap.containsKey(productId)) {
                    ProductBean product = daop.getProductDetails(productId);
                    productMap.put(cartItem, product);
                }
            }
        }

        String addOrderStatus = "fail";
        if (productMap.size() > 0) {
            for (Map.Entry<CartBean, ProductBean> entry : productMap.entrySet()) {
                CartBean cart = entry.getKey();
                ProductBean product = entry.getValue();
                int quantity = cart.getCount();

                OrderBean newOrder = new OrderBean();
                newOrder.setUserId(userInfo.getId());
                newOrder.setOrderNumber(String.valueOf(newOrderNumber));
                newOrder.setProductId(product.getId());
                newOrder.setQuantity(quantity);
                newOrder.setPaymentMethod(paymentMethod);
                newOrder.setStatus("0");
                newOrder.setDeliveryAddress(address);

                addOrderStatus = dao.addOrder(newOrder);

                CustomerService daos = new CustomerOperations();
                if(!daos.checkCustomer(product.getSellerId(),userInfo.getId())){
                    CustomerBean newCustomer = new CustomerBean();
                    newCustomer.setSellerId(product.getSellerId());
                    newCustomer.setUserId(userInfo.getId());
                    daos.addCustomer(newCustomer);
                }
            }
        }

        if ("ok".equals(addOrderStatus)) {
            session.removeAttribute("cartItems");
            response.sendRedirect("orders.jsp");
        } else {
            response.setContentType("text/html");
            try (PrintWriter out = response.getWriter()) {
                out.println("<html><body>");
                out.println("<script type='text/javascript'>");
                out.println("alert('Bir hata meydana geldi.');");
                out.println("window.location.href = 'cart.jsp';");  // Hata mesajından sonra sepet sayfasına yönlendir
                out.println("</script>");
                out.println("</body></html>");
            }
        }
    }
}
