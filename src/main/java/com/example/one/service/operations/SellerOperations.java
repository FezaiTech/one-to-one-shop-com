package com.example.one.service.operations;

import com.example.one.DatabaseConnection;
import com.example.one.beans.SellerBean;
import com.example.one.beans.UserBean;
import com.example.one.service.SellerService;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SellerOperations implements SellerService {
    @Override
    public String addSeller(SellerBean sellerInfo) {
        String status = "fail";
        String sql = "INSERT INTO shopping_db.sellers (user_id, store_name, store_number) VALUES (?, ?, ?)";
        Connection con = DatabaseConnection.provideConnection();
        PreparedStatement ps = null;
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, sellerInfo.getUserId());
            ps.setString(2, sellerInfo.getStoreName());
            ps.setString(3, sellerInfo.getStoreNumber());
            int k = ps.executeUpdate();

            if (k > 0) {
                status = "ok";
            } else {
                status = "fail";
            }
        } catch (SQLException e) {
            status = "Error: " + e.getMessage();
            e.printStackTrace();
        }
        DatabaseConnection.closeConnection(con);
        DatabaseConnection.closeConnection(ps);

        return status;
    }
    @Override
    public boolean updateSeller(int sellerId) {
        return false;
    }
    @Override
    public boolean deleteSeller(int sellerId) {
        return false;
    }

    @Override
    public SellerBean getSellerDetails(int userId){

        String sql = "SELECT * FROM shopping_db.sellers WHERE user_id = ?";
        try (Connection con = DatabaseConnection.provideConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    SellerBean user = new SellerBean(
                            rs.getInt("id"),
                            rs.getInt("user_id"),
                            rs.getString("store_name"),
                            rs.getString("store_number")
                    );
                    DatabaseConnection.closeConnection(rs);
                    return user;
                }
                DatabaseConnection.closeConnection(con);
                DatabaseConnection.closeConnection(ps);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
