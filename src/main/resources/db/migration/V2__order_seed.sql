-- OFBiz orderseeddata.xml
INSERT INTO cust_request_type (cust_request_type_id, description, has_table) SELECT 'RF_BUGFIX', 'Request For Bug Fix', 'N' WHERE NOT EXISTS (SELECT 1 FROM cust_request_type WHERE cust_request_type_id = 'RF_BUGFIX');

INSERT INTO cust_request_type (cust_request_type_id, description, has_table) SELECT 'RF_CATALOG', 'Request For Catalog', 'N' WHERE NOT EXISTS (SELECT 1 FROM cust_request_type WHERE cust_request_type_id = 'RF_CATALOG');

INSERT INTO cust_request_type (cust_request_type_id, description, has_table) SELECT 'RF_FEATURE', 'Request For Feature', 'N' WHERE NOT EXISTS (SELECT 1 FROM cust_request_type WHERE cust_request_type_id = 'RF_FEATURE');

INSERT INTO cust_request_type (cust_request_type_id, description, has_table) SELECT 'RF_INFO', 'Request For Information', 'N' WHERE NOT EXISTS (SELECT 1 FROM cust_request_type WHERE cust_request_type_id = 'RF_INFO');

INSERT INTO cust_request_type (cust_request_type_id, description, has_table) SELECT 'RF_PROPOSAL', 'Request For Proposal', 'N' WHERE NOT EXISTS (SELECT 1 FROM cust_request_type WHERE cust_request_type_id = 'RF_PROPOSAL');

INSERT INTO cust_request_type (cust_request_type_id, description, has_table) SELECT 'RF_QUOTE', 'Request For Quote', 'N' WHERE NOT EXISTS (SELECT 1 FROM cust_request_type WHERE cust_request_type_id = 'RF_QUOTE');

INSERT INTO cust_request_type (cust_request_type_id, description, has_table) SELECT 'RF_SUPPORT', 'Request For Support', 'N' WHERE NOT EXISTS (SELECT 1 FROM cust_request_type WHERE cust_request_type_id = 'RF_SUPPORT');

INSERT INTO cust_request_type (cust_request_type_id, description, has_table) SELECT 'RF_PUR_QUOTE', 'Request For Purchase Quote', 'N' WHERE NOT EXISTS (SELECT 1 FROM cust_request_type WHERE cust_request_type_id = 'RF_PUR_QUOTE');

INSERT INTO cust_request_resolution (cust_request_resolution_id, cust_request_type_id, description) SELECT 'FIXED', 'RF_BUGFIX', 'Fixed' WHERE NOT EXISTS (SELECT 1 FROM cust_request_resolution WHERE cust_request_resolution_id = 'FIXED');

INSERT INTO cust_request_resolution (cust_request_resolution_id, cust_request_type_id, description) SELECT 'WORKS', 'RF_BUGFIX', 'Works For Me' WHERE NOT EXISTS (SELECT 1 FROM cust_request_resolution WHERE cust_request_resolution_id = 'WORKS');

INSERT INTO cust_request_resolution (cust_request_resolution_id, cust_request_type_id, description) SELECT 'WONTFIX', 'RF_BUGFIX', 'Won''t Fix' WHERE NOT EXISTS (SELECT 1 FROM cust_request_resolution WHERE cust_request_resolution_id = 'WONTFIX');

INSERT INTO cust_request_resolution (cust_request_resolution_id, cust_request_type_id, description) SELECT 'DUPLICATE', 'RF_FEATURE', 'Duplicate' WHERE NOT EXISTS (SELECT 1 FROM cust_request_resolution WHERE cust_request_resolution_id = 'DUPLICATE');

INSERT INTO cust_request_resolution (cust_request_resolution_id, cust_request_type_id, description) SELECT 'REJECTED', 'RF_FEATURE', 'Rejected' WHERE NOT EXISTS (SELECT 1 FROM cust_request_resolution WHERE cust_request_resolution_id = 'REJECTED');

INSERT INTO cust_request_resolution (cust_request_resolution_id, cust_request_type_id, description) SELECT 'IMPLEMENTED', 'RF_FEATURE', 'Implemented' WHERE NOT EXISTS (SELECT 1 FROM cust_request_resolution WHERE cust_request_resolution_id = 'IMPLEMENTED');

INSERT INTO order_adjustment_type (description, has_table, order_adjustment_type_id) SELECT 'Promotion', 'N', 'PROMOTION_ADJUSTMENT' WHERE NOT EXISTS (SELECT 1 FROM order_adjustment_type WHERE description = 'Promotion');

INSERT INTO order_adjustment_type (description, has_table, order_adjustment_type_id) SELECT 'Replacement', 'N', 'REPLACE_ADJUSTMENT' WHERE NOT EXISTS (SELECT 1 FROM order_adjustment_type WHERE description = 'Replacement');

INSERT INTO order_adjustment_type (description, has_table, order_adjustment_type_id) SELECT 'Discount', 'N', 'DISCOUNT_ADJUSTMENT' WHERE NOT EXISTS (SELECT 1 FROM order_adjustment_type WHERE description = 'Discount');

INSERT INTO order_adjustment_type (description, has_table, order_adjustment_type_id) SELECT 'Donation', 'N', 'DONATION_ADJUSTMENT' WHERE NOT EXISTS (SELECT 1 FROM order_adjustment_type WHERE description = 'Donation');

INSERT INTO order_adjustment_type (description, has_table, order_adjustment_type_id) SELECT 'Fee', 'N', 'FEE' WHERE NOT EXISTS (SELECT 1 FROM order_adjustment_type WHERE description = 'Fee');

INSERT INTO order_adjustment_type (description, has_table, order_adjustment_type_id) SELECT 'Miscellaneous Charges', 'N', 'MISCELLANEOUS_CHARGE' WHERE NOT EXISTS (SELECT 1 FROM order_adjustment_type WHERE description = 'Miscellaneous Charges');

INSERT INTO order_adjustment_type (description, has_table, order_adjustment_type_id) SELECT 'Sales Tax', 'N', 'SALES_TAX' WHERE NOT EXISTS (SELECT 1 FROM order_adjustment_type WHERE description = 'Sales Tax');

INSERT INTO order_adjustment_type (description, has_table, order_adjustment_type_id) SELECT 'VAT Tax (not added to totals)', 'N', 'VAT_TAX' WHERE NOT EXISTS (SELECT 1 FROM order_adjustment_type WHERE description = 'VAT Tax (not added to totals)');

INSERT INTO order_adjustment_type (description, has_table, order_adjustment_type_id) SELECT 'VAT Price Correction', 'N', 'VAT_PRICE_CORRECT' WHERE NOT EXISTS (SELECT 1 FROM order_adjustment_type WHERE description = 'VAT Price Correction');

INSERT INTO order_adjustment_type (description, has_table, order_adjustment_type_id) SELECT 'Shipping and Handling', 'N', 'SHIPPING_CHARGES' WHERE NOT EXISTS (SELECT 1 FROM order_adjustment_type WHERE description = 'Shipping and Handling');

INSERT INTO order_adjustment_type (description, has_table, order_adjustment_type_id) SELECT 'Surcharge', 'N', 'SURCHARGE_ADJUSTMENT' WHERE NOT EXISTS (SELECT 1 FROM order_adjustment_type WHERE description = 'Surcharge');

INSERT INTO order_adjustment_type (description, has_table, order_adjustment_type_id) SELECT 'Additional Feature', 'N', 'ADDITIONAL_FEATURE' WHERE NOT EXISTS (SELECT 1 FROM order_adjustment_type WHERE description = 'Additional Feature');

INSERT INTO order_adjustment_type (description, has_table, order_adjustment_type_id) SELECT 'Warranty', 'N', 'WARRANTY_ADJUSTMENT' WHERE NOT EXISTS (SELECT 1 FROM order_adjustment_type WHERE description = 'Warranty');

INSERT INTO order_adjustment_type (description, has_table, order_adjustment_type_id) SELECT 'Marketing Package Adjustment', 'N', 'MKTG_PKG_AUTO_ADJUST' WHERE NOT EXISTS (SELECT 1 FROM order_adjustment_type WHERE description = 'Marketing Package Adjustment');

