package com.playpro.playpro.orders.repository;

import com.playpro.playpro.orders.entity.QuoteRole;
import com.playpro.playpro.orders.entity.QuoteRoleId;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface QuoteRoleRepository extends JpaRepository<QuoteRole, QuoteRoleId> {

    List<QuoteRole> findByIdQuoteId(String quoteId);
}
