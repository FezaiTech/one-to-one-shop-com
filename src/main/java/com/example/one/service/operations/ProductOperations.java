package com.example.one.service.operations;

import com.example.one.DatabaseConnection;
import com.example.one.beans.ProductBean;
import com.example.one.service.ProductService;

import java.io.InputStream;
import java.math.BigDecimal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

public class ProductOperations implements ProductService {
    @Override
    public String addProduct(int sellerId, String name, String description, String category, BigDecimal price, InputStream image) {
        return null;
    }

    @Override
    public String addProduct(ProductBean product) {
        String status = "fail";
        String sql = "INSERT INTO shopping_db.products values(?,?,?,?,?,?);";
        Connection con = DatabaseConnection.provideConnection();
        PreparedStatement ps = null;
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, product.getSellerId());
            ps.setString(2, product.getName());
            ps.setString(3, product.getDescription());
            ps.setString(4, product.getCategory());
            ps.setBigDecimal(5, product.getPrice());
            ps.setBlob(6, product.getImage());
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
    public String removeProduct(int id) {
        String sql = "DELETE FROM shopping_db.products WHERE id = ?";
        try (Connection con = DatabaseConnection.provideConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            int rowsAffected = ps.executeUpdate();
            DatabaseConnection.closeConnection(con);
            DatabaseConnection.closeConnection(ps);
            return rowsAffected > 0 ? "ok" : "Product not found.";
        } catch (SQLException e) {
            e.printStackTrace();
            return "Error removing product.";
        }
    }

    @Override
    public String updateProduct(int prevProductId, ProductBean updatedProduct) {
        String sql = "UPDATE shopping_db.products SET name = ?, description = ?, category = ?, price = ?, image = ? WHERE id = ?";
        try (Connection con = DatabaseConnection.provideConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, updatedProduct.getName());
            ps.setString(2, updatedProduct.getDescription());
            ps.setString(3, updatedProduct.getCategory());
            ps.setBigDecimal(4, updatedProduct.getPrice());
            ps.setBlob(5, updatedProduct.getImage());
            ps.setInt(6, prevProductId);
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
    public String updateProductPrice(int id, BigDecimal updatedPrice) {
        String sql = "UPDATE shopping_db.products SET price = ? WHERE id = ?";
        try (Connection con = DatabaseConnection.provideConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setBigDecimal(1, updatedPrice);
            ps.setInt(2, id);
            int rowsAffected = ps.executeUpdate();
            DatabaseConnection.closeConnection(con);
            DatabaseConnection.closeConnection(ps);
            return rowsAffected > 0 ? "ok" : "Product not found.";
        } catch (SQLException e) {
            e.printStackTrace();
            return "Error updating product price.";
        }
    }

    @Override
    public List<ProductBean> getAllProductsByCategory(String category) {
        String sql = "SELECT * FROM shopping_db.products WHERE category = ?";
        List<ProductBean> productList = new ArrayList<>();

        try (Connection con = DatabaseConnection.provideConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            if (con == null) {
                throw new SQLException("Failed to establish a database connection.");
            }
            ps.setString(1, category);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    //other way is set
                    ProductBean product = new ProductBean(
                            rs.getInt("seller_id"),
                            rs.getString("name"),
                            rs.getString("description"),
                            rs.getString("category"),
                            rs.getBigDecimal("price"),
                            rs.getBlob("image") != null ? rs.getBlob("image").getBinaryStream() : null
                    );
                    product.setId(rs.getInt("id"));
                    productList.add(product);
                }
                DatabaseConnection.closeConnection(rs);
            }
            DatabaseConnection.closeConnection(con);
            DatabaseConnection.closeConnection(ps);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return productList;
    }

    @Override
    public List<ProductBean> searchAllProducts(String search) {
        String sql = "SELECT * FROM shopping_db.products WHERE name LIKE ? OR description LIKE ?";
        List<ProductBean> productList = new ArrayList<>();
        try (Connection con = DatabaseConnection.provideConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + search + "%");
            ps.setString(2, "%" + search + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ProductBean product = new ProductBean(
                            rs.getInt("seller_id"),
                            rs.getString("name"),
                            rs.getString("description"),
                            rs.getString("category"),
                            rs.getBigDecimal("price"),
                            rs.getBlob("image").getBinaryStream()
                    );
                    product.setId(rs.getInt("id"));
                    productList.add(product);
                }
                DatabaseConnection.closeConnection(rs);
            }
            DatabaseConnection.closeConnection(con);
            DatabaseConnection.closeConnection(ps);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }

    @Override
    public byte[] getImage(int id) {
        return new byte[0];
    }

    @Override
    public ProductBean getProductDetails(int id) {
        String sql = "SELECT * FROM shopping_db.products WHERE id = ?";
        try (Connection con = DatabaseConnection.provideConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    ProductBean product = new ProductBean(
                            rs.getInt("seller_id"),
                            rs.getString("name"),
                            rs.getString("description"),
                            rs.getString("category"),
                            rs.getBigDecimal("price"),
                            rs.getBlob("image").getBinaryStream()
                    );
                    product.setId(rs.getInt("id"));
                    DatabaseConnection.closeConnection(rs);
                    return product;
                }
                DatabaseConnection.closeConnection(con);
                DatabaseConnection.closeConnection(ps);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public String updateProductWithoutImage(int prevProductId, ProductBean updatedProduct) {
        return null;
    }

    @Override
    public double getProductPrice(int id) {
        return 0;
    }
}
