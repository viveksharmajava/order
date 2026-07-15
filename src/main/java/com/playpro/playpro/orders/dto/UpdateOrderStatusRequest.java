package com.playpro.playpro.orders.dto;

public class UpdateOrderStatusRequest {

    private String statusId;
    private String reason;

    public String getStatusId() {
        return statusId;
    }

    public void setStatusId(String statusId) {
        this.statusId = statusId;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }
}
