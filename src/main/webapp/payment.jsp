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

<section id="header">
  <a href="home.jsp"><img href="" src="assets/brand/onetone.png" alt="AppIcon" class="app-icon"></a>
  <div class="header-button cart-button">
    <img src="assets/icons/cart.png" alt="AppIcon" class="icon">
    <p class="button-text">Sepetim (0)</p>
  </div>
</section>

<section id="payment-stage">
  <div class="payment-box payment-info">
    <p class="title-text">Ödeme<span class="br-small"></span>Aşaması</p>
    <p>Sepetinizde olan <span class="br-small"></span>2 ürün için <span class="br-small"></span>ödeyeceğiniz tutar</p>
    <p class="title-text">3.485,75 TL</p>
  </div>
  <div class="payment-box payment-method">
    <p class="title-text">Ödeme<span class="br-small"></span>Yöntemi</p>
    <p class="button selected" onclick="selectPaymentMethod('card')">Kredi / Banka Kartı</p>
    <p class="button" onclick="selectPaymentMethod('cod')">Kapıda Ödeme</p>
    <p class="button" onclick="selectPaymentMethod('eft')">EFT / Havale</p>
  </div>

  <div class="payment-box payment-form" id="payment-form">
    <p class="title-text form-title" id="form-title">Kart Bilgileriniz</p>
    <div id="pay-by-card">
      <input type="text" placeholder="Kart Numarası"><br>
      <input type="text" placeholder="Son Kullanma Tarihi"><br>
      <input type="text" placeholder="CVV">
    </div>
    <div id="pay-at-door" class="hidden">
      <p>Kapıda ödeme seçtiniz.</p>
    </div>
    <div id="pay-by-eft" class="hidden">
      <p>EFT / Havale bilgilerini giriniz.</p>
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