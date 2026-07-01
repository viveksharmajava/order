package com.playpro.playpro.orders.repository;

import com.playpro.playpro.orders.entity.OrderRole;
import com.playpro.playpro.orders.entity.OrderRoleId;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderRoleRepository extends JpaRepository<OrderRole, OrderRoleId> {

    List<OrderRole> findByIdOrderId(String orderId);
}
