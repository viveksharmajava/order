package com.playpro.playpro.orders.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "order_header")
public class OrderHeader {

    @Id
    @Column(name = "order_id", length = 20)
    private String orderId;

    @Column(name = "order_type_id", length = 20)
    private String orderTypeId;

    @Column(name = "order_name", length = 100)
    private String orderName;

    @Column(name = "external_id", length = 20)
    private String externalId;

    @Column(name = "order_date")
    private LocalDateTime orderDate;

    @Column(name = "entry_date")
    private LocalDateTime entryDate;

    @Column(name = "status_id", length = 20)
    private String statusId;

    @Column(name = "created_by", length = 250)
    private String createdBy;

    @Column(name = "currency_uom", length = 20)
    private String currencyUom;

    @Column(name = "product_store_id", length = 20)
    private String productStoreId;

    @Column(name = "grand_total", precision = 18, scale = 3)
    private BigDecimal grandTotal;

    @Column(name = "remaining_sub_total", precision = 18, scale = 3)
    private BigDecimal remainingSubTotal;

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getOrderTypeId() {
        return orderTypeId;
    }

    public void setOrderTypeId(String orderTypeId) {
        this.orderTypeId = orderTypeId;
    }

    public String getOrderName() {
        return orderName;
    }

    public void setOrderName(String orderName) {
        this.orderName = orderName;
    }

    public String getExternalId() {
        return externalId;
    }

    public void setExternalId(String externalId) {
        this.externalId = externalId;
    }

    public LocalDateTime getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDateTime orderDate) {
        this.orderDate = orderDate;
    }

    public LocalDateTime getEntryDate() {
        return entryDate;
    }

    public void setEntryDate(LocalDateTime entryDate) {
        this.entryDate = entryDate;
    }

    public String getStatusId() {
        return statusId;
    }

    public void setStatusId(String statusId) {
        this.statusId = statusId;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public String getCurrencyUom() {
        return currencyUom;
    }

    public void setCurrencyUom(String currencyUom) {
        this.currencyUom = currencyUom;
    }

    public String getProductStoreId() {
        return productStoreId;
    }

    public void setProductStoreId(String productStoreId) {
        this.productStoreId = productStoreId;
    }

    public BigDecimal getGrandTotal() {
        return grandTotal;
    }

    public void setGrandTotal(BigDecimal grandTotal) {
        this.grandTotal = grandTotal;
    }

    public BigDecimal getRemainingSubTotal() {
        return remainingSubTotal;
    }

    public void setRemainingSubTotal(BigDecimal remainingSubTotal) {
        this.remainingSubTotal = remainingSubTotal;
    }
}
