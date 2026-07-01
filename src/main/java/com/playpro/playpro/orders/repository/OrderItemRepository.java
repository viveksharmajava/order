package com.playpro.playpro.orders.repository;

import com.playpro.playpro.orders.entity.OrderItem;
import com.playpro.playpro.orders.entity.OrderItemId;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderItemRepository extends JpaRepository<OrderItem, OrderItemId> {

    List<OrderItem> findByIdOrderIdOrderByIdOrderItemSeqId(String orderId);
}
