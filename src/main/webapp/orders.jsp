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

<section id="header">
    <img src="assets/brand/onetone.png" alt="AppIcon" class="app-icon">
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
        <p class="order-count">Aktif <span id="activeOrderCount">0</span> siparişiniz bulunmaktadır</p>
    </div>
    <div id="orderList"></div>
</section>

<script src="js/orders.js"></script>
</body>
</html>