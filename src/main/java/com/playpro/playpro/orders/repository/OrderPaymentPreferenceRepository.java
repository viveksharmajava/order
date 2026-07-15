package com.playpro.playpro.orders.repository;

import com.playpro.playpro.orders.entity.OrderPaymentPreference;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderPaymentPreferenceRepository extends JpaRepository<OrderPaymentPreference, String> {

    List<OrderPaymentPreference> findByOrderId(String orderId);
}
