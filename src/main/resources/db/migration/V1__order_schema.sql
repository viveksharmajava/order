-- OFBiz order-entitymodel.xml (112 physical entities)

CREATE TABLE IF NOT EXISTS status_type (status_type_id VARCHAR(20) NOT NULL PRIMARY KEY, parent_type_id VARCHAR(20), has_table CHAR(1), description VARCHAR(255));
CREATE TABLE IF NOT EXISTS status_item (status_id VARCHAR(20) NOT NULL PRIMARY KEY, status_type_id VARCHAR(20), status_code VARCHAR(60), sequence_id VARCHAR(20), description VARCHAR(255));
CREATE TABLE IF NOT EXISTS enumeration_type (enum_type_id VARCHAR(20) NOT NULL PRIMARY KEY, parent_type_id VARCHAR(20), has_table CHAR(1), description VARCHAR(255));
CREATE TABLE IF NOT EXISTS enumeration (enum_id VARCHAR(20) NOT NULL PRIMARY KEY, enum_type_id VARCHAR(20), enum_code VARCHAR(60), sequence_id VARCHAR(20), description VARCHAR(255));
CREATE TABLE IF NOT EXISTS status_valid_change (status_id VARCHAR(20) NOT NULL, status_id_to VARCHAR(20) NOT NULL, transition_name VARCHAR(255), PRIMARY KEY (status_id, status_id_to));

CREATE TABLE IF NOT EXISTS order_adjustment (
    order_adjustment_id VARCHAR(20),
    order_adjustment_type_id VARCHAR(20),
    order_id VARCHAR(20),
    order_item_seq_id VARCHAR(20),
    ship_group_seq_id VARCHAR(20),
    comments VARCHAR(255),
    description VARCHAR(255),
    amount NUMERIC(18,6),
    recurring_amount NUMERIC(18,6),
    amount_already_included NUMERIC(18,6),
    product_promo_id VARCHAR(20),
    product_promo_rule_id VARCHAR(20),
    product_promo_action_seq_id VARCHAR(20),
    product_feature_id VARCHAR(20),
    corresponding_product_id VARCHAR(20),
    tax_authority_rate_seq_id VARCHAR(20),
    source_reference_id VARCHAR(60),
    source_percentage NUMERIC(18,6),
    customer_reference_id VARCHAR(60),
    primary_geo_id VARCHAR(20),
    secondary_geo_id VARCHAR(20),
    exempt_amount NUMERIC(18,3),
    tax_auth_geo_id VARCHAR(20),
    tax_auth_party_id VARCHAR(20),
    override_gl_account_id VARCHAR(20),
    include_in_tax CHAR(1),
    include_in_shipping CHAR(1),
    is_manual CHAR(1),
    created_date TIMESTAMP,
    created_by_user_login VARCHAR(250),
    last_modified_date TIMESTAMP,
    last_modified_by_user_login VARCHAR(250),
    original_adjustment_id VARCHAR(20),
    PRIMARY KEY (order_adjustment_id)
);

CREATE TABLE IF NOT EXISTS order_adjustment_attribute (
    order_adjustment_id VARCHAR(20),
    attr_name VARCHAR(60),
    attr_value VARCHAR(255),
    attr_description VARCHAR(255),
    PRIMARY KEY (order_adjustment_id, attr_name)
);

CREATE TABLE IF NOT EXISTS order_adjustment_type (
    order_adjustment_type_id VARCHAR(20),
    parent_type_id VARCHAR(20),
    has_table CHAR(1),
    description VARCHAR(255),
    PRIMARY KEY (order_adjustment_type_id)
);

CREATE TABLE IF NOT EXISTS order_adjustment_billing (
    order_adjustment_id VARCHAR(20),
    invoice_id VARCHAR(20),
    invoice_item_seq_id VARCHAR(20),
    amount NUMERIC(18,3),
    PRIMARY KEY (order_adjustment_id, invoice_id, invoice_item_seq_id)
);

CREATE TABLE IF NOT EXISTS order_adjustment_type_attr (
    order_adjustment_type_id VARCHAR(20),
    attr_name VARCHAR(60),
    description VARCHAR(255),
    PRIMARY KEY (order_adjustment_type_id, attr_name)
);

CREATE TABLE IF NOT EXISTS order_attribute (
    order_id VARCHAR(20),
    attr_name VARCHAR(60),
    attr_value VARCHAR(255),
    attr_description VARCHAR(255),
    PRIMARY KEY (order_id, attr_name)
);

CREATE TABLE IF NOT EXISTS order_blacklist (
    blacklist_string VARCHAR(255),
    order_blacklist_type_id VARCHAR(20),
    PRIMARY KEY (blacklist_string, order_blacklist_type_id)
);

CREATE TABLE IF NOT EXISTS order_blacklist_type (
    order_blacklist_type_id VARCHAR(20),
    description VARCHAR(255),
    PRIMARY KEY (order_blacklist_type_id)
);

CREATE TABLE IF NOT EXISTS order_denylist (
    denylist_string VARCHAR(255),
    order_denylist_type_id VARCHAR(20),
    PRIMARY KEY (denylist_string, order_denylist_type_id)
);

CREATE TABLE IF NOT EXISTS order_denylist_type (
    order_denylist_type_id VARCHAR(20),
    description VARCHAR(255),
    PRIMARY KEY (order_denylist_type_id)
);

CREATE TABLE IF NOT EXISTS communication_event_order (
    order_id VARCHAR(20),
    communication_event_id VARCHAR(20),
    PRIMARY KEY (order_id, communication_event_id)
);

CREATE TABLE IF NOT EXISTS order_contact_mech (
    order_id VARCHAR(20),
    contact_mech_purpose_type_id VARCHAR(20),
    contact_mech_id VARCHAR(20),
    PRIMARY KEY (order_id, contact_mech_purpose_type_id, contact_mech_id)
);

CREATE TABLE IF NOT EXISTS order_content (
    order_id VARCHAR(20),
    order_item_seq_id VARCHAR(20),
    content_id VARCHAR(20),
    order_content_type_id VARCHAR(20),
    from_date TIMESTAMP,
    thru_date TIMESTAMP,
    PRIMARY KEY (content_id, order_id, order_item_seq_id, order_content_type_id, from_date)
);

