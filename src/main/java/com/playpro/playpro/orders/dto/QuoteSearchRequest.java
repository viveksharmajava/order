package com.playpro.playpro.orders.dto;

import com.playpro.playpro.orders.search.TextMatchMode;

import java.time.LocalDateTime;

public class QuoteSearchRequest {

    private String partyId;
    private String partyIdMatch = "CONTAINS";
    private String quoteId;
    private String quoteIdMatch = "CONTAINS";
    private String productId;
    private String productIdMatch = "CONTAINS";
    private LocalDateTime issueDateFrom;
    private LocalDateTime issueDateTo;
    private int page = 0;
    private int size = 20;

    public String getPartyId() {
        return partyId;
    }

    public void setPartyId(String partyId) {
        this.partyId = partyId;
    }

    public String getPartyIdMatch() {
        return partyIdMatch;
    }

    public void setPartyIdMatch(String partyIdMatch) {
        this.partyIdMatch = partyIdMatch;
    }

    public TextMatchMode getPartyIdMatchMode() {
        return TextMatchMode.fromString(partyIdMatch);
    }

    public String getQuoteId() {
        return quoteId;
    }

    public void setQuoteId(String quoteId) {
        this.quoteId = quoteId;
    }

    public String getQuoteIdMatch() {
        return quoteIdMatch;
    }

    public void setQuoteIdMatch(String quoteIdMatch) {
        this.quoteIdMatch = quoteIdMatch;
    }

    public TextMatchMode getQuoteIdMatchMode() {
        return TextMatchMode.fromString(quoteIdMatch);
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getProductIdMatch() {
        return productIdMatch;
    }

    public void setProductIdMatch(String productIdMatch) {
        this.productIdMatch = productIdMatch;
    }

    public TextMatchMode getProductIdMatchMode() {
        return TextMatchMode.fromString(productIdMatch);
    }

    public LocalDateTime getIssueDateFrom() {
        return issueDateFrom;
    }

    public void setIssueDateFrom(LocalDateTime issueDateFrom) {
        this.issueDateFrom = issueDateFrom;
    }

    public LocalDateTime getIssueDateTo() {
        return issueDateTo;
    }

    public void setIssueDateTo(LocalDateTime issueDateTo) {
        this.issueDateTo = issueDateTo;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }
}