INSERT INTO order_adjustment_type (description, has_table, order_adjustment_type_id) SELECT 'Deposit', 'N', 'DEPOSIT_ADJUSTMENT' WHERE NOT EXISTS (SELECT 1 FROM order_adjustment_type WHERE description = 'Deposit');

INSERT INTO order_denylist_type (order_denylist_type_id, description) SELECT 'DENYLIST_ADDRESS', 'Addresss' WHERE NOT EXISTS (SELECT 1 FROM order_denylist_type WHERE order_denylist_type_id = 'DENYLIST_ADDRESS');

INSERT INTO order_denylist_type (order_denylist_type_id, description) SELECT 'DENYLIST_CREDITCARD', 'Credit Card' WHERE NOT EXISTS (SELECT 1 FROM order_denylist_type WHERE order_denylist_type_id = 'DENYLIST_CREDITCARD');

INSERT INTO order_denylist_type (order_denylist_type_id, description) SELECT 'DENYLIST_EMAIL', 'E-Mail' WHERE NOT EXISTS (SELECT 1 FROM order_denylist_type WHERE order_denylist_type_id = 'DENYLIST_EMAIL');

INSERT INTO order_denylist_type (order_denylist_type_id, description) SELECT 'DENYLIST_PHONE', 'Phone Number' WHERE NOT EXISTS (SELECT 1 FROM order_denylist_type WHERE order_denylist_type_id = 'DENYLIST_PHONE');

INSERT INTO order_item_type (description, has_table, order_item_type_id) SELECT 'Purchase Order Specific', 'N', 'PURCHASE_SPECIFIC' WHERE NOT EXISTS (SELECT 1 FROM order_item_type WHERE description = 'Purchase Order Specific');

INSERT INTO order_item_type (description, has_table, order_item_type_id, parent_type_id) SELECT 'PO: Inventory', 'N', 'INVENTORY_ORDER_ITEM', 'PURCHASE_SPECIFIC' WHERE NOT EXISTS (SELECT 1 FROM order_item_type WHERE description = 'PO: Inventory');

INSERT INTO order_item_type (description, has_table, order_item_type_id, parent_type_id) SELECT 'PO: Supplies (to Expense)', 'N', 'SUPPLIES_ORDER_ITEM', 'PURCHASE_SPECIFIC' WHERE NOT EXISTS (SELECT 1 FROM order_item_type WHERE description = 'PO: Supplies (to Expense)');

INSERT INTO order_item_type (description, has_table, order_item_type_id, parent_type_id) SELECT 'PO: Fixed Asset', 'N', 'ASSET_ORDER_ITEM', 'PURCHASE_SPECIFIC' WHERE NOT EXISTS (SELECT 1 FROM order_item_type WHERE description = 'PO: Fixed Asset');

INSERT INTO order_item_type (description, has_table, order_item_type_id) SELECT 'Product Item', 'N', 'PRODUCT_ORDER_ITEM' WHERE NOT EXISTS (SELECT 1 FROM order_item_type WHERE description = 'Product Item');

INSERT INTO order_item_type (description, has_table, order_item_type_id) SELECT 'Work Item', 'N', 'WORK_ORDER_ITEM' WHERE NOT EXISTS (SELECT 1 FROM order_item_type WHERE description = 'Work Item');

INSERT INTO order_item_type (description, has_table, order_item_type_id) SELECT 'Rental Item', 'N', 'RENTAL_ORDER_ITEM' WHERE NOT EXISTS (SELECT 1 FROM order_item_type WHERE description = 'Rental Item');

INSERT INTO order_item_type (description, has_table, order_item_type_id) SELECT 'Bulk Item', 'N', 'BULK_ORDER_ITEM' WHERE NOT EXISTS (SELECT 1 FROM order_item_type WHERE description = 'Bulk Item');

INSERT INTO order_type (description, has_table, order_type_id) SELECT 'Purchase', 'N', 'PURCHASE_ORDER' WHERE NOT EXISTS (SELECT 1 FROM order_type WHERE description = 'Purchase');

INSERT INTO order_type (description, has_table, order_type_id) SELECT 'Sales', 'N', 'SALES_ORDER' WHERE NOT EXISTS (SELECT 1 FROM order_type WHERE description = 'Sales');

INSERT INTO order_item_assoc_type (description, has_table, order_item_assoc_type_id) SELECT 'Purchase Order', 'N', 'PURCHASE_ORDER' WHERE NOT EXISTS (SELECT 1 FROM order_item_assoc_type WHERE description = 'Purchase Order');

INSERT INTO order_item_assoc_type (description, has_table, order_item_assoc_type_id) SELECT 'Drop Shipment', 'N', 'DROP_SHIPMENT' WHERE NOT EXISTS (SELECT 1 FROM order_item_assoc_type WHERE description = 'Drop Shipment');

INSERT INTO order_item_assoc_type (description, has_table, order_item_assoc_type_id) SELECT 'Return Replacement', 'N', 'REPLACEMENT' WHERE NOT EXISTS (SELECT 1 FROM order_item_assoc_type WHERE description = 'Return Replacement');

INSERT INTO order_item_assoc_type (description, has_table, order_item_assoc_type_id) SELECT 'New Version', 'N', 'NEW_VERSION' WHERE NOT EXISTS (SELECT 1 FROM order_item_assoc_type WHERE description = 'New Version');

INSERT INTO order_item_assoc_type (description, has_table, order_item_assoc_type_id) SELECT 'Exchange Order', 'N', 'EXCHANGE' WHERE NOT EXISTS (SELECT 1 FROM order_item_assoc_type WHERE description = 'Exchange Order');

INSERT INTO enumeration_type (description, enum_type_id, has_table) SELECT 'Order Sales Channel', 'ORDER_SALES_CHANNEL', 'N' WHERE NOT EXISTS (SELECT 1 FROM enumeration_type WHERE description = 'Order Sales Channel');

INSERT INTO enumeration (description, enum_code, enum_id, sequence_id, enum_type_id) SELECT 'Web Channel', 'WEB_CHANNEL', 'WEB_SALES_CHANNEL', '01', 'ORDER_SALES_CHANNEL' WHERE NOT EXISTS (SELECT 1 FROM enumeration WHERE description = 'Web Channel');

INSERT INTO enumeration (description, enum_code, enum_id, sequence_id, enum_type_id) SELECT 'Fax Channel', 'FAX_CHANNEL', 'FAX_SALES_CHANNEL', '03', 'ORDER_SALES_CHANNEL' WHERE NOT EXISTS (SELECT 1 FROM enumeration WHERE description = 'Fax Channel');

INSERT INTO enumeration (description, enum_code, enum_id, sequence_id, enum_type_id) SELECT 'Phone Channel', 'PHONE_CHANNEL', 'PHONE_SALES_CHANNEL', '04', 'ORDER_SALES_CHANNEL' WHERE NOT EXISTS (SELECT 1 FROM enumeration WHERE description = 'Phone Channel');

INSERT INTO enumeration (description, enum_code, enum_id, sequence_id, enum_type_id) SELECT 'E-Mail Channel', 'EMAIL_CHANNEL', 'EMAIL_SALES_CHANNEL', '05', 'ORDER_SALES_CHANNEL' WHERE NOT EXISTS (SELECT 1 FROM enumeration WHERE description = 'E-Mail Channel');

INSERT INTO enumeration (description, enum_code, enum_id, sequence_id, enum_type_id) SELECT 'Snail Mail Channel', 'SNAIL_CHANNEL', 'SNAIL_SALES_CHANNEL', '06', 'ORDER_SALES_CHANNEL' WHERE NOT EXISTS (SELECT 1 FROM enumeration WHERE description = 'Snail Mail Channel');

INSERT INTO enumeration (description, enum_code, enum_id, sequence_id, enum_type_id) SELECT 'Affiliate Channel', 'AFFIL_CHANNEL', 'AFFIL_SALES_CHANNEL', '07', 'ORDER_SALES_CHANNEL' WHERE NOT EXISTS (SELECT 1 FROM enumeration WHERE description = 'Affiliate Channel');

