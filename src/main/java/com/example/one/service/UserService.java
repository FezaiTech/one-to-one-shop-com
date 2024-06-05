package com.example.one.service;

import com.example.one.beans.UserBean;

public interface UserService {

    public boolean registerUser(String name, String surname, String phone, String email, String password, boolean sellerStatus);

    public boolean registerUser(UserBean user);

    public boolean isRegistered(String email);

    public UserBean getUserDetails(String email, String password);

    public String getFName(String emailId);

}