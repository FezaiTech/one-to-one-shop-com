package com.example.one.service.operations;

import com.example.one.beans.CartBean;
import com.example.one.service.CartService;

import java.util.List;

public class CartOperations implements CartService {

    @Override
    public CartBean addItemToCart(int productId, int count) {
        CartBean newItem = new CartBean();
        newItem.setProductId(productId);
        newItem.setCount(count);
        return newItem;
    }

    @Override
    public List<CartBean> getAllCartItems() {
        return null;
    }

    @Override
    public boolean removeAllItemFromCart() {
        return false;
    }

    @Override
    public boolean removeItemFromCart(int productId) {
        return false;
    }

    @Override
    public boolean decreaseItemFromCart(int productId) {
        return false;
    }
}
