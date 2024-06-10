<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.one.beans.ProductBean" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.one.service.ProductService" %>
<%@ page import="com.example.one.service.operations.ProductOperations" %>
<%@ page import="com.example.one.service.CartService" %>
<%@ page import="com.example.one.service.operations.CartOperations" %>
<%@ page import="com.example.one.beans.CartBean" %>
<!DOCTYPE html>
<html lang="tr">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>One To One Shop</title>
  <link rel="stylesheet" href="css/style.css?v=1"/>
  <link rel="stylesheet" href="css/text.css?v=1"/>
  <link rel="stylesheet" href="css/header.css?v=1"/>
  <link rel="stylesheet" href="css/home/fezaitechTrap.css?v=1">
  <link rel="stylesheet" href="css/home/button.css?v=1"/>
  <link rel="stylesheet" href="css/home/media-query.css?v=1"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>

<body>

<jsp:include page="header.jsp">
  <jsp:param name="headerType" value="full" />
</jsp:include>

<section id="slider-bar">
  <div class="posters">
    <div class="poster-index">
      <div class="index" data-index="0">1</div>
      <div class="index" data-index="1">2</div>
      <div class="index" data-index="2">3</div>
      <div class="index" data-index="3">4</div>
      <div class="index" data-index="4">5</div>
    </div>
    <div class="poster">
      <img src="assets/const/poster-electronic.png" alt="Poster 1" class="poster-img">
      <img src="assets/const/poster-laptop.png" alt="Poster 2" class="poster-img">
      <img src="assets/const/poster-fashion.png" alt="Poster 3" class="poster-img">
      <img src="assets/const/poster-chance.png" alt="Poster 4" class="poster-img">
      <img src="assets/const/poster-get.png" alt="Poster 5" class="poster-img">
    </div>
  </div>

  <div class="banner-column">
    <img class="banner" src="assets/const/banner-1.png" alt="">
    <img class="banner" src="assets/const/banner-2.png" alt="">
    <img class="banner" src="assets/const/banner-3.png" alt="">
  </div>
</section>

<section id="tech">
  <div class="title-row">
    <div class="title-column">
      <div class="category-title">Elektronik</div>
      <div class="category-subtitle">Kategorinin öne çıkan ürünleri</div>
    </div>
    <div class="push-button">
      <div class="category-subtitle">Tümü</div>
      <div class="push-icon">
        <img src="assets/icons/push.png" class="mini-icon">
      </div>
    </div>
  </div>

  <%
    ProductService dao = new ProductOperations();
    List<ProductBean> products = dao.getAllProductsByCategory("Elektronik");

    CartService cao = new CartOperations();
    List<CartBean> cart = null;
  %>

  <div class="product-containers" id="productContainer">
    <%
      for (ProductBean product : products) {
    %>
    <div class="product">
      <h2><%= product.getName() %></h2>
      <p class="br-x-small"><%= product.getDescription() %></p>
      <div class="image-center">
        <img src="<%= product.getImage() %>" alt="" class="product-image" data-productid="<%= product.getId() %>">
      </div>
      <div class="product-row">
        <p class="product-price"><%= product.getPrice() %> ₺</p>
        <div class="add-cart-button">
          <img src="assets/icons/add.png" class="cart-icon">
        </div>
      </div>
    </div>
    <%
      }
    %>
  </div>
</section>

<script src="js/home.js"></script>
<script>

  document.addEventListener('DOMContentLoaded', function () {
    var addButtons = document.querySelectorAll('.add-cart-button');

    addButtons.forEach(function (button) {
      button.addEventListener('click', function (event) {
        var productContainer = event.target.closest('.product');
        var productId = productContainer.querySelector('.product-image').getAttribute('data-productid');

        addToCart(productId, 1); // 1 ürün eklemek için
      });
    });
  });


  function addToCart(productId, count) {
    var xhr = new XMLHttpRequest();
    xhr.open('POST', 'addToCartServlet', true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.onreadystatechange = function () {
      if (xhr.readyState === XMLHttpRequest.DONE) {
        if (xhr.status === 200) {
          location.reload();
        } else {
          alert('Ürün sepete eklenirken bir hata oluştu.');
        }
      }
    };
    xhr.send('productId=' + productId + '&count=' + count);
  }

</script>
</body>
</html>
