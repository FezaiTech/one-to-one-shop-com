package com.example.one.service;

import com.example.one.beans.UserBean;

import java.util.List;

public interface UserService {

    public String loginUser(String email, String password);

    public boolean registerUser(String name, String surname, String phone, String email, String password, boolean sellerStatus);

    public boolean registerUser(UserBean user);

    public boolean isRegistered(String email);

    public UserBean getUserDetails(String email);

    public UserBean getUserDetailsWithID(int userId);

    public String updateUserDetails(int userId, UserBean updateUser);

    public String updateUserForSeller(int userId, boolean newSellerStatus);

    public boolean deleteUser(int userId);
    public List<UserBean> getAllUser();
    public String getFName(String emailId);

}