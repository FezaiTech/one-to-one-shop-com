<%@ page import="java.util.Map" %>
<%@ page import="com.example.one.service.operations.ProductOperations" %>
<%@ page import="com.example.one.service.ProductService" %>
<%@ page import="com.example.one.beans.ProductBean" %>
<%@ page import="com.example.one.beans.CartBean" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Sepetim</title>
  <link rel="stylesheet" href="css/style.css" />
  <link rel="stylesheet" href="css/cart.css" />
  <link rel="stylesheet" href="css/text.css" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>

<%
  List<CartBean> cartItems = (List<CartBean>) session.getAttribute("cartItems");
  System.out.println(cartItems);
%>

<section id="header">
  <a href="home.jsp"><img href="home.html" src="assets/brand/onetone.png" alt="AppIcon" class="app-icon"></a>
  <div class="header-button cart-button">
    <img src="assets/icons/cart.png" alt="AppIcon" class="icon">
    <p class="button-text">Sepetim (0)</p>
  </div>
</section>

<section id="shopping-cart">

  <div class="cart-row-fixed">
    <div class="cart-row-fixed content-start mobile-column cart-title">
      <p>Sepetinde</p>
      <p><span  class="bold-font">2</span> ürün var</p>
    </div>
    <div class="cart-row-fixed content-end pointer cart-subtitle" >
      <img src="assets/icons/bin.png" alt="" class="icon">
      <p>Sepeti Temizle</p>
    </div>
  </div>

  <div class="cart-row-fixed list">
    <div class="items-column">
      <%
        if (cartItems != null && cartItems.size() > 0) {
          for (CartBean cartItem : cartItems) {
      %>
      <div class="item-container">
        <p class="text-small">
          <span class="font-bold text-medium"><%= cartItem.getProductIdId() %></span>
          <%= cartItem.getCount() %>
        </p>
      </div>
      <%
        }
      } else {
      %>
      <p>Sepetiniz boş.</p>
      <%
        }
      %>
    </div>

    <div class="end-row">
      <div class="total-cart-container">
        <div class="total-text-row">
          <p class="amount-text">Sepet <span class="font-bold">Toplamı</span></p>
        </div>
        <p class="amount-text">2 Ürün</p>
        <div class="total-text-row">
          <p>Toplam</p>
          <p class="amount-text">3.185 TL</p>
        </div>
        <div class="total-text-row">
          <p>KDV</p>
          <p class="amount-text">300 TL</p>
        </div>
        <div class="total-text-row font-bold">
          <p>Net<span class="br-x-small"></span>Toplam</p>
          <p class="text-large">3.485 TL</p>
        </div>

        <p class="to-pay-button">Alışverişi Tamamla</p>

      </div>
    </div>
  </div>
</section>
</body>
</html>