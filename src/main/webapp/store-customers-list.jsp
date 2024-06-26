<%@ page import="com.example.one.service.CustomerService" %>
<%@ page import="com.example.one.service.operations.CustomerOperations" %>
<%@ page import="com.example.one.beans.UserBean" %>
<%@ page import="com.example.one.service.UserService" %>
<%@ page import="com.example.one.service.operations.UserOperations" %>
<%@ page import="com.example.one.beans.SellerBean" %>
<%@ page import="com.example.one.service.SellerService" %>
<%@ page import="com.example.one.service.operations.SellerOperations" %>
<%@ page import="com.example.one.beans.CustomerBean" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    CustomerService customerService = new CustomerOperations();
    UserService userService = new UserOperations();
    SellerService sellerService = new SellerOperations();

    String userEmail = (session != null) ? (String) session.getAttribute("userEmail") : null;
    UserBean userInfo = userService.getUserDetails(userEmail);


    List<CustomerBean> storeCustomerList = null ;
    int activerCustomer = 0;

    if (userEmail != null) {
        SellerBean mySeller = sellerService.getSellerDetails(userInfo.getId()); //Seller
        int sellerId = mySeller.getId();
        storeCustomerList = customerService.getCustomerForSeller(sellerId);

        for (CustomerBean customerBean : storeCustomerList) {
            activerCustomer++;
        }

    }else {
        response.sendRedirect("login.jsp");
    }


%>

<section id="search-bar">
    <div style="gap: 10px;" class="column">
        <div class="row">
            <div style="color: black" id="sm-item-count" class="text-l">Müşteri Sayısı : <%=storeCustomerList != null ? activerCustomer : 0%></div>
            <button id="add-customer-btn" class="add-new-product-btn">+ Yeni Müşteri Ekle</button>
        </div>
    </div>
</section>
<div class="sizedBox"></div>
<div class="sizedBox"></div>
<section id="customer-section">
    <div class="column-customer-list">
        <!-- First Customer Box -->
        <%
            if(storeCustomerList != null && !storeCustomerList.isEmpty()){
                for (CustomerBean customer : storeCustomerList) {
                    UserBean user = userService.getUserDetailsWithID(customer.getUserId());
        %>
        <div class="customer-box">
            <div class="row" style="gap: 1px">
                <div class="column-customer-line" style="flex: 2">
                    <div class="row-customer-line">
                        <p class="text-m" style="flex: 1">Adı</p>
                        <p class="text-m" style="flex: 4; justify-content: center"><%=user.getName()%></p>
                    </div>
                    <div class="row-customer-line">
                        <p class="text-m" style="flex: 1">Soyadı</p>
                        <p class="text-m" style="flex: 4; justify-content: center"><%=user.getSurname()%></p>
                    </div>
                </div>
                <p class="text-m" style="flex: 1">E-Posta Adresi</p>
                <p class="text-m" style="flex: 2"><%=user.getEmail()%></p>
                <form id="customerDeleteForm" name="delete_customer" action="seller-customer-delete" method="POST">
                    <input type="hidden" name="customerId" value="<%=customer.getId()%>" >
                    <button type="submit" class="unhidden delete-customer-button">Müşteriyi Sil</button>
                    <button type="submit" class="hidden delete-customer-button"><img src="assets/icons/delete.png" height="10" width="10" alt="."></button>
                </form>
            </div>
        </div>
        <%
            }
        }else{
        %>
        <div class="sizedBox"></div>
        <p>Henüz hiç bir müşteriniz yoktur</p>
        <%
            }
        %>
    </div>
</section>