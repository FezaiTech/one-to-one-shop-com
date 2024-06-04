<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Hesap Oluştur</title>
  <link rel="stylesheet" href="css/style.css" />
  <link rel="stylesheet" href="css/login.css" />
  <link rel="stylesheet" href="css/text.css" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>

<section id="login">
  <div class="custom-row">
    <div class="container-text  container-text-sign-up">
      <div>
        <p class="info-text-p1">Hoş <span class="br-login"></span>Geldiniz</p>
        <p class="info-text-p2">Size dair<span class="br-login"></span> her şey</p>
      </div>
      <img src="./assets/brand/onetone-w.png" alt="App Icon" class="app-icon"/>
    </div>
    <div class="custom-column">
      <div class="container-form">
        <p class="info-text-p3 color-sign-up">Hesap Oluştur</p>
        <form class="registration-form" id="registration-form" action="register-servlet" method="POST" onsubmit="return validateForm()">
          <div class="form-row">
            <label for="name"></label>
            <input type="text" id="name" name="name" placeholder="Ad" maxlength="48" required>
            <div class="spacer"></div>
            <label for="surname"></label>
            <input type="text" id="surname" name="surname" placeholder="Soyad" maxlength="48" required>
          </div>
          <label for="phone"></label>
          <input type="tel" id="phone" name="phone" placeholder="Telefon Numarası" maxlength="18" required>
          <label for="email"></label>
          <input type="text" id="email" name="email" placeholder="E-Posta Adresi" maxlength="98" required>
          <label for="password"></label>
          <div class="password-container">
            <input type="password" id="password" name="password" placeholder="Şifre" maxlength="48" required>
            <button type="button" id="toggle-password">göster</button>
          </div>
          <label for="password-repeat"></label>
          <input type="password" id="password-repeat" name="password-repeat" placeholder="Şifre Tekrar" maxlength="48" required>
          <button type="submit" class="button button-sign-up">Kayıt Ol</button>
        </form>
      </div>
      <div class="custom-row custom-text-row">
        <p class="info-text-p4">Zaten kayıtlı bir hesabın mı var?</p>
        <p id="toLogin" class="info-text-p5 color-sign-up">Giriş Yap</p>
      </div>
    </div>
  </div>
</section>
<script>
  function validateForm() {
    var password = document.getElementById("password").value;
    var passwordRepeat = document.getElementById("password-repeat").value;
    if (password !== passwordRepeat) {
      alert("Şifreler aynı değil. Lütfen tekrar deneyin.");
      return false;
    }
    return true;
  }
</script>
<script src="js/login.js"></script>
</body>
</html>
