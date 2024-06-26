<%@ page import="com.example.one.service.SellerService" %>
<%@ page import="com.example.one.service.operations.SellerOperations" %>
<%@ page import="com.example.one.service.UserService" %>
<%@ page import="com.example.one.service.operations.UserOperations" %>
<%@ page import="com.example.one.beans.UserBean" %>
<%@ page import="com.example.one.beans.SellerBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Mağaza Yönetimi</title>
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
    SellerService sellerService = new SellerOperations();
    UserService userService = new UserOperations();

    String userEmail = (session != null) ? (String) session.getAttribute("userEmail") : null;
    UserBean userInfo = userService.getUserDetails(userEmail);

    SellerBean mySeller = sellerService.getSellerDetails(userInfo.getId()); //Seller
    int sellerId = mySeller.getId();

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
                <p class="order-title"><%= mySeller != null ? mySeller.getStoreName() : "Mağaza Bulunamadı" %></p>
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
%><jsp:include page="store-products-list.jsp" /> <%
        break;
    case "2":
%><jsp:include page="store-orders-list.jsp" /> <%
        break;
    case "3":
%><jsp:include page="store-customers-list.jsp" /> <%
        break;
    case "4":
%><jsp:include page="store-update.jsp" /> <%
        break;
    default:
%><jsp:include page="store-products-list.jsp" /> <%
            break;
    }
%>

<jsp:include page="store-popup.jsp"></jsp:include>

<div style="height: 50px;" class="sizedBox"></div>
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