package com.playpro.playpro.orders.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.time.LocalDateTime;

@Entity
@Table(name = "order_fulfillment")
public class OrderFulfillment {

    @Id
    @Column(name = "fulfillment_id", length = 40)
    private String fulfillmentId;

    @Column(name = "order_id", length = 20, nullable = false)
    private String orderId;

    @Column(name = "ship_group_seq_id", length = 20, nullable = false)
    private String shipGroupSeqId;

    @Column(name = "shipping_method_id", length = 40)
    private String shippingMethodId;

    @Column(name = "shipping_method_name", length = 100)
    private String shippingMethodName;

    @Column(name = "carrier_provider", length = 60)
    private String carrierProvider;

    @Column(name = "tracking_number", length = 255)
    private String trackingNumber;

    @Column(name = "track_url", length = 500)
    private String trackUrl;

    @Column(name = "shipping_instructions", length = 500)
    private String shippingInstructions;

    @Column(name = "shipped_date")
    private LocalDateTime shippedDate;

    @Column(name = "created_by", length = 250)
    private String createdBy;

    @Column(name = "created_date")
    private LocalDateTime createdDate;

    public String getFulfillmentId() {
        return fulfillmentId;
    }

    public void setFulfillmentId(String fulfillmentId) {
        this.fulfillmentId = fulfillmentId;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getShipGroupSeqId() {
        return shipGroupSeqId;
    }

    public void setShipGroupSeqId(String shipGroupSeqId) {
        this.shipGroupSeqId = shipGroupSeqId;
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

    public LocalDateTime getShippedDate() {
        return shippedDate;
    }

    public void setShippedDate(LocalDateTime shippedDate) {
        this.shippedDate = shippedDate;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public LocalDateTime getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(LocalDateTime createdDate) {
        this.createdDate = createdDate;
    }
}
