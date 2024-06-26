<%@ page import="com.example.one.service.UserService" %>
<%@ page import="com.example.one.service.operations.UserOperations" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.one.beans.UserBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.one.service.CustomerService" %>
<%@ page import="com.example.one.service.operations.CustomerOperations" %>
<%@ page import="com.example.one.service.SellerService" %>
<%@ page import="com.example.one.service.operations.SellerOperations" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    UserService userService = new UserOperations();
    String userEmail = (session != null) ? (String) session.getAttribute("userEmail") : null;
    UserBean userInfo = userService.getUserDetails(userEmail);

    SellerService sellerService = new SellerOperations();
    CustomerService customerService = new CustomerOperations();
    List<UserBean> customerToUser = customerService.addCustomerForSeller(sellerService.getSellerDetails(userInfo.getId()).getId());
%>

<div id="customer-add-popup-box" class="popup">
    <div class="popup-content column">
        <span class="close">&times;</span>
        <form style="gap: 20px" class="column" id="add-customer-form" name="add-customer-form" method="post" action="addToCustomerServlet" enctype="multipart/form-data" >
            <p style="text-align: center;;color: var(--green-color-1);font-weight: 800;" class="title-m">Mağazana Yeni Müşteri Ekle</p>
            <select class="select-list-class" name="customer-email"  required>
                <%
                    for (UserBean user : customerToUser){
                %>
                <option class="text" value="<%=user.getEmail()%>"><%=user.getEmail()%></option>
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
                    categories.add("Hobi-Oyuncak");

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