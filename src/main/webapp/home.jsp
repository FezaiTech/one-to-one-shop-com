<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="tr">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>One To One Shop</title>
  <link rel="stylesheet" href="css/style.css"/>
  <link rel="stylesheet" href="css/text.css"/>
  <link rel="stylesheet" href="css/orders.css"/>
  <link rel="stylesheet" href="css/home/fezaitechTrap.css"/>
  <link rel="stylesheet" href="css/home/button.css"/>
  <link rel="stylesheet" href="css/home/search.css"/>
  <link rel="stylesheet" href="css/home/media-query.css"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>

<body>
<section id="header">
  <div class="header-row">
    <img src="assets/brand/onetone.png" alt="AppIcon" class="app-icon">
    <div class="search-container main-s-bar ">
      <form action="/search" method="get">
        <input type="text" placeholder="Ürün, kategori veya marka arayın" name="query" class="search-box">
        <button type="submit" class="search-button"><b>Ara</b></button>
      </form>
    </div>
    <div class="text-buttons">
      <div class="header-button category-button dropdown">
        <p class="button-text text-color">Kategoriler</p>
        <div class="dropdown-content">
          <a href="#">Elektronik</a>
          <a href="#">Moda</a>
          <a href="#">Ev, Yaşam</a>
        </div>
      </div>
      <div class="header-button cart-button">
        <img src="assets/icons/cart.png" alt="AppIcon" class="icon">
        <p class="button-text">Sepetim (0)</p>
      </div>
      <div class="header-button profile-button">
        <img src="assets/icons/profile.png" alt="AppIcon" class="icon">
        <p class="button-text my-profile-text">Profilim</p>
      </div>
    </div>
  </div>
  <div class="search-container hidden-s-bar ">
    <form action="/search" method="get">
      <input type="text" placeholder="Ürün, kategori veya marka arayın" name="query" class="search-box">
      <button type="submit" class="search-button"><b>Ara</b></button>
    </form>
  </div>
</section>

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

  <div class="product-containers" id="productContainer"></div>
</section>

<script src="js/home.js"></script>
</body>
</html>
