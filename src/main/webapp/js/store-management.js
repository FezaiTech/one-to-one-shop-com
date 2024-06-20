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