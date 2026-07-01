package com.playpro.playpro.orders.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "order_type")
public class OrderType {

    @Id
    @Column(name = "order_type_id", length = 20)
    private String orderTypeId;

    @Column(name = "parent_type_id", length = 20)
    private String parentTypeId;

    @Column(name = "has_table", length = 1)
    private String hasTable;

    @Column(name = "description", length = 255)
    private String description;

    public String getOrderTypeId() {
        return orderTypeId;
    }

    public void setOrderTypeId(String orderTypeId) {
        this.orderTypeId = orderTypeId;
    }

    public String getParentTypeId() {
        return parentTypeId;
    }

    public void setParentTypeId(String parentTypeId) {
        this.parentTypeId = parentTypeId;
    }

    public String getHasTable() {
        return hasTable;
    }

    public void setHasTable(String hasTable) {
        this.hasTable = hasTable;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
