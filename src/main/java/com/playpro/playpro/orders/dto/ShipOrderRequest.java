package com.playpro.playpro.orders.dto;

import java.util.ArrayList;
import java.util.List;

public class ShipOrderRequest {

    /** When true (or items empty), ship all remaining shippable quantity on each line. */
    private boolean shipAll = true;
    private List<ShipOrderItemRequest> items = new ArrayList<>();
    private String shippingMethodId;
    private String shippingMethodName;
    private String carrierProvider;
    private String trackingNumber;
    private String trackUrl;
    private String shippingInstructions;

    public boolean isShipAll() {
        return shipAll;
    }

    public void setShipAll(boolean shipAll) {
        this.shipAll = shipAll;
    }

    public List<ShipOrderItemRequest> getItems() {
        return items;
    }

    public void setItems(List<ShipOrderItemRequest> items) {
        this.items = items;
    }

    public String getShippingMethodId() {
        return shippingMethodId;
    }

    public void setShippingMethodId(String shippingMethodId) {
        this.shippingMethodId = shippingMethodId;
    }

    public String getShippingMethodName() {
        return shippingMethodName;
    }

    public void setShippingMethodName(String shippingMethodName) {
        this.shippingMethodName = shippingMethodName;
    }

    public String getCarrierProvider() {
        return carrierProvider;
    }

    public void setCarrierProvider(String carrierProvider) {
        this.carrierProvider = carrierProvider;
    }

    public String getTrackingNumber() {
        return trackingNumber;
    }

    public void setTrackingNumber(String trackingNumber) {
        this.trackingNumber = trackingNumber;
    }

    public String getTrackUrl() {
        return trackUrl;
    }

    public void setTrackUrl(String trackUrl) {
        this.trackUrl = trackUrl;
    }

    public String getShippingInstructions() {
        return shippingInstructions;
    }

    public void setShippingInstructions(String shippingInstructions) {
        this.shippingInstructions = shippingInstructions;
    }
}
