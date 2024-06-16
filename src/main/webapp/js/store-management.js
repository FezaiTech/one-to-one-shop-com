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
});
var sm = "<%\n" +
    "        if(storeProducts != null && !storeProducts.isEmpty()){\n" +
    "            for (ProductBean product : storeProducts) {\n" +
    "    %>\n" +
    "    <div class=\"sm-product-box\">\n" +
    "        <div class=\"sm-product-box-padding\">\n" +
    "            <div style=\"gap: 5px\" class=\"column\">\n" +
    "                <div class=\"title-grid\">\n" +
    "                    <p class=\"sm-title\">Markası</p>\n" +
    "                    <p class=\"sm-answer\"><%=product.getName()%></p>\n" +
    "                    <p class=\"sm-title\">Kategori</p>\n" +
    "                    <p class=\"sm-answer\"><%=product.getCategory()%></p>\n" +
    "                    <p class=\"sm-title\">Eklenme Tarihi</p>\n" +
    "                    <p class=\"sm-answer\"><%=product.getAddedDate()%></p>\n" +
    "                    <p class=\"sm-title\">Fiyatı</p>\n" +
    "                    <p class=\"sm-answer\"><%=product.getPrice()%></p>\n" +
    "                </div>\n" +
    "                <div class=\"row\">\n" +
    "                    <div style=\"align-self: start; gap: 10px\" class=\"column\">\n" +
    "                        <p class=\"sm-title\">Detayı</p>\n" +
    "                        <p class=\"sm-answer\"><%=product.getDescription()%></p>\n" +
    "                    </div>\n" +
    "                    <div class=\"image-box image-center\">\n" +
    "                        <img src=\"imageServlet?productId=<%=product.getId()%>\" alt=\"<%=product.getName()%>\" class=\"product-image\" data-productid=\"<%= product.getId() %>\">\n" +
    "                    </div>\n" +
    "                </div>\n" +
    "                <div class=\"sizedBox\"></div>\n" +
    "                <div style=\"justify-content: end;\" class=\"row\">\n" +
    "                    <div class=\"sm-product-edit-btn sm-button-text\">Düzenle</div>\n" +
    "                    <div class=\"sm-product-delete-btn sm-button-text\">Sil</div>\n" +
    "                </div>\n" +
    "            </div>\n" +
    "        </div>\n" +
    "    </div>\n" +
    "    <%\n" +
    "        }\n" +
    "    }else{\n" +
    "    %>\n" +
    "    <div class=\"sizedBox\" style=\"background-color: red\"></div>\n" +
    "    <%\n" +
    "        }\n" +
    "    %>";
const products =
  "        <div style=\"gap: 10px;\" class=\"column\">\n" +
  "            <div class=\"row\">\n" +
  "                <div style=\"color: black\" id=\"sm-item-count\" class=\"text-l\">Ürün Sayısı : <%= storeProducts != null ? activeProducts : 0 %></div>\n" +
  "                <div class=\"search-container-sm unhidden\">\n" +
  "                    <form action=\"/search\" method=\"get\">\n" +
  "                        <input type=\"text\" placeholder=\"Ürün, kategori veya marka arayın\" name=\"query\" class=\"search-box\">\n" +
  "                        <button type=\"button\" class=\"search-button\"><b>Ara</b></button>\n" +
  "                    </form>\n" +
  "                </div>\n" +
  "                <button id=\"add-product-btn\" class=\"add-new-product-btn\">+ Yeni Ürün Ekle</button>\n" +
  "            </div>\n" +
  "            <div class=\"search-container-sm hidden\">\n" +
  "                <form action=\"/search\" method=\"get\">\n" +
  "                    <input type=\"text\" placeholder=\"Ürün, kategori veya marka arayın\" name=\"query\" class=\"search-box\">\n" +
  "                    <button type=\"submit\" class=\"search-button\"><b>Ara</b></button>\n" +
  "                </form>\n" +
  "            </div>\n" +
  "        </div>\n" +
  "    </section>\n" +
  "    <section id=\"sm-body-grid\" class=\"sm-body-grid\">\n" +
  "        <%\n" +
  "            if(storeProducts != null && !storeProducts.isEmpty()){\n" +
  "                for (ProductBean product : storeProducts) {\n" +
  "        %>\n" +
  "        <div class=\"sm-product-box\">\n" +
  "            <div class=\"sm-product-box-padding\">\n" +
  "                <div style=\"gap: 5px\" class=\"column\">\n" +
  "                    <div class=\"title-grid\">\n" +
  "                        <p class=\"sm-title\">Markası</p>\n" +
  "                        <p class=\"sm-answer\"><%=product.getName()%></p>\n" +
  "                        <p class=\"sm-title\">Kategori</p>\n" +
  "                        <p class=\"sm-answer\"><%=product.getCategory()%></p>\n" +
  "                        <p class=\"sm-title\">Eklenme Tarihi</p>\n" +
  "                        <p class=\"sm-answer\"><%=product.getAddedDate()%></p>\n" +
  "                        <p class=\"sm-title\">Fiyatı</p>\n" +
  "                        <p class=\"sm-answer\"><%=product.getPrice()%></p>\n" +
  "                    </div>\n" +
  "                    <div class=\"row\">\n" +
  "                        <div style=\"align-self: start; gap: 10px\" class=\"column\">\n" +
  "                            <p class=\"sm-title\">Detayı</p>\n" +
  "                            <p class=\"sm-answer\"><%=product.getDescription()%></p>\n" +
  "                        </div>\n" +
  "                        <div class=\"image-box image-center\">\n" +
  "                            <img src=\"imageServlet?productId=<%=product.getId()%>\" alt=\"<%=product.getName()%>\" class=\"product-image\" data-productid=\"<%= product.getId() %>\">\n" +
  "                        </div>\n" +
  "                    </div>\n" +
  "                    <div class=\"sizedBox\"></div>\n" +
  "                    <div style=\"justify-content: end;\" class=\"row\">\n" +
  "                        <div class=\"sm-product-edit-btn sm-button-text\">Düzenle</div>\n" +
  "                        <div class=\"sm-product-delete-btn sm-button-text\">Sil</div>\n" +
  "                    </div>\n" +
  "                </div>\n" +
  "            </div>\n" +
  "        </div>\n" +
  "        <%\n" +
  "            }\n" +
  "        }else{\n" +
  "        %>\n" +
  "        <div class=\"sizedBox\" style=\"background-color: red\"></div>\n" +
  "        <%\n" +
  "            }\n" +
  "        %>\n" +
  "\n" ;