CREATE TABLE IF NOT EXISTS order_content_type (
    order_content_type_id VARCHAR(20),
    parent_type_id VARCHAR(20),
    has_table CHAR(1),
    description VARCHAR(255),
    PRIMARY KEY (order_content_type_id)
);

CREATE TABLE IF NOT EXISTS order_delivery_schedule (
    order_id VARCHAR(20),
    order_item_seq_id VARCHAR(20),
    estimated_ready_date TIMESTAMP,
    cartons NUMERIC(20,0),
    skids_pallets NUMERIC(20,0),
    units_pieces NUMERIC(18,6),
    total_cubic_size NUMERIC(18,6),
    total_cubic_uom_id VARCHAR(20),
    total_weight NUMERIC(18,6),
    total_weight_uom_id VARCHAR(20),
    status_id VARCHAR(20),
    PRIMARY KEY (order_id, order_item_seq_id)
);

CREATE TABLE IF NOT EXISTS order_header (
    order_id VARCHAR(20),
    order_type_id VARCHAR(20),
    order_name VARCHAR(100),
    external_id VARCHAR(20),
    sales_channel_enum_id VARCHAR(20),
    order_date TIMESTAMP,
    priority CHAR(1),
    entry_date TIMESTAMP,
    pick_sheet_printed_date TIMESTAMP,
    visit_id VARCHAR(20),
    status_id VARCHAR(20),
    created_by VARCHAR(250),
    first_attempt_order_id VARCHAR(20),
    currency_uom VARCHAR(20),
    sync_status_id VARCHAR(20),
    billing_account_id VARCHAR(20),
    origin_facility_id VARCHAR(20),
    web_site_id VARCHAR(20),
    product_store_id VARCHAR(20),
    agreement_id VARCHAR(20),
    terminal_id VARCHAR(60),
    transaction_id VARCHAR(60),
    auto_order_shopping_list_id VARCHAR(20),
    needs_inventory_issuance CHAR(1),
    is_rush_order CHAR(1),
    internal_code VARCHAR(60),
    remaining_sub_total NUMERIC(18,3),
    grand_total NUMERIC(18,3),
    is_viewed CHAR(1),
    invoice_per_shipment CHAR(1),
    PRIMARY KEY (order_id)
);

CREATE TABLE IF NOT EXISTS order_header_note (
    order_id VARCHAR(20),
    note_id VARCHAR(20),
    internal_note CHAR(1),
    PRIMARY KEY (order_id, note_id)
);

CREATE TABLE IF NOT EXISTS order_header_work_effort (
    order_id VARCHAR(20),
    work_effort_id VARCHAR(20),
    PRIMARY KEY (order_id, work_effort_id)
);

CREATE TABLE IF NOT EXISTS order_item (
    order_id VARCHAR(20),
    order_item_seq_id VARCHAR(20),
    external_id VARCHAR(20),
    order_item_type_id VARCHAR(20),
    order_item_group_seq_id VARCHAR(20),
    is_item_group_primary CHAR(1),
    from_inventory_item_id VARCHAR(20),
    budget_id VARCHAR(20),
    budget_item_seq_id VARCHAR(20),
    product_id VARCHAR(20),
    supplier_product_id VARCHAR(60),
    product_feature_id VARCHAR(20),
    prod_catalog_id VARCHAR(20),
    product_category_id VARCHAR(20),
    is_promo CHAR(1),
    quote_id VARCHAR(20),
    quote_item_seq_id VARCHAR(20),
    shopping_list_id VARCHAR(20),
    shopping_list_item_seq_id VARCHAR(20),
    subscription_id VARCHAR(20),
    deployment_id VARCHAR(20),
    quantity NUMERIC(18,6),
    cancel_quantity NUMERIC(18,6),
    selected_amount NUMERIC(18,6),
    unit_price NUMERIC(18,6),
    unit_list_price NUMERIC(18,6),
    unit_average_cost NUMERIC(18,3),
    unit_recurring_price NUMERIC(18,3),
    discount_rate NUMERIC(18,6),
    is_modified_price CHAR(1),
    recurring_freq_uom_id VARCHAR(20),
    item_description VARCHAR(255),
    comments VARCHAR(255),
    corresponding_po_id VARCHAR(20),
    status_id VARCHAR(20),
    sync_status_id VARCHAR(20),
    estimated_ship_date TIMESTAMP,
    estimated_delivery_date TIMESTAMP,
    auto_cancel_date TIMESTAMP,
    dont_cancel_set_date TIMESTAMP,
    dont_cancel_set_user_login VARCHAR(250),
    ship_before_date TIMESTAMP,
    ship_after_date TIMESTAMP,
    reserve_after_date TIMESTAMP,
    cancel_back_order_date TIMESTAMP,
    override_gl_account_id VARCHAR(20),
    sales_opportunity_id VARCHAR(20),
    change_by_user_login_id VARCHAR(250),
    PRIMARY KEY (order_id, order_item_seq_id)
);

CREATE TABLE IF NOT EXISTS order_item_assoc (
    order_id VARCHAR(20),
    order_item_seq_id VARCHAR(20),
    ship_group_seq_id VARCHAR(20),
    to_order_id VARCHAR(20),
    to_order_item_seq_id VARCHAR(20),
    to_ship_group_seq_id VARCHAR(20),
    order_item_assoc_type_id VARCHAR(20),
    quantity NUMERIC(18,6),
    PRIMARY KEY (order_id, order_item_seq_id, ship_group_seq_id, to_order_id, to_order_item_seq_id, to_ship_group_seq_id, order_item_assoc_type_id)
);

CREATE TABLE IF NOT EXISTS order_item_assoc_type (
    order_item_assoc_type_id VARCHAR(20),
    parent_type_id VARCHAR(20),
    has_table CHAR(1),
    description VARCHAR(255),
    PRIMARY KEY (order_item_assoc_type_id)
);

CREATE TABLE IF NOT EXISTS order_item_attribute (
    order_id VARCHAR(20),
    order_item_seq_id VARCHAR(20),
    attr_name VARCHAR(60),
    attr_value VARCHAR(255),
    attr_description VARCHAR(255),
    PRIMARY KEY (order_id, order_item_seq_id, attr_name)
);

