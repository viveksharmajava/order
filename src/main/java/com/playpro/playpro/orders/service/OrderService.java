package com.playpro.playpro.orders.service;

import com.playpro.playpro.orders.dto.CancelOrderRequest;
import com.playpro.playpro.orders.dto.CreateOrderRequest;
import com.playpro.playpro.orders.dto.OrderDto;
import com.playpro.playpro.orders.dto.OrderSearchRequest;
import org.springframework.data.domain.Page;

public interface OrderService {

    OrderDto createOrder(CreateOrderRequest request, String principal);

    Page<OrderDto> findOrders(OrderSearchRequest request);

    OrderDto getOrder(String orderId);

    OrderDto cancelOrder(String orderId, CancelOrderRequest request, String principal);
}
