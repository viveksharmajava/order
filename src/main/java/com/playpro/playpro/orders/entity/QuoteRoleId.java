package com.playpro.playpro.orders.entity;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Objects;

@Embeddable
public class QuoteRoleId implements Serializable {

    @Column(name = "quote_id", length = 20)
    private String quoteId;

    @Column(name = "party_id", length = 20)
    private String partyId;

    @Column(name = "role_type_id", length = 20)
    private String roleTypeId;

    public QuoteRoleId() {
    }

    public QuoteRoleId(String quoteId, String partyId, String roleTypeId) {
        this.quoteId = quoteId;
        this.partyId = partyId;
        this.roleTypeId = roleTypeId;
    }

    public String getQuoteId() {
        return quoteId;
    }

    public void setQuoteId(String quoteId) {
        this.quoteId = quoteId;
    }

    public String getPartyId() {
        return partyId;
    }

    public void setPartyId(String partyId) {
        this.partyId = partyId;
    }

    public String getRoleTypeId() {
        return roleTypeId;
    }

    public void setRoleTypeId(String roleTypeId) {
        this.roleTypeId = roleTypeId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof QuoteRoleId)) return false;
        QuoteRoleId that = (QuoteRoleId) o;
        return Objects.equals(quoteId, that.quoteId)
                && Objects.equals(partyId, that.partyId)
                && Objects.equals(roleTypeId, that.roleTypeId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(quoteId, partyId, roleTypeId);
    }
}
