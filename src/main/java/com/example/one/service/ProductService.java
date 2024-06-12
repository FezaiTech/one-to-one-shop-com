package com.example.one.service;

import java.io.InputStream;
import java.math.BigDecimal;
import java.util.List;

import com.example.one.beans.ProductBean;

public interface ProductService {

    public String addProduct(int sellerId, String name, String description, String category, BigDecimal price,
                             InputStream image);

    public String addProduct(ProductBean product);

    public String removeProduct(int id);

    public String updateProduct(int prevProductId, ProductBean updatedProduct);

    public String updateProductPrice(int id, BigDecimal updatedPrice);

    public List<ProductBean> getAllProductsByCategory(String category, int maxResults);

    public List<ProductBean> searchAllProducts(String search);

    public byte[] getImage(int id);

    public ProductBean getProductDetails(int id);

    public String updateProductWithoutImage(int prevProductId, ProductBean updatedProduct);

    public double getProductPrice(int id);

}
