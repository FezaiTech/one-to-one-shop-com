package com.example.one;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DatabaseOperations {
    private Connection connection;

    public DatabaseOperations(Connection connection) {
        this.connection = connection;
    }

    public boolean insertUser(String name, String surname, String phone, String email, String password, boolean isSeller) {
        String query = "INSERT INTO users (name, surname, phone, email, password, seller_status) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, name);
            pstmt.setString(2, surname);
            pstmt.setString(3, phone);
            pstmt.setString(4, email);
            pstmt.setString(5, password);
            pstmt.setBoolean(6, isSeller);
            int rows = pstmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean checkEmailExists(String email) throws SQLException {
        String checkEmailQuery = "SELECT * FROM users WHERE email = ?";
        try (PreparedStatement checkStmt = connection.prepareStatement(checkEmailQuery)) {
            checkStmt.setString(1, email);
            try (ResultSet rs = checkStmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    public static String loginUser(String email, String password) throws SQLException {
        String message;
        String query = "SELECT * FROM users WHERE email = ?";

        try (Connection conn = DatabaseConnection.initializeDatabase();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");
                if (storedPassword.equals(password)) {
                    message = "ok";
                } else {
                    message = "Şifre hatalı";
                }
            } else {
                message = "E-posta hatalı";
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new SQLException("Database error", e);
        }

        return message;
    }


    public boolean deleteUser(int userId) {
        String query = "DELETE FROM users WHERE id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            int rows = pstmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
