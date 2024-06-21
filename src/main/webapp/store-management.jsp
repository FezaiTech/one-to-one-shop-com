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
    <title>store-management</title>
    <link rel="stylesheet" href="css/header.css"/>
    <link rel="stylesheet" href="css/text.css"/>
    <link rel="stylesheet" href="css/style.css"/>
    <link rel="stylesheet" href="css/store_management/button.css"/>
    <link rel="stylesheet" href="css/store_management/bone.css"/>
    <link rel="stylesheet" href="css/store_management/media-query-sm.css"/>
    <link rel="stylesheet" href="css/store_management/search-bar.css"/>
    <link rel="stylesheet" href="css/store_management/text-sm.css"/>
    <link rel="stylesheet" href="css/store_management/customer-section.css">

</head>
<body>
<%
    String nane = "products";
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

<jsp:include page="header.jsp">
    <jsp:param name="headerType" value="profile" />
</jsp:include>

<section id="store-desk">
    <div class="title">
        <div class="custom-row">
            <div  class="title-container"></div>
            <div style="max-width: 300px" class="column">
                <p class="order-title">Mağaza Yönetimi</p>
                <p class="order-title"><%= mySeller != null ? mySeller.getStoreName() : "Mağaza ADİİ" %></p>
            </div>
        </div>
        <form id="store-desk-form" method="post">
            <input type="hidden" name="page" id="pageValue" value="<%="1"%>" />
            <div class="row-store-man-header">
                <button class=" store-man-header-button button-text-center" type="button" onclick="document.getElementById('pageValue').value='1'; this.form.submit();">Ürünlerim</button>
                <button class=" store-man-header-button button-text-center" type="button" onclick="document.getElementById('pageValue').value='2'; this.form.submit();">Siparişlerin</button>
                <button class=" store-man-header-button button-text-center" type="button" onclick="document.getElementById('pageValue').value='3'; this.form.submit();">Müşterilerin</button>
                <button class=" store-man-header-button button-text-center" type="button" onclick="document.getElementById('pageValue').value='4'; this.form.submit();">Yönetim</button>
            </div>
        </form>
    </div>
</section>

<div class="sizedBox"></div>
<%
    String currentPage = request.getParameter("page");
    if (currentPage == null) {
        currentPage = "1";
    }

    switch (currentPage) {
        case "1":
%><jsp:include page="products-list.jsp" /> <%
        break;
    case "2":
%><jsp:include page="orders-list.jsp" /> <%
        break;
    case "3":
%><jsp:include page="customers-list.jsp" /> <%
        break;
    case "4":
%><jsp:include page="footer.jsp" /> <%
        break;
    default:
%><jsp:include page="products-list.jsp" /> <%
            break;
    }
%>

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
<div style="height: 50px;" class="sizedBox"></div>
<jsp:include page="footer.jsp"></jsp:include>
<script src="js/store-management.js"></script>
</body>
<style>
    #store-desk-form{
        width: 60%;
    }
    @media screen and (max-width: 600px){
        #store-desk-form {
            width: 100%;
        }
    }
</style>
</html>