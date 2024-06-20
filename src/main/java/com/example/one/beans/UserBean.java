package com.example.one.beans;

import java.security.Timestamp;

public class UserBean {
    private int id;
    private String name;
    private String surname;
    private String phone;
    private String email;
    private String password;
    private boolean sellerStatus;
    private Timestamp joinDate;

    // Constructor
    public UserBean() {}

    public UserBean(String name, String surname, String phone, String email, String password, boolean sellerStatus) {
        super();
        this.name = name;
        this.surname = surname;
        this.phone = phone;
        this.email = email;
        this.password = password;
        this.sellerStatus = sellerStatus;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isSellerStatus() {
        return sellerStatus;
    }

    public void setSellerStatus(boolean sellerStatus) {
        this.sellerStatus = sellerStatus;
    }

    public boolean getSellerStatus() {return sellerStatus;}

    public Timestamp getJoinDate() {
        return joinDate;
    }

    public void setJoinDate(Timestamp joinDate) {
        this.joinDate = joinDate;
    }
}