INSERT INTO enumeration (description, enum_code, enum_id, sequence_id, enum_type_id) SELECT 'eBay Channel', 'EBAY_CHANNEL', 'EBAY_SALES_CHANNEL', '08', 'ORDER_SALES_CHANNEL' WHERE NOT EXISTS (SELECT 1 FROM enumeration WHERE description = 'eBay Channel');

INSERT INTO enumeration (description, enum_code, enum_id, sequence_id, enum_type_id) SELECT 'Unknown Channel', 'UNKOWN_CHANNEL', 'UNKNWN_SALES_CHANNEL', '99', 'ORDER_SALES_CHANNEL' WHERE NOT EXISTS (SELECT 1 FROM enumeration WHERE description = 'Unknown Channel');

INSERT INTO enumeration_type (description, enum_type_id, has_table) SELECT 'Order Item Change Type', 'ODR_ITM_CHANGE_TYPE', 'N' WHERE NOT EXISTS (SELECT 1 FROM enumeration_type WHERE description = 'Order Item Change Type');

INSERT INTO enumeration (description, enum_code, enum_id, sequence_id, enum_type_id) SELECT 'Order Item Update', 'ITM_UPDATE', 'ODR_ITM_UPDATE', '01', 'ODR_ITM_CHANGE_TYPE' WHERE NOT EXISTS (SELECT 1 FROM enumeration WHERE description = 'Order Item Update');

INSERT INTO enumeration (description, enum_code, enum_id, sequence_id, enum_type_id) SELECT 'Order Item Cancel', 'ITM_CANCEL', 'ODR_ITM_CANCEL', '02', 'ODR_ITM_CHANGE_TYPE' WHERE NOT EXISTS (SELECT 1 FROM enumeration WHERE description = 'Order Item Cancel');

INSERT INTO enumeration (description, enum_code, enum_id, sequence_id, enum_type_id) SELECT 'Order Item Append', 'ITM_APPEND', 'ODR_ITM_APPEND', '03', 'ODR_ITM_CHANGE_TYPE' WHERE NOT EXISTS (SELECT 1 FROM enumeration WHERE description = 'Order Item Append');

INSERT INTO enumeration_type (description, enum_type_id, has_table) SELECT 'Order Item Change Reason', 'ODR_ITM_CH_REASON', 'N' WHERE NOT EXISTS (SELECT 1 FROM enumeration_type WHERE description = 'Order Item Change Reason');

INSERT INTO enumeration (description, enum_code, enum_id, sequence_id, enum_type_id) SELECT 'Mis-Ordered Item', 'MISORDER', 'OICR_MISORDER_ITEM', '01', 'ODR_ITM_CH_REASON' WHERE NOT EXISTS (SELECT 1 FROM enumeration WHERE description = 'Mis-Ordered Item');

INSERT INTO enumeration (description, enum_code, enum_id, sequence_id, enum_type_id) SELECT 'Changed Mind', 'CHANGE_MIND', 'OICR_CHANGE_MIND', '02', 'ODR_ITM_CH_REASON' WHERE NOT EXISTS (SELECT 1 FROM enumeration WHERE description = 'Changed Mind');

INSERT INTO quote_type (description, has_table, quote_type_id) SELECT 'Other', 'N', 'OTHER_QUOTE' WHERE NOT EXISTS (SELECT 1 FROM quote_type WHERE description = 'Other');

INSERT INTO quote_type (description, has_table, quote_type_id) SELECT 'Product', 'N', 'PRODUCT_QUOTE' WHERE NOT EXISTS (SELECT 1 FROM quote_type WHERE description = 'Product');

INSERT INTO quote_type (description, has_table, quote_type_id) SELECT 'Proposal', 'N', 'PROPOSAL' WHERE NOT EXISTS (SELECT 1 FROM quote_type WHERE description = 'Proposal');

INSERT INTO quote_type (description, has_table, quote_type_id) SELECT 'Product Purchase', 'N', 'PURCHASE_QUOTE' WHERE NOT EXISTS (SELECT 1 FROM quote_type WHERE description = 'Product Purchase');

INSERT INTO requirement_type (description, has_table, requirement_type_id) SELECT 'Customer Requirement', 'N', 'CUSTOMER_REQUIREMENT' WHERE NOT EXISTS (SELECT 1 FROM requirement_type WHERE description = 'Customer Requirement');

INSERT INTO requirement_type (description, has_table, requirement_type_id) SELECT 'Internal Requirement', 'N', 'INTERNAL_REQUIREMENT' WHERE NOT EXISTS (SELECT 1 FROM requirement_type WHERE description = 'Internal Requirement');

INSERT INTO requirement_type (description, has_table, requirement_type_id) SELECT 'Product Requirement', 'N', 'PRODUCT_REQUIREMENT' WHERE NOT EXISTS (SELECT 1 FROM requirement_type WHERE description = 'Product Requirement');

INSERT INTO requirement_type (description, has_table, requirement_type_id) SELECT 'Work Requirement', 'N', 'WORK_REQUIREMENT' WHERE NOT EXISTS (SELECT 1 FROM requirement_type WHERE description = 'Work Requirement');

INSERT INTO requirement_type (description, requirement_type_id) SELECT 'Inter Facility Transfer Requirement', 'TRANSFER_REQUIREMENT' WHERE NOT EXISTS (SELECT 1 FROM requirement_type WHERE description = 'Inter Facility Transfer Requirement');

INSERT INTO shopping_list_type (description, shopping_list_type_id) SELECT 'Wish List', 'SLT_WISH_LIST' WHERE NOT EXISTS (SELECT 1 FROM shopping_list_type WHERE description = 'Wish List');

INSERT INTO shopping_list_type (description, shopping_list_type_id) SELECT 'Gift Registry', 'SLT_GIFT_REG' WHERE NOT EXISTS (SELECT 1 FROM shopping_list_type WHERE description = 'Gift Registry');

INSERT INTO shopping_list_type (description, shopping_list_type_id) SELECT 'Automatic Re-Orders', 'SLT_AUTO_REODR' WHERE NOT EXISTS (SELECT 1 FROM shopping_list_type WHERE description = 'Automatic Re-Orders');

INSERT INTO shopping_list_type (description, shopping_list_type_id) SELECT 'Frequent Purchases', 'SLT_FREQ_PURCHASES' WHERE NOT EXISTS (SELECT 1 FROM shopping_list_type WHERE description = 'Frequent Purchases');

INSERT INTO shopping_list_type (description, shopping_list_type_id) SELECT 'Special Purpose', 'SLT_SPEC_PURP' WHERE NOT EXISTS (SELECT 1 FROM shopping_list_type WHERE description = 'Special Purpose');

INSERT INTO status_type (description, has_table, status_type_id) SELECT 'Order', 'N', 'ORDER_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_type WHERE description = 'Order');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Created', '01', 'CREATED', 'ORDER_CREATED', 'ORDER_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Created');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Processing', '04', 'PROCESSING', 'ORDER_PROCESSING', 'ORDER_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Processing');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Approved', '05', 'APPROVED', 'ORDER_APPROVED', 'ORDER_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Approved');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Sent', '03', 'SENT', 'ORDER_SENT', 'ORDER_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Sent');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Held', '06', 'HELD', 'ORDER_HOLD', 'ORDER_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Held');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Completed', '10', 'COMPLETED', 'ORDER_COMPLETED', 'ORDER_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Completed');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Rejected', '98', 'REJECTED', 'ORDER_REJECTED', 'ORDER_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Rejected');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Cancelled', '99', 'CANCELLED', 'ORDER_CANCELLED', 'ORDER_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Cancelled');

