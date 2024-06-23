package com.example.one.beans;

import java.sql.Timestamp;

public class CustomerBean {
    private int id;
    private int sellerId;
    private int userId;

    private Timestamp createdDate;

    public CustomerBean() {}

    public CustomerBean(int userId, int sellerId) {
        super();
        this.sellerId = sellerId;
        this.userId = userId;
    }
    public int getId() {
        return id;
    }
    public  void setId(int id){
        this.id = id;
    }
    // Getters and Setters
    public int getSellerId() {
        return sellerId;
    }
    public void setSellerId(int sellerId) {
        this.sellerId = sellerId;
    }
    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {this.userId = userId;}

    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }

    public Timestamp getCreatedDate() {
        return createdDate;
    }
}
