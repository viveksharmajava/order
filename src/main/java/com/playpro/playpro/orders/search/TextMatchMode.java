package com.playpro.playpro.orders.search;

public enum TextMatchMode {
    CONTAINS,
    EQUALS,
    STARTS_WITH,
    ENDS_WITH,
    INCLUDE;

    public static TextMatchMode fromString(String value) {
        if (value == null || value.trim().isEmpty()) {
            return CONTAINS;
        }
        try {
            return TextMatchMode.valueOf(value.trim().toUpperCase());
        } catch (IllegalArgumentException ex) {
            return CONTAINS;
        }
    }
}
