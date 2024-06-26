package com.example.one.service;

import java.util.List;

import com.example.one.beans.OrderBean;

public interface OrderService {

    public String addOrder(OrderBean order);

    public List<OrderBean> getAllOrdersForSeller(int sellerID);

    public List<OrderBean> getAllOrdersForUser(int userId);

    public String updateOrder(int orderId,OrderBean order);

    public String updateOrderStatus(int orderId, String newStatus);
    public String analyzingStatus(String status);
    public int getLastOrderNumber();

}