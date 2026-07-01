package com.playpro.playpro.orders.entity;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class OrderRoleId implements Serializable {

    @Column(name = "order_id", length = 20)
    private String orderId;

    @Column(name = "party_id", length = 20)
    private String partyId;

    @Column(name = "role_type_id", length = 20)
    private String roleTypeId;

    public OrderRoleId() {
    }

    public OrderRoleId(String orderId, String partyId, String roleTypeId) {
        this.orderId = orderId;
        this.partyId = partyId;
        this.roleTypeId = roleTypeId;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getPartyId() {
        return partyId;
    }

    public void setPartyId(String partyId) {
        this.partyId = partyId;
    }

    public String getRoleTypeId() {
        return roleTypeId;
    }

    public void setRoleTypeId(String roleTypeId) {
        this.roleTypeId = roleTypeId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof OrderRoleId)) return false;
        OrderRoleId that = (OrderRoleId) o;
        return Objects.equals(orderId, that.orderId)
                && Objects.equals(partyId, that.partyId)
                && Objects.equals(roleTypeId, that.roleTypeId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(orderId, partyId, roleTypeId);
    }
}
