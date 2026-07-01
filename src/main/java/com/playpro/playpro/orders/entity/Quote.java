package com.playpro.playpro.orders.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.time.LocalDateTime;

@Entity
@Table(name = "quote")
public class Quote {

    @Id
    @Column(name = "quote_id", length = 20)
    private String quoteId;

    @Column(name = "quote_type_id", length = 20)
    private String quoteTypeId;

    @Column(name = "party_id", length = 20)
    private String partyId;

    @Column(name = "issue_date")
    private LocalDateTime issueDate;

    @Column(name = "status_id", length = 20)
    private String statusId;

    @Column(name = "currency_uom_id", length = 20)
    private String currencyUomId;

    @Column(name = "quote_name", length = 100)
    private String quoteName;

    @Column(name = "description", length = 255)
    private String description;

    @Column(name = "valid_from_date")
    private LocalDateTime validFromDate;

    @Column(name = "valid_thru_date")
    private LocalDateTime validThruDate;

    @Column(name = "product_store_id", length = 20)
    private String productStoreId;

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
}
