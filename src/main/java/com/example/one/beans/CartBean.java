package com.example.one.beans;

public class CartBean {
    private int productId;
    private int count;

    public CartBean() {}

    public CartBean(int productId, int count) {
        super();
        this.productId = productId;
        this.count = count;
    }

    // Getters and Setters
    public int getProductIdId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {this.count = count;}
}
