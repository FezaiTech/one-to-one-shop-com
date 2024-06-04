document.getElementById('toggle-password').addEventListener('click', function () {
    var passwordField = document.getElementById('password');
    var passwordFieldType = passwordField.getAttribute('type');

    var passwordRepeatField = document.getElementById('password-repeat');

    var toggleButton = document.getElementById('toggle-password');

    if (passwordFieldType === 'password') {
        passwordField.setAttribute('type', 'text');
        passwordRepeatField.setAttribute('type', 'text');
        toggleButton.textContent = 'gizle';
    } else {
        passwordField.setAttribute('type', 'password');
        passwordRepeatField.setAttribute('type', 'password');
        toggleButton.textContent = 'göster';
    }
});

document.addEventListener('DOMContentLoaded', function () {
    var toLogin = document.getElementById('toLogin');
    var toSignUp = document.getElementById('toSignUp');

    if (toLogin) {
        toLogin.addEventListener('click', function () {
            window.location.href = 'login.html';
        });
    }

    if (toSignUp) {
        toSignUp.addEventListener('click', function () {
            window.location.href = 'sign_up.html';
        });
    }
});