INSERT INTO status_type (description, has_table, parent_type_id, status_type_id) SELECT 'Order Item', 'N', 'ORDER_STATUS', 'ORDER_ITEM_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_type WHERE description = 'Order Item');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Created', '01', 'CREATED', 'ITEM_CREATED', 'ORDER_ITEM_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Created');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Approved', '05', 'APPROVED', 'ITEM_APPROVED', 'ORDER_ITEM_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Approved');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Completed', '10', 'COMPLETED', 'ITEM_COMPLETED', 'ORDER_ITEM_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Completed');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Rejected', '98', 'REJECTED', 'ITEM_REJECTED', 'ORDER_ITEM_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Rejected');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Cancelled', '99', 'CANCELLED', 'ITEM_CANCELLED', 'ORDER_ITEM_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Cancelled');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ORDER_CREATED', 'ORDER_PROCESSING', 'Process Order' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ORDER_CREATED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ORDER_CREATED', 'ORDER_APPROVED', 'Approve Order' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ORDER_CREATED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ORDER_CREATED', 'ORDER_HOLD', 'Hold Order' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ORDER_CREATED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ORDER_CREATED', 'ORDER_REJECTED', 'Reject Order' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ORDER_CREATED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ORDER_CREATED', 'ORDER_CANCELLED', 'Cancel Order' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ORDER_CREATED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ORDER_PROCESSING', 'ORDER_HOLD', 'Hold Order' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ORDER_PROCESSING');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ORDER_PROCESSING', 'ORDER_APPROVED', 'Approve Order' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ORDER_PROCESSING');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ORDER_PROCESSING', 'ORDER_REJECTED', 'Reject Order' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ORDER_PROCESSING');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ORDER_PROCESSING', 'ORDER_CANCELLED', 'Cancel Order' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ORDER_PROCESSING');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ORDER_APPROVED', 'ORDER_SENT', 'Send Order' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ORDER_APPROVED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ORDER_APPROVED', 'ORDER_PROCESSING', 'Process Order' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ORDER_APPROVED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ORDER_APPROVED', 'ORDER_COMPLETED', 'Complete Order' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ORDER_APPROVED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ORDER_APPROVED', 'ORDER_CANCELLED', 'Cancel Order' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ORDER_APPROVED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ORDER_APPROVED', 'ORDER_HOLD', 'Hold Order' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ORDER_APPROVED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ORDER_HOLD', 'ORDER_PROCESSING', 'Process Order' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ORDER_HOLD');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ORDER_HOLD', 'ORDER_APPROVED', 'Approve Order' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ORDER_HOLD');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ORDER_HOLD', 'ORDER_CANCELLED', 'Cancel Order' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ORDER_HOLD');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ORDER_SENT', 'ORDER_COMPLETED', 'Order Completed' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ORDER_SENT');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ORDER_SENT', 'ORDER_CANCELLED', 'Order Cancelled' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ORDER_SENT');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ORDER_COMPLETED', 'ORDER_APPROVED', 'Approve Order' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ORDER_COMPLETED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ITEM_CREATED', 'ITEM_APPROVED', 'Approve Item' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ITEM_CREATED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ITEM_CREATED', 'ITEM_REJECTED', 'Reject Item' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ITEM_CREATED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ITEM_CREATED', 'ITEM_CANCELLED', 'Cancel Item' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ITEM_CREATED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ITEM_APPROVED', 'ITEM_COMPLETED', 'Complete Item' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ITEM_APPROVED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ITEM_APPROVED', 'ITEM_CANCELLED', 'Cancel Item' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ITEM_APPROVED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ITEM_COMPLETED', 'ITEM_APPROVED', 'Approve Item' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ITEM_COMPLETED');

INSERT INTO status_type (description, has_table, status_type_id) SELECT 'Payment Preference', 'N', 'PAYMENT_PREF_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_type WHERE description = 'Payment Preference');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Not-Received', '01', 'NOT_RECEIVED', 'PAYMENT_NOT_RECEIVED', 'PAYMENT_PREF_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Not-Received');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Received', '02', 'RECEIVED', 'PAYMENT_RECEIVED', 'PAYMENT_PREF_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Received');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Not-Authorized', '01', 'NOT_AUTHORIZED', 'PAYMENT_NOT_AUTH', 'PAYMENT_PREF_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Not-Authorized');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Authorized', '02', 'AUTHORIZED', 'PAYMENT_AUTHORIZED', 'PAYMENT_PREF_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Authorized');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Settled', '03', 'SETTLED', 'PAYMENT_SETTLED', 'PAYMENT_PREF_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Settled');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Declined', '04', 'DECLINED', 'PAYMENT_DECLINED', 'PAYMENT_PREF_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Declined');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Refunded', '05', 'REFUNDED', 'PAYMENT_REFUNDED', 'PAYMENT_PREF_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Refunded');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Cancelled', '99', 'CANCELLED', 'PAYMENT_CANCELLED', 'PAYMENT_PREF_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Cancelled');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'PAYMENT_NOT_RECEIVED', 'PAYMENT_RECEIVED', 'Payment Received' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'PAYMENT_NOT_RECEIVED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'PAYMENT_NOT_RECEIVED', 'PAYMENT_CANCELLED', 'Payment Cancelled' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'PAYMENT_NOT_RECEIVED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'PAYMENT_NOT_AUTH', 'PAYMENT_AUTHORIZED', 'Payment Authorized' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'PAYMENT_NOT_AUTH');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'PAYMENT_NOT_AUTH', 'PAYMENT_CANCELLED', 'Payment Cancelled' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'PAYMENT_NOT_AUTH');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'PAYMENT_AUTHORIZED', 'PAYMENT_SETTLED', 'Payment Settled' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'PAYMENT_AUTHORIZED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'PAYMENT_AUTHORIZED', 'PAYMENT_CANCELLED', 'Payment Cancelled' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'PAYMENT_AUTHORIZED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'PAYMENT_SETTLED', 'PAYMENT_REFUNDED', 'Payment Refunded' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'PAYMENT_SETTLED');

INSERT INTO status_type (description, has_table, status_type_id) SELECT 'Order Delivery Schedule', 'N', 'ORDER_DEL_SCH' WHERE NOT EXISTS (SELECT 1 FROM status_type WHERE description = 'Order Delivery Schedule');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Supplier Submitted', '01', 'SUBMITTED', 'ODS_SUBMITTED', 'ORDER_DEL_SCH' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Supplier Submitted');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Accepted', '02', 'ACCEPTED', 'ODS_ACCEPTED', 'ORDER_DEL_SCH' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Accepted');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Schedule Approved', '03', 'APPROVED', 'ODS_APPROVED', 'ORDER_DEL_SCH' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Schedule Approved');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Delivery Arranged', '04', 'ARRANGED', 'ODS_ARRANGED', 'ORDER_DEL_SCH' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Delivery Arranged');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Delivery Cancelled', '99', 'CANCELLED', 'ODS_CANCELLED', 'ORDER_DEL_SCH' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Delivery Cancelled');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ODS_SUBMITTED', 'ODS_ACCEPTED', 'Accept Delivery Information' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ODS_SUBMITTED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ODS_ACCEPTED', 'ODS_APPROVED', 'Approve Delivery Schedule' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ODS_ACCEPTED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ODS_APPROVED', 'ODS_ARRANGED', 'Arrange Delivery' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ODS_APPROVED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ODS_SUBMITTED', 'ODS_CANCELLED', 'Cancel Delivery' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ODS_SUBMITTED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ODS_ACCEPTED', 'ODS_CANCELLED', 'Cancel Delivery' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ODS_ACCEPTED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ODS_APPROVED', 'ODS_CANCELLED', 'Cancel Delivery' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ODS_APPROVED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ODS_ARRANGED', 'ODS_CANCELLED', 'Cancel Delivery' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ODS_ARRANGED');

