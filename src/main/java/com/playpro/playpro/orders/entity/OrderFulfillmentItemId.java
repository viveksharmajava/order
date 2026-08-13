package com.playpro.playpro.orders.entity;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class OrderFulfillmentItemId implements Serializable {

    @Column(name = "fulfillment_id", length = 40)
    private String fulfillmentId;

    @Column(name = "order_item_seq_id", length = 20)
    private String orderItemSeqId;

    public OrderFulfillmentItemId() {
    }

    public OrderFulfillmentItemId(String fulfillmentId, String orderItemSeqId) {
        this.fulfillmentId = fulfillmentId;
        this.orderItemSeqId = orderItemSeqId;
    }

    public String getFulfillmentId() {
        return fulfillmentId;
    }

    public void setFulfillmentId(String fulfillmentId) {
        this.fulfillmentId = fulfillmentId;
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
        if (o == null || getClass() != o.getClass()) return false;
        OrderFulfillmentItemId that = (OrderFulfillmentItemId) o;
        return Objects.equals(fulfillmentId, that.fulfillmentId)
                && Objects.equals(orderItemSeqId, that.orderItemSeqId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(fulfillmentId, orderItemSeqId);
    }
}
