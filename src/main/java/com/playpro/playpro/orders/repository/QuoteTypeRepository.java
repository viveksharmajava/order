package com.playpro.playpro.orders.repository;

import com.playpro.playpro.orders.entity.QuoteType;
import org.springframework.data.jpa.repository.JpaRepository;

public interface QuoteTypeRepository extends JpaRepository<QuoteType, String> {
}
