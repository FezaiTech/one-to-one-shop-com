<%@ page import="com.example.one.beans.ProductBean" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.one.service.operations.SellerOperations" %>
<%@ page import="com.example.one.service.SellerService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Kategori Sonuçları</title>
    <link rel="stylesheet" href="css/style.css"/>
    <link rel="stylesheet" href="css/text.css"/>
    <link rel="stylesheet" href="css/header.css"/>
    <link rel="stylesheet" href="css/category.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>

<jsp:include page="header.jsp">
    <jsp:param name="headerType" value="full" />
</jsp:include>

<%
    String categoryName = request.getAttribute("categoryName") != null ? (String) request.getAttribute("categoryName") : "";
    List<ProductBean> products = request.getAttribute("resultProducts") != null ? (List<ProductBean>) request.getAttribute("resultProducts") : null;
    int count = 0;
    String[] classes = {"a", "b", "c", "a-r", "b-r", "c-r"};
%>

<section id="items">
    <p class="c-text-l bold"><%=categoryName%><span class="c-text-s normal"> Kategorisi</span></p>

    <% if(products != null && !products.isEmpty()){
    %>
    <div class="wrapper">
        <%
            for (ProductBean product : products) {
                SellerService dao = new SellerOperations();
                String sellerName = dao.getSellerDetails(product.getSellerId()).getStoreName();
                if (count > 0 && count % 3 == 0) {
        %>
    </div>
    <div class="wrapper<%= (count / 3) % 2 == 1 ? "-reverse" : "" %>">
        <%
            }
            String itemClass = classes[count % classes.length];
        %>
        <div class="result-item <%= itemClass %>">
            <img src="<%= product.getImage() %>" alt="" class="img-container">
            <div class="flex-column">
                <p class="item-text-m"><%= product.getName() %></p>
                <p><%= product.getDescription() %></p>
                <p class="item-text-s">Satıcı : <%= sellerName %></p>
                <div class="flex-row">
                    <p class="item-text-l"><%= product.getPrice() %> TL</p>
                    <div class="item-add-cart">
                        <img src="assets/icons/add-cart.png" alt="" class="cart-icon-l">
                        <p class="add-text">Sepete Ekle</p>
                    </div>
                </div>
            </div>
        </div>
        <%
                count++;
            }
        %>
    </div>
    <%}else{
     %>
    <p class="item-text-m">Bu kategoriye henüz ürün eklenmemiş</p>
    <%}%>
</section>


</body>
</html>
