package com.example.one;

import java.sql.*;
import java.util.ResourceBundle;

public class DatabaseConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/";
    private static final String DB_NAME = "shopping_db";
    private static final String USER = "shop_user";
    private static final String PASSWORD = "password";

    public static Connection initializeDatabase() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        createDatabaseIfNotExists();
        return DriverManager.getConnection(URL + DB_NAME, USER, PASSWORD);
    }

    public static void createDatabaseIfNotExists() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
             Statement statement = connection.createStatement()) {
            String createDatabaseSQL = "CREATE DATABASE IF NOT EXISTS " + DB_NAME;
            statement.executeUpdate(createDatabaseSQL);
        }
    }

    private static Connection conn;

    public DatabaseConnection() {
    }

    public static Connection provideConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return conn;
    }

    public static void closeConnection(Connection con) {
        try { if (con != null && !con.isClosed()) {con.close(); } } catch (SQLException e) {e.printStackTrace(); }

    }
    public static void closeConnection(ResultSet rs) {
        try {
            if (rs != null && !rs.isClosed()) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void closeConnection(PreparedStatement ps) {
        try {
            if (ps != null && !ps.isClosed()) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void createTables() throws SQLException, ClassNotFoundException {
        try (Connection connection = initializeDatabase();
             Statement statement = connection.createStatement()) {

            String createUsersTableSQL = "CREATE TABLE IF NOT EXISTS users ("
                    + "id INT AUTO_INCREMENT PRIMARY KEY, "
                    + "name VARCHAR(50) NOT NULL, "
                    + "surname VARCHAR(50) NOT NULL, "
                    + "phone VARCHAR(20) NOT NULL, "
                    + "email VARCHAR(100) NOT NULL,"
                    + "password VARCHAR(50) NOT NULL, "
                    + "seller_status BOOLEAN NOT NULL DEFAULT FALSE, "
                    + "join_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP"
                    + ")";

            String createProductsTableSQL = "CREATE TABLE IF NOT EXISTS products (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "seller_id INT NOT NULL, " +
                    "name VARCHAR(100) NOT NULL, " +
                    "description TEXT, " +
                    "category VARCHAR(50), " +
                    "price DECIMAL(10, 2) NOT NULL, " +
                    "image LONGBLOB NULL DEFAULT NULL, " +
                    "added_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                    "FOREIGN KEY (seller_id) REFERENCES users(id)" +
                    ")";


            String createSellersTableSQL = "CREATE TABLE IF NOT EXISTS sellers ("
                    + "id INT AUTO_INCREMENT PRIMARY KEY, "
                    + "user_id INT NOT NULL, "
                    + "store_name VARCHAR(100) NOT NULL, "
                    + "store_number VARCHAR(20) NOT NULL, "
                    + "join_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"
                    + "FOREIGN KEY (user_id) REFERENCES users(id)"
                    + ")";

            String createOrdersTableSQL = "CREATE TABLE IF NOT EXISTS orders ("
                    + "id INT AUTO_INCREMENT PRIMARY KEY, "
                    + "user_id INT NOT NULL, "
                    + "order_number VARCHAR(50) NOT NULL, "
                    + "product_id INT NOT NULL, "
                    + "quantity INT NOT NULL, "
                    + "payment_method VARCHAR(50) NOT NULL, "
                    + "status VARCHAR(50) NOT NULL, "
                    + "created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
                    + "delivery_address TEXT NOT NULL, "
                    + "FOREIGN KEY (user_id) REFERENCES users(id), "
                    + "FOREIGN KEY (product_id) REFERENCES products(id)"
                    + ")";

            statement.execute(createUsersTableSQL);
            statement.execute(createProductsTableSQL);
            statement.execute(createSellersTableSQL);
            statement.execute(createOrdersTableSQL);

            System.out.println("Tables created successfully.");
        }
    }
}
