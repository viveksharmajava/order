package com.playpro.playpro.orders.repository;

import com.playpro.playpro.orders.entity.OrderStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderStatusRepository extends JpaRepository<OrderStatus, String> {

    List<OrderStatus> findByOrderIdOrderByStatusDatetimeDesc(String orderId);
}
