package com.playpro.playpro.orders.controller;

import com.playpro.playpro.orders.dto.CancelOrderRequest;
import com.playpro.playpro.orders.dto.CreateOrderRequest;
import com.playpro.playpro.orders.dto.OrderDto;
import com.playpro.playpro.orders.dto.OrderSearchRequest;
import com.playpro.playpro.orders.service.OrderService;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/orders")
public class OrderController {

    private final OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @PostMapping
    public ResponseEntity<OrderDto> createOrder(@RequestHeader(value = "X-User", required = false) String xUser,
                                                @RequestBody CreateOrderRequest request) {
        return ResponseEntity.ok(orderService.createOrder(request, resolvePrincipal(xUser)));
    }

    @PostMapping("/find")
    public ResponseEntity<Page<OrderDto>> findOrders(@RequestBody OrderSearchRequest request) {
        return ResponseEntity.ok(orderService.findOrders(request));
    }

    @GetMapping("/{orderId}")
    public ResponseEntity<OrderDto> getOrder(@PathVariable String orderId) {
        return ResponseEntity.ok(orderService.getOrder(orderId));
    }

    @PostMapping("/{orderId}/cancel")
    public ResponseEntity<OrderDto> cancelOrder(@RequestHeader(value = "X-User", required = false) String xUser,
                                                @PathVariable String orderId,
                                                @RequestBody(required = false) CancelOrderRequest request) {
        return ResponseEntity.ok(orderService.cancelOrder(orderId, request, resolvePrincipal(xUser)));
    }

    private String resolvePrincipal(String xUser) {
        if (xUser == null || !xUser.contains(":")) {
            return "system";
        }
        return xUser.split(":", 2)[0];
    }
}
