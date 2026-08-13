package com.playpro.playpro.orders.entity;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.math.BigDecimal;

@Entity
@Table(name = "order_fulfillment_item")
public class OrderFulfillmentItem {

    @EmbeddedId
    private OrderFulfillmentItemId id;

    @Column(name = "order_id", length = 20, nullable = false)
    private String orderId;

    @Column(name = "quantity", precision = 18, scale = 6, nullable = false)
    private BigDecimal quantity;

    public OrderFulfillmentItemId getId() {
        return id;
    }

    public void setId(OrderFulfillmentItemId id) {
        this.id = id;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public BigDecimal getQuantity() {
        return quantity;
    }

    public void setQuantity(BigDecimal quantity) {
        this.quantity = quantity;
    }
}
