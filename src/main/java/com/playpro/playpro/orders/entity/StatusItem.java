package com.playpro.playpro.orders.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "status_item")
public class StatusItem {

    @Id
    @Column(name = "status_id", length = 20)
    private String statusId;

    @Column(name = "status_type_id", length = 20)
    private String statusTypeId;

    @Column(name = "status_code", length = 60)
    private String statusCode;

    @Column(name = "sequence_id", length = 20)
    private String sequenceId;

    @Column(name = "description", length = 255)
    private String description;

    public String getStatusId() {
        return statusId;
    }

    public void setStatusId(String statusId) {
        this.statusId = statusId;
    }

    public String getStatusTypeId() {
        return statusTypeId;
    }

    public void setStatusTypeId(String statusTypeId) {
        this.statusTypeId = statusTypeId;
    }

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }

    public String getSequenceId() {
        return sequenceId;
    }

    public void setSequenceId(String sequenceId) {
        this.sequenceId = sequenceId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
