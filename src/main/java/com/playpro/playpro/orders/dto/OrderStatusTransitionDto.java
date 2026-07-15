package com.playpro.playpro.orders.dto;

public class OrderStatusTransitionDto {

    private String statusId;
    private String label;

    public OrderStatusTransitionDto() {
    }

    public OrderStatusTransitionDto(String statusId, String label) {
        this.statusId = statusId;
        this.label = label;
    }

    public String getStatusId() {
        return statusId;
    }

    public void setStatusId(String statusId) {
        this.statusId = statusId;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }
}