CREATE TABLE IF NOT EXISTS order_item_billing (
    order_id VARCHAR(20),
    order_item_seq_id VARCHAR(20),
    invoice_id VARCHAR(20),
    invoice_item_seq_id VARCHAR(20),
    item_issuance_id VARCHAR(20),
    shipment_receipt_id VARCHAR(20),
    quantity NUMERIC(18,6),
    amount NUMERIC(18,3),
    PRIMARY KEY (order_id, order_item_seq_id, invoice_id, invoice_item_seq_id)
);

CREATE TABLE IF NOT EXISTS order_item_change (
    order_item_change_id VARCHAR(20),
    order_id VARCHAR(20),
    order_item_seq_id VARCHAR(20),
    change_type_enum_id VARCHAR(20),
    change_datetime TIMESTAMP,
    change_user_login VARCHAR(250),
    quantity NUMERIC(18,6),
    cancel_quantity NUMERIC(18,6),
    unit_price NUMERIC(18,3),
    item_description VARCHAR(255),
    reason_enum_id VARCHAR(20),
    change_comments VARCHAR(255),
    PRIMARY KEY (order_item_change_id)
);

CREATE TABLE IF NOT EXISTS order_item_contact_mech (
    order_id VARCHAR(20),
    order_item_seq_id VARCHAR(20),
    contact_mech_purpose_type_id VARCHAR(20),
    contact_mech_id VARCHAR(20),
    PRIMARY KEY (order_id, order_item_seq_id, contact_mech_purpose_type_id)
);

CREATE TABLE IF NOT EXISTS order_item_group (
    order_id VARCHAR(20),
    order_item_group_seq_id VARCHAR(20),
    parent_group_seq_id VARCHAR(20),
    group_name VARCHAR(100),
    PRIMARY KEY (order_id, order_item_group_seq_id)
);

CREATE TABLE IF NOT EXISTS order_item_group_order (
    order_id VARCHAR(20),
    order_item_seq_id VARCHAR(20),
    group_order_id VARCHAR(20),
    PRIMARY KEY (order_id, order_item_seq_id, group_order_id)
);

CREATE TABLE IF NOT EXISTS order_item_price_info (
    order_item_price_info_id VARCHAR(20),
    order_id VARCHAR(20),
    order_item_seq_id VARCHAR(20),
    product_price_rule_id VARCHAR(20),
    product_price_action_seq_id VARCHAR(20),
    modify_amount NUMERIC(18,6),
    description VARCHAR(255),
    rate_code VARCHAR(255),
    PRIMARY KEY (order_item_price_info_id)
);

CREATE TABLE IF NOT EXISTS order_item_role (
    order_id VARCHAR(20),
    order_item_seq_id VARCHAR(20),
    party_id VARCHAR(20),
    role_type_id VARCHAR(20),
    PRIMARY KEY (order_id, order_item_seq_id, party_id, role_type_id)
);

CREATE TABLE IF NOT EXISTS order_item_ship_group (
    order_id VARCHAR(20),
    ship_group_seq_id VARCHAR(20),
    shipment_method_type_id VARCHAR(20),
    supplier_party_id VARCHAR(20),
    supplier_agreement_id VARCHAR(20),
    vendor_party_id VARCHAR(20),
    carrier_party_id VARCHAR(20),
    carrier_role_type_id VARCHAR(20),
    facility_id VARCHAR(20),
    contact_mech_id VARCHAR(20),
    telecom_contact_mech_id VARCHAR(20),
    tracking_number VARCHAR(255),
    shipping_instructions VARCHAR(255),
    may_split CHAR(1),
    gift_message VARCHAR(255),
    is_gift CHAR(1),
    ship_after_date TIMESTAMP,
    ship_by_date TIMESTAMP,
    estimated_ship_date TIMESTAMP,
    estimated_delivery_date TIMESTAMP,
    PRIMARY KEY (order_id, ship_group_seq_id)
);

CREATE TABLE IF NOT EXISTS order_item_ship_group_assoc (
    order_id VARCHAR(20),
    order_item_seq_id VARCHAR(20),
    ship_group_seq_id VARCHAR(20),
    quantity NUMERIC(18,6),
    cancel_quantity NUMERIC(18,6),
    PRIMARY KEY (order_id, order_item_seq_id, ship_group_seq_id)
);

CREATE TABLE IF NOT EXISTS order_item_ship_grp_inv_res (
    order_id VARCHAR(20),
    ship_group_seq_id VARCHAR(20),
    order_item_seq_id VARCHAR(20),
    inventory_item_id VARCHAR(20),
    reserve_order_enum_id VARCHAR(20),
    quantity NUMERIC(18,6),
    quantity_not_available NUMERIC(18,6),
    reserved_datetime TIMESTAMP,
    created_datetime TIMESTAMP,
    promised_datetime TIMESTAMP,
    current_promised_date TIMESTAMP,
    priority CHAR(1),
    sequence_id NUMERIC(20,0),
    PRIMARY KEY (order_id, ship_group_seq_id, order_item_seq_id, inventory_item_id)
);

CREATE TABLE IF NOT EXISTS order_item_type (
    order_item_type_id VARCHAR(20),
    parent_type_id VARCHAR(20),
    has_table CHAR(1),
    description VARCHAR(255),
    PRIMARY KEY (order_item_type_id)
);

CREATE TABLE IF NOT EXISTS order_item_type_attr (
    order_item_type_id VARCHAR(20),
    attr_name VARCHAR(60),
    description VARCHAR(255),
    PRIMARY KEY (order_item_type_id, attr_name)
);

CREATE TABLE IF NOT EXISTS order_notification (
    order_notification_id VARCHAR(20),
    order_id VARCHAR(20),
    email_type VARCHAR(20),
    comments VARCHAR(255),
    notification_date TIMESTAMP,
    PRIMARY KEY (order_notification_id)
);

