package com.playpro.playpro.orders.dto;

import com.playpro.playpro.orders.search.TextMatchMode;

import java.time.LocalDateTime;

public class OrderSearchRequest {

    private String partyId;
    private String partyIdMatch = "CONTAINS";
    private String orderId;
    private String orderIdMatch = "CONTAINS";
    private String productId;
    private String productIdMatch = "CONTAINS";
    private String orderTypeId;
    private LocalDateTime orderDateFrom;
    private LocalDateTime orderDateTo;
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

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getOrderIdMatch() {
        return orderIdMatch;
    }

    public void setOrderIdMatch(String orderIdMatch) {
        this.orderIdMatch = orderIdMatch;
    }

    public TextMatchMode getOrderIdMatchMode() {
        return TextMatchMode.fromString(orderIdMatch);
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

    public String getOrderTypeId() {
        return orderTypeId;
    }

    public void setOrderTypeId(String orderTypeId) {
        this.orderTypeId = orderTypeId;
    }

    public LocalDateTime getOrderDateFrom() {
        return orderDateFrom;
    }

    public void setOrderDateFrom(LocalDateTime orderDateFrom) {
        this.orderDateFrom = orderDateFrom;
    }

    public LocalDateTime getOrderDateTo() {
        return orderDateTo;
    }

    public void setOrderDateTo(LocalDateTime orderDateTo) {
        this.orderDateTo = orderDateTo;
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
