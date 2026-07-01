package com.playpro.playpro.orders.service;

import com.playpro.playpro.orders.dto.ReferenceItemDto;

import java.util.List;

public interface ReferenceService {

    List<ReferenceItemDto> listOrderTypes();

    List<ReferenceItemDto> listOrderStatuses();

    List<ReferenceItemDto> listQuoteTypes();

    List<ReferenceItemDto> listQuoteStatuses();
}
