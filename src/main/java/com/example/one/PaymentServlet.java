package com.example.one;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

@WebServlet(name = "paymentServlet", urlPatterns = {"/payment-servlet"})
public class PaymentServlet extends HttpServlet {
}
