<%@ page import="com.example.one.beans.ProductBean" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.one.service.ProductService" %>
<%@ page import="com.example.one.service.SellerService" %>
<%@ page import="com.example.one.service.UserService" %>
<%@ page import="com.example.one.service.operations.ProductOperations" %>
<%@ page import="com.example.one.service.operations.SellerOperations" %>
<%@ page import="com.example.one.service.operations.UserOperations" %>
<%@ page import="com.example.one.beans.SellerBean" %>
<%@ page import="com.example.one.beans.UserBean" %>
<%@ page import="com.example.one.service.OrderService" %>
<%@ page import="com.example.one.service.operations.OrderOperations" %>
<%@ page import="com.example.one.beans.OrderBean" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  OrderService orderService = new OrderOperations();
  SellerService sellerService = new SellerOperations();
  UserService userService = new UserOperations();
  ProductService productService = new ProductOperations();

  String userEmail = (session != null) ? (String) session.getAttribute("userEmail") : null;
  UserBean userInfo = userService.getUserDetails(userEmail);

  SellerBean mySeller = sellerService.getSellerDetails(((UserBean) userInfo).getId()); //Seller
  int sellerId = mySeller.getId();

  List<OrderBean> storeOrdersList ;
  List<OrderBean> finishOrdersList = new ArrayList<>();
  List<OrderBean> activeOrdersList = new ArrayList<>();
  int activeOrder = 0 ;
  int passiveOrder = 0 ;

  if (userEmail != null) {
    storeOrdersList = orderService.getAllOrdersForSeller(sellerId);
    for (OrderBean order : storeOrdersList){
      if (order.getStatus().equals("0") || order.getStatus().equals("1")){
        activeOrdersList.add(order);
        activeOrder++;
      }else {
        finishOrdersList.add(order);
        passiveOrder++;
      }
    }

    int userId = userService.getUserDetails(userEmail).getId();
    mySeller = sellerService.getSellerDetails(userId);

  }else {
    response.sendRedirect("login.jsp");
  }
%>

<section id="search-bar">
  <div style="gap: 10px;" class="column">
    <div class="row">
      <div style="color: black" id="sm-item-count1" class="text-l">Aktif Sipariş Sayısı : <%= activeOrder %></div>
    </div>
  </div>
</section>

<section id="sm-body-grid" class="sm-body-grid">
  <%
    if(activeOrdersList != null && !activeOrdersList.isEmpty()){
      for (OrderBean order : activeOrdersList) {
        ProductBean orderProduct = productService.getProductDetails(order.getProductId());
  %>
  <div class="sm-product-box">
    <div class="sm-product-box-padding">
      <div class="column" style="gap: 5px">
        <div class="title-grid">
          <p class="sm-title">Sipariş Numarası</p>
          <p class="sm-answer">#<%=order.getOrderNumber()%></p>
          <p class="sm-title">Markası</p>
          <p class="sm-answer"><%=orderProduct.getName()%></p>
          <p class="sm-title">Adedi</p>
          <p class="sm-answer"><%=order.getQuantity()%></p>
          <p class="sm-title">Sipariş Tarihi</p>
          <p class="sm-answer"><%=order.getCreatedDate()%></p>
          <p class="sm-title">Sipariş Durumu</p>
          <p class="sm-answer"><%=orderService.analyzingStatus(order.getStatus())%></p>
          <p class="sm-title">Fiyatı</p>
          <p class="sm-answer"><%=orderProduct.getPrice().multiply(new BigDecimal(order.getQuantity()))%></p>
          <p class="sm-title">Adress</p>
          <p class="sm-answer"><%=order.getDeliveryAddress()%></p>
        </div>
        <div class="row">
          <div class="column" style="align-self: start; gap: 10px">
            <p class="sm-title">Detayı</p>
            <p class="sm-answer"><%=orderProduct.getDescription()%></p>
          </div>
          <div class="image-box image-center">
            <img src="imageServlet?productId=<%=orderProduct.getId()%>" alt="<%=orderProduct.getName()%>" class="product-image" data-productid="<%= orderProduct.getId() %>">
          </div>
        </div>
        <div class="sizedBox"></div>
        <div class="row" style="justify-content: end;">
          <%
            if (order.getStatus().equals("1")){
          %>
            <form id="orderDeliveredForm" name="deliver_order" action="seller-delivered-order" method="POST">
              <input type="hidden" name="orderId" value="<%=order.getId()%>" >
              <button type="submit" class="sm-product-delivered-btn sm-button-text">Teslim Edildi Olarak İşaretle</button>
            </form>
          <%
            }else {
          %>
              <form id="orderMarkedTrackedForm" name="tracked-order" action="seller-marked-tracked" method="POST">
                <input type="hidden" name="orderId" value="<%=order.getId()%>" >
                <button type="submit" class="sm-product-edit-btn sm-button-text">Kargo Verildi Olarak İşaretle</button>
              </form>
          <%
            }
          %>
          <form id="orderDeleteForm" name="delete_order" action="seller-cancelled-order" method="POST">
            <input type="hidden" name="orderId" value="<%=order.getId()%>" >
            <button type="submit" class="sm-product-delete-btn sm-button-text">Siparişi İptal Et</button>
          </form>
        </div>
      </div>
    </div>
  </div>
  <%
    }
  }else{
  %>
  <div class="sizedBox"></div>
  <p class="warning-text">Henüz siparişiniz yok</p>
  <%
    }
  %>
