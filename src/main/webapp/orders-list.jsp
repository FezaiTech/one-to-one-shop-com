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

  List<OrderBean> storeOrdersList = null ;
  int activeOrder = 0;

  if (userEmail != null) {
    storeOrdersList = orderService.getAllOrdersForSeller(sellerId);

    int userId = userService.getUserDetails(userEmail).getId();
    mySeller = sellerService.getSellerDetails(userId);

    for (OrderBean orderBean : storeOrdersList) {
      activeOrder++;
    }
  }else {
    response.sendRedirect("login.jsp");
  }
%>

<section id="search-bar">
  <div style="gap: 10px;" class="column">
    <div class="row">
      <div style="color: black" id="sm-item-count" class="text-l">Aktif Sipariş Sayısı : <%= storeOrdersList != null ? activeOrder : 0 %></div>
    </div>
    <div class="search-container-sm hidden">
      <form action="/search" method="get">
        <input type="text" placeholder="Ürün, kategori veya marka arayın" name="query" class="search-box">
        <button type="submit" class="search-button"><b>Ara</b></button>
      </form>
    </div>
  </div>
</section>

<section id="sm-body-grid" class="sm-body-grid">
  <%
    if(storeOrdersList != null && !storeOrdersList.isEmpty()){
      for (OrderBean order : storeOrdersList) {
        ProductBean orderProduct = productService.getProductDetails(order.getProductId());
  %>
  <div class="sm-product-box">
    <div class="sm-product-box-padding">
      <div class="column" style="gap: 5px">
        <div class="title-grid">
          <p class="sm-title">Markası</p>
          <p class="sm-answer"><%=orderProduct.getName()%></p>
          <p class="sm-title">Adedi</p>
          <p class="sm-answer"><%=order.getQuantity()%></p>
          <p class="sm-title">Sipariş Tarihi</p>
          <p class="sm-answer"><%=order.getCreatedDate()%></p>
          <p class="sm-title">Fiyatı</p>
          <p class="sm-answer"><%=orderProduct.getPrice().multiply(new BigDecimal(order.getQuantity()))%></p>
        </div>
        <div class="row">
          <div class="column" style="align-self: start; gap: 10px">
            <p class="sm-title">Detayı</p>
            <p class="sm-answer"><%=orderProduct.getDescription()%></p>
            <p class="sm-title">Teslimat Adresi</p>
            <p class="sm-answer"><%=order.getDeliveryAddress()%></p>
          </div>
          <div class="image-box image-center">
            <img src="imageServlet?productId=<%=orderProduct.getId()%>" alt="<%=orderProduct.getName()%>" class="product-image" data-productid="<%= orderProduct.getId() %>">
          </div>
        </div>
        <div class="sizedBox"></div>
        <div class="row" style="justify-content: end;">
          <div class="sm-product-edit-btn sm-button-text">Kargo Verildi Olarak İşaretle</div>
          <div class="sm-product-delete-btn sm-button-text">Siparişi İptal Et</div>
        </div>
      </div>
    </div>
  </div>
  <%
    }
  }else{
  %>
  <div class="sizedBox"></div>
  <p>HENÜZ HİÇ BİR ÜRÜNÜNÜZ YOKTUR</p>
  <%
    }
  %>
</section>
