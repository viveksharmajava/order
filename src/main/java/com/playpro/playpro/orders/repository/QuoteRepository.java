package com.playpro.playpro.orders.repository;

import com.playpro.playpro.orders.entity.Quote;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface QuoteRepository extends JpaRepository<Quote, String>, JpaSpecificationExecutor<Quote> {
}
