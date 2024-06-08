package com.example.one.service.operations;

import com.example.one.DatabaseConnection;
import com.example.one.beans.OrderBean;
import com.example.one.service.OrderService;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class OrderOperations implements OrderService {
    @Override
    public String addOrder(OrderBean order) {
        String status = "fail";
        String sql = "INSERT INTO shopping_db.orders (user_id, order_number, product_id, quantity, payment_method, status, delivery_address) VALUES (?,?,?,?,?,?,?)";
        Connection con = DatabaseConnection.provideConnection();
        PreparedStatement ps = null;
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, order.getUserId());
            ps.setString(2, order.getOrderNumber());
            ps.setInt(3, order.getProductId());
            ps.setInt(4, order.getQuantity());
            ps.setString(5, order.getPaymentMethod());
            ps.setString(6, order.getStatus());
            ps.setString(7, order.getDeliveryAddress());
            int k = ps.executeUpdate();

            if (k > 0) {status = "ok";}
        } catch (SQLException e) {
            status = "Error: " + e.getMessage();
            e.printStackTrace();
        }
        DatabaseConnection.closeConnection(con);
        DatabaseConnection.closeConnection(ps);

        return status;
    }

    @Override
    public List<OrderBean> getAllOrdersForSeller(int productId) {
        return null;
    }

    @Override
    public List<OrderBean> getAllOrdersForUser(int userId) {
        return null;
    }

    @Override
    public int getLastOrderNumber() {
        int lastOrderNumber = 0;
        String query = "SELECT MAX(order_number) FROM shopping_db.orders";

        try (Connection conn = DatabaseConnection.provideConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                lastOrderNumber = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lastOrderNumber;
    }
}
