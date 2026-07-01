package com.playpro.playpro.orders.entity;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class QuoteItemId implements Serializable {

    @Column(name = "quote_id", length = 20)
    private String quoteId;

    @Column(name = "quote_item_seq_id", length = 20)
    private String quoteItemSeqId;

    public QuoteItemId() {
    }

    public QuoteItemId(String quoteId, String quoteItemSeqId) {
        this.quoteId = quoteId;
        this.quoteItemSeqId = quoteItemSeqId;
    }

    public String getQuoteId() {
        return quoteId;
    }

    public void setQuoteId(String quoteId) {
        this.quoteId = quoteId;
    }

    public String getQuoteItemSeqId() {
        return quoteItemSeqId;
    }

    public void setQuoteItemSeqId(String quoteItemSeqId) {
        this.quoteItemSeqId = quoteItemSeqId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof QuoteItemId)) return false;
        QuoteItemId that = (QuoteItemId) o;
        return Objects.equals(quoteId, that.quoteId)
                && Objects.equals(quoteItemSeqId, that.quoteItemSeqId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(quoteId, quoteItemSeqId);
    }
}
