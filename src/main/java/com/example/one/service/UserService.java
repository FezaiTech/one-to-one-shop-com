package com.example.one.service;

import com.example.one.beans.UserBean;

public interface UserService {

    public boolean registerUser(String name, String surname, String phone, String email, String password, boolean sellerStatus);

    public boolean registerUser(UserBean user);

    public boolean isRegistered(String email);

    public UserBean getUserDetails(String email);
    public UserBean getUserDetailsWithID(int userId);
    public String updateUserDetails(int userId, UserBean updateUser);

    public String updateUserForSeller(int userId, boolean newSellerStatus);

    public String getFName(String emailId);

}