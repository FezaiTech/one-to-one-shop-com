package com.example.one.service.operations;

import com.example.one.DatabaseConnection;
import com.example.one.beans.ProductBean;
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
    public UserBean getUserDetails(String email) {
        String sql = "SELECT * FROM shopping_db.users WHERE email = ?";
        try (Connection con = DatabaseConnection.provideConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    UserBean user = new UserBean(
                            rs.getString("name"),
                            rs.getString("surname"),
                            rs.getString("phone"),
                            rs.getString("email"),
                            rs.getString("password"),
                            rs.getBoolean("seller_status")
                    );
                    user.setId(rs.getInt("id"));
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


    public String updateUserDetails(int userId, UserBean updateUser){

        String sql = "UPDATE shopping_db.users SET name = ?, surname = ?, phone = ?, email = ?, password = ?, seller_status = ? WHERE id = ?";
        try (Connection con = DatabaseConnection.provideConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, updateUser.getName());
            ps.setString(2, updateUser.getSurname());
            ps.setString(3, updateUser.getPhone());
            ps.setString(4, updateUser.getEmail());
            ps.setString(5, updateUser.getPassword());
            ps.setBoolean(6, updateUser.getSellerStatus());
            ps.setInt(7, userId);

            int rowsAffected = ps.executeUpdate();
            DatabaseConnection.closeConnection(con);
            DatabaseConnection.closeConnection(ps);
            return rowsAffected > 0 ? "ok" : "Product not found.";
        } catch (SQLException e) {
            e.printStackTrace();
            return "Error updating product.";
        }
    }

    public String updateUserForSeller(int userId, boolean newSellerStatus){
        String sql = "UPDATE shopping_db.users SET seller_status = ? WHERE id = ?";
        try (Connection con = DatabaseConnection.provideConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setBoolean(1, newSellerStatus);
            ps.setInt(2, userId);

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
    public String getFName(String email) {
        return null;
    }
}
