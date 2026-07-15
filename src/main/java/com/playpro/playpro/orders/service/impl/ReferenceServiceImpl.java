package com.playpro.playpro.orders.service.impl;

import com.playpro.playpro.orders.dto.OrderStatusTransitionDto;
import com.playpro.playpro.orders.dto.ReferenceItemDto;
import com.playpro.playpro.orders.mapper.OrderMapper;
import com.playpro.playpro.orders.repository.OrderTypeRepository;
import com.playpro.playpro.orders.repository.QuoteTypeRepository;
import com.playpro.playpro.orders.repository.StatusItemRepository;
import com.playpro.playpro.orders.repository.StatusValidChangeRepository;
import com.playpro.playpro.orders.service.ReferenceService;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional(readOnly = true)
public class ReferenceServiceImpl implements ReferenceService {

    private static final String ORDER_STATUS_TYPE = "ORDER_STATUS";
    private static final String QUOTE_STATUS_TYPE = "QUOTE_STATUS";

    private final OrderTypeRepository orderTypeRepository;
    private final QuoteTypeRepository quoteTypeRepository;
    private final StatusItemRepository statusItemRepository;
    private final StatusValidChangeRepository statusValidChangeRepository;

    public ReferenceServiceImpl(OrderTypeRepository orderTypeRepository,
                                QuoteTypeRepository quoteTypeRepository,
                                StatusItemRepository statusItemRepository,
                                StatusValidChangeRepository statusValidChangeRepository) {
        this.orderTypeRepository = orderTypeRepository;
        this.quoteTypeRepository = quoteTypeRepository;
        this.statusItemRepository = statusItemRepository;
        this.statusValidChangeRepository = statusValidChangeRepository;
    }

    @Override
    public List<ReferenceItemDto> listOrderTypes() {
        return orderTypeRepository.findAll(Sort.by("description")).stream()
                .map(t -> new ReferenceItemDto(t.getOrderTypeId(), t.getDescription()))
                .collect(Collectors.toList());
    }

    @Override
    public List<ReferenceItemDto> listOrderStatuses() {
        return statusItemRepository.findByStatusTypeIdOrderBySequenceId(ORDER_STATUS_TYPE).stream()
                .map(s -> new ReferenceItemDto(s.getStatusId(), s.getDescription()))
                .collect(Collectors.toList());
    }

    @Override
    public List<ReferenceItemDto> listQuoteTypes() {
        return quoteTypeRepository.findAll(Sort.by("description")).stream()
                .map(t -> new ReferenceItemDto(t.getQuoteTypeId(), t.getDescription()))
                .collect(Collectors.toList());
    }

    @Override
    public List<ReferenceItemDto> listQuoteStatuses() {
        return statusItemRepository.findByStatusTypeIdOrderBySequenceId(QUOTE_STATUS_TYPE).stream()
                .map(s -> new ReferenceItemDto(s.getStatusId(), s.getDescription()))
                .collect(Collectors.toList());
    }

    @Override
    public List<OrderStatusTransitionDto> listOrderStatusTransitions(String fromStatusId) {
        if (fromStatusId == null || fromStatusId.trim().isEmpty()) {
            return java.util.Collections.emptyList();
        }
        return statusValidChangeRepository.findByIdStatusIdOrderByIdStatusIdTo(fromStatusId.trim()).stream()
                .map(OrderMapper::toTransitionDto)
                .collect(Collectors.toList());
    }
}
