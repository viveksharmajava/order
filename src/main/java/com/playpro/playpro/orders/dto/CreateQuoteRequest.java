package com.playpro.playpro.orders.dto;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class CreateQuoteRequest {

    private String partyId;
    private String quoteName;
    private String description;
    private String currencyUomId;
    private String productStoreId;
    private String statusId;
    private LocalDateTime validFromDate;
    private LocalDateTime validThruDate;
    private List<QuoteItemDto> items = new ArrayList<>();

    public String getPartyId() {
        return partyId;
    }

    public void setPartyId(String partyId) {
        this.partyId = partyId;
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

    public String getCurrencyUomId() {
        return currencyUomId;
    }

    public void setCurrencyUomId(String currencyUomId) {
        this.currencyUomId = currencyUomId;
    }

    public String getProductStoreId() {
        return productStoreId;
    }

    public void setProductStoreId(String productStoreId) {
        this.productStoreId = productStoreId;
    }

    public String getStatusId() {
        return statusId;
    }

    public void setStatusId(String statusId) {
        this.statusId = statusId;
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

    public List<QuoteItemDto> getItems() {
        return items;
    }

    public void setItems(List<QuoteItemDto> items) {
        this.items = items;
    }
}
