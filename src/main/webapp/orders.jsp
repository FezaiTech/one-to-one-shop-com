<%@ page import="com.example.one.service.OrderService" %>
<%@ page import="com.example.one.service.operations.OrderOperations" %>
<%@ page import="com.example.one.service.UserService" %>
<%@ page import="com.example.one.service.operations.UserOperations" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.one.beans.OrderBean" %>
<%@ page import="java.util.Objects" %>
<%@ page import="com.example.one.beans.ProductBean" %>
<%@ page import="com.example.one.service.ProductService" %>
<%@ page import="com.example.one.service.operations.ProductOperations" %>
<%@ page import="com.example.one.service.SellerService" %>
<%@ page import="com.example.one.service.operations.SellerOperations" %>
<%@ page import="com.example.one.beans.SellerBean" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Siparişlerim</title>
    <link rel="stylesheet" href="css/orders.css?v=1"/>
    <link rel="stylesheet" href="css/style.css?v=1"/>
    <link rel="stylesheet" href="css/text.css?v=1"/>
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
    if(userEmail != null){
        for (OrderBean order : orders) {
            if (!Objects.equals(order.getStatus(), "2")) {
                activeOrders++;
            }
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
                ProductService daop = new ProductOperations();
                SellerService daos = new SellerOperations();
                String currentOrderNumber = null;
                for (OrderBean order : orders) {
                    ProductBean orderToProduct = daop.getProductDetails(order.getProductId());
                    SellerBean orderToSeller = daos.getSellerDetails(orderToProduct.getSellerId());
                    BigDecimal totalPrice = orderToProduct.getPrice().multiply(BigDecimal.valueOf(order.getQuantity()));
                    if (currentOrderNumber == null || !currentOrderNumber.equals(order.getOrderNumber())) {
                        currentOrderNumber = order.getOrderNumber();
        %>
        <p class="order-number">Sipariş Numarası: #<%= order.getOrderNumber() %></p>
        <%
            }
                    String boxAndTextColor = "var(--secondary-color-1)";
                    String status = "Bilinmiyor";
                    String buttonText = "İşlem yapılamaz";
                    String orderStatus = order.getStatus();
                    if(orderStatus.equals("0")){
                        boxAndTextColor = "var(--orange-color-1)";
                        status = "Hazırlanıyor";
                        buttonText = "Siparişi İptal Et";
                    } else if (orderStatus.equals("1")) {
                        boxAndTextColor = "var(--blue-color-1)";
                        status = "Kargolandı";
                        buttonText = "Kargo Takip";
                    } else if (orderStatus.equals("2")) {
                        boxAndTextColor = "var(--green-color-1)";
                        status = "Teslim Edildi";
                        buttonText = "Değerlendir";
                    } else if (orderStatus.equals("3")) {
                        boxAndTextColor = "var(--red-color-1)";
                        status = "İptal Ettiniz";
                        buttonText = "İşlem Yapılamaz";
                    } else if (orderStatus.equals("4")) {
                        boxAndTextColor = "var(--grey-color-1)";
                        status = "İptal Edildi";
                        buttonText = "İşlem Yapılamaz";
                    }

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
                        <p class="order-info-title"><%=orderToProduct.getName()%></p>
                        <p><%=orderToProduct.getDescription()%></p>
                        <p><%=order.getQuantity()%> Adet</p>
                        <p>Satıcı : <%=orderToSeller.getStoreName()%></p>
                    </div>
                    <div class="order-image">
                        <!-- Ürün resmi buraya gelecek -->
                    </div>
                </div>
            </div>
            <div class="spacer"></div>
            <div class="order-operation" style="background-color: <%=boxAndTextColor%>;">
                <div class="order-state">
                    <p class="order-operation-text">Sipariş<br class="br-x-small">Durumu</p>
                    <p class="order-operation-text text-align-end"><%=status%></p>
                </div>
                <div class="order-amount">
                    <p class="order-operation-text">Ödendi</p>
                    <p class="order-amount-text text-align-end"><%=totalPrice%> TL</p>
                </div>
                <%
                    if(orderStatus.equals("0") || orderStatus.equals("1") || orderStatus.equals("2")){
                %>
                <form id="orderCancellationForm" class="form-temp" method="post" action=<%=orderStatus.equals("0") ? "customer-order-cancellation" : ""%>>
                    <input type="hidden" name="orderId" value="<%=order.getId()%>">
                    <input type="hidden" name="newStatus" value="3">
                    <button type="submit" class="order-button"  onclick="return confirmOrderAction(event, '<%= order.getStatus() %>')">
                        <p class="order-button-text" style="color: <%=boxAndTextColor%>;">
                            <%=buttonText%></p>
                    </button>
                </form>
                <%
                    }else{
                %>
                <div class="order-button">
                    <p class="order-button-text" style="color: <%=boxAndTextColor%>;">
                        <%=buttonText%>
                    </p>
                </div>
                <%
                    }
                %>
            </div>
        </div>
        <%
                }
            }
        %>
    </div>
</section>

<script>
    function confirmOrderAction(event, status) {
        if (status === '0') {
            if (confirm('Siparişi iptal etmek istediğinizden emin misiniz?')) {
                return true;
            } else {
                event.preventDefault();
                return false;
            }
        } else if (status === '1') {
            window.alert('Kargo firmasının takip sistemi henüz aktif değildir.')
        } else {
            window.alert('Siparişi değerlendirmek için yeteri kadar süre geçmedi')
        }
    }
</script>
</body>
</html>
