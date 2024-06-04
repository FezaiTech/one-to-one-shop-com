package com.example.one;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class DatabaseConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/shopping_db";
    private static final String USER = "shop_user";
    private static final String PASSWORD = "password";

    public static Connection initializeDatabase() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    public static void createTable() throws SQLException, ClassNotFoundException {
        String createTableSQL = "CREATE TABLE IF NOT EXISTS users ("
                + "id INT AUTO_INCREMENT PRIMARY KEY, "
                + "name VARCHAR(50) NOT NULL, "
                + "surname VARCHAR(50) NOT NULL, "
                + "phone VARCHAR(20) NOT NULL, "
                + "email VARCHAR(100) NOT NULL,"
                + "password VARCHAR(50) NOT NULL"
                + ")";

        try (Connection connection = initializeDatabase();
             Statement statement = connection.createStatement()) {

            statement.execute(createTableSQL);
            System.out.println("Table 'users' created successfully.");
        }
    }
}
