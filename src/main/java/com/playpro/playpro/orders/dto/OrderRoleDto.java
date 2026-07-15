package com.playpro.playpro.orders.dto;

public class OrderRoleDto {

    private String partyId;
    private String roleTypeId;

    public OrderRoleDto() {
    }

    public OrderRoleDto(String partyId, String roleTypeId) {
        this.partyId = partyId;
        this.roleTypeId = roleTypeId;
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
}
