package com.example.one.service;

import java.util.List;

import com.example.one.beans.OrderBean;

public interface OrderService {

    public String addOrder(OrderBean order);

    public List<OrderBean> getAllOrdersForSeller(int productId);

    public List<OrderBean> getAllOrdersForUser(int userId);

    public int getLastOrderNumber();

}