package com.example.one.service;

import com.example.one.beans.UserBean;

public interface UserService {

    public String registerUser(String name, String surname, String phone, String email, String password, boolean sellerStatus);

    public String registerUser(UserBean user);

    public boolean isRegistered(String emailId);

    public UserBean getUserDetails(String email, String password);

    public String getFName(String emailId);

}