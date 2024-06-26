document.addEventListener("DOMContentLoaded", function () {
    setupPopup('add-product-btn', 'product-add-popup-box');
    setupPopup('add-customer-btn', 'customer-add-popup-box');

    function setupPopup(buttonId, popupBoxId) {
        var popupButton = document.getElementById(buttonId);
        var popupBox = document.getElementById(popupBoxId);

        if (popupButton && popupBox) {
            var closeButton = popupBox.getElementsByClassName("close")[0];

            // Butona tıklanınca popup'u göster
            popupButton.onclick = function () {
                popupBox.style.display = "block";
            };

            // Kapatma butonuna tıklanınca popup'u gizle
            if (closeButton) {
                closeButton.onclick = function () {
                    popupBox.style.display = "none";
                };
            }

            // Popup dışına tıklanınca popup'u gizle
            window.onclick = function (event) {
                if (event.target == popupBox) {
                    popupBox.style.display = "none";
                }
            };
        }
    }
});

function confirmOrderAction(productId) {
    if (confirm('Ürünü silmek istediğinizden emin misiniz?')) {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    window.location.href = "store-management.jsp";
                } else {
                    alert('Bir hata meydana geldi: ' + xhr.responseText);
                }
            }
        };
        xhr.open('POST', 'seller-product-delete', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.send('productId=' + productId);
    }
}

function enableEdit(productId) {
    const form = document.getElementById(`productForm-${productId}`);
    const inputs = form.querySelectorAll('input');
    const textareas = form.querySelectorAll('textarea');
    const editButton = form.querySelector('.sm-product-edit-btn');
    const saveButton = form.querySelector('.sm-product-save-btn');

    inputs.forEach(input => input.removeAttribute('readonly'));
    textareas.forEach(textarea => textarea.removeAttribute('readonly'));
    editButton.style.display = 'none';
    saveButton.style.display = 'inline';
}

function filterProducts() {
    var input, filter, section, div, name, category, detail, i, nameValue, categoryValue, detailValue;
    input = document.getElementById("search-box");
    filter = input.value.toUpperCase();
    section = document.getElementById("sm-body-grid");
    div = section.getElementsByClassName("sm-product-box");

    for (i = 0; i < div.length; i++) {
        name = div[i].querySelector(".sm-answer[name='name-form']");
        category = div[i].querySelector(".sm-answer[name='category-form']");
        detail = div[i].querySelector(".sm-answer[name='detail-form']");

        nameValue = name.value || name.textContent || name.innerText;
        categoryValue = category.value || category.textContent || category.innerText;
        detailValue = detail.value || detail.textContent || detail.innerText;

        if (nameValue.toUpperCase().indexOf(filter) > -1 || categoryValue.toUpperCase().indexOf(filter) > -1 || detailValue.toUpperCase().indexOf(filter) > -1) {
            div[i].style.display = "";
        } else {
            div[i].style.display = "none";
        }
    }
}