<%@ page import="com.example.one.beans.CartBean" %>
<%@ page import="com.example.one.beans.ProductBean" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.example.one.service.operations.ProductOperations" %>
<%@ page import="com.example.one.service.ProductService" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Ödeme Aşaması</title>
  <link rel="stylesheet" href="css/style.css" />
  <link rel="stylesheet" href="css/payment.css" />
  <link rel="stylesheet" href="css/text.css" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
<%
  Map<CartBean, ProductBean> productMap = new HashMap<>();
  List<CartBean> cartItems = (List<CartBean>) session.getAttribute("cartItems");
  ProductService dao = new ProductOperations();

  if (cartItems != null) {
    for (CartBean cartItem : cartItems) {
      int productId = cartItem.getProductId();
      if (!productMap.containsKey(productId)) {
        ProductBean product = dao.getProductDetails(productId);
        productMap.put(cartItem, product);
      }
    }
  }
  int cartSize = 0;
  if (cartItems != null && cartItems.size() >0){
    cartSize = cartItems.size();
  }

  BigDecimal totalAmount = BigDecimal.ZERO;
  if (productMap != null && productMap.size() > 0) {
    for (Map.Entry<CartBean, ProductBean> entry : productMap.entrySet()) {
      CartBean cart = entry.getKey();
      ProductBean product = entry.getValue();
      int quantity = cart.getCount();

      BigDecimal totalPrice = product.getPrice().multiply(BigDecimal.valueOf(quantity));
      BigDecimal formattedTotalPrice = totalPrice.setScale(2, BigDecimal.ROUND_HALF_UP);
      totalAmount = totalAmount.add(formattedTotalPrice);
    }
  }
%>
<section id="header">
  <a href="home.jsp"><img href="" src="assets/brand/onetone.png" alt="AppIcon" class="app-icon"></a>
  <div class="header-button cart-button">
    <img src="assets/icons/cart.png" alt="AppIcon" class="icon">
    <p class="button-text">Sepetim (<%=cartItems != null ? cartItems.size() : 0%>)</p>
  </div>
</section>

<section id="payment-stage">
  <div class="payment-box payment-info">
    <p class="title-text">Ödeme <span class="br-payment"></span>Aşaması</p>
    <p>Sepetinizde olan <span class="br-payment"></span><%=cartSize%> ürün için <span class="br-payment"></span>ödeyeceğiniz tutar</p>
    <p class="title-text"><%=totalAmount%> TL</p>
  </div>
  <div class="payment-box payment-method">
    <p class="title-text">Ödeme <span class="br-payment"></span>Yöntemi</p>
    <p class="button selected" onclick="selectPaymentMethod('card')">Kredi / Banka Kartı</p>
    <p class="button" onclick="selectPaymentMethod('cod')">Kapıda Ödeme</p>
    <p class="button" onclick="selectPaymentMethod('eft')">EFT / Havale</p>
  </div>
  <div class="payment-box payment-form" id="payment-form">
    <p class="title-text form-title" id="form-title">Kart Bilgileriniz</p>
    <div id="pay-by-card">
      <form class="card-form" id="card-form" action="" method="POST">
        <div class="form-row">
          <div class="form-column">
            <input type="text" id="card-name" name="card-name" placeholder="Kart sahibinin adı" maxlength="48" required>
            <input type="text" id="card-no" name="card-no" placeholder="Kart numarası" maxlength="16" required>
          </div>
          <div class="form-column form-column-small">
            <input class="small-input" type="text" id="card-date" name="card-date" placeholder="Ay/Yıl" maxlength="7" required>
            <input class="small-input" type="text" id="card-cvv" name="card-cvv" placeholder="CVV" maxlength="3" required>
          </div>
        </div>
        <p class="title-text form-title full-text">Adres Bilgileriniz</p>
        <input type="text" id="address" name="address" placeholder="Teslimat adresini giriniz" maxlength="124" required>
        <button type="submit" class="button-form ">Siparişi Oluştur</button>
      </form>
    </div>
    <div id="pay-at-door" class="hidden">
      <p>Kapıda ödeme yapabilmeniz için kargonuzu teslim almadan önce OneToOneShop imzalı faturanızı kontrol ediniz ve
        fatura tutarını görevliye teslim ediniz.</p>
      <p>İlave kargo ücreti eklenebilir.</p>
      <form class="at-door-form" id="at-door-form" action="" method="POST">
        <p class="title-text form-title full-text">Adres Bilgileriniz</p>
        <input type="text" id="address-door" name="address" placeholder="Teslimat adresini giriniz" maxlength="124" required>
        <button type="submit" class="button-form ">Siparişi Oluştur</button>
      </form>
    </div>
    <div id="pay-by-eft" class="hidden">
      <p>Aşağıda yazan hesap bilgilerine EFT/Havale işlemini gerçekleştiriniz.
        Ödemeniz alındığı zaman sipariş oluşturulacak tarafınıza bilgilendirme yapılacaktır.</p>
      <p>OneToOneShop TR00 0000 0000 0000 0000 0000 00</p>
      <form class="eft-form" id="eft-form" action="" method="POST">
        <p class="title-text form-title full-text">Adres Bilgileriniz</p>
        <input type="text" id="address-eft" name="address" placeholder="Teslimat adresini giriniz" maxlength="124" required>
        <button type="submit" class="button-form ">Siparişi Oluştur</button>
      </form>
    </div>
  </div>

</section>

<script>
  function selectPaymentMethod(method) {
    document.querySelectorAll('.button').forEach(button => {
      button.classList.remove('selected');
    });
    document.getElementById('pay-by-card').classList.add('hidden');
    document.getElementById('pay-at-door').classList.add('hidden');
    document.getElementById('pay-by-eft').classList.add('hidden');

    if (method === 'card') {
      document.querySelector('p[onclick="selectPaymentMethod(\'card\')"]').classList.add('selected');
      document.getElementById('pay-by-card').classList.remove('hidden');
      document.getElementById('form-title').innerText = 'Kart Bilgileriniz';
    } else if (method === 'cod') {
      document.querySelector('p[onclick="selectPaymentMethod(\'cod\')"]').classList.add('selected');
      document.getElementById('pay-at-door').classList.remove('hidden');
      document.getElementById('form-title').innerText = 'Kapıda Ödeme Bilgileri';
    } else if (method === 'eft') {
      document.querySelector('p[onclick="selectPaymentMethod(\'eft\')"]').classList.add('selected');
      document.getElementById('pay-by-eft').classList.remove('hidden');
      document.getElementById('form-title').innerText = 'EFT / Havale Bilgileri';
    }
  }

  window.onload = function() {
    selectPaymentMethod('card');
  }
</script>
</body>
</html>