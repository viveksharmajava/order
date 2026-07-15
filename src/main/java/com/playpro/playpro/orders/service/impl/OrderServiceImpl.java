package com.playpro.playpro.orders.service.impl;

import com.playpro.playpro.orders.client.FacilityClient;
import com.playpro.playpro.orders.client.dto.InventoryOperationClientRequest;
import com.playpro.playpro.orders.client.dto.InventoryOperationLineClientDto;
import com.playpro.playpro.orders.dto.CancelOrderItemRequest;
import com.playpro.playpro.orders.dto.CancelOrderRequest;
import com.playpro.playpro.orders.dto.CreateOrderRequest;
import com.playpro.playpro.orders.dto.OrderDto;
import com.playpro.playpro.orders.dto.OrderItemDto;
import com.playpro.playpro.orders.dto.OrderSearchRequest;
import com.playpro.playpro.orders.dto.UpdateOrderStatusRequest;
import com.playpro.playpro.orders.entity.OrderHeader;
import com.playpro.playpro.orders.entity.OrderItem;
import com.playpro.playpro.orders.entity.OrderItemId;
import com.playpro.playpro.orders.entity.OrderPaymentPreference;
import com.playpro.playpro.orders.entity.OrderRole;
import com.playpro.playpro.orders.entity.OrderRoleId;
import com.playpro.playpro.orders.entity.OrderStatus;
import com.playpro.playpro.orders.entity.StatusValidChangeId;
import com.playpro.playpro.orders.exception.ResourceNotFoundException;
import com.playpro.playpro.orders.mapper.OrderMapper;
import com.playpro.playpro.orders.repository.OrderHeaderRepository;
import com.playpro.playpro.orders.repository.OrderItemRepository;
import com.playpro.playpro.orders.repository.OrderPaymentPreferenceRepository;
import com.playpro.playpro.orders.repository.OrderRoleRepository;
import com.playpro.playpro.orders.repository.OrderStatusRepository;
import com.playpro.playpro.orders.repository.StatusValidChangeRepository;
import com.playpro.playpro.orders.search.SearchPredicateBuilder;
import com.playpro.playpro.orders.service.OrderService;
import com.playpro.playpro.orders.service.ReferenceService;
import com.playpro.playpro.orders.util.OrderIdGenerator;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.persistence.criteria.Subquery;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@Transactional
public class OrderServiceImpl implements OrderService {

    private static final String SALES_ORDER = "SALES_ORDER";
    private static final String ORDER_CREATED = "ORDER_CREATED";
    private static final String ORDER_COMPLETED = "ORDER_COMPLETED";
    private static final String ORDER_CANCELLED = "ORDER_CANCELLED";
    private static final String PRODUCT_ORDER_ITEM = "PRODUCT_ORDER_ITEM";

    private static final String ITEM_CANCELLED = "ITEM_CANCELLED";

    private static final Set<String> COMPLETABLE_STATUSES = new HashSet<>(
            Arrays.asList("ORDER_APPROVED", "ORDER_SENT", "ORDER_PROCESSING", "ORDER_CREATED"));

    private final OrderHeaderRepository orderHeaderRepository;
    private final OrderItemRepository orderItemRepository;
    private final OrderRoleRepository orderRoleRepository;
    private final OrderStatusRepository orderStatusRepository;
    private final OrderPaymentPreferenceRepository orderPaymentPreferenceRepository;
    private final StatusValidChangeRepository statusValidChangeRepository;
    private final ReferenceService referenceService;
    private final FacilityClient facilityClient;

    public OrderServiceImpl(OrderHeaderRepository orderHeaderRepository,
                            OrderItemRepository orderItemRepository,
                            OrderRoleRepository orderRoleRepository,
                            OrderStatusRepository orderStatusRepository,
                            OrderPaymentPreferenceRepository orderPaymentPreferenceRepository,
                            StatusValidChangeRepository statusValidChangeRepository,
                            ReferenceService referenceService,
                            FacilityClient facilityClient) {
        this.orderHeaderRepository = orderHeaderRepository;
        this.orderItemRepository = orderItemRepository;
        this.orderRoleRepository = orderRoleRepository;
        this.orderStatusRepository = orderStatusRepository;
        this.orderPaymentPreferenceRepository = orderPaymentPreferenceRepository;
        this.statusValidChangeRepository = statusValidChangeRepository;
        this.referenceService = referenceService;
        this.facilityClient = facilityClient;
    }

