package com.example.one.service;

import com.example.one.beans.CartBean;


import java.util.List;

public interface CartService {

    public CartBean addItemToCart(int productId, int count);

    public List<CartBean> getAllCartItems();

    public boolean removeAllItemFromCart();

    public boolean removeItemFromCart(int productId);

    public boolean decreaseItemFromCart(int productId);
}
