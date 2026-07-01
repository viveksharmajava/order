package com.playpro.playpro.orders.mapper;

import com.playpro.playpro.orders.dto.CreateOrderRequest;
import com.playpro.playpro.orders.dto.OrderDto;
import com.playpro.playpro.orders.dto.OrderItemDto;
import com.playpro.playpro.orders.entity.OrderHeader;
import com.playpro.playpro.orders.entity.OrderItem;
import com.playpro.playpro.orders.entity.OrderRole;

import java.util.List;
import java.util.stream.Collectors;

public final class OrderMapper {

    private OrderMapper() {
    }

    public static OrderDto toDto(OrderHeader header, List<OrderItem> items, String partyId) {
        OrderDto dto = new OrderDto();
        dto.setOrderId(header.getOrderId());
        dto.setOrderTypeId(header.getOrderTypeId());
        dto.setOrderName(header.getOrderName());
        dto.setOrderDate(header.getOrderDate());
        dto.setEntryDate(header.getEntryDate());
        dto.setStatusId(header.getStatusId());
        dto.setCreatedBy(header.getCreatedBy());
        dto.setCurrencyUom(header.getCurrencyUom());
        dto.setProductStoreId(header.getProductStoreId());
        dto.setGrandTotal(header.getGrandTotal());
        dto.setRemainingSubTotal(header.getRemainingSubTotal());
        dto.setExternalId(header.getExternalId());
        dto.setPartyId(partyId);
        if (items != null) {
            dto.setItems(items.stream().map(OrderMapper::toItemDto).collect(Collectors.toList()));
        }
        return dto;
    }

    public static OrderItemDto toItemDto(OrderItem item) {
        OrderItemDto dto = new OrderItemDto();
        dto.setOrderItemSeqId(item.getId().getOrderItemSeqId());
        dto.setProductId(item.getProductId());
        dto.setQuantity(item.getQuantity());
        dto.setUnitPrice(item.getUnitPrice());
        dto.setStatusId(item.getStatusId());
        dto.setOrderItemTypeId(item.getOrderItemTypeId());
        return dto;
    }

    public static void applyCreateRequest(CreateOrderRequest request, OrderHeader header, String orderId, String principal) {
        header.setOrderId(orderId);
        header.setOrderTypeId("SALES_ORDER");
        header.setOrderName(request.getOrderName());
        header.setExternalId(request.getExternalId());
        header.setStatusId("ORDER_CREATED");
        header.setCreatedBy(principal);
        header.setCurrencyUom(request.getCurrencyUom() != null ? request.getCurrencyUom() : "USD");
        header.setProductStoreId(request.getProductStoreId());
    }

    public static String resolvePartyId(List<OrderRole> roles) {
        if (roles == null || roles.isEmpty()) {
            return null;
        }
        return roles.stream()
                .filter(r -> "BILL_TO_CUSTOMER".equals(r.getId().getRoleTypeId()))
                .map(r -> r.getId().getPartyId())
                .findFirst()
                .orElse(roles.get(0).getId().getPartyId());
    }
}