    @Override
    public OrderDto createOrder(CreateOrderRequest request, String xUser) {
        if (!StringUtils.hasText(request.getPartyId())) {
            throw new IllegalArgumentException("partyId is required");
        }
        if (request.getItems() == null || request.getItems().isEmpty()) {
            throw new IllegalArgumentException("At least one order item is required");
        }

        String principal = resolvePrincipal(xUser);
        String orderId = OrderIdGenerator.nextOrderId();
        LocalDateTime now = LocalDateTime.now();

        OrderHeader header = new OrderHeader();
        OrderMapper.applyCreateRequest(request, header, orderId, principal);
        header.setOrderDate(now);
        header.setEntryDate(now);

        BigDecimal subTotal = BigDecimal.ZERO;
        int seq = 1;
        boolean purchaseOrder = "PURCHASE_ORDER".equals(header.getOrderTypeId());
        String defaultItemType = purchaseOrder ? "INVENTORY_ORDER_ITEM" : PRODUCT_ORDER_ITEM;
        List<OrderItem> savedItems = new ArrayList<>();
        for (OrderItemDto itemDto : request.getItems()) {
            validateItem(itemDto);
            OrderItem item = new OrderItem();
            item.setId(new OrderItemId(orderId, OrderIdGenerator.nextOrderItemSeqId(seq++)));
            item.setProductId(itemDto.getProductId());
            item.setQuantity(itemDto.getQuantity());
            item.setUnitPrice(itemDto.getUnitPrice());
            item.setStatusId("ITEM_CREATED");
            item.setOrderItemTypeId(StringUtils.hasText(itemDto.getOrderItemTypeId())
                    ? itemDto.getOrderItemTypeId() : defaultItemType);
            orderItemRepository.save(item);
            savedItems.add(item);
            subTotal = subTotal.add(itemDto.getQuantity().multiply(itemDto.getUnitPrice()));
        }

        header.setGrandTotal(subTotal);
        header.setRemainingSubTotal(subTotal);
        orderHeaderRepository.save(header);

        OrderRole role = new OrderRole();
        role.setId(new OrderRoleId(orderId, request.getPartyId().trim(), "BILL_TO_CUSTOMER"));
        orderRoleRepository.save(role);

        if (shouldReserveInventory(header)) {
            facilityClient.reserveInventory(buildInventoryRequest(header, savedItems), facilityAuth(xUser));
        } else if (shouldIssueOnCreate(header)) {
            facilityClient.issueInventory(buildInventoryRequest(header, savedItems), facilityAuth(xUser));
            for (OrderItem item : savedItems) {
                item.setStatusId("ITEM_COMPLETED");
                orderItemRepository.save(item);
            }
            recordOrderStatus(orderId, header.getStatusId(), principal, now, null);
        }

        return OrderMapper.toDto(header, savedItems, request.getPartyId().trim());
    }

    @Override
    @Transactional(readOnly = true)
    public Page<OrderDto> findOrders(OrderSearchRequest request) {
        Specification<OrderHeader> spec = buildSearchSpecification(request);
        PageRequest pageRequest = PageRequest.of(
                Math.max(request.getPage(), 0),
                Math.max(request.getSize(), 1),
                Sort.by(Sort.Direction.DESC, "orderDate"));

        Page<OrderHeader> page = orderHeaderRepository.findAll(spec, pageRequest);
        List<OrderDto> content = page.getContent().stream()
                .map(this::toOrderDto)
                .collect(Collectors.toList());
        return new PageImpl<>(content, pageRequest, page.getTotalElements());
    }

    @Override
    @Transactional(readOnly = true)
    public OrderDto getOrder(String orderId) {
        OrderHeader header = orderHeaderRepository.findById(orderId)
                .orElseThrow(() -> new ResourceNotFoundException("Order not found: " + orderId));
        return toOrderDto(header);
    }

