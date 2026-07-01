package com.playpro.playpro.orders.util;

import java.util.concurrent.ThreadLocalRandom;

public final class OrderIdGenerator {

    private OrderIdGenerator() {
    }

    public static String nextOrderId() {
        int random = ThreadLocalRandom.current().nextInt(1000, 10000);
        return "ORD" + System.currentTimeMillis() + random;
    }

    public static String nextOrderStatusId() {
        int random = ThreadLocalRandom.current().nextInt(1000, 10000);
        return "OST" + System.currentTimeMillis() + random;
    }

    public static String nextOrderItemSeqId(int sequence) {
        return String.format("%05d", sequence);
    }
}
