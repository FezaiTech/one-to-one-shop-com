package com.example.one.service;

import com.example.one.beans.SellerBean;
import com.example.one.beans.UserBean;

public interface SellerService {

    public String addSeller(SellerBean sellerInfo);

    public  String updateSeller(int sellerId, SellerBean newSellerInfo);

    public  String deleteSeller(SellerBean seller);

    public SellerBean getSellerDetails(int userId);
}