INSERT INTO status_type (description, has_table, status_type_id) SELECT 'Order Return Status For Customer Returns', 'N', 'ORDER_RETURN_STTS' WHERE NOT EXISTS (SELECT 1 FROM status_type WHERE description = 'Order Return Status For Customer Returns');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Requested', '01', 'REQUESTED', 'RETURN_REQUESTED', 'ORDER_RETURN_STTS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Requested');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Accepted', '02', 'ACCEPTED', 'RETURN_ACCEPTED', 'ORDER_RETURN_STTS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Accepted');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Received', '03', 'RECEIVED', 'RETURN_RECEIVED', 'ORDER_RETURN_STTS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Received');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Completed', '10', 'COMPLETED', 'RETURN_COMPLETED', 'ORDER_RETURN_STTS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Completed');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Manual Refund Required', '11', 'MANUAL_REFUND', 'RETURN_MAN_REFUND', 'ORDER_RETURN_STTS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Manual Refund Required');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Cancelled', '99', 'CANCELLED', 'RETURN_CANCELLED', 'ORDER_RETURN_STTS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Cancelled');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'RETURN_REQUESTED', 'RETURN_ACCEPTED', 'Requested Return Accepted' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'RETURN_REQUESTED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'RETURN_REQUESTED', 'RETURN_CANCELLED', 'Requested Return Cancelled' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'RETURN_REQUESTED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'RETURN_ACCEPTED', 'RETURN_RECEIVED', 'Accepted Return Received' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'RETURN_ACCEPTED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'RETURN_ACCEPTED', 'RETURN_CANCELLED', 'Accepted Return Cancelled' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'RETURN_ACCEPTED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'RETURN_RECEIVED', 'RETURN_COMPLETED', 'Received Return Completed' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'RETURN_RECEIVED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'RETURN_RECEIVED', 'RETURN_CANCELLED', 'Received Return Cancelled' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'RETURN_RECEIVED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'RETURN_RECEIVED', 'RETURN_MAN_REFUND', 'Received Return Requires Manual Refund' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'RETURN_RECEIVED');

INSERT INTO status_type (description, has_table, status_type_id) SELECT 'Order Return Status For Supplier Returns', 'N', 'PORDER_RETURN_STTS' WHERE NOT EXISTS (SELECT 1 FROM status_type WHERE description = 'Order Return Status For Supplier Returns');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Requested', '01', 'REQUESTED', 'SUP_RETURN_REQUESTED', 'PORDER_RETURN_STTS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Requested');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Accepted', '02', 'ACCEPTED', 'SUP_RETURN_ACCEPTED', 'PORDER_RETURN_STTS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Accepted');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Shipped', '03', 'SHIPPED', 'SUP_RETURN_SHIPPED', 'PORDER_RETURN_STTS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Shipped');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Completed', '10', 'COMPLETED', 'SUP_RETURN_COMPLETED', 'PORDER_RETURN_STTS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Completed');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Cancelled', '99', 'CANCELLED', 'SUP_RETURN_CANCELLED', 'PORDER_RETURN_STTS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Cancelled');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'SUP_RETURN_REQUESTED', 'SUP_RETURN_ACCEPTED', 'Requested Return Accepted' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'SUP_RETURN_REQUESTED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'SUP_RETURN_REQUESTED', 'SUP_RETURN_CANCELLED', 'Requested Return Cancelled' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'SUP_RETURN_REQUESTED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'SUP_RETURN_ACCEPTED', 'SUP_RETURN_SHIPPED', 'Accepted Return Shipped' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'SUP_RETURN_ACCEPTED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'SUP_RETURN_ACCEPTED', 'SUP_RETURN_CANCELLED', 'Accepted Return Cancelled' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'SUP_RETURN_ACCEPTED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'SUP_RETURN_SHIPPED', 'SUP_RETURN_COMPLETED', 'Shipped Return Completed' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'SUP_RETURN_SHIPPED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'SUP_RETURN_SHIPPED', 'SUP_RETURN_CANCELLED', 'Shipped Return Cancelled' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'SUP_RETURN_SHIPPED');

INSERT INTO status_type (description, has_table, status_type_id) SELECT 'Custom Request Status', 'N', 'CUSTREQ_STTS' WHERE NOT EXISTS (SELECT 1 FROM status_type WHERE description = 'Custom Request Status');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Draft', '00', 'DRAFT', 'CRQ_DRAFT', 'CUSTREQ_STTS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Draft');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Submitted', '01', 'SUBMITTED', 'CRQ_SUBMITTED', 'CUSTREQ_STTS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Submitted');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Accepted', '02', 'ACCEPTED', 'CRQ_ACCEPTED', 'CUSTREQ_STTS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Accepted');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Reviewed', '03', 'REVIEWED', 'CRQ_REVIEWED', 'CUSTREQ_STTS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Reviewed');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Pending Cust.', '09', 'PENDING', 'CRQ_PENDING', 'CUSTREQ_STTS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Pending Cust.');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Completed', '04', 'COMPLETED', 'CRQ_COMPLETED', 'CUSTREQ_STTS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Completed');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Rejected', '98', 'REJECTED', 'CRQ_REJECTED', 'CUSTREQ_STTS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Rejected');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Cancelled', '99', 'CANCELLED', 'CRQ_CANCELLED', 'CUSTREQ_STTS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Cancelled');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'CRQ_DRAFT', 'CRQ_ACCEPTED', 'Accept Request' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'CRQ_DRAFT');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'CRQ_DRAFT', 'CRQ_SUBMITTED', 'Submit Request' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'CRQ_DRAFT');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'CRQ_DRAFT', 'CRQ_CANCELLED', 'Cancel Request' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'CRQ_DRAFT');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'CRQ_SUBMITTED', 'CRQ_ACCEPTED', 'Accept Request' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'CRQ_SUBMITTED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'CRQ_SUBMITTED', 'CRQ_COMPLETED', 'Complete Request' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'CRQ_SUBMITTED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'CRQ_SUBMITTED', 'CRQ_REJECTED', 'Reject Request' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'CRQ_SUBMITTED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'CRQ_SUBMITTED', 'CRQ_CANCELLED', 'Cancel Request' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'CRQ_SUBMITTED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'CRQ_SUBMITTED', 'CRQ_PENDING', 'Pending customer' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'CRQ_SUBMITTED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'CRQ_PENDING', 'CRQ_SUBMITTED', 'Submit Request' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'CRQ_PENDING');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'CRQ_PENDING', 'CRQ_ACCEPTED', 'Accept Request' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'CRQ_PENDING');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'CRQ_PENDING', 'CRQ_REVIEWED', 'Review Request' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'CRQ_PENDING');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'CRQ_PENDING', 'CRQ_CANCELLED', 'Cancel Request' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'CRQ_PENDING');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'CRQ_ACCEPTED', 'CRQ_REVIEWED', 'Review Request' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'CRQ_ACCEPTED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'CRQ_ACCEPTED', 'CRQ_COMPLETED', 'Complete Request' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'CRQ_ACCEPTED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'CRQ_ACCEPTED', 'CRQ_CANCELLED', 'Cancel Request' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'CRQ_ACCEPTED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'CRQ_ACCEPTED', 'CRQ_PENDING', 'Pending Customer' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'CRQ_ACCEPTED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'CRQ_REVIEWED', 'CRQ_COMPLETED', 'Complete Request' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'CRQ_REVIEWED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'CRQ_REVIEWED', 'CRQ_CANCELLED', 'Cancel Request' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'CRQ_REVIEWED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'CRQ_REVIEWED', 'CRQ_PENDING', 'Pending Customer' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'CRQ_REVIEWED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'CRQ_COMPLETED', 'CRQ_REVIEWED', 'Re-open Request' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'CRQ_COMPLETED');

INSERT INTO status_type (description, has_table, status_type_id) SELECT 'Requirement Status', 'N', 'REQUIREMENT_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_type WHERE description = 'Requirement Status');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Proposed', '01', 'PROPOSED', 'REQ_PROPOSED', 'REQUIREMENT_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Proposed');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Created', '01', 'CREATED', 'REQ_CREATED', 'REQUIREMENT_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Created');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Approved', '02', 'APPROVED', 'REQ_APPROVED', 'REQUIREMENT_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Approved');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Ordered', '03', 'ORDERED', 'REQ_ORDERED', 'REQUIREMENT_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Ordered');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Rejected', '98', 'REJECTED', 'REQ_REJECTED', 'REQUIREMENT_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Rejected');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'REQ_PROPOSED', 'REQ_APPROVED', 'Accept Requirement' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'REQ_PROPOSED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'REQ_PROPOSED', 'REQ_REJECTED', 'Reject Requirement' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'REQ_PROPOSED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'REQ_CREATED', 'REQ_APPROVED', 'Accept Requirement' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'REQ_CREATED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'REQ_CREATED', 'REQ_REJECTED', 'Reject Requirement' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'REQ_CREATED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'REQ_APPROVED', 'REQ_ORDERED', 'Order Requirement' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'REQ_APPROVED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'REQ_APPROVED', 'REQ_REJECTED', 'Reject Requirement' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'REQ_APPROVED');

