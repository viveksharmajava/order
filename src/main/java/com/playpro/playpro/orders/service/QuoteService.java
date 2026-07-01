package com.playpro.playpro.orders.service;

import com.playpro.playpro.orders.dto.CreateQuoteRequest;
import com.playpro.playpro.orders.dto.QuoteDto;
import com.playpro.playpro.orders.dto.QuoteSearchRequest;
import org.springframework.data.domain.Page;

public interface QuoteService {

    QuoteDto createQuote(CreateQuoteRequest request, String principal);

    Page<QuoteDto> findQuotes(QuoteSearchRequest request);

    QuoteDto getQuote(String quoteId);
}
