package com.playpro.playpro.orders.service;

import com.playpro.playpro.orders.dto.CancelOrderRequest;
import com.playpro.playpro.orders.dto.CreateOrderRequest;
import com.playpro.playpro.orders.dto.OrderDto;
import com.playpro.playpro.orders.dto.OrderSearchRequest;
import com.playpro.playpro.orders.dto.UpdateOrderStatusRequest;
import org.springframework.data.domain.Page;

public interface OrderService {

    OrderDto createOrder(CreateOrderRequest request, String xUser);

    Page<OrderDto> findOrders(OrderSearchRequest request);

    OrderDto getOrder(String orderId);

    OrderDto cancelOrder(String orderId, CancelOrderRequest request, String xUser);

    OrderDto completeOrder(String orderId, String xUser);

    OrderDto updateOrderStatus(String orderId, UpdateOrderStatusRequest request, String xUser);
}
