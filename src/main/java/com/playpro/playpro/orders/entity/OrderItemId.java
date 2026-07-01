package com.playpro.playpro.orders.entity;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class OrderItemId implements Serializable {

    @Column(name = "order_id", length = 20)
    private String orderId;

    @Column(name = "order_item_seq_id", length = 20)
    private String orderItemSeqId;

    public OrderItemId() {
    }

    public OrderItemId(String orderId, String orderItemSeqId) {
        this.orderId = orderId;
        this.orderItemSeqId = orderItemSeqId;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getOrderItemSeqId() {
        return orderItemSeqId;
    }

    public void setOrderItemSeqId(String orderItemSeqId) {
        this.orderItemSeqId = orderItemSeqId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof OrderItemId)) return false;
        OrderItemId that = (OrderItemId) o;
        return Objects.equals(orderId, that.orderId)
                && Objects.equals(orderItemSeqId, that.orderItemSeqId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(orderId, orderItemSeqId);
    }
}
