<%@ page import="com.example.one.service.UserService" %>
<%@ page import="com.example.one.service.operations.UserOperations" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.one.beans.UserBean" %>
<%@ page import="java.util.ArrayList" %>
<%
    UserService userService = new UserOperations();
    List<UserBean> users = userService.getAllUser();
%>

<div id="customer-add-popup-box" class="popup">
    <div class="popup-content column">
        <span class="close">&times;</span>
        <form style="gap: 20px" class="column" id="add-customer-form" name="add-customer-form" method="post" action="addToCustomerServlet" enctype="multipart/form-data" >
            <p style="text-align: center;;color: var(--green-color-1);font-weight: 800;" class="title-m">Mağazana Yeni Müşteri Ekle</p>
            <select class="select-list-class" name="customer-email"  required>
                <%
                    for (int i = 0; i < users.size(); i++){
                %>
                <option class="text" value="<%=users.get(i).getEmail()%>"><%=users.get(i).getEmail()%></option>
                <%
                    }
                %>
            </select>
            <button type="submit" style="width: 100%;color: #FFFFFF" class="add-new-product-btn text-l " id="add-cutomer-btn-last">Ekle</button>
        </form>
    </div>
</div>

<div id="product-add-popup-box" class="popup">
    <div class="popup-content column">
        <span class="close">&times;</span>
        <form style="gap: 20px" class="column" id="add-product-form" name="add-product-form" method="post" action="addToProductServlet" enctype="multipart/form-data" >
            <p style="text-align: center;;color: var(--green-color-1);font-weight: 800;" class="title-m">Mağazana Yeni Ürün Ekle</p>
            <input id="product-brand" name="product-brand" type="text" placeholder="Marka" required>
            <select class="select-list-class" name="product-category" required>
                <%
                    List<String> categories = new ArrayList<>();
                    categories.add("Elektronik");
                    categories.add("Moda");
                    categories.add("Ev-Yaşam");
                    categories.add("Kitap");

                    for (int i = 0; i < categories.size(); i++){
                %>
                <option class="select-list-class" value="<%=categories.get(i)%>"><%=categories.get(i)%></option>
                <%
                    }
                %>
            </select>
            <input id="product-detail" name="product-detail" type="text" placeholder="Detay" required>
            <input id="product-amount" name="product-amount" type="text" placeholder="Fiyat" required>
            <input id="product-img" name="product-img" type="file" accept="image/*" required>
            <button type="submit" style="width: 100%;color: #FFFFFF" class="add-new-product-btn text-l " id="add-product-btn-last">Ekle</button>
        </form>
    </div>
</div>