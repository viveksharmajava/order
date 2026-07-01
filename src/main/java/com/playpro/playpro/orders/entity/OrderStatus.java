package com.playpro.playpro.orders.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.time.LocalDateTime;

@Entity
@Table(name = "order_status")
public class OrderStatus {

    @Id
    @Column(name = "order_status_id", length = 20)
    private String orderStatusId;

    @Column(name = "order_id", length = 20)
    private String orderId;

    @Column(name = "status_id", length = 20)
    private String statusId;

    @Column(name = "status_datetime")
    private LocalDateTime statusDatetime;

    @Column(name = "status_user_login", length = 250)
    private String statusUserLogin;

    @Column(name = "change_reason", length = 255)
    private String changeReason;

    public String getOrderStatusId() {
        return orderStatusId;
    }

    public void setOrderStatusId(String orderStatusId) {
        this.orderStatusId = orderStatusId;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getStatusId() {
        return statusId;
    }

    public void setStatusId(String statusId) {
        this.statusId = statusId;
    }

    public LocalDateTime getStatusDatetime() {
        return statusDatetime;
    }

    public void setStatusDatetime(LocalDateTime statusDatetime) {
        this.statusDatetime = statusDatetime;
    }

    public String getStatusUserLogin() {
        return statusUserLogin;
    }

    public void setStatusUserLogin(String statusUserLogin) {
        this.statusUserLogin = statusUserLogin;
    }

    public String getChangeReason() {
        return changeReason;
    }

    public void setChangeReason(String changeReason) {
        this.changeReason = changeReason;
    }
}
