package com.playpro.playpro.orders.entity;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.time.LocalDateTime;

@Entity
@Table(name = "quote_role")
public class QuoteRole {

    @EmbeddedId
    private QuoteRoleId id;

    @Column(name = "from_date")
    private LocalDateTime fromDate;

    @Column(name = "thru_date")
    private LocalDateTime thruDate;

    public QuoteRoleId getId() {
        return id;
    }

    public void setId(QuoteRoleId id) {
        this.id = id;
    }

    public LocalDateTime getFromDate() {
        return fromDate;
    }

    public void setFromDate(LocalDateTime fromDate) {
        this.fromDate = fromDate;
    }

    public LocalDateTime getThruDate() {
        return thruDate;
    }

    public void setThruDate(LocalDateTime thruDate) {
        this.thruDate = thruDate;
    }
}
