document.addEventListener("DOMContentLoaded", function () {
    var popupButton = document.getElementById("add-product-btn");
    var popupBox = document.getElementById("product-add-popup-box");
    var closeButton = document.getElementsByClassName("close")[0];

    // Butona tıklanınca popup'u göster
    popupButton.onclick = function () {
        popupBox.style.display = "block";
    };

    // Kapatma butonuna tıklanınca popup'u gizle
    closeButton.onclick = function () {
        popupBox.style.display = "none";
    };

    // Popup dışına tıklanınca popup'u gizle
    window.onclick = function (event) {
        if (event.target == popupBox) {
            popupBox.style.display = "none";
        }
    };
    function deleteInputs(){
        document.ge
    }
});

function confirmOrderAction(event) {
    if (confirm('Ürünü silmek istediğinizden emin misiniz?')) {
        return true;
    } else {
        event.preventDefault();
        return false;
    }
}

document.addEventListener('DOMContentLoaded', (event) => {
    const buttons = document.querySelectorAll('.store-man-header-button');

    buttons.forEach(button => {
        button.addEventListener('click', () => {
            buttons.forEach(btn => btn.classList.remove('active'));
            button.classList.add('active');
        });
    });
});

function enableEdit(productId) {
    const form = document.getElementById(`productForm-${productId}`);
    const inputs = form.querySelectorAll('input');
    const editButton = form.querySelector('.sm-product-edit-btn');
    const saveButton = form.querySelector('.sm-product-save-btn');

    inputs.forEach(input => input.removeAttribute('readonly'));
    editButton.style.display = 'none';
    saveButton.style.display = 'inline';
}
