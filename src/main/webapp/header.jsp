<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<section id="header">
    <div class="header-row">
      <a href="home.jsp"><img src="assets/brand/onetone.png" alt="AppIcon" class="app-icon"></a>
      <div class="search-container main-s-bar ">
        <form action="/search" method="get">
          <input type="text" placeholder="Ürün, kategori veya marka arayın" name="query" class="search-box">
          <button type="submit" class="search-button"><b>Ara</b></button>
        </form>
      </div>
      <div class="text-buttons">
        <div class="header-button category-button dropdown">
          <p class="button-text text-color">Kategoriler</p>
          <div class="dropdown-content">
            <a href="#">Elektronik</a>
            <a href="#">Moda</a>
            <a href="#">Ev, Yaşam</a>
          </div>
        </div>
        <a href="cart.jsp" style="text-decoration: none">
          <div class="header-button cart-button">
            <img src="assets/icons/cart.png" alt="AppIcon" class="icon">
            <p class="button-text">Sepetim (<%=cartItems != null ? cartItems.size() : 0%>)</p>
          </div>
        </a>
        <div class="header-button profile-button">
          <img src="assets/icons/profile.png" alt="AppIcon" class="icon">
          <p class="button-text my-profile-text">
            <%if (userEmail != null) {%>Profilim<%
          } else {%><a href="login.jsp" class="button-text my-profile-text">Giriş Yap</a><%}%>
          </p>
          </p>
          <%if (userEmail != null) {%>
          <div class="dropdown-content dropdown-profile">
            <a href="profile.jsp">Hesap Bilgileri</a>
            <a href="orders.jsp">Siparişlerim</a>
            <a href="logout-servlet">Çıkış Yap</a>
          </div><%
          }%>
        </div>
      </div>
    </div>
    <div class="search-container hidden-s-bar ">
      <form action="/search" method="get">
        <input type="text" placeholder="Ürün, kategori veya marka arayın" name="query" class="search-box">
        <button type="submit" class="search-button"><b>Ara</b></button>
      </form>
    </div>
</section>