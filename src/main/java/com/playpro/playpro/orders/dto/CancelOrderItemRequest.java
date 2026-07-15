package com.playpro.playpro.orders.dto;

import java.math.BigDecimal;

public class CancelOrderItemRequest {

    private String orderItemSeqId;
    private BigDecimal cancelQuantity;

    public String getOrderItemSeqId() {
        return orderItemSeqId;
    }

    public void setOrderItemSeqId(String orderItemSeqId) {
        this.orderItemSeqId = orderItemSeqId;
    }

    public BigDecimal getCancelQuantity() {
        return cancelQuantity;
    }

    public void setCancelQuantity(BigDecimal cancelQuantity) {
        this.cancelQuantity = cancelQuantity;
    }
}