</section>
<section id="search-bar">
  <div style="gap: 10px;" class="column">
    <div class="row">
      <div style="color: black" id="sm-item-count" class="text-l">Tamamlanmış Sipariş Sayısı : <%= finishOrdersList != null ? passiveOrder : 0 %></div>
    </div>
  </div>
</section>
<section id="sm-body-grid" class="sm-body-grid">
  <%
    if(finishOrdersList != null && !finishOrdersList.isEmpty()){
      for (OrderBean order : finishOrdersList) {
        ProductBean orderProduct = productService.getProductDetails(order.getProductId());
  %>
  <div class="sm-product-box">
    <div class="sm-product-box-padding">
      <div class="column" style="gap: 5px">
        <div class="title-grid">
          <p class="sm-title">Sipariş Numarası</p>
          <p class="sm-answer">#<%=order.getOrderNumber()%></p>
          <p class="sm-title">Markası</p>
          <p class="sm-answer"><%=orderProduct.getName()%></p>
          <p class="sm-title">Adedi</p>
          <p class="sm-answer"><%=order.getQuantity()%></p>
          <p class="sm-title">Sipariş Tarihi</p>
          <p class="sm-answer"><%=order.getCreatedDate()%></p>
          <p class="sm-title">Sipariş Durumu</p>
          <p class="sm-answer"><%=orderService.analyzingStatus(order.getStatus())%></p>
          <p class="sm-title">Fiyatı</p>
          <p class="sm-answer"><%=orderProduct.getPrice().multiply(new BigDecimal(order.getQuantity()))%></p>
          <p class="sm-title">Adress</p>
          <p class="sm-answer"><%=order.getDeliveryAddress()%></p>
        </div>
        <div class="row">
          <div class="column" style=" align-self: start; gap: 10px">
              <p class="sm-title">Detayı</p>
              <p class="sm-answer"><%=orderProduct.getDescription()%></p>
          </div>
          <div class="image-box image-center">
            <img src="imageServlet?productId=<%=orderProduct.getId()%>" alt="<%=orderProduct.getName()%>" class="product-image" data-productid="<%= orderProduct.getId() %>">
          </div>
        </div>
      </div>
    </div>
  </div>
  <%
    }
  }else{
  %>
  <div class="sizedBox"></div>
  <p class="warning-text">Henüz tamamlanmış siparişiniz yok</p>
  <%
    }
  %>
</section>