    @Override
    public OrderDto cancelOrder(String orderId, CancelOrderRequest request, String xUser) {
        OrderHeader header = orderHeaderRepository.findById(orderId)
                .orElseThrow(() -> new ResourceNotFoundException("Order not found: " + orderId));

        if (ORDER_CANCELLED.equals(header.getStatusId())) {
            throw new IllegalArgumentException("Order is already cancelled");
        }
        if (ORDER_COMPLETED.equals(header.getStatusId())) {
            throw new IllegalArgumentException("Cannot cancel a completed order");
        }

        List<OrderItem> items = orderItemRepository.findByIdOrderIdOrderByIdOrderItemSeqId(orderId);
        Map<String, BigDecimal> quantitiesToCancel = resolveCancelQuantities(items, request);
        if (quantitiesToCancel.isEmpty()) {
            throw new IllegalArgumentException("No active line items to cancel");
        }

        applyLineCancellations(items, quantitiesToCancel);
        orderItemRepository.saveAll(items);

        if (shouldReleaseInventory(header)) {
            facilityClient.releaseInventory(
                    buildInventoryRequest(header, items, quantitiesToCancel), facilityAuth(xUser));
        }

        recalculateTotals(header, items);
        orderHeaderRepository.save(header);

        if (allItemsCancelled(items)) {
            header.setStatusId(ORDER_CANCELLED);
            orderHeaderRepository.save(header);
            recordOrderStatus(orderId, ORDER_CANCELLED, resolvePrincipal(xUser), LocalDateTime.now(),
                    request != null ? request.getReason() : null);
        }

        return toOrderDto(header);
    }

    @Override
    public OrderDto updateOrderStatus(String orderId, UpdateOrderStatusRequest request, String xUser) {
        if (request == null || !StringUtils.hasText(request.getStatusId())) {
            throw new IllegalArgumentException("statusId is required");
        }
        OrderHeader header = orderHeaderRepository.findById(orderId)
                .orElseThrow(() -> new ResourceNotFoundException("Order not found: " + orderId));

        String targetStatus = request.getStatusId().trim();
        String currentStatus = header.getStatusId();
        if (targetStatus.equals(currentStatus)) {
            throw new IllegalArgumentException("Order is already in status: " + targetStatus);
        }

        validateStatusTransition(currentStatus, targetStatus);

        List<OrderItem> items = orderItemRepository.findByIdOrderIdOrderByIdOrderItemSeqId(orderId);

        if (ORDER_CANCELLED.equals(targetStatus)) {
            CancelOrderRequest cancelRequest = new CancelOrderRequest();
            cancelRequest.setCancelAll(true);
            cancelRequest.setReason(request.getReason());
            return cancelOrder(orderId, cancelRequest, xUser);
        }

        if (ORDER_COMPLETED.equals(targetStatus) && shouldIssueInventory(header)) {
            if (hasUnissuedProductLines(items)) {
                facilityClient.issueInventory(buildInventoryRequest(header, items), facilityAuth(xUser));
                for (OrderItem item : items) {
                    if (PRODUCT_ORDER_ITEM.equals(item.getOrderItemTypeId())
                            && !"ITEM_COMPLETED".equals(item.getStatusId())) {
                        item.setStatusId("ITEM_COMPLETED");
                        orderItemRepository.save(item);
                    }
                }
            }
        }

        LocalDateTime now = LocalDateTime.now();
        header.setStatusId(targetStatus);
        orderHeaderRepository.save(header);
        recordOrderStatus(orderId, targetStatus, resolvePrincipal(xUser), now, request.getReason());

        return toOrderDto(header);
    }

    private void recordOrderStatus(String orderId, String statusId, String principal,
                                   LocalDateTime when, String reason) {
        OrderStatus status = new OrderStatus();
        status.setOrderStatusId(OrderIdGenerator.nextOrderStatusId());
        status.setOrderId(orderId);
        status.setStatusId(statusId);
        status.setStatusDatetime(when);
        status.setStatusUserLogin(principal);
        if (StringUtils.hasText(reason)) {
            status.setChangeReason(reason.trim());
        }
        orderStatusRepository.save(status);
    }

