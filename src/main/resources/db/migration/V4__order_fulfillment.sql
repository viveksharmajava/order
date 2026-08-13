-- Order fulfillment / split shipping support

CREATE TABLE IF NOT EXISTS order_fulfillment (
    fulfillment_id          VARCHAR(40)   NOT NULL PRIMARY KEY,
    order_id                VARCHAR(20)   NOT NULL,
    ship_group_seq_id       VARCHAR(20)   NOT NULL,
    shipping_method_id      VARCHAR(40),
    shipping_method_name    VARCHAR(100),
    carrier_provider        VARCHAR(60),
    tracking_number         VARCHAR(255),
    track_url               VARCHAR(500),
    shipping_instructions   VARCHAR(500),
    shipped_date            TIMESTAMP,
    created_by              VARCHAR(250),
    created_date            TIMESTAMP,
    CONSTRAINT uq_order_fulfillment_group UNIQUE (order_id, ship_group_seq_id)
);

CREATE INDEX IF NOT EXISTS idx_order_fulfillment_order ON order_fulfillment (order_id);

CREATE TABLE IF NOT EXISTS order_fulfillment_item (
    fulfillment_id      VARCHAR(40)    NOT NULL,
    order_id            VARCHAR(20)    NOT NULL,
    order_item_seq_id   VARCHAR(20)    NOT NULL,
    quantity            NUMERIC(18,6)  NOT NULL,
    PRIMARY KEY (fulfillment_id, order_item_seq_id),
    CONSTRAINT fk_ofi_fulfillment FOREIGN KEY (fulfillment_id) REFERENCES order_fulfillment (fulfillment_id)
);

CREATE INDEX IF NOT EXISTS idx_ofi_order ON order_fulfillment_item (order_id);

-- Allow Created / Processing orders to be marked Sent (shipped)
INSERT INTO status_valid_change (status_id, status_id_to, transition_name)
SELECT 'ORDER_CREATED', 'ORDER_SENT', 'Ship Order'
WHERE NOT EXISTS (
    SELECT 1 FROM status_valid_change
    WHERE status_id = 'ORDER_CREATED' AND status_id_to = 'ORDER_SENT'
);

INSERT INTO status_valid_change (status_id, status_id_to, transition_name)
SELECT 'ORDER_PROCESSING', 'ORDER_SENT', 'Ship Order'
WHERE NOT EXISTS (
    SELECT 1 FROM status_valid_change
    WHERE status_id = 'ORDER_PROCESSING' AND status_id_to = 'ORDER_SENT'
);

INSERT INTO status_valid_change (status_id, status_id_to, transition_name)
SELECT 'ORDER_CREATED', 'ORDER_PROCESSING', 'Process Order'
WHERE NOT EXISTS (
    SELECT 1 FROM status_valid_change
    WHERE status_id = 'ORDER_CREATED' AND status_id_to = 'ORDER_PROCESSING'
);

-- Item shipped status for partially / fully shipped lines
INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id)
SELECT 'Shipped', '06', 'SHIPPED', 'ITEM_SHIPPED', 'ORDER_ITEM_STATUS'
WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE status_id = 'ITEM_SHIPPED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name)
SELECT 'ITEM_CREATED', 'ITEM_SHIPPED', 'Ship Item'
WHERE NOT EXISTS (
    SELECT 1 FROM status_valid_change
    WHERE status_id = 'ITEM_CREATED' AND status_id_to = 'ITEM_SHIPPED'
);

INSERT INTO status_valid_change (status_id, status_id_to, transition_name)
SELECT 'ITEM_APPROVED', 'ITEM_SHIPPED', 'Ship Item'
WHERE NOT EXISTS (
    SELECT 1 FROM status_valid_change
    WHERE status_id = 'ITEM_APPROVED' AND status_id_to = 'ITEM_SHIPPED'
);

INSERT INTO status_valid_change (status_id, status_id_to, transition_name)
SELECT 'ITEM_SHIPPED', 'ITEM_COMPLETED', 'Complete Item'
WHERE NOT EXISTS (
    SELECT 1 FROM status_valid_change
    WHERE status_id = 'ITEM_SHIPPED' AND status_id_to = 'ITEM_COMPLETED'
);
