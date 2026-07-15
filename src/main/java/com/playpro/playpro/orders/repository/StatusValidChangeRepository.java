package com.playpro.playpro.orders.repository;

import com.playpro.playpro.orders.entity.StatusValidChange;
import com.playpro.playpro.orders.entity.StatusValidChangeId;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface StatusValidChangeRepository extends JpaRepository<StatusValidChange, StatusValidChangeId> {

    List<StatusValidChange> findByIdStatusIdOrderByIdStatusIdTo(String statusId);
}