    @Override
    public OrderDto completeOrder(String orderId, String xUser) {
        OrderHeader header = orderHeaderRepository.findById(orderId)
                .orElseThrow(() -> new ResourceNotFoundException("Order not found: " + orderId));

        List<OrderItem> items = orderItemRepository.findByIdOrderIdOrderByIdOrderItemSeqId(orderId);
        boolean alreadyCompleted = ORDER_COMPLETED.equals(header.getStatusId());
        boolean itemsFulfilled = items.stream()
                .allMatch(item -> "ITEM_COMPLETED".equals(item.getStatusId())
                        || !PRODUCT_ORDER_ITEM.equals(item.getOrderItemTypeId()));

        if (alreadyCompleted && itemsFulfilled) {
            throw new IllegalArgumentException("Order is already completed");
        }
        if (!alreadyCompleted && !COMPLETABLE_STATUSES.contains(header.getStatusId())) {
            throw new IllegalArgumentException("Order cannot be completed from status: " + header.getStatusId());
        }

        if (shouldIssueInventory(header) && hasUnissuedProductLines(items)) {
            facilityClient.issueInventory(buildInventoryRequest(header, items), facilityAuth(xUser));
        }

        LocalDateTime now = LocalDateTime.now();
        if (!alreadyCompleted) {
            header.setStatusId(ORDER_COMPLETED);
            orderHeaderRepository.save(header);
            recordOrderStatus(orderId, ORDER_COMPLETED, resolvePrincipal(xUser), now, null);
        }

        for (OrderItem item : items) {
            if (PRODUCT_ORDER_ITEM.equals(item.getOrderItemTypeId())
                    && !"ITEM_COMPLETED".equals(item.getStatusId())) {
                item.setStatusId("ITEM_COMPLETED");
                orderItemRepository.save(item);
            }
        }

        return toOrderDto(header);
    }

    private boolean hasUnissuedProductLines(List<OrderItem> items) {
        return items.stream().anyMatch(item -> PRODUCT_ORDER_ITEM.equals(item.getOrderItemTypeId())
                && !"ITEM_COMPLETED".equals(item.getStatusId()));
    }

    private boolean shouldIssueOnCreate(OrderHeader header) {
        return SALES_ORDER.equals(header.getOrderTypeId()) && ORDER_COMPLETED.equals(header.getStatusId());
    }

    private boolean shouldReserveInventory(OrderHeader header) {
        return SALES_ORDER.equals(header.getOrderTypeId()) && ORDER_CREATED.equals(header.getStatusId());
    }

    private boolean shouldReleaseInventory(OrderHeader header) {
        return SALES_ORDER.equals(header.getOrderTypeId())
                && !ORDER_COMPLETED.equals(header.getStatusId());
    }

    private boolean shouldIssueInventory(OrderHeader header) {
        return SALES_ORDER.equals(header.getOrderTypeId());
    }

    private InventoryOperationClientRequest buildInventoryRequest(OrderHeader header, List<OrderItem> items) {
        InventoryOperationClientRequest request = new InventoryOperationClientRequest();
        request.setOrderId(header.getOrderId());
        request.setProductStoreId(header.getProductStoreId());
        List<InventoryOperationLineClientDto> lines = new ArrayList<>();
        for (OrderItem item : items) {
            if (!PRODUCT_ORDER_ITEM.equals(item.getOrderItemTypeId())) {
                continue;
            }
            BigDecimal qty = remainingQuantity(item);
            if (qty.signum() <= 0) {
                continue;
            }
            lines.add(new InventoryOperationLineClientDto(
                    item.getProductId(),
                    item.getId().getOrderItemSeqId(),
                    qty));
        }
        request.setLines(lines);
        return request;
    }

    private String facilityAuth(String xUser) {
        if (StringUtils.hasText(xUser) && xUser.contains(":")) {
            return xUser;
        }
        return "system:ADMIN";
    }

    private String resolvePrincipal(String xUser) {
        if (xUser == null || !xUser.contains(":")) {
            return "system";
        }
        return xUser.split(":", 2)[0];
    }

