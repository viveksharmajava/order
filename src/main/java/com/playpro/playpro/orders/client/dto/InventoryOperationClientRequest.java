package com.playpro.playpro.orders.client.dto;

import java.util.ArrayList;
import java.util.List;

public class InventoryOperationClientRequest {

    private String orderId;
    private String productStoreId;
    private List<InventoryOperationLineClientDto> lines = new ArrayList<>();

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getProductStoreId() {
        return productStoreId;
    }

    public void setProductStoreId(String productStoreId) {
        this.productStoreId = productStoreId;
    }

    public List<InventoryOperationLineClientDto> getLines() {
        return lines;
    }

    public void setLines(List<InventoryOperationLineClientDto> lines) {
        this.lines = lines;
    }
}
