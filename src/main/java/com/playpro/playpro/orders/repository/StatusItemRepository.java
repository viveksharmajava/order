package com.playpro.playpro.orders.repository;

import com.playpro.playpro.orders.entity.StatusItem;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface StatusItemRepository extends JpaRepository<StatusItem, String> {

    List<StatusItem> findByStatusTypeIdOrderBySequenceId(String statusTypeId);
}
