<%@ page import="com.example.one.service.ProductService" %>
<%@ page import="com.example.one.service.operations.ProductOperations" %>
<%@ page import="com.example.one.service.SellerService" %>
<%@ page import="com.example.one.service.operations.UserOperations" %>
<%@ page import="com.example.one.service.operations.SellerOperations" %>
<%@ page import="com.example.one.service.UserService" %>
<%@ page import="com.example.one.beans.UserBean" %>
<%@ page import="com.example.one.beans.SellerBean" %>
<%@ page import="com.example.one.beans.ProductBean" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
    <%
        if(storeProducts != null && !storeProducts.isEmpty()){
            for (ProductBean product : storeProducts) {
    %>
    <div class="sm-product-box">
        <div class="sm-product-box-padding">
            <div style="gap: 5px" class="column">
                <div class="title-grid">
                    <p class="sm-title">Markası</p>
                    <p class="sm-answer"><%=product.getName()%></p>
                    <p class="sm-title">Kategori</p>
                    <p class="sm-answer"><%=product.getCategory()%></p>
                    <p class="sm-title">Eklenme Tarihi</p>
                    <p class="sm-answer"><%=product.getAddedDate()%></p>
                    <p class="sm-title">Fiyatı</p>
                    <p class="sm-answer"><%=product.getPrice()%></p>
                </div>
                <div class="row">
                    <div style="align-self: start; gap: 10px" class="column">
                        <p class="sm-title">Detayı</p>
                        <p class="sm-answer"><%=product.getDescription()%></p>
                    </div>
                    <div class="image-box image-center">
                        <img src="imageServlet?productId=<%=product.getId()%>" alt="<%=product.getName()%>" class="product-image" data-productid="<%= product.getId() %>">
                    </div>
                </div>
                <div class="sizedBox"></div>
                <div style="justify-content: end;" class="row">
                    <form id="productEditForm" class="form-temp-seller-button" method="post" action="seller-product-edit">
                        <input type="hidden" name="productId" value="<%=product.getId()%>">
                        <button type="submit" class="sm-product-edit-btn sm-button-text">Düzenle</button>
                    </form>
                    <form id="productCancellationForm" class="form-temp-seller-button" method="post" action="seller-product-delete">
                    <input type="hidden" name="productId" value="<%=product.getId()%>">
                    <button type="submit" class="sm-product-delete-btn sm-button-text" onclick="return confirmOrderAction(event)">Sil</button>
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
    <p>HENÜZ HİÇ BİR ÜRÜNÜNÜZ YOKTUR</p>
    <%
        }
    %>
</section>