<%@ page import="java.util.Map" %>
<%@ page import="com.example.one.service.operations.ProductOperations" %>
<%@ page import="com.example.one.service.ProductService" %>
<%@ page import="com.example.one.beans.ProductBean" %>
<%@ page import="com.example.one.beans.CartBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.example.one.service.SellerService" %>
<%@ page import="com.example.one.service.operations.SellerOperations" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Sepetim</title>
  <link rel="stylesheet" href="css/style.css" />
  <link rel="stylesheet" href="css/header.css" />
  <link rel="stylesheet" href="css/cart.css" />
  <link rel="stylesheet" href="css/text.css" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>

<%

  String userEmail = (session != null) ? (String) session.getAttribute("userEmail") : null;

  Map<CartBean, ProductBean> productMap = new HashMap<>();
  List<CartBean> cartItems = (List<CartBean>) session.getAttribute("cartItems");
  ProductService dao = new ProductOperations();

  if (cartItems != null) {
    for (CartBean cartItem : cartItems) {
      int productId = cartItem.getProductId();
      if (!productMap.containsKey(productId)) {
        ProductBean product = dao.getProductDetails(productId);
        productMap.put(cartItem, product);
      }
    }
  }
  int cartSize = 0;
  if (cartItems != null && cartItems.size() >0){
    cartSize = cartItems.size();
  }

%>

<jsp:include page="header.jsp">
  <jsp:param name="headerType" value="cart" />
</jsp:include>

<section id="shopping-cart">

  <div class="cart-row-fixed">
    <div class="cart-row-fixed content-start mobile-column cart-title">
      <p>Sepetinde</p>
      <p><span  class="bold-font"><%=cartSize != 0 ? cartSize : ""%></span> <%=cartSize != 0 ? "ürün var": "ürün yok"%></p>
    </div>
    <div class="cart-row-fixed content-end pointer cart-subtitle" onclick="clearCart()">
      <img src="assets/icons/bin.png" alt="" class="icon">
      <p>Sepeti Temizle</p>
    </div>
  </div>

  <div class="cart-row-fixed list">
    <div class="items-column">
      <%

        BigDecimal totalAmount = BigDecimal.ZERO;
        if (productMap != null && productMap.size() > 0) {
          for (Map.Entry<CartBean, ProductBean> entry : productMap.entrySet()) {
            CartBean cart = entry.getKey();
            ProductBean product = entry.getValue();
            int quantity = cart.getCount();
            SellerService daos = new SellerOperations();
            String sellerName = daos.getSellerDetails(product.getSellerId()).getStoreName();

            BigDecimal totalPrice = product.getPrice().multiply(BigDecimal.valueOf(quantity));
            BigDecimal formattedTotalPrice = totalPrice.setScale(2, BigDecimal.ROUND_HALF_UP);
            totalAmount = totalAmount.add(formattedTotalPrice);
      %>
      <div class="item-container">
        <p class="text-small"> <span class="font-bold text-medium"><%=product.getName()%></span> <%= product.getDescription() %></p>

        <div class="cart-row-fixed content-between no-margin">
          <div class="text-column">
            <p><%= product.getPrice() %> TL</p>
            <p text-small>Satıcı: <span class="font-bold"><%=sellerName%></span></p>
            <p text-small>3 gün içinde kargoda</p>
          </div>
          <div class="item-image"><img src="assets/watch.png"></div>
        </div>

        <div class="cart-row-fixed content-between">
          <div class="count-button">
            <img src="assets/icons/decrease-black.png" alt="decrease" class="icon-button" onclick="updateCart(<%= cart.getProductId() %>, <%= quantity - 1 %>)">
            <p class="one-line"><%= quantity %> adet</p>
            <img src="assets/icons/add-black.png" alt="add" class="icon-button" onclick="updateCart(<%= cart.getProductId() %>, <%= quantity + 1 %>)">
          </div>
          <p class="font-bold text-large"><%=formattedTotalPrice%> TL</p>
        </div>
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
    <%
      BigDecimal percentage = new BigDecimal("0.18");
      BigDecimal percentageAmount = totalAmount.multiply(percentage).setScale(2, BigDecimal.ROUND_HALF_UP);
      BigDecimal amountAfterPercentage = totalAmount.subtract(percentageAmount).setScale(2, BigDecimal.ROUND_HALF_UP);%>
    <%
      if (productMap != null && productMap.size() > 0) {
     %>
    <div class="end-row">
      <div class="total-cart-container">
        <div class="total-text-row">
          <p class="amount-text">Sepet <span class="font-bold">Toplamı</span></p>
        </div>
        <p class="amount-text"><%=cartSize%> Ürün</p>
        <div class="total-text-row">
          <p>Toplam</p>
          <p class="amount-text"><%=amountAfterPercentage%> TL</p>
        </div>
        <div class="total-text-row">
          <p>KDV</p>
          <p class="amount-text"><%=percentageAmount%> TL</p>
        </div>
        <div class="total-text-row font-bold">
          <p>Net<span class="br-x-small"></span>Toplam</p>
          <p class="text-large"><%=totalAmount%> TL</p>
        </div>

        <p class="to-pay-button" onclick="redirectToPayment('<%=userEmail%>')">Alışverişi Tamamla</p>

      </div>
    </div>
    <%
      }
    %>

  </div>
</section>

<script>
  function updateCart(productId, newQuantity) {
    var xhr = new XMLHttpRequest();
    var url = 'updateCartServlet';
    var params = 'productId=' + encodeURIComponent(productId) + '&newQuantity=' + encodeURIComponent(newQuantity);

    xhr.open('POST', url, true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

    xhr.onreadystatechange = function () {
      if (xhr.readyState === XMLHttpRequest.DONE) {
        if (xhr.status === 200) {
          // Başarılı yanıt
          location.reload();
        } else {
          // Hata durumu
          alert('Sepet güncellenirken bir hata oluştu.');
        }
      }
    };

    xhr.send(params);
  }

  function clearCart() {
    var xhr = new XMLHttpRequest();
    xhr.open('POST', 'removeCartServlet', true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

    xhr.onreadystatechange = function () {
      if (xhr.readyState === XMLHttpRequest.DONE) {
        if (xhr.status === 200) {
          // Başarılı yanıt
          location.reload();
        } else {
          // Hata durumu
          alert('Sepet temizlenirken bir hata oluştu.');
        }
      }
    };

    xhr.send();
  }

  function redirectToPayment(email) {
    if (email !== 'null' && email !== '') {
      window.location.href = 'payment.jsp';
    } else {
      if (confirm("Giriş yapmanız gerekmektedir. Giriş yapmak istiyor musunuz?")) {
        window.location.href = 'login.jsp';
      }
    }
  }

</script>
</body>
</html>