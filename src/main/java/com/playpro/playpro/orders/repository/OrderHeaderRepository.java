package com.playpro.playpro.orders.repository;

import com.playpro.playpro.orders.entity.OrderHeader;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface OrderHeaderRepository extends JpaRepository<OrderHeader, String>, JpaSpecificationExecutor<OrderHeader> {
}
