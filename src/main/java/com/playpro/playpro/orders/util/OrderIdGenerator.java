package com.playpro.playpro.orders.util;

import java.util.concurrent.ThreadLocalRandom;

public final class OrderIdGenerator {

    /** Crockford-like alphabet (no I/O/0/1) for readable short ids. */
    private static final char[] ALPHABET = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789".toCharArray();

    private static final int MIN_ORDER_ID_LENGTH = 6;
    private static final int MAX_ORDER_ID_LENGTH = 8;

    private OrderIdGenerator() {
    }

    /**
     * Short order id: 6–8 characters (A–Z / 2–9), suitable for display and URLs.
     */
    public static String nextOrderId() {
        ThreadLocalRandom rnd = ThreadLocalRandom.current();
        int length = rnd.nextInt(MIN_ORDER_ID_LENGTH, MAX_ORDER_ID_LENGTH + 1);
        char[] buf = new char[length];
        for (int i = 0; i < length; i++) {
            buf[i] = ALPHABET[rnd.nextInt(ALPHABET.length)];
        }
        return new String(buf);
    }

    public static String nextOrderStatusId() {
        int random = ThreadLocalRandom.current().nextInt(1000, 10000);
        return "OST" + System.currentTimeMillis() + random;
    }

    public static String nextOrderItemSeqId(int sequence) {
        return String.format("%05d", sequence);
    }
}
