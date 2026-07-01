package com.playpro.playpro.orders.mapper;

import com.playpro.playpro.orders.dto.CreateQuoteRequest;
import com.playpro.playpro.orders.dto.QuoteDto;
import com.playpro.playpro.orders.dto.QuoteItemDto;
import com.playpro.playpro.orders.entity.Quote;
import com.playpro.playpro.orders.entity.QuoteItem;

import java.util.List;
import java.util.stream.Collectors;

public final class QuoteMapper {

    private QuoteMapper() {
    }

    public static QuoteDto toDto(Quote quote, List<QuoteItem> items) {
        QuoteDto dto = new QuoteDto();
        dto.setQuoteId(quote.getQuoteId());
        dto.setQuoteTypeId(quote.getQuoteTypeId());
        dto.setPartyId(quote.getPartyId());
        dto.setIssueDate(quote.getIssueDate());
        dto.setStatusId(quote.getStatusId());
        dto.setCurrencyUomId(quote.getCurrencyUomId());
        dto.setQuoteName(quote.getQuoteName());
        dto.setDescription(quote.getDescription());
        dto.setValidFromDate(quote.getValidFromDate());
        dto.setValidThruDate(quote.getValidThruDate());
        dto.setProductStoreId(quote.getProductStoreId());
        if (items != null) {
            dto.setItems(items.stream().map(QuoteMapper::toItemDto).collect(Collectors.toList()));
        }
        return dto;
    }

    public static QuoteItemDto toItemDto(QuoteItem item) {
        QuoteItemDto dto = new QuoteItemDto();
        dto.setQuoteItemSeqId(item.getId().getQuoteItemSeqId());
        dto.setProductId(item.getProductId());
        dto.setQuantity(item.getQuantity());
        dto.setQuoteUnitPrice(item.getQuoteUnitPrice());
        return dto;
    }

    public static void applyCreateRequest(CreateQuoteRequest request, Quote quote, String quoteId) {
        quote.setQuoteId(quoteId);
        quote.setQuoteTypeId("PRODUCT_QUOTE");
        quote.setPartyId(request.getPartyId());
        quote.setQuoteName(request.getQuoteName());
        quote.setDescription(request.getDescription());
        quote.setCurrencyUomId(request.getCurrencyUomId() != null ? request.getCurrencyUomId() : "USD");
        quote.setProductStoreId(request.getProductStoreId());
        quote.setValidFromDate(request.getValidFromDate());
        quote.setValidThruDate(request.getValidThruDate());
        String statusId = request.getStatusId();
        if (statusId == null || statusId.trim().isEmpty()) {
            statusId = "QUO_CREATED";
        }
        quote.setStatusId(statusId);
    }
}
