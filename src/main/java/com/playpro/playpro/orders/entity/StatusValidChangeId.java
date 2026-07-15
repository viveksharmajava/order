package com.playpro.playpro.orders.entity;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class StatusValidChangeId implements Serializable {

    @Column(name = "status_id", length = 20)
    private String statusId;

    @Column(name = "status_id_to", length = 20)
    private String statusIdTo;

    public StatusValidChangeId() {
    }

    public StatusValidChangeId(String statusId, String statusIdTo) {
        this.statusId = statusId;
        this.statusIdTo = statusIdTo;
    }

    public String getStatusId() {
        return statusId;
    }

    public void setStatusId(String statusId) {
        this.statusId = statusId;
    }

    public String getStatusIdTo() {
        return statusIdTo;
    }

    public void setStatusIdTo(String statusIdTo) {
        this.statusIdTo = statusIdTo;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof StatusValidChangeId)) return false;
        StatusValidChangeId that = (StatusValidChangeId) o;
        return Objects.equals(statusId, that.statusId) && Objects.equals(statusIdTo, that.statusIdTo);
    }

    @Override
    public int hashCode() {
        return Objects.hash(statusId, statusIdTo);
    }
}
