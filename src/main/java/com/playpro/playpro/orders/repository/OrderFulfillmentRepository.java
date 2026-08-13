package com.playpro.playpro.orders.repository;

import com.playpro.playpro.orders.entity.OrderFulfillment;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderFulfillmentRepository extends JpaRepository<OrderFulfillment, String> {

    List<OrderFulfillment> findByOrderIdOrderByShipGroupSeqIdAsc(String orderId);

    long countByOrderId(String orderId);
}