INSERT INTO status_type (description, has_table, status_type_id) SELECT 'Quote Status', 'N', 'QUOTE_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_type WHERE description = 'Quote Status');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Created', '01', 'CREATED', 'QUO_CREATED', 'QUOTE_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Created');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Approved', '02', 'APPROVED', 'QUO_APPROVED', 'QUOTE_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Approved');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Ordered', '03', 'ORDERED', 'QUO_ORDERED', 'QUOTE_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Ordered');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Rejected', '98', 'REJECTED', 'QUO_REJECTED', 'QUOTE_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Rejected');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'QUO_CREATED', 'QUO_APPROVED', 'Accept Quote' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'QUO_CREATED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'QUO_CREATED', 'QUO_REJECTED', 'Reject Quote' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'QUO_CREATED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'QUO_APPROVED', 'QUO_ORDERED', 'Order Quote' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'QUO_APPROVED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'QUO_APPROVED', 'QUO_REJECTED', 'Reject Quote' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'QUO_APPROVED');

INSERT INTO return_adjustment_type (description, has_table, return_adjustment_type_id) SELECT 'Return Promotion', 'N', 'RET_PROMOTION_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_adjustment_type WHERE description = 'Return Promotion');

INSERT INTO return_adjustment_type (description, has_table, return_adjustment_type_id) SELECT 'Return Replacement', 'N', 'RET_REPLACE_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_adjustment_type WHERE description = 'Return Replacement');

INSERT INTO return_adjustment_type (description, has_table, return_adjustment_type_id) SELECT 'Return Discount', 'N', 'RET_DISCOUNT_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_adjustment_type WHERE description = 'Return Discount');

INSERT INTO return_adjustment_type (description, has_table, return_adjustment_type_id) SELECT 'Return Fee', 'N', 'RET_FEE_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_adjustment_type WHERE description = 'Return Fee');

INSERT INTO return_adjustment_type (description, has_table, return_adjustment_type_id) SELECT 'Return Miscellaneous Charges', 'N', 'RET_MISC_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_adjustment_type WHERE description = 'Return Miscellaneous Charges');

INSERT INTO return_adjustment_type (description, has_table, return_adjustment_type_id) SELECT 'Return Sales Tax', 'N', 'RET_SALES_TAX_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_adjustment_type WHERE description = 'Return Sales Tax');

INSERT INTO return_adjustment_type (description, has_table, return_adjustment_type_id) SELECT 'Return VAT Tax', 'N', 'RET_VAT_TAX_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_adjustment_type WHERE description = 'Return VAT Tax');

INSERT INTO return_adjustment_type (description, has_table, return_adjustment_type_id) SELECT 'Return VAT Price Correction', 'N', 'RET_VAT_PC_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_adjustment_type WHERE description = 'Return VAT Price Correction');

INSERT INTO return_adjustment_type (description, has_table, return_adjustment_type_id) SELECT 'Return Shipping and Handling', 'N', 'RET_SHIPPING_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_adjustment_type WHERE description = 'Return Shipping and Handling');

INSERT INTO return_adjustment_type (description, has_table, return_adjustment_type_id) SELECT 'Return Surcharge', 'N', 'RET_SURCHARGE_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_adjustment_type WHERE description = 'Return Surcharge');

INSERT INTO return_adjustment_type (description, has_table, return_adjustment_type_id) SELECT 'Return Additional Feature', 'N', 'RET_ADD_FEATURE_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_adjustment_type WHERE description = 'Return Additional Feature');

INSERT INTO return_adjustment_type (description, has_table, return_adjustment_type_id) SELECT 'Return Warranty', 'N', 'RET_WARRANTY_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_adjustment_type WHERE description = 'Return Warranty');

INSERT INTO return_adjustment_type (description, has_table, return_adjustment_type_id) SELECT 'Return Marketing Package Adjustment', 'N', 'RET_MKTG_PKG_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_adjustment_type WHERE description = 'Return Marketing Package Adjustment');

INSERT INTO return_adjustment_type (description, has_table, return_adjustment_type_id) SELECT 'Return Manual Adjustment', 'N', 'RET_MAN_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_adjustment_type WHERE description = 'Return Manual Adjustment');

INSERT INTO return_header_type (description, return_header_type_id) SELECT 'Return from Customer', 'CUSTOMER_RETURN' WHERE NOT EXISTS (SELECT 1 FROM return_header_type WHERE description = 'Return from Customer');

INSERT INTO return_header_type (description, return_header_type_id) SELECT 'Return to Vendor', 'VENDOR_RETURN' WHERE NOT EXISTS (SELECT 1 FROM return_header_type WHERE description = 'Return to Vendor');

INSERT INTO return_item_type (description, return_item_type_id) SELECT 'Return Non-Product Item', 'RET_NPROD_ITEM' WHERE NOT EXISTS (SELECT 1 FROM return_item_type WHERE description = 'Return Non-Product Item');

INSERT INTO return_item_type (description, return_item_type_id) SELECT 'Return Product Item', 'RET_PROD_ITEM' WHERE NOT EXISTS (SELECT 1 FROM return_item_type WHERE description = 'Return Product Item');

INSERT INTO return_item_type (description, return_item_type_id, parent_type_id) SELECT 'Return Finished Good Item', 'RET_FPROD_ITEM', 'RET_PROD_ITEM' WHERE NOT EXISTS (SELECT 1 FROM return_item_type WHERE description = 'Return Finished Good Item');

INSERT INTO return_item_type (description, return_item_type_id, parent_type_id) SELECT 'Return Digital Good Item', 'RET_DPROD_ITEM', 'RET_PROD_ITEM' WHERE NOT EXISTS (SELECT 1 FROM return_item_type WHERE description = 'Return Digital Good Item');

INSERT INTO return_item_type (description, return_item_type_id, parent_type_id) SELECT 'Return Finished/Digital Good Item', 'RET_FDPROD_ITEM', 'RET_PROD_ITEM' WHERE NOT EXISTS (SELECT 1 FROM return_item_type WHERE description = 'Return Finished/Digital Good Item');

INSERT INTO return_item_type (description, return_item_type_id, parent_type_id) SELECT 'Return Raw Material Good Item', 'RET_RPROD_ITEM', 'RET_PROD_ITEM' WHERE NOT EXISTS (SELECT 1 FROM return_item_type WHERE description = 'Return Raw Material Good Item');

INSERT INTO return_item_type (description, return_item_type_id, parent_type_id) SELECT 'Return Product-Feature Item', 'RET_PROD_FEATR_ITEM', 'RET_PROD_ITEM' WHERE NOT EXISTS (SELECT 1 FROM return_item_type WHERE description = 'Return Product-Feature Item');

INSERT INTO return_item_type (description, return_item_type_id, parent_type_id) SELECT 'Return Service Product Item', 'RET_SPROD_ITEM', 'RET_PROD_ITEM' WHERE NOT EXISTS (SELECT 1 FROM return_item_type WHERE description = 'Return Service Product Item');

INSERT INTO return_item_type (description, return_item_type_id, parent_type_id) SELECT 'Return Work-Effort Item', 'RET_WE_ITEM', 'RET_NPROD_ITEM' WHERE NOT EXISTS (SELECT 1 FROM return_item_type WHERE description = 'Return Work-Effort Item');

INSERT INTO return_item_type (description, return_item_type_id, parent_type_id) SELECT 'Return Time-Entry Item', 'RET_TE_ITEM', 'RET_NPROD_ITEM' WHERE NOT EXISTS (SELECT 1 FROM return_item_type WHERE description = 'Return Time-Entry Item');

