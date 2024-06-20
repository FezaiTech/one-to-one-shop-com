package com.example.one.beans;

import java.security.Timestamp;

public class SellerBean {
    private int id;
    private int userId;
    private String storeName;
    private String storeNumber;
    private Timestamp joinDate;

    // Constructor
    public SellerBean() {}

    public SellerBean(int id, int userId, String storeName, String storeNumber) {
        super();
        this.id = id;
        this.userId = userId;
        this.storeName = storeName;
        this.storeNumber = storeNumber;
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

    public String getStoreName() {
        return storeName;
    }

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    public String getStoreNumber() {
        return storeNumber;
    }

    public void setStoreNumber(String storeNumber) {
        this.storeNumber = storeNumber;
    }

    public Timestamp getJoinDate() {
        return joinDate;
    }

    public void setJoinDate(Timestamp joinDate) {
        this.joinDate = joinDate;
    }
}