    private OrderDto toOrderDto(OrderHeader header) {
        List<OrderItem> items = orderItemRepository.findByIdOrderIdOrderByIdOrderItemSeqId(header.getOrderId());
        List<OrderRole> roles = orderRoleRepository.findByIdOrderId(header.getOrderId());
        OrderDto dto = OrderMapper.toDto(header, items, OrderMapper.resolvePartyId(roles));
        dto.setRoles(roles.stream().map(OrderMapper::toRoleDto).collect(Collectors.toList()));
        dto.setPayments(orderPaymentPreferenceRepository.findByOrderId(header.getOrderId()).stream()
                .map(OrderMapper::toPaymentDto)
                .collect(Collectors.toList()));
        dto.setAllowedTransitions(referenceService.listOrderStatusTransitions(header.getStatusId()));
        return dto;
    }

    private void validateStatusTransition(String fromStatus, String toStatus) {
        boolean allowed = statusValidChangeRepository.existsById(new StatusValidChangeId(fromStatus, toStatus));
        if (!allowed) {
            throw new IllegalArgumentException("Invalid status transition from " + fromStatus + " to " + toStatus);
        }
    }

    private Map<String, BigDecimal> resolveCancelQuantities(List<OrderItem> items, CancelOrderRequest request) {
        Map<String, BigDecimal> quantities = new HashMap<>();
        boolean cancelAll = request == null || request.isCancelAll()
                || request.getItems() == null || request.getItems().isEmpty();

        if (cancelAll) {
            for (OrderItem item : items) {
                BigDecimal remaining = remainingQuantity(item);
                if (remaining.signum() > 0 && !ITEM_CANCELLED.equals(item.getStatusId())) {
                    quantities.put(item.getId().getOrderItemSeqId(), remaining);
                }
            }
            return quantities;
        }

        Map<String, OrderItem> bySeq = items.stream()
                .collect(Collectors.toMap(i -> i.getId().getOrderItemSeqId(), i -> i));

        for (CancelOrderItemRequest line : request.getItems()) {
            if (!StringUtils.hasText(line.getOrderItemSeqId())) {
                throw new IllegalArgumentException("orderItemSeqId is required on each cancel line");
            }
            OrderItem item = bySeq.get(line.getOrderItemSeqId().trim());
            if (item == null) {
                throw new IllegalArgumentException("Unknown order item: " + line.getOrderItemSeqId());
            }
            BigDecimal remaining = remainingQuantity(item);
            if (remaining.signum() <= 0) {
                throw new IllegalArgumentException("Line " + line.getOrderItemSeqId() + " has no quantity to cancel");
            }
            BigDecimal cancelQty = line.getCancelQuantity() != null ? line.getCancelQuantity() : remaining;
            if (cancelQty.signum() <= 0 || cancelQty.compareTo(remaining) > 0) {
                throw new IllegalArgumentException("Invalid cancel quantity for line " + line.getOrderItemSeqId());
            }
            quantities.put(item.getId().getOrderItemSeqId(), cancelQty);
        }
        return quantities;
    }

    private void applyLineCancellations(List<OrderItem> items, Map<String, BigDecimal> quantitiesToCancel) {
        for (OrderItem item : items) {
            BigDecimal cancelQty = quantitiesToCancel.get(item.getId().getOrderItemSeqId());
            if (cancelQty == null) {
                continue;
            }
            BigDecimal existing = item.getCancelQuantity() != null ? item.getCancelQuantity() : BigDecimal.ZERO;
            item.setCancelQuantity(existing.add(cancelQty));
            if (remainingQuantity(item).signum() <= 0) {
                item.setStatusId(ITEM_CANCELLED);
            }
        }
    }

    private boolean allItemsCancelled(List<OrderItem> items) {
        return items.stream().allMatch(item -> ITEM_CANCELLED.equals(item.getStatusId())
                || remainingQuantity(item).signum() <= 0);
    }

    private BigDecimal remainingQuantity(OrderItem item) {
        BigDecimal qty = item.getQuantity() != null ? item.getQuantity() : BigDecimal.ZERO;
        BigDecimal cancelled = item.getCancelQuantity() != null ? item.getCancelQuantity() : BigDecimal.ZERO;
        return qty.subtract(cancelled).max(BigDecimal.ZERO);
    }

