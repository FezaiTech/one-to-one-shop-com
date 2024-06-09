package com.example.one.service;

import com.example.one.beans.SellerBean;
import com.example.one.beans.UserBean;

public interface SellerService {

    public String addSeller(SellerBean sellerInfo);

    public  boolean updateSeller(int sellerId);

    public  boolean deleteSeller(int sellerId);

    public SellerBean getSellerDetails(int userId);
}
