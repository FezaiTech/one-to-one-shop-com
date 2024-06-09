<%@ page import="com.example.one.service.UserService" %>
<%@ page import="com.example.one.service.operations.UserOperations" %>
<%@ page import="com.example.one.beans.UserBean" %>
<%@ page import="com.example.one.service.SellerService" %>
<%@ page import="com.example.one.service.operations.SellerOperations" %>
<%@ page import="com.example.one.beans.SellerBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="tr">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Profilim</title>
  <link rel="stylesheet" href="css/style.css"/>
  <link rel="stylesheet" href="css/text.css"/>
  <link rel="stylesheet" href="css/profile.css"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
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
<body>
<section id="header">
  <a href="home.jsp"><img href="" src="assets/brand/onetone.png" alt="AppIcon" class="app-icon"></a>
  <div class="profile-button">
    <img src="assets/icons/profile.png" alt="AppIcon" class="icon">
    <p class="button-text">Profilim</p>
  </div>
</section>

<section id="profile-form">
  <div class="user-profile">
    <p class="title-box profile-title">Hesap</p>
    <div class="form-box">
      <p class="form-title">Bilgileriniz</p>
      <form class="user-update-form" id="userUpdateForm" action="update-user-servlet" method="GET">
        <input type="hidden" id="userId" name="userId" value="<%= userInfo.getId() %>">
        <input type="hidden" id="password" name="password" value="<%= userInfo.getPassword() %>">
        <input type="hidden" id="sellerStatus" name="sellerStatus" value="<%= userInfo.isSellerStatus() %>">
        <div class="form-row">
          <label for="name"></label>
          <input type="text" id="name" name="name" value="<%= userInfo.getName()%>" placeholder="Adınız" maxlength="48" required>
          <div class="spacer"></div>
          <label for="surname"></label>
          <input type="text" id="surname" name="surname" value="<%=userInfo.getSurname()%>" placeholder="Soyadınız" maxlength="48" required>
        </div>
        <label for="phone"></label>
        <input type="tel" id="phone" name="phone" value="<%= userInfo.getPhone()%>" placeholder="Telefon numaranız" maxlength="18" required>
        <label for="email"></label>
        <input type="text" id="email" name="email" value="<%= userInfo.getEmail()%>" placeholder="E-mail adresiniz" maxlength="98" required>
        <button type="submit" class="button">Bilgileri Kaydet</button>
      </form>
    </div>
    <p class="password-change">Şifremi Değiştirmek İstiyorum</p>
  </div>
  <div class="seller-profile">
    <p class="title-box seller-title"><%=isSeller ? "Satıcı Bilgileriniz" : "Satıcı Olmak İstiyorum"%></p>
    <div class="form-box">
      <p class="form-title seller-form-title">Mağaza Bilgileriniz</p>
      <form class="user-update-form" id="sellerUpdateForm" action="<%= isSeller ? "store-management.jsp" : "update-seller-servlet" %>" method="POST">
        <input type="hidden" id="sellerUserId" name="sellerUserId" value="<%= userInfo.getId() %>">
        <label for="seller-name"></label>
        <input type="text" id="seller-name" name="seller-name" value="<%= isSeller ? seller.getStoreName() : "" %>" placeholder="Mağaza Adı" maxlength="48" <%= isSeller ? "readonly" : "" %> required>
        <label for="seller-no"></label>
        <input type="number" id="seller-no" name="seller-no" value="<%= isSeller ? seller.getStoreNumber() : "" %>" placeholder="Vergi Numarası" maxlength="10" <%= isSeller ? "readonly" : "" %> required>
        <p class="info-text"><%= isSeller ? "Daha önceden açtığınız mağaza bilgileri yukarıda yer almaktadır. Mağazanıza giderek panele erişebilirsiniz"
                : "Gerekli kontrol işlemlerinin ardından mağazanız aktif olacaktır. Profilinizden kontrol edebilirsiniz." %></p>
        <button type="submit" class="button button-seller-info"><%= isSeller ? "Mağazaya Git" : "Satıcı Ol" %></button>
      </form>
    </div>
  </div>
</section>

</body>
</html>