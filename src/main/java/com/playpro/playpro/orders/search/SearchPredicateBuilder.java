package com.playpro.playpro.orders.search;

import org.springframework.util.StringUtils;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.Expression;
import javax.persistence.criteria.Predicate;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public final class SearchPredicateBuilder {

    private SearchPredicateBuilder() {
    }

    public static Predicate apply(CriteriaBuilder cb, Expression<String> field, String value, TextMatchMode mode) {
        if (!StringUtils.hasText(value)) {
            return cb.conjunction();
        }
        String trimmed = value.trim();
        TextMatchMode effectiveMode = mode != null ? mode : TextMatchMode.CONTAINS;
        Expression<String> lowerField = cb.lower(field);
        String lowerValue = trimmed.toLowerCase();

        switch (effectiveMode) {
            case EQUALS:
                return cb.equal(lowerField, lowerValue);
            case STARTS_WITH:
                return cb.like(lowerField, lowerValue + "%");
            case ENDS_WITH:
                return cb.like(lowerField, "%" + lowerValue);
            case INCLUDE:
                List<String> tokens = Arrays.stream(trimmed.split(","))
                        .map(String::trim)
                        .filter(StringUtils::hasText)
                        .map(String::toLowerCase)
                        .collect(Collectors.toList());
                if (tokens.isEmpty()) {
                    return cb.conjunction();
                }
                return lowerField.in(tokens);
            case CONTAINS:
            default:
                return cb.like(lowerField, "%" + lowerValue + "%");
        }
    }
}
