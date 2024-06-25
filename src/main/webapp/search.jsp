<%@ page import="java.util.List" %>
<%@ page import="com.example.one.beans.ProductBean" %>
<%@ page import="com.example.one.service.SellerService" %>
<%@ page import="com.example.one.service.operations.SellerOperations" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Arama Sonuçları</title>
    <link rel="stylesheet" href="css/style.css"/>
    <link rel="stylesheet" href="css/text.css"/>
    <link rel="stylesheet" href="css/search.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
<%
    String searchQuery = request.getAttribute("searchQuery") != null ? (String) request.getAttribute("searchQuery") : "";
    List<ProductBean> resultProducts = request.getAttribute("resultProducts") != null ? (List<ProductBean>) request.getAttribute("resultProducts") : null;
    String searchResultSize = "0";
    if (resultProducts != null && !resultProducts.isEmpty()) {
        searchResultSize = ""+resultProducts.size()+" sonuç bulundu";
    } else {
        searchResultSize = "sonuç bulunamadı";
    }
%>
<jsp:include page="header.jsp">
    <jsp:param name="headerType" value="full" />
    <jsp:param name="searchQuery" value="<%=searchQuery%>" />
</jsp:include>


<section id="results">
    <p class="s-text-l bold"><%=searchQuery%> <span class="s-text-s normal">Arama Sonuçları (<%=searchResultSize%>)</span></p>
    <div class="result-items">
        <%
            if(resultProducts != null && !resultProducts.isEmpty()){
                for(ProductBean product : resultProducts){
                    SellerService dao = new SellerOperations();
                    String sellerName = dao.getSellerDetails(product.getSellerId()).getStoreName();
        %>
        <div class="result-item">
            <img src="imageServlet?productId=<%=product.getId()%>" alt="<%=product.getName()%>" class="img-container" data-productid="<%= product.getId() %>">
            <div class="flex-column">
                <p class="item-text-m"><%=product.getName()%></p>
                <p><%=product.getDescription()%></p>
                <p class="item-text-s">Satıcı : <%=sellerName%></p>
                <div class="flex-row">
                    <p class="item-text-l"><%=product.getPrice()%></p>
                    <div class="item-add-cart">
                        <img src="assets/icons/add-cart.png" alt="" class="cart-icon-l">
                        <p class="add-text">Sepete Ekle</p>
                    </div>

                </div>
            </div>
        </div>
        <%
            }
            }else{
        %>
            <p class="item-text-m"> Maalesef aradığınızı bulamadık</p>
        <%
            }
        %>
    </div>
</section>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        var addButtons = document.querySelectorAll('.item-add-cart');

        addButtons.forEach(function (button) {
            button.addEventListener('click', function (event) {
                var productContainer = event.target.closest('.result-item');
                var productId = productContainer.querySelector('.img-container').getAttribute('data-productid');

                addToCart(productId, 1);
            });
        });
    });

    function addToCart(productId, count) {
        var xhr = new XMLHttpRequest();
        xhr.open('POST', 'addToCartServlet', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onreadystatechange = function () {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    location.reload();
                } else {
                    alert('Ürün sepete eklenirken bir hata oluştu.');
                }
            }
        };
        xhr.send('productId=' + productId + '&count=' + count);
    }

</script>
</body>
</html>