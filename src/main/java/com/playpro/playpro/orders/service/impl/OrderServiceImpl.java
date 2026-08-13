package com.playpro.playpro.orders.service.impl;

import com.playpro.playpro.orders.client.FacilityClient;
import com.playpro.playpro.orders.client.dto.InventoryOperationClientRequest;
import com.playpro.playpro.orders.client.dto.InventoryOperationLineClientDto;
import com.playpro.playpro.orders.dto.CancelOrderItemRequest;
import com.playpro.playpro.orders.dto.CancelOrderRequest;
import com.playpro.playpro.orders.dto.CreateOrderRequest;
import com.playpro.playpro.orders.dto.OrderDto;
import com.playpro.playpro.orders.dto.OrderFulfillmentDto;
import com.playpro.playpro.orders.dto.OrderItemDto;
import com.playpro.playpro.orders.dto.OrderSearchRequest;
import com.playpro.playpro.orders.dto.ShipOrderItemRequest;
import com.playpro.playpro.orders.dto.ShipOrderRequest;
import com.playpro.playpro.orders.dto.UpdateOrderStatusRequest;
import com.playpro.playpro.orders.entity.OrderFulfillment;
import com.playpro.playpro.orders.entity.OrderFulfillmentItem;
import com.playpro.playpro.orders.entity.OrderFulfillmentItemId;
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
import com.playpro.playpro.orders.repository.OrderFulfillmentItemRepository;
import com.playpro.playpro.orders.repository.OrderFulfillmentRepository;
import com.playpro.playpro.orders.repository.OrderHeaderRepository;
import com.playpro.playpro.orders.repository.OrderItemRepository;
import com.playpro.playpro.orders.repository.OrderPaymentPreferenceRepository;
import com.playpro.playpro.orders.repository.OrderRoleRepository;
import com.playpro.playpro.orders.repository.OrderStatusRepository;
import com.playpro.playpro.orders.repository.StatusValidChangeRepository;
import com.playpro.playpro.orders.search.SearchPredicateBuilder;
import com.playpro.playpro.orders.service.OrderService;
import com.playpro.playpro.orders.service.ReferenceService;
import com.playpro.playpro.orders.util.FulfillmentIdGenerator;
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
    private static final String ORDER_PROCESSING = "ORDER_PROCESSING";
    private static final String ORDER_SENT = "ORDER_SENT";
    private static final String ORDER_COMPLETED = "ORDER_COMPLETED";
    private static final String ORDER_CANCELLED = "ORDER_CANCELLED";
    private static final String PRODUCT_ORDER_ITEM = "PRODUCT_ORDER_ITEM";

    private static final String ITEM_CANCELLED = "ITEM_CANCELLED";
    private static final String ITEM_SHIPPED = "ITEM_SHIPPED";
    private static final String ITEM_COMPLETED = "ITEM_COMPLETED";

    private static final Set<String> COMPLETABLE_STATUSES = new HashSet<>(
            Arrays.asList("ORDER_APPROVED", "ORDER_SENT", "ORDER_PROCESSING", "ORDER_CREATED"));

    private static final Set<String> SHIPPABLE_STATUSES = new HashSet<>(
            Arrays.asList("ORDER_CREATED", "ORDER_PROCESSING", "ORDER_APPROVED", "ORDER_SENT"));

    private final OrderHeaderRepository orderHeaderRepository;
    private final OrderItemRepository orderItemRepository;
    private final OrderRoleRepository orderRoleRepository;
    private final OrderStatusRepository orderStatusRepository;
    private final OrderPaymentPreferenceRepository orderPaymentPreferenceRepository;
    private final OrderFulfillmentRepository orderFulfillmentRepository;
    private final OrderFulfillmentItemRepository orderFulfillmentItemRepository;
    private final StatusValidChangeRepository statusValidChangeRepository;
    private final ReferenceService referenceService;
    private final FacilityClient facilityClient;

    public OrderServiceImpl(OrderHeaderRepository orderHeaderRepository,
                            OrderItemRepository orderItemRepository,
                            OrderRoleRepository orderRoleRepository,
                            OrderStatusRepository orderStatusRepository,
                            OrderPaymentPreferenceRepository orderPaymentPreferenceRepository,
                            OrderFulfillmentRepository orderFulfillmentRepository,
                            OrderFulfillmentItemRepository orderFulfillmentItemRepository,
                            StatusValidChangeRepository statusValidChangeRepository,
                            ReferenceService referenceService,
                            FacilityClient facilityClient) {
        this.orderHeaderRepository = orderHeaderRepository;
        this.orderItemRepository = orderItemRepository;
        this.orderRoleRepository = orderRoleRepository;
        this.orderStatusRepository = orderStatusRepository;
        this.orderPaymentPreferenceRepository = orderPaymentPreferenceRepository;
        this.orderFulfillmentRepository = orderFulfillmentRepository;
        this.orderFulfillmentItemRepository = orderFulfillmentItemRepository;
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
        String orderId = allocateUniqueOrderId();
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

    private String allocateUniqueOrderId() {
        for (int attempt = 0; attempt < 40; attempt++) {
            String candidate = OrderIdGenerator.nextOrderId();
            if (!orderHeaderRepository.existsById(candidate)) {
                return candidate;
            }
        }
        throw new IllegalStateException("Unable to allocate a unique 6–8 character order id");
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

    @Override
    public OrderDto shipOrder(String orderId, ShipOrderRequest request, String xUser) {
        OrderHeader header = orderHeaderRepository.findById(orderId)
                .orElseThrow(() -> new ResourceNotFoundException("Order not found: " + orderId));

        if (!SHIPPABLE_STATUSES.contains(header.getStatusId())) {
            throw new IllegalArgumentException(
                    "Order can only be shipped from Created/Processing/Approved/Sent. Current status: "
                            + header.getStatusId());
        }
        if (ORDER_CANCELLED.equals(header.getStatusId()) || ORDER_COMPLETED.equals(header.getStatusId())) {
            throw new IllegalArgumentException("Cannot ship a cancelled or completed order");
        }
        if (request == null) {
            throw new IllegalArgumentException("Ship request is required");
        }
        if (!StringUtils.hasText(request.getShippingMethodId())
                && !StringUtils.hasText(request.getShippingMethodName())
                && !StringUtils.hasText(request.getCarrierProvider())) {
            throw new IllegalArgumentException("Select a shipping service (shipping method or carrier)");
        }
        if (!StringUtils.hasText(request.getTrackingNumber())) {
            throw new IllegalArgumentException("Tracking number is required");
        }

        List<OrderItem> items = orderItemRepository.findByIdOrderIdOrderByIdOrderItemSeqId(orderId);
        Map<String, BigDecimal> alreadyShipped = loadShippedQuantities(orderId);
        Map<String, BigDecimal> quantitiesToShip = resolveShipQuantities(items, alreadyShipped, request);
        if (quantitiesToShip.isEmpty()) {
            throw new IllegalArgumentException("No remaining items available to ship");
        }

        String principal = resolvePrincipal(xUser);
        LocalDateTime now = LocalDateTime.now();
        int nextGroup = (int) orderFulfillmentRepository.countByOrderId(orderId) + 1;

        OrderFulfillment fulfillment = new OrderFulfillment();
        fulfillment.setFulfillmentId(FulfillmentIdGenerator.nextFulfillmentId());
        fulfillment.setOrderId(orderId);
        fulfillment.setShipGroupSeqId(FulfillmentIdGenerator.nextShipGroupSeqId(nextGroup));
        fulfillment.setShippingMethodId(trimToNull(request.getShippingMethodId()));
        fulfillment.setShippingMethodName(trimToNull(request.getShippingMethodName()));
        fulfillment.setCarrierProvider(trimToNull(request.getCarrierProvider()));
        fulfillment.setTrackingNumber(request.getTrackingNumber().trim());
        fulfillment.setTrackUrl(resolveTrackUrl(request));
        fulfillment.setShippingInstructions(trimToNull(request.getShippingInstructions()));
        fulfillment.setShippedDate(now);
        fulfillment.setCreatedBy(principal);
        fulfillment.setCreatedDate(now);
        orderFulfillmentRepository.save(fulfillment);

        Map<String, OrderItem> bySeq = items.stream()
                .collect(Collectors.toMap(i -> i.getId().getOrderItemSeqId(), i -> i));

        for (Map.Entry<String, BigDecimal> entry : quantitiesToShip.entrySet()) {
            OrderFulfillmentItem line = new OrderFulfillmentItem();
            line.setId(new OrderFulfillmentItemId(fulfillment.getFulfillmentId(), entry.getKey()));
            line.setOrderId(orderId);
            line.setQuantity(entry.getValue());
            orderFulfillmentItemRepository.save(line);

            OrderItem item = bySeq.get(entry.getKey());
            BigDecimal shippedTotal = alreadyShipped.getOrDefault(entry.getKey(), BigDecimal.ZERO).add(entry.getValue());
            if (!ITEM_CANCELLED.equals(item.getStatusId())
                    && !ITEM_COMPLETED.equals(item.getStatusId())) {
                item.setStatusId(ITEM_SHIPPED);
                orderItemRepository.save(item);
            }
            alreadyShipped.put(entry.getKey(), shippedTotal);
        }

        // Refresh shipped map including this shipment for header status decision
        Map<String, BigDecimal> shippedAfter = loadShippedQuantities(orderId);
        boolean allShipped = allShippableQuantityFulfilled(items, shippedAfter);
        String previousStatus = header.getStatusId();
        String nextStatus = allShipped ? ORDER_SENT : ORDER_PROCESSING;
        if (!nextStatus.equals(previousStatus)) {
            header.setStatusId(nextStatus);
            orderHeaderRepository.save(header);
            recordOrderStatus(orderId, nextStatus, principal, now,
                    "Shipment " + fulfillment.getShipGroupSeqId()
                            + " tracking " + fulfillment.getTrackingNumber());
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

        Map<String, BigDecimal> shipped = loadShippedQuantities(header.getOrderId());
        if (dto.getItems() != null) {
            for (OrderItemDto item : dto.getItems()) {
                item.setShippedQuantity(shipped.getOrDefault(item.getOrderItemSeqId(), BigDecimal.ZERO));
            }
        }
        dto.setFulfillments(loadFulfillmentDtos(header.getOrderId()));
        return dto;
    }

    private List<OrderFulfillmentDto> loadFulfillmentDtos(String orderId) {
        List<OrderFulfillment> fulfillments = orderFulfillmentRepository.findByOrderIdOrderByShipGroupSeqIdAsc(orderId);
        List<OrderFulfillmentDto> result = new ArrayList<>();
        for (OrderFulfillment fulfillment : fulfillments) {
            OrderFulfillmentDto dto = new OrderFulfillmentDto();
            dto.setFulfillmentId(fulfillment.getFulfillmentId());
            dto.setOrderId(fulfillment.getOrderId());
            dto.setShipGroupSeqId(fulfillment.getShipGroupSeqId());
            dto.setShippingMethodId(fulfillment.getShippingMethodId());
            dto.setShippingMethodName(fulfillment.getShippingMethodName());
            dto.setCarrierProvider(fulfillment.getCarrierProvider());
            dto.setTrackingNumber(fulfillment.getTrackingNumber());
            dto.setTrackUrl(fulfillment.getTrackUrl());
            dto.setShippingInstructions(fulfillment.getShippingInstructions());
            dto.setShippedDate(fulfillment.getShippedDate());
            dto.setCreatedBy(fulfillment.getCreatedBy());
            List<OrderFulfillmentDto.OrderFulfillmentItemDto> lines = new ArrayList<>();
            for (OrderFulfillmentItem item
                    : orderFulfillmentItemRepository.findByIdFulfillmentId(fulfillment.getFulfillmentId())) {
                OrderFulfillmentDto.OrderFulfillmentItemDto line = new OrderFulfillmentDto.OrderFulfillmentItemDto();
                line.setOrderItemSeqId(item.getId().getOrderItemSeqId());
                line.setQuantity(item.getQuantity());
                lines.add(line);
            }
            dto.setItems(lines);
            result.add(dto);
        }
        return result;
    }

    private Map<String, BigDecimal> loadShippedQuantities(String orderId) {
        Map<String, BigDecimal> shipped = new HashMap<>();
        for (OrderFulfillmentItem item : orderFulfillmentItemRepository.findByOrderId(orderId)) {
            String seq = item.getId().getOrderItemSeqId();
            shipped.merge(seq, item.getQuantity() != null ? item.getQuantity() : BigDecimal.ZERO, BigDecimal::add);
        }
        return shipped;
    }

    private Map<String, BigDecimal> resolveShipQuantities(List<OrderItem> items,
                                                         Map<String, BigDecimal> alreadyShipped,
                                                         ShipOrderRequest request) {
        Map<String, BigDecimal> quantities = new HashMap<>();
        boolean shipAll = request.isShipAll() || request.getItems() == null || request.getItems().isEmpty();

        if (shipAll) {
            for (OrderItem item : items) {
                BigDecimal remaining = shippableRemaining(item, alreadyShipped);
                if (remaining.signum() > 0) {
                    quantities.put(item.getId().getOrderItemSeqId(), remaining);
                }
            }
            return quantities;
        }

        Map<String, OrderItem> bySeq = items.stream()
                .collect(Collectors.toMap(i -> i.getId().getOrderItemSeqId(), i -> i));
        for (ShipOrderItemRequest line : request.getItems()) {
            if (!StringUtils.hasText(line.getOrderItemSeqId())) {
                throw new IllegalArgumentException("orderItemSeqId is required on each ship line");
            }
            OrderItem item = bySeq.get(line.getOrderItemSeqId().trim());
            if (item == null) {
                throw new IllegalArgumentException("Unknown order item: " + line.getOrderItemSeqId());
            }
            BigDecimal remaining = shippableRemaining(item, alreadyShipped);
            if (remaining.signum() <= 0) {
                throw new IllegalArgumentException("Line " + line.getOrderItemSeqId() + " has no quantity left to ship");
            }
            BigDecimal shipQty = line.getQuantity() != null ? line.getQuantity() : remaining;
            if (shipQty.signum() <= 0) {
                throw new IllegalArgumentException("Invalid ship quantity for line " + line.getOrderItemSeqId());
            }
            if (shipQty.compareTo(remaining) > 0) {
                throw new IllegalArgumentException(
                        "Ship quantity exceeds remaining for line " + line.getOrderItemSeqId());
            }
            quantities.put(item.getId().getOrderItemSeqId(), shipQty);
        }
        return quantities;
    }

    private BigDecimal shippableRemaining(OrderItem item, Map<String, BigDecimal> alreadyShipped) {
        if (ITEM_CANCELLED.equals(item.getStatusId()) || ITEM_COMPLETED.equals(item.getStatusId())) {
            return BigDecimal.ZERO;
        }
        BigDecimal remaining = remainingQuantity(item);
        BigDecimal shipped = alreadyShipped.getOrDefault(item.getId().getOrderItemSeqId(), BigDecimal.ZERO);
        BigDecimal left = remaining.subtract(shipped);
        return left.signum() > 0 ? left : BigDecimal.ZERO;
    }

    private boolean allShippableQuantityFulfilled(List<OrderItem> items, Map<String, BigDecimal> shipped) {
        for (OrderItem item : items) {
            if (ITEM_CANCELLED.equals(item.getStatusId())) {
                continue;
            }
            BigDecimal remaining = remainingQuantity(item);
            if (remaining.signum() <= 0) {
                continue;
            }
            BigDecimal shippedQty = shipped.getOrDefault(item.getId().getOrderItemSeqId(), BigDecimal.ZERO);
            if (shippedQty.compareTo(remaining) < 0) {
                return false;
            }
        }
        return true;
    }

    private String resolveTrackUrl(ShipOrderRequest request) {
        String trackUrl = trimToNull(request.getTrackUrl());
        if (trackUrl == null) {
            return null;
        }
        String tracking = request.getTrackingNumber() != null ? request.getTrackingNumber().trim() : "";
        return trackUrl
                .replace("{trackingNumber}", tracking)
                .replace("{tracking}", tracking)
                .replace("{awb}", tracking);
    }

    private String trimToNull(String value) {
        if (!StringUtils.hasText(value)) {
            return null;
        }
        return value.trim();
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
