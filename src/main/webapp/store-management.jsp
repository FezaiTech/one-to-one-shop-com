<%@ page import="com.example.one.service.ProductService" %>
<%@ page import="com.example.one.service.operations.ProductOperations" %>
<%@ page import="com.example.one.service.UserService" %>
<%@ page import="com.example.one.service.operations.UserOperations" %>
<%@ page import="com.example.one.beans.ProductBean" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.one.service.SellerService" %>
<%@ page import="com.example.one.service.operations.SellerOperations" %>
<%@ page import="com.example.one.beans.SellerBean" %>
<%@ page import="com.example.one.beans.UserBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>sotore-management</title>
    <link rel="stylesheet" href="css/text.css"/>
    <link rel="stylesheet" href="css/style.css"/>
    <link rel="stylesheet" href="css/store_management/button.css"/>
    <link rel="stylesheet" href="css/store_management/bone.css"/>
    <link rel="stylesheet" href="css/store_management/media-query-sm.css"/>
    <link rel="stylesheet" href="css/store_management/search-bar.css"/>
    <link rel="stylesheet" href="css/store_management/text-sm.css"/>

</head>
<body>
<%
    ProductService productService = new ProductOperations();
    SellerService sellerService = new SellerOperations();
    UserService userService = new UserOperations();

    String userEmail = (session != null) ? (String) session.getAttribute("userEmail") : null;
    UserBean userInfo = userService.getUserDetails(userEmail);

    SellerBean mySeller = sellerService.getSellerDetails(userInfo.getId()); //Seller
    int sellerId = mySeller.getId();


    List<ProductBean> storeProducts = null ;

    int activeProducts = 0;
    if (userEmail != null) {
        storeProducts = productService.getAllProductsBySellerid(sellerId);
        int userId = userService.getUserDetails(userEmail).getId();
        mySeller = sellerService.getSellerDetails(userId);

        for (ProductBean products : storeProducts) {
            activeProducts++;
        }
    }
%>
<section id="header-sm">
    <div class="header-row-sm">
        <a href="/home.jsp"><img src="assets/brand/onetone.png" alt="AppIcon" class="app-icon"></a>
        <div class="spacer"></div>
        <div class="text-buttons">
            <div class="header-button profile-button">
                <img src="assets/icons/profile.png" alt="AppIcon" class="icon">
                <p class="button-text my-profile-text">Profilim</p>
                <div class="dropdown-content dropdown-profile">
                    <a href="">Hesap Bilgileri</a>
                    <a href="">Çıkış Yap</a>
                </div>
            </div>
        </div>
    </div>
</section>

<section id="store-desk">
    <div class="title">
        <div class="custom-row">
            <div  class="title-container"></div>
            <div style="max-width: 300px" class="column">
                <p class="order-title">Mağaza Yönetimi</p>
                <p class="order-title"><%= mySeller != null ? mySeller.getStoreName() : "Mağaza ADİİ" %></p>
            </div>
        </div>
        <div class="row-store-man-header" >
            <div class="store-man-header-button"><div class="button-text-center">Ürünlerim</div></div>
            <div class="store-man-header-button"><div class="button-text-center">Siparişlerin</div></div>
            <div class="store-man-header-button"><div class="button-text-center">Müşterilerin</div></div>
            <div class="store-man-header-button"><div class="button-text-center">Yönetim</div></div>
        </div>
    </div>
</section>
<div class="sizedBox"></div>
<section id="search-bar">
    <div style="gap: 10px;" class="column">
        <div class="row">
            <div style="color: black" id="sm-item-count" class="text-l">Ürün Sayısı : <%= storeProducts != null ? activeProducts : 0 %></div>
            <div class="search-container-sm unhidden">
                <form action="/search" method="get">
                    <input type="text" placeholder="Ürün, kategori veya marka arayın" name="query" class="search-box">
                    <button type="button" class="search-button"><b>Ara</b></button>
                </form>
            </div>
            <button id="add-product-btn" class="add-new-product-btn">+ Yeni Ürün Ekle</button>
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
    <c:forEach var="product" items="${storeProducts}">
        <div class="sm-product-box">
            <div class="sm-product-box-padding">
                <div style="gap: 5px" class="column">
                    <div class="title-grid">
                        <p class="sm-title">Markası</p>
                        <p class="sm-answer">${product.name}</p>
                        <p class="sm-title">Kategori</p>
                        <p class="sm-answer">${product.category}</p>
                        <p class="sm-title">Eklenme Tarihi</p>
                        <p class="sm-answer">${product.addedDate}</p>
                        <p class="sm-title">Fiyatı</p>
                        <p class="sm-answer">${product.price}</p>
                    </div>
                    <div class="row">
                        <div style="align-self: start; gap: 10px" class="column">
                            <p class="sm-title">Detayı</p>
                            <p class="sm-answer">${product.description}</p>
                        </div>
                        <div class="image-box image-center">
                            <img src="assets/monitor.png" alt="product/info" >
                        </div>
                    </div>
                    <div class="sizedBox"></div>
                    <div style="justify-content: end;" class="row">
                        <div class="sm-product-edit-btn sm-button-text">Düzenle</div>
                        <div class="sm-product-delete-btn sm-button-text">Sil</div>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>

</section>
<div id="product-add-popup-box" class="popup">
    <div class="popup-content column">
        <span class="close">&times;</span>
        <form style="gap: 20px" class="column" id="add-product-form" name="add-product-form" method="post" action="addToProductServlet" enctype="multipart/form-data" >
            <p style="text-align: center;;color: var(--green-color-1);font-weight: 800;" class="title-m">Mağazana Yeni Ürün Ekle</p>
            <input id="product-brand" name="product-brand" type="text" placeholder="Marka" required>
            <input id="prdoduct-category" name="product-category" type="text" placeholder="Kategori" required>
            <input id="product-detail" name="product-detail" type="text" placeholder="Detay" required>
            <input id="product-amount" name="product-amount" type="text" placeholder="Fiyat" required>
            <input id="product-img" name="product-img" type="file" accept="image/*" required>
            <button type="submit" style="width: 100%;color: #FFFFFF" class="add-new-product-btn text-l " id="add-product-btn-last">Ekle</button>
        </form>
    </div>
</div>
<script src="js/store-management.js"></script>
</body>
</html>