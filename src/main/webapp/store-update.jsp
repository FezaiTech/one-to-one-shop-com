<%@ page import="com.example.one.service.UserService" %>
<%@ page import="com.example.one.service.operations.UserOperations" %>
<%@ page import="com.example.one.beans.UserBean" %>
<%@ page import="com.example.one.beans.SellerBean" %>
<%@ page import="com.example.one.service.SellerService" %>
<%@ page import="com.example.one.service.operations.SellerOperations" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <link rel="stylesheet" href="css/store_management/store-update.css?v=1"/>
</head>
<%
    String userEmail = (session != null) ? (String) session.getAttribute("userEmail") : null;
    UserService daou = new UserOperations();
    UserBean userInfo = daou.getUserDetails(userEmail);
    boolean isSeller = userInfo.getSellerStatus();
    SellerBean seller = null;
    if(isSeller){
        SellerService daos = new SellerOperations();
        seller = daos.getSellerDetails(userInfo.getId());
    }
%>

<% if(isSeller){

%>

<section id="profile-form">
    <div class="seller-profile">
        <p class="title-box">Mağazanız</p>
        <div class="form-box">
            <p class="form-title">Mağaza Bilgileriniz</p>
            <form class="seller-update-form" id="sellerUpdateForm" action="update-seller-servlet" method="post">
                <input type="hidden" id="userId" name="userId" value="<%= userInfo.getId() %>">
                <label for="seller-name"></label>
                <input type="text" id="seller-name" name="seller-name" value="<%=seller.getStoreName()%>" placeholder="Mağaza Adı" maxlength="48" required>
                <label for="seller-no"></label>
                <input type="number" id="seller-no" name="seller-no" value="<%=seller.getStoreNumber()%>" placeholder="Vergi Numarası" maxlength="10" required>
                <p class="info-text">Gerekli kontrol işlemlerinin ardından mağaza bilgileriniz güncellenecektir. Bu panelden kontrol edebilirsiniz.</p>
                <button type="submit" class="button">Bilgileri Kaydet</button>
            </form>
        </div>
        <form id="remve-seller" name="delete-seller" action="delete-seller-servlet" method="post">
            <input type="hidden" id="userId1" name="userId" value="<%= userInfo.getId() %>">
            <button><p class="delete-store">Mağazayı kapatmak istiyorum</p></button>
        </form>
    </div>
</section>
<%
}
%>


