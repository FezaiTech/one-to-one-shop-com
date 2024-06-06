package com.example.one.service;

import com.example.one.beans.SellerBean;

public interface SellerService {

    public boolean addSeller(SellerBean order);

    public  boolean updateUserToSeller(int userId);
}
