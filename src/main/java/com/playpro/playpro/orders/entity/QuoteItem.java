package com.playpro.playpro.orders.entity;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.math.BigDecimal;

@Entity
@Table(name = "quote_item")
public class QuoteItem {

    @EmbeddedId
    private QuoteItemId id;

    @Column(name = "product_id", length = 20)
    private String productId;

    @Column(name = "quantity", precision = 18, scale = 6)
    private BigDecimal quantity;

    @Column(name = "quote_unit_price", precision = 18, scale = 3)
    private BigDecimal quoteUnitPrice;

    public QuoteItemId getId() {
        return id;
    }

    public void setId(QuoteItemId id) {
        this.id = id;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public BigDecimal getQuantity() {
        return quantity;
    }

    public void setQuantity(BigDecimal quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getQuoteUnitPrice() {
        return quoteUnitPrice;
    }

    public void setQuoteUnitPrice(BigDecimal quoteUnitPrice) {
        this.quoteUnitPrice = quoteUnitPrice;
    }
}