CREATE TABLE IF NOT EXISTS order_payment_preference (
    order_payment_preference_id VARCHAR(20),
    order_id VARCHAR(20),
    order_item_seq_id VARCHAR(20),
    ship_group_seq_id VARCHAR(20),
    product_price_purpose_id VARCHAR(20),
    payment_method_type_id VARCHAR(20),
    payment_method_id VARCHAR(20),
    fin_account_id VARCHAR(20),
    security_code VARCHAR(255),
    track2 VARCHAR(255),
    present_flag CHAR(1),
    swiped_flag CHAR(1),
    overflow_flag CHAR(1),
    max_amount NUMERIC(18,3),
    process_attempt NUMERIC(20,0),
    billing_postal_code VARCHAR(255),
    manual_auth_code VARCHAR(255),
    manual_ref_num VARCHAR(255),
    status_id VARCHAR(20),
    needs_nsf_retry CHAR(1),
    created_date TIMESTAMP,
    created_by_user_login VARCHAR(250),
    last_modified_date TIMESTAMP,
    last_modified_by_user_login VARCHAR(250),
    PRIMARY KEY (order_payment_preference_id)
);

CREATE TABLE IF NOT EXISTS order_product_promo_code (
    order_id VARCHAR(20),
    product_promo_code_id VARCHAR(20),
    PRIMARY KEY (order_id, product_promo_code_id)
);

CREATE TABLE IF NOT EXISTS order_role (
    order_id VARCHAR(20),
    party_id VARCHAR(20),
    role_type_id VARCHAR(20),
    PRIMARY KEY (order_id, party_id, role_type_id)
);

CREATE TABLE IF NOT EXISTS order_shipment (
    order_id VARCHAR(20),
    order_item_seq_id VARCHAR(20),
    ship_group_seq_id VARCHAR(20),
    shipment_id VARCHAR(20),
    shipment_item_seq_id VARCHAR(20),
    quantity NUMERIC(18,6),
    PRIMARY KEY (order_id, order_item_seq_id, ship_group_seq_id, shipment_id, shipment_item_seq_id)
);

CREATE TABLE IF NOT EXISTS order_status (
    order_status_id VARCHAR(20),
    status_id VARCHAR(20),
    order_id VARCHAR(20),
    order_item_seq_id VARCHAR(20),
    order_payment_preference_id VARCHAR(20),
    status_datetime TIMESTAMP,
    status_user_login VARCHAR(250),
    change_reason VARCHAR(255),
    PRIMARY KEY (order_status_id)
);

CREATE TABLE IF NOT EXISTS order_summary_entry (
    entry_date DATE,
    product_id VARCHAR(20),
    facility_id VARCHAR(20),
    total_quantity NUMERIC(18,6),
    gross_sales NUMERIC(18,3),
    product_cost NUMERIC(18,3),
    PRIMARY KEY (entry_date, product_id, facility_id)
);

CREATE TABLE IF NOT EXISTS order_term (
    term_type_id VARCHAR(20),
    order_id VARCHAR(20),
    order_item_seq_id VARCHAR(20),
    term_value NUMERIC(18,3),
    term_days NUMERIC(20,0),
    text_value VARCHAR(255),
    description VARCHAR(255),
    uom_id VARCHAR(20),
    PRIMARY KEY (term_type_id, order_id, order_item_seq_id)
);

CREATE TABLE IF NOT EXISTS order_term_attribute (
    term_type_id VARCHAR(20),
    order_id VARCHAR(20),
    order_item_seq_id VARCHAR(20),
    attr_name VARCHAR(60),
    attr_value VARCHAR(255),
    attr_description VARCHAR(255),
    PRIMARY KEY (term_type_id, order_id, order_item_seq_id, attr_name)
);

CREATE TABLE IF NOT EXISTS order_type (
    order_type_id VARCHAR(20),
    parent_type_id VARCHAR(20),
    has_table CHAR(1),
    description VARCHAR(255),
    PRIMARY KEY (order_type_id)
);

CREATE TABLE IF NOT EXISTS order_type_attr (
    order_type_id VARCHAR(20),
    attr_name VARCHAR(60),
    description VARCHAR(255),
    PRIMARY KEY (order_type_id, attr_name)
);

CREATE TABLE IF NOT EXISTS product_order_item (
    order_id VARCHAR(20),
    order_item_seq_id VARCHAR(20),
    engagement_id VARCHAR(20),
    engagement_item_seq_id VARCHAR(20),
    product_id VARCHAR(20),
    PRIMARY KEY (order_id, order_item_seq_id, engagement_id, engagement_item_seq_id)
);

CREATE TABLE IF NOT EXISTS work_order_item_fulfillment (
    work_effort_id VARCHAR(20),
    order_id VARCHAR(20),
    order_item_seq_id VARCHAR(20),
    ship_group_seq_id VARCHAR(20),
    PRIMARY KEY (work_effort_id, order_id, order_item_seq_id)
);

CREATE TABLE IF NOT EXISTS quote (
    quote_id VARCHAR(20),
    quote_type_id VARCHAR(20),
    party_id VARCHAR(20),
    issue_date TIMESTAMP,
    status_id VARCHAR(20),
    currency_uom_id VARCHAR(20),
    product_store_id VARCHAR(20),
    sales_channel_enum_id VARCHAR(20),
    valid_from_date TIMESTAMP,
    valid_thru_date TIMESTAMP,
    quote_name VARCHAR(100),
    description VARCHAR(255),
    PRIMARY KEY (quote_id)
);

CREATE TABLE IF NOT EXISTS quote_attribute (
    quote_id VARCHAR(20),
    attr_name VARCHAR(60),
    attr_value VARCHAR(255),
    attr_description VARCHAR(255),
    PRIMARY KEY (quote_id, attr_name)
);

CREATE TABLE IF NOT EXISTS quote_coefficient (
    quote_id VARCHAR(20),
    coeff_name VARCHAR(60),
    coeff_value NUMERIC(18,6),
    PRIMARY KEY (quote_id, coeff_name)
);

CREATE TABLE IF NOT EXISTS quote_item (
    quote_id VARCHAR(20),
    quote_item_seq_id VARCHAR(20),
    product_id VARCHAR(20),
    product_feature_id VARCHAR(20),
    deliverable_type_id VARCHAR(20),
    skill_type_id VARCHAR(20),
    uom_id VARCHAR(20),
    work_effort_id VARCHAR(20),
    cust_request_id VARCHAR(20),
    cust_request_item_seq_id VARCHAR(20),
    quantity NUMERIC(18,6),
    selected_amount NUMERIC(18,6),
    quote_unit_price NUMERIC(18,3),
    reserv_start TIMESTAMP,
    reserv_length NUMERIC(18,6),
    reserv_persons NUMERIC(18,6),
    config_id VARCHAR(20),
    estimated_delivery_date TIMESTAMP,
    comments VARCHAR(255),
    is_promo CHAR(1),
    lead_time_days NUMERIC(20,0),
    PRIMARY KEY (quote_id, quote_item_seq_id)
);