INSERT INTO return_item_type (description, return_item_type_id, parent_type_id) SELECT 'Return Raw Material Item', 'RET_MPROD_ITEM', 'RET_PROD_ITEM' WHERE NOT EXISTS (SELECT 1 FROM return_item_type WHERE description = 'Return Raw Material Item');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'CUSTOMER_RETURN', 'FINISHED_GOOD', 'RET_FPROD_ITEM' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'CUSTOMER_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'CUSTOMER_RETURN', 'MARKETING_PKG_AUTO', 'RET_FPROD_ITEM' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'CUSTOMER_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'CUSTOMER_RETURN', 'MARKETING_PKG_PICK', 'RET_FPROD_ITEM' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'CUSTOMER_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'CUSTOMER_RETURN', 'AGGREGATED_CONF', 'RET_FPROD_ITEM' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'CUSTOMER_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'CUSTOMER_RETURN', 'DIGITAL_GOOD', 'RET_DPROD_ITEM' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'CUSTOMER_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'CUSTOMER_RETURN', 'FINDIG_GOOD', 'RET_FDPROD_ITEM' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'CUSTOMER_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'CUSTOMER_RETURN', 'RAW_MATERIAL', 'RET_RPROD_ITEM' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'CUSTOMER_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'CUSTOMER_RETURN', 'PROMOTION_ADJUSTMENT', 'RET_PROMOTION_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'CUSTOMER_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'CUSTOMER_RETURN', 'REPLACE_ADJUSTMENT', 'RET_REPLACE_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'CUSTOMER_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'CUSTOMER_RETURN', 'DISCOUNT_ADJUSTMENT', 'RET_DISCOUNT_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'CUSTOMER_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'CUSTOMER_RETURN', 'FEE', 'RET_FEE_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'CUSTOMER_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'CUSTOMER_RETURN', 'MISCELLANEOUS_CHARGE', 'RET_MISC_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'CUSTOMER_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'CUSTOMER_RETURN', 'SALES_TAX', 'RET_SALES_TAX_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'CUSTOMER_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'CUSTOMER_RETURN', 'VAT_TAX', 'RET_VAT_TAX_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'CUSTOMER_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'CUSTOMER_RETURN', 'VAT_PRICE_CORRECT', 'RET_VAT_PC_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'CUSTOMER_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'CUSTOMER_RETURN', 'SHIPPING_CHARGES', 'RET_SHIPPING_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'CUSTOMER_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'CUSTOMER_RETURN', 'SURCHARGE_ADJUSTMENT', 'RET_SURCHARGE_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'CUSTOMER_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'CUSTOMER_RETURN', 'ADDITIONAL_FEATURE', 'RET_ADD_FEATURE_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'CUSTOMER_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'CUSTOMER_RETURN', 'WARRANTY_ADJUSTMENT', 'RET_WARRANTY_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'CUSTOMER_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'CUSTOMER_RETURN', 'RENTAL_ORDER_ITEM', 'RET_FPROD_ITEM' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'CUSTOMER_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'CUSTOMER_RETURN', 'ASSET_USAGE_OUT_IN', 'RET_FPROD_ITEM' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'CUSTOMER_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'CUSTOMER_RETURN', 'SERVICE_PRODUCT', 'RET_SPROD_ITEM' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'CUSTOMER_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'CUSTOMER_RETURN', 'SERVICE', 'RET_SPROD_ITEM' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'CUSTOMER_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'CUSTOMER_RETURN', 'RAW_MATERIAL', 'RET_MPROD_ITEM' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'CUSTOMER_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'VENDOR_RETURN', 'FINISHED_GOOD', 'RET_FPROD_ITEM' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'VENDOR_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'VENDOR_RETURN', 'MARKETING_PKG_AUTO', 'RET_FPROD_ITEM' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'VENDOR_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'VENDOR_RETURN', 'MARKETING_PKG_PICK', 'RET_FPROD_ITEM' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'VENDOR_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'VENDOR_RETURN', 'AGGREGATED_CONF', 'RET_FPROD_ITEM' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'VENDOR_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'VENDOR_RETURN', 'DIGITAL_GOOD', 'RET_DPROD_ITEM' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'VENDOR_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'VENDOR_RETURN', 'FINDIG_GOOD', 'RET_FDPROD_ITEM' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'VENDOR_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'VENDOR_RETURN', 'RAW_MATERIAL', 'RET_RPROD_ITEM' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'VENDOR_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'VENDOR_RETURN', 'PROMOTION_ADJUSTMENT', 'RET_PROMOTION_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'VENDOR_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'VENDOR_RETURN', 'REPLACE_ADJUSTMENT', 'RET_REPLACE_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'VENDOR_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'VENDOR_RETURN', 'DISCOUNT_ADJUSTMENT', 'RET_DISCOUNT_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'VENDOR_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'VENDOR_RETURN', 'FEE', 'RET_FEE_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'VENDOR_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'VENDOR_RETURN', 'MISCELLANEOUS_CHARGE', 'RET_MISC_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'VENDOR_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'VENDOR_RETURN', 'SALES_TAX', 'RET_SALES_TAX_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'VENDOR_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'VENDOR_RETURN', 'VAT_TAX', 'RET_VAT_TAX_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'VENDOR_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'VENDOR_RETURN', 'VAT_PRICE_CORRECT', 'RET_VAT_PC_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'VENDOR_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'VENDOR_RETURN', 'SHIPPING_CHARGES', 'RET_SHIPPING_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'VENDOR_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'VENDOR_RETURN', 'SURCHARGE_ADJUSTMENT', 'RET_SURCHARGE_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'VENDOR_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'VENDOR_RETURN', 'ADDITIONAL_FEATURE', 'RET_ADD_FEATURE_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'VENDOR_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'VENDOR_RETURN', 'WARRANTY_ADJUSTMENT', 'RET_WARRANTY_ADJ' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'VENDOR_RETURN');

INSERT INTO return_item_type_map (return_header_type_id, return_item_map_key, return_item_type_id) SELECT 'VENDOR_RETURN', 'RAW_MATERIAL', 'RET_MPROD_ITEM' WHERE NOT EXISTS (SELECT 1 FROM return_item_type_map WHERE return_header_type_id = 'VENDOR_RETURN');

INSERT INTO return_reason (sequence_id, return_reason_id, description) SELECT '01', 'RTN_NOT_WANT', 'Did Not Want Item' WHERE NOT EXISTS (SELECT 1 FROM return_reason WHERE sequence_id = '01');

INSERT INTO return_reason (sequence_id, return_reason_id, description) SELECT '02', 'RTN_DEFECTIVE_ITEM', 'Defective Item' WHERE NOT EXISTS (SELECT 1 FROM return_reason WHERE sequence_id = '02');

INSERT INTO return_reason (sequence_id, return_reason_id, description) SELECT '03', 'RTN_MISSHIP_ITEM', 'Mis-Shipped Item' WHERE NOT EXISTS (SELECT 1 FROM return_reason WHERE sequence_id = '03');

INSERT INTO return_reason (sequence_id, return_reason_id, description) SELECT '04', 'RTN_DIG_FILL_FAIL', 'Digital Fulfillment Failed' WHERE NOT EXISTS (SELECT 1 FROM return_reason WHERE sequence_id = '04');

INSERT INTO return_reason (sequence_id, return_reason_id, description) SELECT '05', 'RTN_COD_REJECT', 'COD Payment Rejected' WHERE NOT EXISTS (SELECT 1 FROM return_reason WHERE sequence_id = '05');

INSERT INTO return_reason (sequence_id, return_reason_id, description) SELECT '06', 'RTN_SIZE_EXCHANGE', 'Size Exchange' WHERE NOT EXISTS (SELECT 1 FROM return_reason WHERE sequence_id = '06');

INSERT INTO return_reason (sequence_id, return_reason_id, description) SELECT '07', 'RTN_NORMAL_RETURN', 'Normal Return' WHERE NOT EXISTS (SELECT 1 FROM return_reason WHERE sequence_id = '07');

INSERT INTO return_type (sequence_id, return_type_id, description, has_table) SELECT '01', 'RTN_CREDIT', 'Store Credit', 'N' WHERE NOT EXISTS (SELECT 1 FROM return_type WHERE sequence_id = '01');

INSERT INTO return_type (sequence_id, return_type_id, description, has_table) SELECT '02', 'RTN_REFUND', 'Refund', 'N' WHERE NOT EXISTS (SELECT 1 FROM return_type WHERE sequence_id = '02');

