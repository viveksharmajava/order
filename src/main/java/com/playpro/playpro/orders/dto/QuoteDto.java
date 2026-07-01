package com.playpro.playpro.orders.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class QuoteDto {

    private String quoteId;
    private String quoteTypeId;
    private String partyId;
    private LocalDateTime issueDate;
    private String statusId;
    private String currencyUomId;
    private String quoteName;
    private String description;
    private LocalDateTime validFromDate;
    private LocalDateTime validThruDate;
    private String productStoreId;
    private List<QuoteItemDto> items = new ArrayList<>();

    public String getQuoteId() {
        return quoteId;
    }

    public void setQuoteId(String quoteId) {
        this.quoteId = quoteId;
    }

    public String getQuoteTypeId() {
        return quoteTypeId;
    }

    public void setQuoteTypeId(String quoteTypeId) {
        this.quoteTypeId = quoteTypeId;
    }

    public String getPartyId() {
        return partyId;
    }

    public void setPartyId(String partyId) {
        this.partyId = partyId;
    }

    public LocalDateTime getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(LocalDateTime issueDate) {
        this.issueDate = issueDate;
    }

    public String getStatusId() {
        return statusId;
    }

    public void setStatusId(String statusId) {
        this.statusId = statusId;
    }

    public String getCurrencyUomId() {
        return currencyUomId;
    }

    public void setCurrencyUomId(String currencyUomId) {
        this.currencyUomId = currencyUomId;
    }

    public String getQuoteName() {
        return quoteName;
    }

    public void setQuoteName(String quoteName) {
        this.quoteName = quoteName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDateTime getValidFromDate() {
        return validFromDate;
    }

    public void setValidFromDate(LocalDateTime validFromDate) {
        this.validFromDate = validFromDate;
    }

    public LocalDateTime getValidThruDate() {
        return validThruDate;
    }

    public void setValidThruDate(LocalDateTime validThruDate) {
        this.validThruDate = validThruDate;
    }

    public String getProductStoreId() {
        return productStoreId;
    }

    public void setProductStoreId(String productStoreId) {
        this.productStoreId = productStoreId;
    }

    public List<QuoteItemDto> getItems() {
        return items;
    }

    public void setItems(List<QuoteItemDto> items) {
        this.items = items;
    }
}