CREATE TABLE IF NOT EXISTS quote_note (
    quote_id VARCHAR(20),
    note_id VARCHAR(20),
    PRIMARY KEY (quote_id, note_id)
);

CREATE TABLE IF NOT EXISTS quote_role (
    quote_id VARCHAR(20),
    party_id VARCHAR(20),
    role_type_id VARCHAR(20),
    from_date TIMESTAMP,
    thru_date TIMESTAMP,
    PRIMARY KEY (quote_id, party_id, role_type_id)
);

CREATE TABLE IF NOT EXISTS quote_term (
    term_type_id VARCHAR(20),
    quote_id VARCHAR(20),
    quote_item_seq_id VARCHAR(20),
    term_value NUMERIC(20,0),
    uom_id VARCHAR(20),
    term_days NUMERIC(20,0),
    text_value VARCHAR(255),
    description VARCHAR(255),
    PRIMARY KEY (term_type_id, quote_id, quote_item_seq_id)
);

CREATE TABLE IF NOT EXISTS quote_term_attribute (
    term_type_id VARCHAR(20),
    quote_id VARCHAR(20),
    quote_item_seq_id VARCHAR(20),
    attr_name VARCHAR(60),
    attr_value VARCHAR(255),
    attr_description VARCHAR(255),
    PRIMARY KEY (term_type_id, quote_id, quote_item_seq_id, attr_name)
);

CREATE TABLE IF NOT EXISTS quote_type (
    quote_type_id VARCHAR(20),
    parent_type_id VARCHAR(20),
    has_table CHAR(1),
    description VARCHAR(255),
    PRIMARY KEY (quote_type_id)
);

CREATE TABLE IF NOT EXISTS quote_type_attr (
    quote_type_id VARCHAR(20),
    attr_name VARCHAR(60),
    description VARCHAR(255),
    PRIMARY KEY (quote_type_id, attr_name)
);

CREATE TABLE IF NOT EXISTS quote_work_effort (
    quote_id VARCHAR(20),
    work_effort_id VARCHAR(20),
    PRIMARY KEY (quote_id, work_effort_id)
);

CREATE TABLE IF NOT EXISTS quote_adjustment (
    quote_adjustment_id VARCHAR(20),
    quote_adjustment_type_id VARCHAR(20),
    quote_id VARCHAR(20),
    quote_item_seq_id VARCHAR(20),
    comments VARCHAR(255),
    description VARCHAR(255),
    amount NUMERIC(18,3),
    product_promo_id VARCHAR(20),
    product_promo_rule_id VARCHAR(20),
    product_promo_action_seq_id VARCHAR(20),
    product_feature_id VARCHAR(20),
    corresponding_product_id VARCHAR(20),
    source_reference_id VARCHAR(60),
    source_percentage NUMERIC(18,6),
    customer_reference_id VARCHAR(60),
    primary_geo_id VARCHAR(20),
    secondary_geo_id VARCHAR(20),
    exempt_amount NUMERIC(18,3),
    tax_auth_geo_id VARCHAR(20),
    tax_auth_party_id VARCHAR(20),
    override_gl_account_id VARCHAR(20),
    include_in_tax CHAR(1),
    include_in_shipping CHAR(1),
    created_date TIMESTAMP,
    created_by_user_login VARCHAR(250),
    last_modified_date TIMESTAMP,
    last_modified_by_user_login VARCHAR(250),
    PRIMARY KEY (quote_adjustment_id)
);

CREATE TABLE IF NOT EXISTS cust_request (
    cust_request_id VARCHAR(20),
    cust_request_type_id VARCHAR(20),
    cust_request_category_id VARCHAR(20),
    status_id VARCHAR(20),
    from_party_id VARCHAR(20),
    priority NUMERIC(20,0),
    cust_request_date TIMESTAMP,
    response_required_date TIMESTAMP,
    cust_request_name VARCHAR(100),
    description VARCHAR(255),
    maximum_amount_uom_id VARCHAR(20),
    product_store_id VARCHAR(20),
    sales_channel_enum_id VARCHAR(20),
    fulfill_contact_mech_id VARCHAR(20),
    currency_uom_id VARCHAR(20),
    open_date_time TIMESTAMP,
    closed_date_time TIMESTAMP,
    internal_comment VARCHAR(255),
    reason VARCHAR(255),
    created_date TIMESTAMP,
    created_by_user_login VARCHAR(250),
    last_modified_date TIMESTAMP,
    last_modified_by_user_login VARCHAR(250),
    PRIMARY KEY (cust_request_id)
);

CREATE TABLE IF NOT EXISTS cust_request_attribute (
    cust_request_id VARCHAR(20),
    attr_name VARCHAR(60),
    attr_value VARCHAR(255),
    attr_description VARCHAR(255),
    PRIMARY KEY (cust_request_id, attr_name)
);

CREATE TABLE IF NOT EXISTS cust_request_category (
    cust_request_category_id VARCHAR(20),
    cust_request_type_id VARCHAR(20),
    description VARCHAR(255),
    PRIMARY KEY (cust_request_category_id)
);

CREATE TABLE IF NOT EXISTS cust_request_comm_event (
    cust_request_id VARCHAR(20),
    communication_event_id VARCHAR(20),
    PRIMARY KEY (cust_request_id, communication_event_id)
);

CREATE TABLE IF NOT EXISTS cust_request_content (
    cust_request_id VARCHAR(20),
    content_id VARCHAR(20),
    from_date TIMESTAMP,
    thru_date TIMESTAMP,
    PRIMARY KEY (cust_request_id, content_id, from_date)
);

CREATE TABLE IF NOT EXISTS cust_request_item (
    cust_request_id VARCHAR(20),
    cust_request_item_seq_id VARCHAR(20),
    cust_request_resolution_id VARCHAR(20),
    status_id VARCHAR(20),
    priority NUMERIC(20,0),
    sequence_num NUMERIC(20,0),
    required_by_date TIMESTAMP,
    product_id VARCHAR(20),
    quantity NUMERIC(18,6),
    selected_amount NUMERIC(18,6),
    maximum_amount NUMERIC(18,3),
    reserv_start TIMESTAMP,
    reserv_length NUMERIC(18,6),
    reserv_persons NUMERIC(18,6),
    config_id VARCHAR(20),
    description VARCHAR(255),
    story VARCHAR(255),
    PRIMARY KEY (cust_request_id, cust_request_item_seq_id)
);