    private void recalculateTotals(OrderHeader header, List<OrderItem> items) {
        BigDecimal subTotal = BigDecimal.ZERO;
        for (OrderItem item : items) {
            BigDecimal remaining = remainingQuantity(item);
            if (remaining.signum() > 0 && item.getUnitPrice() != null) {
                subTotal = subTotal.add(remaining.multiply(item.getUnitPrice()));
            }
        }
        header.setGrandTotal(subTotal);
        header.setRemainingSubTotal(subTotal);
    }

    private InventoryOperationClientRequest buildInventoryRequest(OrderHeader header, List<OrderItem> items,
                                                                  Map<String, BigDecimal> quantities) {
        InventoryOperationClientRequest request = new InventoryOperationClientRequest();
        request.setOrderId(header.getOrderId());
        request.setProductStoreId(header.getProductStoreId());
        List<InventoryOperationLineClientDto> lines = new ArrayList<>();
        for (OrderItem item : items) {
            if (!PRODUCT_ORDER_ITEM.equals(item.getOrderItemTypeId())) {
                continue;
            }
            BigDecimal qty = quantities.get(item.getId().getOrderItemSeqId());
            if (qty == null || qty.signum() <= 0) {
                continue;
            }
            lines.add(new InventoryOperationLineClientDto(
                    item.getProductId(),
                    item.getId().getOrderItemSeqId(),
                    qty));
        }
        request.setLines(lines);
        return request;
    }

    private Specification<OrderHeader> buildSearchSpecification(OrderSearchRequest request) {
        return (root, query, cb) -> {
            List<Predicate> predicates = new ArrayList<>();

            if (StringUtils.hasText(request.getOrderId())) {
                predicates.add(SearchPredicateBuilder.apply(
                        cb, root.get("orderId"), request.getOrderId(), request.getOrderIdMatchMode()));
            }

            if (StringUtils.hasText(request.getOrderTypeId())) {
                predicates.add(cb.equal(root.get("orderTypeId"), request.getOrderTypeId().trim()));
            }

            if (StringUtils.hasText(request.getPartyId())) {
                Subquery<String> roleSubquery = query.subquery(String.class);
                Root<OrderRole> roleRoot = roleSubquery.from(OrderRole.class);
                roleSubquery.select(roleRoot.get("id").get("orderId"));
                Predicate partyMatch = SearchPredicateBuilder.apply(
                        cb,
                        roleRoot.get("id").get("partyId"),
                        request.getPartyId(),
                        request.getPartyIdMatchMode());
                roleSubquery.where(partyMatch);
                predicates.add(root.get("orderId").in(roleSubquery));
            }

            if (StringUtils.hasText(request.getProductId())) {
                Subquery<String> itemSubquery = query.subquery(String.class);
                Root<OrderItem> itemRoot = itemSubquery.from(OrderItem.class);
                itemSubquery.select(itemRoot.get("id").get("orderId"));
                Predicate productMatch = SearchPredicateBuilder.apply(
                        cb,
                        itemRoot.get("productId"),
                        request.getProductId(),
                        request.getProductIdMatchMode());
                itemSubquery.where(productMatch);
                predicates.add(root.get("orderId").in(itemSubquery));
            }

            if (request.getOrderDateFrom() != null) {
                predicates.add(cb.greaterThanOrEqualTo(root.get("orderDate"), request.getOrderDateFrom()));
            }
            if (request.getOrderDateTo() != null) {
                predicates.add(cb.lessThanOrEqualTo(root.get("orderDate"), request.getOrderDateTo()));
            }

            return cb.and(predicates.toArray(new Predicate[0]));
        };
    }

    private void validateItem(OrderItemDto itemDto) {
        if (!StringUtils.hasText(itemDto.getProductId())) {
            throw new IllegalArgumentException("productId is required for each order item");
        }
        if (itemDto.getQuantity() == null || itemDto.getQuantity().signum() <= 0) {
            throw new IllegalArgumentException("quantity must be positive for each order item");
        }
        if (itemDto.getUnitPrice() == null) {
            throw new IllegalArgumentException("unitPrice is required for each order item");
        }
    }
}
