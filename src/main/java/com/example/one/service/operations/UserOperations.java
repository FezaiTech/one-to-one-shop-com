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
    public String registerUser(String name, String surname, String phone, String email, String password, boolean sellerStatus) {
        return null;
    }

    @Override
    public String registerUser(UserBean user) {
        return null;
    }

    @Override
    public boolean isRegistered(String email) {
        String sql = "SELECT * FROM shopping_db.users WHERE email = ?";
        try (Connection con = DatabaseConnection.provideConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            } catch (SQLException e) {
                throw new RuntimeException(e);
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