CREATE TABLE IF NOT EXISTS cust_request_note (
    cust_request_id VARCHAR(20),
    note_id VARCHAR(20),
    PRIMARY KEY (cust_request_id, note_id)
);

CREATE TABLE IF NOT EXISTS cust_request_item_note (
    cust_request_id VARCHAR(20),
    cust_request_item_seq_id VARCHAR(20),
    note_id VARCHAR(20),
    PRIMARY KEY (cust_request_id, cust_request_item_seq_id, note_id)
);

CREATE TABLE IF NOT EXISTS cust_request_item_work_effort (
    cust_request_id VARCHAR(20),
    cust_request_item_seq_id VARCHAR(20),
    work_effort_id VARCHAR(20),
    PRIMARY KEY (cust_request_id, cust_request_item_seq_id, work_effort_id)
);

CREATE TABLE IF NOT EXISTS cust_request_resolution (
    cust_request_resolution_id VARCHAR(20),
    cust_request_type_id VARCHAR(20),
    description VARCHAR(255),
    PRIMARY KEY (cust_request_resolution_id)
);

CREATE TABLE IF NOT EXISTS cust_request_party (
    cust_request_id VARCHAR(20),
    party_id VARCHAR(20),
    role_type_id VARCHAR(20),
    from_date TIMESTAMP,
    thru_date TIMESTAMP,
    PRIMARY KEY (cust_request_id, party_id, role_type_id, from_date)
);

CREATE TABLE IF NOT EXISTS cust_request_status (
    cust_request_status_id VARCHAR(20),
    status_id VARCHAR(20),
    cust_request_id VARCHAR(20),
    cust_request_item_seq_id VARCHAR(20),
    status_date TIMESTAMP,
    change_by_user_login_id VARCHAR(250),
    PRIMARY KEY (cust_request_status_id)
);

CREATE TABLE IF NOT EXISTS cust_request_type (
    cust_request_type_id VARCHAR(20),
    parent_type_id VARCHAR(20),
    has_table CHAR(1),
    description VARCHAR(255),
    party_id VARCHAR(20),
    PRIMARY KEY (cust_request_type_id)
);

CREATE TABLE IF NOT EXISTS cust_request_type_attr (
    cust_request_type_id VARCHAR(20),
    attr_name VARCHAR(60),
    description VARCHAR(255),
    PRIMARY KEY (cust_request_type_id, attr_name)
);

CREATE TABLE IF NOT EXISTS cust_request_work_effort (
    cust_request_id VARCHAR(20),
    work_effort_id VARCHAR(20),
    PRIMARY KEY (cust_request_id, work_effort_id)
);

CREATE TABLE IF NOT EXISTS responding_party (
    responding_party_seq_id VARCHAR(20),
    cust_request_id VARCHAR(20),
    party_id VARCHAR(20),
    contact_mech_id VARCHAR(20),
    date_sent TIMESTAMP,
    PRIMARY KEY (responding_party_seq_id, cust_request_id, party_id)
);

CREATE TABLE IF NOT EXISTS desired_feature (
    desired_feature_id VARCHAR(20),
    requirement_id VARCHAR(20),
    product_feature_id VARCHAR(20),
    optional_ind CHAR(1),
    PRIMARY KEY (desired_feature_id, requirement_id)
);

CREATE TABLE IF NOT EXISTS order_requirement_commitment (
    order_id VARCHAR(20),
    order_item_seq_id VARCHAR(20),
    requirement_id VARCHAR(20),
    quantity NUMERIC(18,6),
    PRIMARY KEY (order_id, order_item_seq_id, requirement_id)
);

CREATE TABLE IF NOT EXISTS requirement (
    requirement_id VARCHAR(20),
    requirement_type_id VARCHAR(20),
    facility_id VARCHAR(20),
    deliverable_id VARCHAR(20),
    fixed_asset_id VARCHAR(20),
    product_id VARCHAR(20),
    status_id VARCHAR(20),
    description VARCHAR(255),
    requirement_start_date TIMESTAMP,
    required_by_date TIMESTAMP,
    estimated_budget NUMERIC(18,3),
    quantity NUMERIC(18,6),
    use_case VARCHAR(255),
    reason VARCHAR(255),
    created_date TIMESTAMP,
    created_by_user_login VARCHAR(250),
    last_modified_date TIMESTAMP,
    last_modified_by_user_login VARCHAR(250),
    facility_id_to VARCHAR(20),
    PRIMARY KEY (requirement_id)
);

CREATE TABLE IF NOT EXISTS requirement_attribute (
    requirement_id VARCHAR(20),
    attr_name VARCHAR(60),
    attr_value VARCHAR(255),
    attr_description VARCHAR(255),
    PRIMARY KEY (requirement_id, attr_name)
);

CREATE TABLE IF NOT EXISTS requirement_budget_allocation (
    budget_id VARCHAR(20),
    budget_item_seq_id VARCHAR(20),
    requirement_id VARCHAR(20),
    amount NUMERIC(18,3),
    PRIMARY KEY (budget_id, budget_item_seq_id, requirement_id)
);

CREATE TABLE IF NOT EXISTS requirement_cust_request (
    cust_request_id VARCHAR(20),
    cust_request_item_seq_id VARCHAR(20),
    requirement_id VARCHAR(20),
    PRIMARY KEY (cust_request_id, cust_request_item_seq_id, requirement_id)
);

CREATE TABLE IF NOT EXISTS requirement_role (
    requirement_id VARCHAR(20),
    party_id VARCHAR(20),
    role_type_id VARCHAR(20),
    from_date TIMESTAMP,
    thru_date TIMESTAMP,
    PRIMARY KEY (requirement_id, party_id, role_type_id, from_date)
);

CREATE TABLE IF NOT EXISTS requirement_status (
    requirement_id VARCHAR(20),
    status_id VARCHAR(20),
    status_date TIMESTAMP,
    change_by_user_login_id VARCHAR(250),
    PRIMARY KEY (requirement_id, status_id)
);

