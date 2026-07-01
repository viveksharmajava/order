package com.playpro.playpro.orders.service.impl;

import com.playpro.playpro.orders.dto.CancelOrderRequest;
import com.playpro.playpro.orders.dto.CreateOrderRequest;
import com.playpro.playpro.orders.dto.OrderDto;
import com.playpro.playpro.orders.dto.OrderItemDto;
import com.playpro.playpro.orders.dto.OrderSearchRequest;
import com.playpro.playpro.orders.entity.OrderHeader;
import com.playpro.playpro.orders.entity.OrderItem;
import com.playpro.playpro.orders.entity.OrderItemId;
import com.playpro.playpro.orders.entity.OrderRole;
import com.playpro.playpro.orders.entity.OrderRoleId;
import com.playpro.playpro.orders.entity.OrderStatus;
import com.playpro.playpro.orders.exception.ResourceNotFoundException;
import com.playpro.playpro.orders.mapper.OrderMapper;
import com.playpro.playpro.orders.repository.OrderHeaderRepository;
import com.playpro.playpro.orders.repository.OrderItemRepository;
import com.playpro.playpro.orders.repository.OrderRoleRepository;
import com.playpro.playpro.orders.repository.OrderStatusRepository;
import com.playpro.playpro.orders.search.SearchPredicateBuilder;
import com.playpro.playpro.orders.service.OrderService;
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
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class OrderServiceImpl implements OrderService {

    private final OrderHeaderRepository orderHeaderRepository;
    private final OrderItemRepository orderItemRepository;
    private final OrderRoleRepository orderRoleRepository;
    private final OrderStatusRepository orderStatusRepository;

    public OrderServiceImpl(OrderHeaderRepository orderHeaderRepository,
                            OrderItemRepository orderItemRepository,
                            OrderRoleRepository orderRoleRepository,
                            OrderStatusRepository orderStatusRepository) {
        this.orderHeaderRepository = orderHeaderRepository;
        this.orderItemRepository = orderItemRepository;
        this.orderRoleRepository = orderRoleRepository;
        this.orderStatusRepository = orderStatusRepository;
    }

    @Override
    public OrderDto createOrder(CreateOrderRequest request, String principal) {
        if (!StringUtils.hasText(request.getPartyId())) {
            throw new IllegalArgumentException("partyId is required");
        }
        if (request.getItems() == null || request.getItems().isEmpty()) {
            throw new IllegalArgumentException("At least one order item is required");
        }

        String orderId = OrderIdGenerator.nextOrderId();
        LocalDateTime now = LocalDateTime.now();

        OrderHeader header = new OrderHeader();
        OrderMapper.applyCreateRequest(request, header, orderId, principal);
        header.setOrderDate(now);
        header.setEntryDate(now);

        BigDecimal subTotal = BigDecimal.ZERO;
        int seq = 1;
        for (OrderItemDto itemDto : request.getItems()) {
            validateItem(itemDto);
            OrderItem item = new OrderItem();
            item.setId(new OrderItemId(orderId, OrderIdGenerator.nextOrderItemSeqId(seq++)));
            item.setProductId(itemDto.getProductId());
            item.setQuantity(itemDto.getQuantity());
            item.setUnitPrice(itemDto.getUnitPrice());
            item.setStatusId("ITEM_CREATED");
            item.setOrderItemTypeId(StringUtils.hasText(itemDto.getOrderItemTypeId())
                    ? itemDto.getOrderItemTypeId() : "PRODUCT_ORDER_ITEM");
            orderItemRepository.save(item);
            subTotal = subTotal.add(itemDto.getQuantity().multiply(itemDto.getUnitPrice()));
        }

        header.setGrandTotal(subTotal);
        header.setRemainingSubTotal(subTotal);
        orderHeaderRepository.save(header);

        OrderRole role = new OrderRole();
        role.setId(new OrderRoleId(orderId, request.getPartyId().trim(), "BILL_TO_CUSTOMER"));
        orderRoleRepository.save(role);

        List<OrderItem> items = orderItemRepository.findByIdOrderIdOrderByIdOrderItemSeqId(orderId);
        return OrderMapper.toDto(header, items, request.getPartyId().trim());
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
    public OrderDto cancelOrder(String orderId, CancelOrderRequest request, String principal) {
        OrderHeader header = orderHeaderRepository.findById(orderId)
                .orElseThrow(() -> new ResourceNotFoundException("Order not found: " + orderId));

        if ("ORDER_CANCELLED".equals(header.getStatusId())) {
            throw new IllegalArgumentException("Order is already cancelled");
        }

        LocalDateTime now = LocalDateTime.now();
        header.setStatusId("ORDER_CANCELLED");
        orderHeaderRepository.save(header);

        OrderStatus status = new OrderStatus();
        status.setOrderStatusId(OrderIdGenerator.nextOrderStatusId());
        status.setOrderId(orderId);
        status.setStatusId("ORDER_CANCELLED");
        status.setStatusDatetime(now);
        status.setStatusUserLogin(principal);
        if (request != null && StringUtils.hasText(request.getReason())) {
            status.setChangeReason(request.getReason().trim());
        }
        orderStatusRepository.save(status);

        return toOrderDto(header);
    }

    private OrderDto toOrderDto(OrderHeader header) {
        List<OrderItem> items = orderItemRepository.findByIdOrderIdOrderByIdOrderItemSeqId(header.getOrderId());
        List<OrderRole> roles = orderRoleRepository.findByIdOrderId(header.getOrderId());
        return OrderMapper.toDto(header, items, OrderMapper.resolvePartyId(roles));
    }

    private Specification<OrderHeader> buildSearchSpecification(OrderSearchRequest request) {
        return (root, query, cb) -> {
            List<Predicate> predicates = new ArrayList<>();

            if (StringUtils.hasText(request.getOrderId())) {
                predicates.add(SearchPredicateBuilder.apply(
                        cb, root.get("orderId"), request.getOrderId(), request.getOrderIdMatchMode()));
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
