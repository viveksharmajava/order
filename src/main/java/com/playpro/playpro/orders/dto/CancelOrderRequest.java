package com.playpro.playpro.orders.dto;

import java.util.ArrayList;
import java.util.List;

public class CancelOrderRequest {

    private String reason;
    private boolean cancelAll;
    private List<CancelOrderItemRequest> items = new ArrayList<>();

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public boolean isCancelAll() {
        return cancelAll;
    }

    public void setCancelAll(boolean cancelAll) {
        this.cancelAll = cancelAll;
    }

    public List<CancelOrderItemRequest> getItems() {
        return items;
    }

    public void setItems(List<CancelOrderItemRequest> items) {
        this.items = items;
    }
}
