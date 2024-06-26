<%@ page import="com.example.one.beans.CartBean" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<head>
  <link rel="stylesheet" href="css/header.css?v=1"/>
</head>

<%

  String userEmail = (session != null) ? (String) session.getAttribute("userEmail") : null;
  List<CartBean> cartItems = (List<CartBean>) session.getAttribute("cartItems");
  String headerType = request.getParameter("headerType") != null ? request.getParameter("headerType") : "full";
  String searchQuery = request.getParameter("searchQuery") != null ? request.getParameter("searchQuery") : "";
  /*headerType: full, profile, cart */
%>

<section id="header">
    <div class="header-row">
      <a href="home.jsp"><img src="assets/brand/onetone.png" alt="AppIcon" class="app-icon"></a>
      <%
        if(headerType.equals("full")){
      %>
      <div class="search-container main-s-bar ">
        <form action="search-servlet" method="get">
          <input type="text" placeholder="Ürün, kategori veya marka arayın" value="<%=searchQuery%>" name="query" class="search-box">
          <button type="submit" class="search-button"><b>Ara</b></button>
        </form>
      </div>
      <%
        }
      %>
      <div class="text-buttons">
        <%
          if(headerType.equals("full")){
        %>
        <div class="header-button category-button dropdown">
          <p class="button-text text-color">Kategoriler</p>
          <div class="dropdown-content">
            <a href="category-servlet?categoryName=Elektronik">Elektronik</a>
            <a href="category-servlet?categoryName=Moda">Moda</a>
            <a href="category-servlet?categoryName=Ev-Yaşam">Ev-Yaşam</a>
            <a href="category-servlet?categoryName=Kitap">Kitap</a>
            <a href="category-servlet?categoryName=Hobi-Oyuncak">Hobi-Oyuncak</a>
          </div>
        </div>
        <%
          }
          if(headerType.equals("full") || headerType.equals("cart")){
        %>
        <a href="cart.jsp" style="text-decoration: none">
          <div class="header-button cart-button">
            <img src="assets/icons/cart.png" alt="AppIcon" class="icon">
            <p class="button-text">Sepetim (<%=cartItems != null ? cartItems.size() : 0%>)</p>
          </div>
        </a>
        <%
          }
          if(headerType.equals("full") || headerType.equals("profile")){
            if(userEmail == null){
        %>
        <a href="login.jsp" style="text-decoration: none">
          <div class="header-button profile-button">
            <img src="assets/icons/profile.png" alt="AppIcon" class="icon">
            <p class="button-text my-profile-text">Giriş Yap</p>
          </div>
        </a>
        <%}else{%>
          <div class="header-button profile-button">
            <img src="assets/icons/profile.png" alt="AppIcon" class="icon">
            <p class="button-text my-profile-text">Profilim</p>
            <div class="dropdown-content dropdown-profile">
              <a href="profile.jsp">Hesap Bilgileri</a>
              <a href="orders.jsp">Siparişlerim</a>
              <a href="logout-servlet">Çıkış Yap</a>
            </div>
          </div>
        <%}}%>
      </div>
    </div>
      <%
        if(headerType.equals("full")){
      %>
    <div class="search-container hidden-s-bar ">
      <form action="search-servlet" method="get">
        <input type="text" placeholder="Ürün, kategori veya marka arayın" value="<%=searchQuery%>" name="query" class="search-box">
        <button type="submit" class="search-button"><b>Ara</b></button>
      </form>
    </div>
      <%
        }
      %>
</section>