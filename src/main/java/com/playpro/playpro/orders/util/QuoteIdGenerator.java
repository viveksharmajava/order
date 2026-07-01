package com.playpro.playpro.orders.util;

import java.util.concurrent.ThreadLocalRandom;

public final class QuoteIdGenerator {

    private QuoteIdGenerator() {
    }

    public static String nextQuoteId() {
        int random = ThreadLocalRandom.current().nextInt(1000, 10000);
        return "QUO" + System.currentTimeMillis() + random;
    }

    public static String nextQuoteItemSeqId(int sequence) {
        return String.format("%05d", sequence);
    }
}
