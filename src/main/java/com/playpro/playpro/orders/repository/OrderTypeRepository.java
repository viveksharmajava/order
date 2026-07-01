package com.playpro.playpro.orders.repository;

import com.playpro.playpro.orders.entity.OrderType;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderTypeRepository extends JpaRepository<OrderType, String> {
}
