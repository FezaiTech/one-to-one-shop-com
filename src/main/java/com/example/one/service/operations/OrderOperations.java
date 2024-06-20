package com.example.one.service.operations;

import com.example.one.DatabaseConnection;
import com.example.one.beans.OrderBean;
import com.example.one.beans.ProductBean;
import com.example.one.service.OrderService;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
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
    public List<OrderBean> getAllOrdersForSeller(int sellerId) {
        String sql = "SELECT " +
                "o.id, o.user_id, o.order_number, o.product_id, o.quantity, o.payment_method, o.status, o.delivery_address, o.created_date " +
                "FROM shopping_db.orders o " +
                "JOIN shopping_db.products p ON o.product_id = p.id " +
                "JOIN shopping_db.users u ON o.user_id = u.id " +
                "WHERE p.seller_id = ?";
        List<OrderBean> orderList = new ArrayList<>();

        try (Connection con = DatabaseConnection.provideConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            if (con == null) {
                throw new SQLException("Failed to establish a database connection.");
            }

            ps.setInt(1, sellerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderBean order = new OrderBean(
                            rs.getInt("user_id"),
                            rs.getString("order_number"),
                            rs.getInt("product_id"),
                            rs.getInt("quantity"),
                            rs.getString("payment_method"),
                            rs.getString("status"),
                            rs.getString("delivery_address")
                    );
                    order.setId(rs.getInt("id"));
                    order.setCreatedDate(rs.getTimestamp("created_date"));
                    orderList.add(order);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderList;
    }

    @Override
    public List<OrderBean> getAllOrdersForUser(int userId) {
        String sql = "SELECT * FROM shopping_db.orders WHERE user_id = ?";
        List<OrderBean> orderList = new ArrayList<>();

        try (Connection con = DatabaseConnection.provideConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            if (con == null) {
                throw new SQLException("Failed to establish a database connection.");
            }
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    //other way is set
                    OrderBean order = new OrderBean(
                            rs.getInt("user_id"),
                            rs.getString("order_number"),
                            rs.getInt("product_id"),
                            rs.getInt("quantity"),
                            rs.getString("payment_method"),
                            rs.getString("status"),
                            rs.getString("delivery_address")
                    );
                    order.setId(rs.getInt("id"));
                    order.setCreatedDate(rs.getTimestamp("created_date"));
                    orderList.add(order);
                }
                DatabaseConnection.closeConnection(rs);
            }
            DatabaseConnection.closeConnection(con);
            DatabaseConnection.closeConnection(ps);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderList;
    }

    public String updateOrder(int orderId,OrderBean order){
        return "";
    }

    public String updateOrderStatus(int orderId, String newStatus){
        String sql = "UPDATE shopping_db.orders SET status = ? WHERE id = ?";
        try (Connection con = DatabaseConnection.provideConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, orderId);

            int rowsAffected = ps.executeUpdate();
            DatabaseConnection.closeConnection(con);
            DatabaseConnection.closeConnection(ps);
            return rowsAffected > 0 ? "ok" : "Product not found.";
        } catch (SQLException e) {
            e.printStackTrace();
            return "Error updating product.";
        }
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
