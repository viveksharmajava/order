package com.playpro.playpro.orders.controller;

import com.playpro.playpro.orders.dto.ReferenceItemDto;
import com.playpro.playpro.orders.service.ReferenceService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/orders/reference")
public class ReferenceController {

    private final ReferenceService referenceService;

    public ReferenceController(ReferenceService referenceService) {
        this.referenceService = referenceService;
    }

    @GetMapping("/order-types")
    public ResponseEntity<List<ReferenceItemDto>> orderTypes() {
        return ResponseEntity.ok(referenceService.listOrderTypes());
    }

    @GetMapping("/order-statuses")
    public ResponseEntity<List<ReferenceItemDto>> orderStatuses() {
        return ResponseEntity.ok(referenceService.listOrderStatuses());
    }

    @GetMapping("/quote-types")
    public ResponseEntity<List<ReferenceItemDto>> quoteTypes() {
        return ResponseEntity.ok(referenceService.listQuoteTypes());
    }

    @GetMapping("/quote-statuses")
    public ResponseEntity<List<ReferenceItemDto>> quoteStatuses() {
        return ResponseEntity.ok(referenceService.listQuoteStatuses());
    }

    @GetMapping("/order-status-transitions")
    public ResponseEntity<List<com.playpro.playpro.orders.dto.OrderStatusTransitionDto>> orderStatusTransitions(
            @RequestParam("fromStatusId") String fromStatusId) {
        return ResponseEntity.ok(referenceService.listOrderStatusTransitions(fromStatusId));
    }
}
