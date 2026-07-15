package com.playpro.playpro.orders.client.dto;

import java.math.BigDecimal;

public class InventoryOperationLineClientDto {

    private String productId;
    private String orderItemSeqId;
    private BigDecimal quantity;

    public InventoryOperationLineClientDto() {
    }

    public InventoryOperationLineClientDto(String productId, String orderItemSeqId, BigDecimal quantity) {
        this.productId = productId;
        this.orderItemSeqId = orderItemSeqId;
        this.quantity = quantity;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getOrderItemSeqId() {
        return orderItemSeqId;
    }

    public void setOrderItemSeqId(String orderItemSeqId) {
        this.orderItemSeqId = orderItemSeqId;
    }

    public BigDecimal getQuantity() {
        return quantity;
    }

    public void setQuantity(BigDecimal quantity) {
        this.quantity = quantity;
    }
}
