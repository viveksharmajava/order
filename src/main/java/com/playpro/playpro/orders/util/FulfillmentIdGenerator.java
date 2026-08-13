package com.playpro.playpro.orders.util;

import java.util.UUID;

public final class FulfillmentIdGenerator {

    private FulfillmentIdGenerator() {
    }

    public static String nextFulfillmentId() {
        return "FUL-" + UUID.randomUUID().toString().replace("-", "").substring(0, 16).toUpperCase();
    }

    public static String nextShipGroupSeqId(int sequence) {
        return String.format("%05d", sequence);
    }
}