INSERT INTO return_type (sequence_id, return_type_id, description, has_table) SELECT '03', 'RTN_REPLACE', 'Wait Replacement', 'N' WHERE NOT EXISTS (SELECT 1 FROM return_type WHERE sequence_id = '03');

INSERT INTO return_type (sequence_id, return_type_id, description, has_table) SELECT '04', 'RTN_CSREPLACE', 'Cross-Ship Replacement', 'N' WHERE NOT EXISTS (SELECT 1 FROM return_type WHERE sequence_id = '04');

INSERT INTO return_type (sequence_id, return_type_id, description, has_table) SELECT '05', 'RTN_REPAIR_REPLACE', 'Repair Replacement', 'N' WHERE NOT EXISTS (SELECT 1 FROM return_type WHERE sequence_id = '05');

INSERT INTO return_type (sequence_id, return_type_id, description, has_table) SELECT '06', 'RTN_WAIT_REPLACE_RES', 'Wait Replacement Reserved', 'N' WHERE NOT EXISTS (SELECT 1 FROM return_type WHERE sequence_id = '06');

INSERT INTO return_type (sequence_id, return_type_id, description, has_table) SELECT '07', 'RTN_REPLACE_IMMEDIAT', 'Replace Immediately', 'N' WHERE NOT EXISTS (SELECT 1 FROM return_type WHERE sequence_id = '07');

INSERT INTO return_type (sequence_id, return_type_id, description, has_table) SELECT '08', 'RTN_REFUND_IMMEDIATE', 'Refund immediately', 'N' WHERE NOT EXISTS (SELECT 1 FROM return_type WHERE sequence_id = '08');

INSERT INTO return_type (sequence_id, return_type_id, description, has_table) SELECT '09', 'RTN_RENTAL', 'Rental', 'N' WHERE NOT EXISTS (SELECT 1 FROM return_type WHERE sequence_id = '09');

INSERT INTO work_req_fulf_type (description, work_req_fulf_type_id) SELECT 'Implements', 'WRF_IMPLEMENTS' WHERE NOT EXISTS (SELECT 1 FROM work_req_fulf_type WHERE description = 'Implements');

INSERT INTO work_req_fulf_type (description, work_req_fulf_type_id) SELECT 'Fixes', 'WRF_FIXES' WHERE NOT EXISTS (SELECT 1 FROM work_req_fulf_type WHERE description = 'Fixes');

INSERT INTO work_req_fulf_type (description, work_req_fulf_type_id) SELECT 'Deploys', 'WRF_DEPLOYS' WHERE NOT EXISTS (SELECT 1 FROM work_req_fulf_type WHERE description = 'Deploys');

INSERT INTO work_req_fulf_type (description, work_req_fulf_type_id) SELECT 'Tests', 'WRF_TESTS' WHERE NOT EXISTS (SELECT 1 FROM work_req_fulf_type WHERE description = 'Tests');

INSERT INTO work_req_fulf_type (description, work_req_fulf_type_id) SELECT 'Delivers', 'WRF_DELIVERS' WHERE NOT EXISTS (SELECT 1 FROM work_req_fulf_type WHERE description = 'Delivers');

INSERT INTO allocation_plan_type (description, has_table, plan_type_id) SELECT 'Sales Order Allocation Plan', 'N', 'SALES_ORD_ALLOCATION' WHERE NOT EXISTS (SELECT 1 FROM allocation_plan_type WHERE description = 'Sales Order Allocation Plan');

INSERT INTO status_type (description, has_table, status_type_id) SELECT 'Allocation Plan Status', 'N', 'ALLOC_PLAN_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_type WHERE description = 'Allocation Plan Status');

INSERT INTO status_type (description, has_table, parent_type_id, status_type_id) SELECT 'Allocation Plan Item Status', 'N', 'ALLOC_PLAN_STATUS', 'ALLOC_PLAN_ITEM_STTS' WHERE NOT EXISTS (SELECT 1 FROM status_type WHERE description = 'Allocation Plan Item Status');

INSERT INTO enumeration_type (description, enum_type_id, has_table) SELECT 'Allocation Plan Method', 'ALLOC_PLAN_METHOD', 'N' WHERE NOT EXISTS (SELECT 1 FROM enumeration_type WHERE description = 'Allocation Plan Method');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Created', '01', 'CREATED', 'ALLOC_PLAN_CREATED', 'ALLOC_PLAN_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Created');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Approved', '02', 'APPROVED', 'ALLOC_PLAN_APPROVED', 'ALLOC_PLAN_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Approved');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Completed', '03', 'COMPLETED', 'ALLOC_PLAN_COMPLETED', 'ALLOC_PLAN_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Completed');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Cancelled', '04', 'CANCELLED', 'ALLOC_PLAN_CANCELLED', 'ALLOC_PLAN_STATUS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Cancelled');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Created', '01', 'CREATED', 'ALLOC_PLAN_ITEM_CRTD', 'ALLOC_PLAN_ITEM_STTS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Created');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Approved', '02', 'APPROVED', 'ALLOC_PLAN_ITEM_APRV', 'ALLOC_PLAN_ITEM_STTS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Approved');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Completed', '03', 'COMPLETED', 'ALLOC_PLAN_ITEM_CMPL', 'ALLOC_PLAN_ITEM_STTS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Completed');

INSERT INTO status_item (description, sequence_id, status_code, status_id, status_type_id) SELECT 'Cancelled', '04', 'CANCELLED', 'ALLOC_PLAN_ITEM_CNCL', 'ALLOC_PLAN_ITEM_STTS' WHERE NOT EXISTS (SELECT 1 FROM status_item WHERE description = 'Cancelled');

INSERT INTO enumeration (description, enum_code, enum_id, enum_type_id, sequence_id) SELECT 'Auto', 'AUTO', 'AUTO', 'ALLOC_PLAN_METHOD', '01' WHERE NOT EXISTS (SELECT 1 FROM enumeration WHERE description = 'Auto');

INSERT INTO enumeration (description, enum_code, enum_id, enum_type_id, sequence_id) SELECT 'Manual', 'MANUAL', 'MANUAL', 'ALLOC_PLAN_METHOD', '02' WHERE NOT EXISTS (SELECT 1 FROM enumeration WHERE description = 'Manual');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ALLOC_PLAN_CREATED', 'ALLOC_PLAN_APPROVED', 'Approve' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ALLOC_PLAN_CREATED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ALLOC_PLAN_CREATED', 'ALLOC_PLAN_CANCELLED', 'Cancel' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ALLOC_PLAN_CREATED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ALLOC_PLAN_APPROVED', 'ALLOC_PLAN_CREATED', 'Create' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ALLOC_PLAN_APPROVED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ALLOC_PLAN_APPROVED', 'ALLOC_PLAN_COMPLETED', 'Complete' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ALLOC_PLAN_APPROVED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ALLOC_PLAN_APPROVED', 'ALLOC_PLAN_CANCELLED', 'Cancel' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ALLOC_PLAN_APPROVED');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ALLOC_PLAN_ITEM_CRTD', 'ALLOC_PLAN_ITEM_APRV', 'Approve' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ALLOC_PLAN_ITEM_CRTD');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ALLOC_PLAN_ITEM_CRTD', 'ALLOC_PLAN_ITEM_CNCL', 'Cancel' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ALLOC_PLAN_ITEM_CRTD');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ALLOC_PLAN_ITEM_APRV', 'ALLOC_PLAN_ITEM_CRTD', 'Create' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ALLOC_PLAN_ITEM_APRV');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ALLOC_PLAN_ITEM_APRV', 'ALLOC_PLAN_ITEM_CMPL', 'Complete' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ALLOC_PLAN_ITEM_APRV');

INSERT INTO status_valid_change (status_id, status_id_to, transition_name) SELECT 'ALLOC_PLAN_ITEM_APRV', 'ALLOC_PLAN_ITEM_CNCL', 'Cancel' WHERE NOT EXISTS (SELECT 1 FROM status_valid_change WHERE status_id = 'ALLOC_PLAN_ITEM_APRV');

