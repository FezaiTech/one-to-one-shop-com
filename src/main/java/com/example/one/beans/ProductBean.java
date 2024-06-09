package com.example.one.beans;

import java.math.BigDecimal;
import java.security.Timestamp;
import java.io.InputStream;
import java.io.Serializable;
public class ProductBean implements Serializable {
    private int id;
    private int sellerId;
    private String name;
    private String description;
    private String category;
    private BigDecimal price;
    private InputStream image;
    private Timestamp addedDate;

    // Constructor
    public ProductBean() {}

    public ProductBean(int sellerId, String name, String description, String category, BigDecimal price, InputStream image) {
        super();
        this.sellerId = sellerId;
        this.name = name;
        this.description = description;
        this.category = category;
        this.price = price;
        this.image = image;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getSellerId() {
        return sellerId;
    }

    public void setSellerId(int sellerId) {
        this.sellerId = sellerId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public InputStream getImage() {
        return image;
    }

    public void setImage(InputStream image) {
        this.image = image;
    }

    public Timestamp getAddedDate() {
        return addedDate;
    }

    public void setAddedDate(Timestamp addedDate) {
        this.addedDate = addedDate;
    }
}
