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

    List<ProductBean> storeProducts = null;

    if (userEmail != null) {
        storeProducts = productService.getAllProductsBySellerid(sellerId);
        int userId = userService.getUserDetails(userEmail).getId();
        mySeller = sellerService.getSellerDetails(userId);
    }
%>
<section id="search-bar">
    <div style="gap: 10px;" class="column">
        <div class="row">
            <div style="color: black" id="sm-item-count" class="text-l">Ürün Sayısı : <%= storeProducts != null ? storeProducts.size() : 0 %></div>
            <div class="search-container-sm unhidden">
                <input type="text" id="search-box" placeholder="Ürün, kategori veya marka arayın" class="search-box" onkeyup="filterProducts()">
            </div>
            <button id="add-product-btn" class="add-new-product-btn">+ Yeni Ürün Ekle</button>
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
                <form id="productForm-<%=product.getId()%>" method="post" action="seller-product-edit">
                    <div class="title-grid">
                        <input type="hidden" name="productId" value="<%=product.getId()%>">
                        <p class="sm-title">Markası</p>
                        <input id="name-form" class="linedit-sm sm-answer" type="text" name="name-form" value="<%=product.getName()%>" readonly>
                        <p class="sm-title">Kategori</p>
                        <input id="category-form" class="linedit-sm sm-answer" type="text" name="category-form" value="<%=product.getCategory()%>" readonly>
                        <p class="sm-title">Eklenme Tarihi</p>
                        <input id="date-form" class="linedit-sm sm-answer" type="text" name="date-form" value="<%=product.getAddedDate()%>" readonly>
                        <p class="sm-title">Fiyatı</p>
                        <input id="price-form" class="linedit-sm sm-answer" type="number" name="price-form" value="<%=product.getPrice()%>" readonly>
                    </div>
                    <div class="sizedBox"></div>
                    <div class="row">
                        <div style="align-self: start; gap: 10px" class="column">
                            <p class="sm-title">Detayı</p>
                            <textarea id="detail-form" class="sm-answer linedit-sm"  style="border:none;resize:none;width: 80%;height: 100px;" name="detail-form" readonly><%=product.getDescription()%></textarea>
                        </div>
                        <div class="image-box image-center">
                            <img src="imageServlet?productId=<%=product.getId()%>" alt="<%=product.getName()%>" class="product-image" data-productid="<%= product.getId() %>">
                        </div>
                    </div>
                    <div class="sizedBox"></div>
                    <div style="justify-content: end;" class="row">
                        <button type="button" class="sm-product-edit-btn sm-button-text" onclick="enableEdit('<%=product.getId()%>')">Düzenle</button>
                        <button type="submit" class="sm-product-save-btn sm-button-text" style="display:none;">Kaydet</button>
                        <button type="button" class="sm-product-delete-btn sm-button-text" onclick="confirmOrderAction(<%=product.getId()%>)">Sil</button>
                    </div>
                </form>

            </div>
        </div>
    </div>
    <%
        }
    }else{
    %>
    <div class="sizedBox"></div>
    <p class="warning-text">Henüz hiç bir ürününüz yok. Ürün eklemeyi deneyin.</p>
    <%
        }
    %>
</section>
