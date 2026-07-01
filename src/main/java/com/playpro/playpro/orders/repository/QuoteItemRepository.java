package com.playpro.playpro.orders.repository;

import com.playpro.playpro.orders.entity.QuoteItem;
import com.playpro.playpro.orders.entity.QuoteItemId;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface QuoteItemRepository extends JpaRepository<QuoteItem, QuoteItemId> {

    List<QuoteItem> findByIdQuoteIdOrderByIdQuoteItemSeqId(String quoteId);
}
