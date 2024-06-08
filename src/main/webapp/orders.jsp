<%@ page import="com.example.one.service.OrderService" %>
<%@ page import="com.example.one.service.operations.OrderOperations" %>
<%@ page import="com.example.one.service.UserService" %>
<%@ page import="com.example.one.service.operations.UserOperations" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.one.beans.OrderBean" %>
<%@ page import="java.util.Objects" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Siparişlerim</title>
    <link rel="stylesheet" href="css/style.css"/>
    <link rel="stylesheet" href="css/text.css"/>
    <link rel="stylesheet" href="css/orders.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>

<%
    OrderService orderService = new OrderOperations();
    UserService userService = new UserOperations();
    String userEmail = (session != null) ? (String) session.getAttribute("userEmail") : null;

    List<OrderBean> orders = null;
    if (userEmail != null) {
        int userId = userService.getUserDetails(userEmail).getId();
        orders = orderService.getAllOrdersForUser(userId);
    }
    int activeOrders = 0;
    for (OrderBean order : orders) {
        if (!Objects.equals(order.getStatus(), "2")) {
            activeOrders++;
        }
    }

%>

<section id="header">
    <a href="home.jsp"><img src="assets/brand/onetone.png" alt="AppIcon" class="app-icon"></a>
    <div class="profile-button">
        <img src="assets/icons/profile.png" alt="AppIcon" class="icon">
        <p class="button-text">Profilim</p>
    </div>
</section>

<section id="orders">
    <div class="title">
        <div class="custom-row">
            <div class="title-container"></div>
            <p class="order-title">Siparişleriniz</p>
        </div>
        <p class="order-count">Aktif <span id="activeOrderCount"><%= orders != null ? activeOrders : 0 %></span> siparişiniz bulunmaktadır</p>
    </div>
    <div id="orderList">
        <%
            if (orders != null) {
                for (OrderBean order : orders) {
        %>
        <div class="order-item">
            <div class="order-info">
                <div class="order-date">
                    <p class="order-info-title">Sipariş<br class="br-x-small">Tarihi</p>
                    <p class="order-info-date"><%= order.getCreatedDate() %></p>
                </div>
                <div class="order-line"></div>
                <div class="order-details">
                    <div class="text-column">
                        <p class="order-info-title">Ürün ID: <%= order.getProductId() %></p>
                        <p>Satıcı: <%= order.getOrderNumber() %></p>
                        <p>Adet: <%= order.getQuantity() %></p>
                    </div>
                    <div class="order-image">
                        <!-- Ürün resmi buraya gelecek -->
                    </div>
                </div>
            </div>
            <div class="spacer"></div>
            <div class="order-operation" style="background-color: <%= order.getStatus().equals("0") ? "var(--orange-color-1)" : order.getStatus().equals("1") ? "var(--blue-color-1)" : "var(--green-color-1)" %>;">
                <div class="order-state">
                    <p class="order-operation-text">Sipariş<br class="br-x-small">Durumu</p>
                    <p class="order-operation-text text-align-end"><%= order.getStatus().equals("0") ? "Hazırlanıyor" : order.getStatus().equals("1") ? "Kargoya Verildi" : "Teslim Edildi" %></p>
                </div>
                <div class="order-amount">
                    <p class="order-operation-text">Ödendi</p>
                    <p class="order-amount-text text-align-end"><%= order.getQuantity() %> TL</p>
                </div>
                <div class="order-button">
                    <p class="order-button-text" style="color: <%= order.getStatus().equals("0") ? "var(--orange-color-1)" : order.getStatus().equals("1") ? "var(--blue-color-1)" : "var(--green-color-1)" %>;">
                        <%= order.getStatus().equals("0") ? "Siparişi İptal Et" : order.getStatus().equals("1") ? "Kargo Takip" : "Değerlendir" %>
                    </p>
                </div>
            </div>
        </div>

        <%
                }
            }
        %>
    </div>
</section>
</body>
</html>
