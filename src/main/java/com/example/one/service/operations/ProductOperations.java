package com.example.one.service.operations;

import com.example.one.DatabaseConnection;
import com.example.one.beans.ProductBean;
import com.example.one.service.ProductService;

import java.io.InputStream;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class ProductOperations implements ProductService {
    @Override
    public String addProduct(int sellerId, String name, String description, String category, BigDecimal price, InputStream image) {
        return null;
    }

    @Override
    public String addProduct(ProductBean product) {
        String status = "fail";

        Connection con = DatabaseConnection.provideConnection();
        PreparedStatement ps = null;

        try {
            ps = con.prepareStatement("insert into products values(?,?,?,?,?,?);");
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
        return null;
    }

    @Override
    public String updateProduct(int prevProductId, ProductBean updatedProduct) {
        return null;
    }

    @Override
    public String updateProductPrice(int id, BigDecimal updatedPrice) {
        return null;
    }

    @Override
    public List<ProductBean> getAllProducts() {
        return null;
    }

    @Override
    public List<ProductBean> getAllProductsByCategory(String category) {
        return null;
    }

    @Override
    public List<ProductBean> searchAllProducts(String search) {
        return null;
    }

    @Override
    public byte[] getImage(String id) {
        return new byte[0];
    }

    @Override
    public ProductBean getProductDetails(String id) {
        return null;
    }

    @Override
    public String updateProductWithoutImage(String prevProductId, ProductBean updatedProduct) {
        return null;
    }

    @Override
    public double getProductPrice(String id) {
        return 0;
    }
}