CREATE TABLE IF NOT EXISTS requirement_type (
    requirement_type_id VARCHAR(20),
    parent_type_id VARCHAR(20),
    has_table CHAR(1),
    description VARCHAR(255),
    PRIMARY KEY (requirement_type_id)
);

CREATE TABLE IF NOT EXISTS requirement_type_attr (
    requirement_type_id VARCHAR(20),
    attr_name VARCHAR(60),
    description VARCHAR(255),
    PRIMARY KEY (requirement_type_id, attr_name)
);

CREATE TABLE IF NOT EXISTS work_req_fulf_type (
    work_req_fulf_type_id VARCHAR(20),
    description VARCHAR(255),
    PRIMARY KEY (work_req_fulf_type_id)
);

CREATE TABLE IF NOT EXISTS work_requirement_fulfillment (
    requirement_id VARCHAR(20),
    work_effort_id VARCHAR(20),
    work_req_fulf_type_id VARCHAR(20),
    PRIMARY KEY (requirement_id, work_effort_id)
);

CREATE TABLE IF NOT EXISTS return_adjustment (
    return_adjustment_id VARCHAR(20),
    return_adjustment_type_id VARCHAR(20),
    return_id VARCHAR(20),
    return_item_seq_id VARCHAR(20),
    ship_group_seq_id VARCHAR(20),
    comments VARCHAR(255),
    description VARCHAR(255),
    return_type_id VARCHAR(20),
    order_adjustment_id VARCHAR(20),
    amount NUMERIC(18,6),
    product_promo_id VARCHAR(20),
    product_promo_rule_id VARCHAR(20),
    product_promo_action_seq_id VARCHAR(20),
    product_feature_id VARCHAR(20),
    corresponding_product_id VARCHAR(20),
    tax_authority_rate_seq_id VARCHAR(20),
    source_reference_id VARCHAR(60),
    source_percentage NUMERIC(18,6),
    customer_reference_id VARCHAR(60),
    primary_geo_id VARCHAR(20),
    secondary_geo_id VARCHAR(20),
    exempt_amount NUMERIC(18,3),
    tax_auth_geo_id VARCHAR(20),
    tax_auth_party_id VARCHAR(20),
    override_gl_account_id VARCHAR(20),
    include_in_tax CHAR(1),
    include_in_shipping CHAR(1),
    created_date TIMESTAMP,
    created_by_user_login VARCHAR(250),
    last_modified_date TIMESTAMP,
    last_modified_by_user_login VARCHAR(250),
    PRIMARY KEY (return_adjustment_id)
);

CREATE TABLE IF NOT EXISTS return_adjustment_type (
    return_adjustment_type_id VARCHAR(20),
    parent_type_id VARCHAR(20),
    has_table CHAR(1),
    description VARCHAR(255),
    PRIMARY KEY (return_adjustment_type_id)
);

CREATE TABLE IF NOT EXISTS return_header (
    return_id VARCHAR(20),
    return_header_type_id VARCHAR(20),
    status_id VARCHAR(20),
    created_by VARCHAR(250),
    from_party_id VARCHAR(20),
    to_party_id VARCHAR(20),
    payment_method_id VARCHAR(20),
    fin_account_id VARCHAR(20),
    billing_account_id VARCHAR(20),
    entry_date TIMESTAMP,
    origin_contact_mech_id VARCHAR(20),
    destination_facility_id VARCHAR(20),
    needs_inventory_receive CHAR(1),
    currency_uom_id VARCHAR(20),
    supplier_rma_id VARCHAR(20),
    PRIMARY KEY (return_id)
);

CREATE TABLE IF NOT EXISTS return_header_type (
    return_header_type_id VARCHAR(20),
    parent_type_id VARCHAR(20),
    description VARCHAR(255),
    PRIMARY KEY (return_header_type_id)
);

CREATE TABLE IF NOT EXISTS return_item (
    return_id VARCHAR(20),
    return_item_seq_id VARCHAR(20),
    return_reason_id VARCHAR(20),
    return_type_id VARCHAR(20),
    return_item_type_id VARCHAR(20),
    product_id VARCHAR(20),
    description VARCHAR(255),
    order_id VARCHAR(20),
    order_item_seq_id VARCHAR(20),
    status_id VARCHAR(20),
    expected_item_status VARCHAR(20),
    return_quantity NUMERIC(18,6),
    received_quantity NUMERIC(18,6),
    return_price NUMERIC(18,3),
    return_item_response_id VARCHAR(20),
    PRIMARY KEY (return_id, return_item_seq_id)
);

CREATE TABLE IF NOT EXISTS return_item_response (
    return_item_response_id VARCHAR(20),
    order_payment_preference_id VARCHAR(20),
    replacement_order_id VARCHAR(20),
    payment_id VARCHAR(20),
    billing_account_id VARCHAR(20),
    fin_account_trans_id VARCHAR(20),
    response_amount NUMERIC(18,3),
    response_date TIMESTAMP,
    PRIMARY KEY (return_item_response_id)
);

CREATE TABLE IF NOT EXISTS return_item_type (
    return_item_type_id VARCHAR(20),
    parent_type_id VARCHAR(20),
    description VARCHAR(255),
    PRIMARY KEY (return_item_type_id)
);

CREATE TABLE IF NOT EXISTS return_item_type_map (
    return_item_map_key VARCHAR(20),
    return_header_type_id VARCHAR(20),
    return_item_type_id VARCHAR(20),
    PRIMARY KEY (return_item_map_key, return_header_type_id)
);

CREATE TABLE IF NOT EXISTS return_reason (
    return_reason_id VARCHAR(20),
    description VARCHAR(255),
    sequence_id VARCHAR(20),
    PRIMARY KEY (return_reason_id)
);

CREATE TABLE IF NOT EXISTS return_status (
    return_status_id VARCHAR(20),
    status_id VARCHAR(20),
    return_id VARCHAR(20),
    return_item_seq_id VARCHAR(20),
    change_by_user_login_id VARCHAR(250),
    status_datetime TIMESTAMP,
    PRIMARY KEY (return_status_id)
);

