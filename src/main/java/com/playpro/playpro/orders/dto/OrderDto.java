package com.playpro.playpro.orders.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class OrderDto {

    private String orderId;
    private String orderTypeId;
    private String orderName;
    private LocalDateTime orderDate;
    private LocalDateTime entryDate;
    private String statusId;
    private String createdBy;
    private String currencyUom;
    private String productStoreId;
    private BigDecimal grandTotal;
    private BigDecimal remainingSubTotal;
    private String externalId;
    private String partyId;
    private List<OrderItemDto> items = new ArrayList<>();
    private List<OrderRoleDto> roles = new ArrayList<>();
    private List<OrderPaymentDto> payments = new ArrayList<>();
    private List<OrderStatusTransitionDto> allowedTransitions = new ArrayList<>();

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

    public String getExternalId() {
        return externalId;
    }

    public void setExternalId(String externalId) {
        this.externalId = externalId;
    }

    public String getPartyId() {
        return partyId;
    }

    public void setPartyId(String partyId) {
        this.partyId = partyId;
    }

    public List<OrderItemDto> getItems() {
        return items;
    }

    public void setItems(List<OrderItemDto> items) {
        this.items = items;
    }

    public List<OrderRoleDto> getRoles() {
        return roles;
    }

    public void setRoles(List<OrderRoleDto> roles) {
        this.roles = roles;
    }

    public List<OrderPaymentDto> getPayments() {
        return payments;
    }

    public void setPayments(List<OrderPaymentDto> payments) {
        this.payments = payments;
    }

    public List<OrderStatusTransitionDto> getAllowedTransitions() {
        return allowedTransitions;
    }

    public void setAllowedTransitions(List<OrderStatusTransitionDto> allowedTransitions) {
        this.allowedTransitions = allowedTransitions;
    }
}
