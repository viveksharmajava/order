-- Align product_id with catalog (VARCHAR(64)) for order/quote lines.

ALTER TABLE order_item ALTER COLUMN product_id VARCHAR(64);
ALTER TABLE quote_item ALTER COLUMN product_id VARCHAR(64);