CREATE TABLE IF NOT EXISTS return_type (
    return_type_id VARCHAR(20),
    parent_type_id VARCHAR(20),
    has_table CHAR(1),
    description VARCHAR(255),
    sequence_id VARCHAR(20),
    PRIMARY KEY (return_type_id)
);

CREATE TABLE IF NOT EXISTS return_item_billing (
    return_id VARCHAR(20),
    return_item_seq_id VARCHAR(20),
    invoice_id VARCHAR(20),
    invoice_item_seq_id VARCHAR(20),
    shipment_receipt_id VARCHAR(20),
    quantity NUMERIC(18,6),
    amount NUMERIC(18,3),
    PRIMARY KEY (return_id, return_item_seq_id, invoice_id, invoice_item_seq_id)
);

CREATE TABLE IF NOT EXISTS return_item_shipment (
    return_id VARCHAR(20),
    return_item_seq_id VARCHAR(20),
    shipment_id VARCHAR(20),
    shipment_item_seq_id VARCHAR(20),
    quantity NUMERIC(18,6),
    PRIMARY KEY (return_id, return_item_seq_id, shipment_id, shipment_item_seq_id)
);

CREATE TABLE IF NOT EXISTS return_contact_mech (
    return_id VARCHAR(20),
    contact_mech_purpose_type_id VARCHAR(20),
    contact_mech_id VARCHAR(20),
    PRIMARY KEY (return_id, contact_mech_purpose_type_id, contact_mech_id)
);

CREATE TABLE IF NOT EXISTS communication_event_return (
    return_id VARCHAR(20),
    communication_event_id VARCHAR(20),
    PRIMARY KEY (return_id, communication_event_id)
);

CREATE TABLE IF NOT EXISTS cart_abandoned_line (
    visit_id VARCHAR(20),
    cart_abandoned_line_seq_id VARCHAR(20),
    product_id VARCHAR(20),
    prod_catalog_id VARCHAR(20),
    quantity NUMERIC(18,6),
    reserv_start TIMESTAMP,
    reserv_length NUMERIC(18,6),
    reserv_persons NUMERIC(18,6),
    unit_price NUMERIC(18,3),
    reserv2nd_pp_perc NUMERIC(18,6),
    reserv_nth_pp_perc NUMERIC(18,6),
    config_id VARCHAR(20),
    total_with_adjustments NUMERIC(18,3),
    was_reserved CHAR(1),
    PRIMARY KEY (visit_id, cart_abandoned_line_seq_id)
);

CREATE TABLE IF NOT EXISTS shopping_list (
    shopping_list_id VARCHAR(20),
    shopping_list_type_id VARCHAR(20),
    parent_shopping_list_id VARCHAR(20),
    product_store_id VARCHAR(20),
    visitor_id VARCHAR(20),
    party_id VARCHAR(20),
    list_name VARCHAR(100),
    description VARCHAR(255),
    is_public CHAR(1),
    is_active CHAR(1),
    currency_uom VARCHAR(20),
    shipment_method_type_id VARCHAR(20),
    carrier_party_id VARCHAR(20),
    carrier_role_type_id VARCHAR(20),
    contact_mech_id VARCHAR(20),
    payment_method_id VARCHAR(20),
    recurrence_info_id VARCHAR(20),
    last_ordered_date TIMESTAMP,
    last_admin_modified TIMESTAMP,
    product_promo_code_id VARCHAR(20),
    PRIMARY KEY (shopping_list_id)
);

CREATE TABLE IF NOT EXISTS shopping_list_item (
    shopping_list_id VARCHAR(20),
    shopping_list_item_seq_id VARCHAR(20),
    product_id VARCHAR(20),
    quantity NUMERIC(18,6),
    modified_price NUMERIC(18,6),
    reserv_start TIMESTAMP,
    reserv_length NUMERIC(18,6),
    reserv_persons NUMERIC(18,6),
    quantity_purchased NUMERIC(18,6),
    config_id VARCHAR(20),
    PRIMARY KEY (shopping_list_id, shopping_list_item_seq_id)
);

CREATE TABLE IF NOT EXISTS shopping_list_item_attribute (
    shopping_list_id VARCHAR(20),
    shopping_list_item_seq_id VARCHAR(20),
    attr_name VARCHAR(60),
    attr_value VARCHAR(255),
    PRIMARY KEY (shopping_list_id, shopping_list_item_seq_id, attr_name)
);

CREATE TABLE IF NOT EXISTS shopping_list_item_survey (
    shopping_list_id VARCHAR(20),
    shopping_list_item_seq_id VARCHAR(20),
    survey_response_id VARCHAR(20),
    PRIMARY KEY (shopping_list_id, shopping_list_item_seq_id, survey_response_id)
);

CREATE TABLE IF NOT EXISTS shopping_list_type (
    shopping_list_type_id VARCHAR(20),
    description VARCHAR(255),
    PRIMARY KEY (shopping_list_type_id)
);

CREATE TABLE IF NOT EXISTS shopping_list_work_effort (
    shopping_list_id VARCHAR(20),
    work_effort_id VARCHAR(20),
    PRIMARY KEY (shopping_list_id, work_effort_id)
);

CREATE TABLE IF NOT EXISTS allocation_plan_type (
    plan_type_id VARCHAR(20),
    description VARCHAR(255),
    has_table CHAR(1),
    PRIMARY KEY (plan_type_id)
);

CREATE TABLE IF NOT EXISTS allocation_plan_header (
    plan_id VARCHAR(20),
    product_id VARCHAR(20),
    plan_type_id VARCHAR(20),
    plan_name VARCHAR(100),
    status_id VARCHAR(20),
    created_by_user_login VARCHAR(250),
    last_modified_by_user_login VARCHAR(250),
    PRIMARY KEY (plan_id, product_id)
);

CREATE TABLE IF NOT EXISTS allocation_plan_item (
    plan_id VARCHAR(20),
    plan_item_seq_id VARCHAR(20),
    status_id VARCHAR(20),
    plan_method_enum_id VARCHAR(20),
    order_id VARCHAR(20),
    order_item_seq_id VARCHAR(20),
    product_id VARCHAR(20),
    allocated_quantity NUMERIC(18,6),
    priority_seq_id VARCHAR(20),
    created_by_user_login VARCHAR(250),
    last_modified_by_user_login VARCHAR(250),
    PRIMARY KEY (plan_id, plan_item_seq_id, product_id)
);

