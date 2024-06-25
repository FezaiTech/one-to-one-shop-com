package com.example.one.service;

import com.example.one.beans.CustomerBean;

import java.util.List;

public interface CustomerService {

    public String addCustomer(CustomerBean customer);

    public String deleteCustomer(int customerId);

    public boolean checkCustomer(int sellerId,int userId);

    public List<CustomerBean> getCustomerForSeller(int sellerId);

    public List<CustomerBean> addCustomerForSeller(int sellerId);

}