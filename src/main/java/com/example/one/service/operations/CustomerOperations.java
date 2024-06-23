package com.example.one.service.operations;

import com.example.one.DatabaseConnection;
import com.example.one.beans.CustomerBean;
import com.example.one.service.CustomerService;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CustomerOperations implements CustomerService {
    @Override
    public String addCustomer(CustomerBean customer) {
        String status = "fail";
        String sql = "INSERT INTO shopping_db.customers (user_id, seller_id) VALUES (?,?)";
        Connection con = DatabaseConnection.provideConnection();
        PreparedStatement ps = null;
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, customer.getUserId());
            ps.setInt(2, customer.getSellerId());
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
    public String deleteCustomer(int customerId) {
        String sql = "DELETE FROM shopping_db.customers WHERE id = ?";
        try (Connection con = DatabaseConnection.provideConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            int rowsAffected = ps.executeUpdate();
            DatabaseConnection.closeConnection(con);
            DatabaseConnection.closeConnection(ps);
            return rowsAffected > 0 ? "ok" : "Customer not found.";
        } catch (SQLException e) {
            e.printStackTrace();
            return "Error removing customer.";
        }
    }
    @Override
    public boolean checkCustomer(int sellerId, int userId) {
        String sql = "SELECT * FROM shopping_db.customers WHERE seller_id = ? AND user_id = ?";
        try (Connection con = DatabaseConnection.provideConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, sellerId);
            ps.setInt(2, userId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<CustomerBean> getCustomerForSeller(int sellerId) {
        String sql = "SELECT * FROM shopping_db.customers WHERE seller_id = ?";
        List<CustomerBean> customerList = new ArrayList<>();

        try (Connection con = DatabaseConnection.provideConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            if (con == null) {
                throw new SQLException("Failed to establish a database connection.");
            }
            ps.setInt(1, sellerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CustomerBean customer = new CustomerBean(
                            rs.getInt("user_id"),
                            rs.getInt("seller_id")
                    );
                    customer.setId(rs.getInt("id"));
                    customer.setUserId(rs.getInt("user_id"));
                    customer.setSellerId(rs.getInt("seller_id"));
                    customer.setCreatedDate(rs.getTimestamp("join_date"));
                    customerList.add(customer);
                }
                DatabaseConnection.closeConnection(rs);
            }
            DatabaseConnection.closeConnection(con);
            DatabaseConnection.closeConnection(ps);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return customerList;
    }
}
