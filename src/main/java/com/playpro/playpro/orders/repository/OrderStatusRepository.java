package com.playpro.playpro.orders.repository;

import com.playpro.playpro.orders.entity.OrderStatus;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderStatusRepository extends JpaRepository<OrderStatus, String> {
}
