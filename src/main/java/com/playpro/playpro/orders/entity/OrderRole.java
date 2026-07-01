package com.playpro.playpro.orders.entity;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "order_role")
public class OrderRole {

    @EmbeddedId
    private OrderRoleId id;

    public OrderRoleId getId() {
        return id;
    }

    public void setId(OrderRoleId id) {
        this.id = id;
    }
}
