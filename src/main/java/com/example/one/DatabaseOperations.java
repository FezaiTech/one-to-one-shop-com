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
