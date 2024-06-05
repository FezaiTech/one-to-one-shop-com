package com.example.one.beans;

import java.security.Timestamp;

public class OrderBean {
    private int id;
    private int userId;
    private String orderNumber;
    private int productId;
    private int quantity;
    private String paymentMethod;
    private String status;
    private Timestamp createdDate;
    private String deliveryAddress;

    // Constructor
    public OrderBean() {}

    public OrderBean(int userId, String orderNumber, int productId, int quantity, String paymentMethod, String status, String deliveryAddress) {
        super();
        this.userId = userId;
        this.orderNumber = orderNumber;
        this.productId = productId;
        this.quantity = quantity;
        this.paymentMethod = paymentMethod;
        this.status = status;
        this.deliveryAddress = deliveryAddress;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getOrderNumber() {
        return orderNumber;
    }

    public void setOrderNumber(String orderNumber) {
        this.orderNumber = orderNumber;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }

    public String getDeliveryAddress() {
        return deliveryAddress;
    }

    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }
}
