<%@ page import="com.example.one.service.ProductService" %>
<%@ page import="com.example.one.service.operations.ProductOperations" %>
<%@ page import="com.example.one.beans.ProductBean" %>
<%@ page import="com.example.one.service.SellerService" %>
<%@ page import="com.example.one.service.operations.SellerOperations" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Ürün Detayı</title>
    <link rel="stylesheet" href="css/style.css"/>
    <link rel="stylesheet" href="css/text.css"/>
    <link rel="stylesheet" href="css/product-detail.css"/>
    <link rel="stylesheet" href="css/header.css"/>
    <link rel="stylesheet" href="css/category-list.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
<%
    int productId = Integer.parseInt(request.getParameter("id"));
    ProductService dao = new ProductOperations();
    ProductBean product = dao.getProductDetails(productId);

    SellerService daos = new SellerOperations();
    String sellerName = daos.getSellerDetails(product.getSellerId()).getStoreName();
%>

<jsp:include page="header.jsp">
    <jsp:param name="headerType" value="full" />
</jsp:include>

<section id="product-info">
    <div class="flex-row-pi flex-prop">
        <div class="img-container-pi">
            <img src="imageServlet?productId=<%=product.getId()%>" alt="<%=product.getName()%>" class="img-pi" data-productid="<%= product.getId() %>">
        </div>
        <div class="flex-column-pi item-descriptions">
            <div class="flex-column-pi">
                <p class="title-pi"><%=product.getName()%></p>
                <p class="mini-pi">Çok satan marka</p>
            </div>
            <p class="exp-pi"><%=product.getDescription()%></p>
            <div class="flex-row-pi">
                <div class="flex-column-pi">
                    <p class="subtitle-pi"><%=product.getCategory()%></p>
                    <p class="subtitle-pi">Satıcı : <%=sellerName%></p>
                    <p class="subtitle-pi">7 gün içinde kapınızda</p>
                </div>

                <div class="flex-column-pi align-end">
                    <p class="subtitle-pi">KDV Dahil</p>
                    <p class="price-pi"><%=product.getPrice()%> TL</p>
                    <div class="add-cart-pi">Sepete Ekle</div>
                </div>
            </div>
        </div>
    </div>
</section>

<section id="category-list">
    <%
        ProductService daop = new ProductOperations();
        List<ProductBean> categoryProducts = daop.getAllProductsByCategory(product.getCategory(),10);
    %>
    <div class="one-category">
        <div class="title-row">
            <div class="title-column">
                <div class="category-title"><%=product.getCategory()%></div>
                <div class="category-subtitle">Kategorinin öne çıkan ürünleri</div>
            </div>
            <div class="push-button" onclick=goCategoryPage("<%=product.getCategory()%>")>
                <div class="category-subtitle">Tümü</div>
                <div class="push-icon">
                    <img src="assets/icons/push.png" class="mini-icon">
                </div>
            </div>
        </div>
        <div class="product-containers" id="productContainer">
            <%
                if(categoryProducts != null && !categoryProducts.isEmpty()){
                    for (ProductBean categoryProduct : categoryProducts) {
            %>
            <div class="product">
                <p class="item-name-text"><%= categoryProduct.getName() %></p>
                <p class="br-x-small desc-text"><%= categoryProduct.getDescription() %></p>
                <div class="image-center">
                    <img src="imageServlet?productId=<%=categoryProduct.getId()%>" alt="<%=categoryProduct.getName()%>" class="product-image" data-productid="<%= categoryProduct.getId() %>">
                </div>
                <div class="product-row">
                    <p class="product-price"><%= categoryProduct.getPrice() %> TL</p>
                    <div class="add-cart-button">
                        <img src="assets/icons/add.png" class="cart-icon">
                    </div>
                </div>
            </div>
            <%
                }
            }else{
            %>
            <div class="product" style="height: min-content">
                <p class="product-price">Bu kategori için henüz ürün eklenmedi.</p>
            </div>
            <%
                }
            %>
        </div>
    </div>
</section>

<script src="js/category-list.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        var addButtons = document.querySelectorAll('.add-cart-pi');

        addButtons.forEach(function (button) {
            button.addEventListener('click', function (event) {
                var productContainer = event.target.closest('.flex-prop');
                var productId = productContainer.querySelector('.img-pi').getAttribute('data-productid');

                addToCart(productId, 1); // 1 ürün eklemek için
            });
        });
    });

    document.addEventListener('DOMContentLoaded', function () {
        var addButtons = document.querySelectorAll('.add-cart-button');

        addButtons.forEach(function (button) {
            button.addEventListener('click', function (event) {
                var productContainer = event.target.closest('.product');
                var productId = productContainer.querySelector('.product-image').getAttribute('data-productid');

                addToCart(productId, 1); // 1 ürün eklemek için
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

    function goCategoryPage(category) {
        window.location.href = 'category-servlet?categoryName=' + encodeURIComponent(category);
    }
</script>
</body>
</html>
