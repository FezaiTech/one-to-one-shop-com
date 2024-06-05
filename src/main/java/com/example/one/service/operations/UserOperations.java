package com.example.one.service.operations;

import com.example.one.DatabaseConnection;
import com.example.one.beans.UserBean;
import com.example.one.service.UserService;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserOperations implements UserService {
    @Override
    public boolean registerUser(String name, String surname, String phone, String email, String password, boolean sellerStatus) {
        String sql = "INSERT INTO shopping_db.users (name, surname, phone, email, password, seller_status) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = DatabaseConnection.provideConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, surname);
            ps.setString(3, phone);
            ps.setString(4, email);
            ps.setString(5, password);
            ps.setBoolean(6, sellerStatus);
            int rows = ps.executeUpdate();
            DatabaseConnection.closeConnection(con);
            DatabaseConnection.closeConnection(ps);
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean registerUser(UserBean user) {
        return false;
    }

    @Override
    public boolean isRegistered(String email) {
        String sql = "SELECT * FROM shopping_db.users WHERE email = ?";
        try (Connection con = DatabaseConnection.provideConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public UserBean getUserDetails(String email, String password) {
        return null;
    }

    @Override
    public String getFName(String email) {
        return null;
    }
}