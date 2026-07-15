package com.playpro.playpro.orders.entity;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "status_valid_change")
public class StatusValidChange {

    @EmbeddedId
    private StatusValidChangeId id;

    @Column(name = "transition_name", length = 255)
    private String transitionName;

    public StatusValidChangeId getId() {
        return id;
    }

    public void setId(StatusValidChangeId id) {
        this.id = id;
    }

    public String getTransitionName() {
        return transitionName;
    }

    public void setTransitionName(String transitionName) {
        this.transitionName = transitionName;
    }
}
