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

document.addEventListener("DOMContentLoaded", function () {
    fetch("produccts.json")
        .then(response => response.json())
        .then(data => {

            const productList = document.getElementById("sm-body-grid");
            const activeProductCount = document.getElementById("sm-item-count");
            let activeOrders = 0;

            data.forEach(eachItem =>{
                const item = document.createElement('div');


            })
        })
})