package com.playpro.playpro.orders.service.impl;

import com.playpro.playpro.orders.dto.CreateQuoteRequest;
import com.playpro.playpro.orders.dto.QuoteDto;
import com.playpro.playpro.orders.dto.QuoteItemDto;
import com.playpro.playpro.orders.dto.QuoteSearchRequest;
import com.playpro.playpro.orders.entity.Quote;
import com.playpro.playpro.orders.entity.QuoteItem;
import com.playpro.playpro.orders.entity.QuoteItemId;
import com.playpro.playpro.orders.entity.QuoteRole;
import com.playpro.playpro.orders.entity.QuoteRoleId;
import com.playpro.playpro.orders.exception.ResourceNotFoundException;
import com.playpro.playpro.orders.mapper.QuoteMapper;
import com.playpro.playpro.orders.repository.QuoteItemRepository;
import com.playpro.playpro.orders.repository.QuoteRepository;
import com.playpro.playpro.orders.repository.QuoteRoleRepository;
import com.playpro.playpro.orders.repository.StatusItemRepository;
import com.playpro.playpro.orders.search.SearchPredicateBuilder;
import com.playpro.playpro.orders.service.QuoteService;
import com.playpro.playpro.orders.util.QuoteIdGenerator;
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
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@Transactional
public class QuoteServiceImpl implements QuoteService {

    private static final Set<String> ALLOWED_QUOTE_STATUSES = new HashSet<>(
            Arrays.asList("QUO_CREATED", "QUO_APPROVED"));

    private final QuoteRepository quoteRepository;
    private final QuoteItemRepository quoteItemRepository;
    private final QuoteRoleRepository quoteRoleRepository;
    private final StatusItemRepository statusItemRepository;

    public QuoteServiceImpl(QuoteRepository quoteRepository,
                            QuoteItemRepository quoteItemRepository,
                            QuoteRoleRepository quoteRoleRepository,
                            StatusItemRepository statusItemRepository) {
        this.quoteRepository = quoteRepository;
        this.quoteItemRepository = quoteItemRepository;
        this.quoteRoleRepository = quoteRoleRepository;
        this.statusItemRepository = statusItemRepository;
    }

    @Override
    public QuoteDto createQuote(CreateQuoteRequest request, String principal) {
        if (!StringUtils.hasText(request.getPartyId())) {
            throw new IllegalArgumentException("partyId is required");
        }
        if (request.getItems() == null || request.getItems().isEmpty()) {
            throw new IllegalArgumentException("At least one quote item is required");
        }

        String statusId = request.getStatusId();
        if (StringUtils.hasText(statusId) && !ALLOWED_QUOTE_STATUSES.contains(statusId)) {
            throw new IllegalArgumentException("Unsupported quote status: " + statusId);
        }
        if (StringUtils.hasText(statusId) && !statusItemRepository.existsById(statusId)) {
            throw new IllegalArgumentException("Unknown quote status: " + statusId);
        }

        String quoteId = QuoteIdGenerator.nextQuoteId();
        LocalDateTime now = LocalDateTime.now();

        Quote quote = new Quote();
        QuoteMapper.applyCreateRequest(request, quote, quoteId);
        quote.setIssueDate(now);
        if (quote.getValidFromDate() == null) {
            quote.setValidFromDate(now);
        }
        quoteRepository.save(quote);

        int seq = 1;
        for (QuoteItemDto itemDto : request.getItems()) {
            validateItem(itemDto);
            QuoteItem item = new QuoteItem();
            item.setId(new QuoteItemId(quoteId, QuoteIdGenerator.nextQuoteItemSeqId(seq++)));
            item.setProductId(itemDto.getProductId());
            item.setQuantity(itemDto.getQuantity());
            item.setQuoteUnitPrice(itemDto.getQuoteUnitPrice());
            quoteItemRepository.save(item);
        }

        QuoteRole role = new QuoteRole();
        role.setId(new QuoteRoleId(quoteId, request.getPartyId().trim(), "BILL_TO_CUSTOMER"));
        role.setFromDate(now);
        quoteRoleRepository.save(role);

        List<QuoteItem> items = quoteItemRepository.findByIdQuoteIdOrderByIdQuoteItemSeqId(quoteId);
        return QuoteMapper.toDto(quote, items);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<QuoteDto> findQuotes(QuoteSearchRequest request) {
        Specification<Quote> spec = buildSearchSpecification(request);
        PageRequest pageRequest = PageRequest.of(
                Math.max(request.getPage(), 0),
                Math.max(request.getSize(), 1),
                Sort.by(Sort.Direction.DESC, "issueDate"));

        Page<Quote> page = quoteRepository.findAll(spec, pageRequest);
        List<QuoteDto> content = page.getContent().stream()
                .map(this::toQuoteDto)
                .collect(Collectors.toList());
        return new PageImpl<>(content, pageRequest, page.getTotalElements());
    }

    @Override
    @Transactional(readOnly = true)
    public QuoteDto getQuote(String quoteId) {
        Quote quote = quoteRepository.findById(quoteId)
                .orElseThrow(() -> new ResourceNotFoundException("Quote not found: " + quoteId));
        return toQuoteDto(quote);
    }

    private QuoteDto toQuoteDto(Quote quote) {
        List<QuoteItem> items = quoteItemRepository.findByIdQuoteIdOrderByIdQuoteItemSeqId(quote.getQuoteId());
        return QuoteMapper.toDto(quote, items);
    }

    private Specification<Quote> buildSearchSpecification(QuoteSearchRequest request) {
        return (root, query, cb) -> {
            List<Predicate> predicates = new ArrayList<>();

            if (StringUtils.hasText(request.getQuoteId())) {
                predicates.add(SearchPredicateBuilder.apply(
                        cb, root.get("quoteId"), request.getQuoteId(), request.getQuoteIdMatchMode()));
            }

            if (StringUtils.hasText(request.getPartyId())) {
                predicates.add(SearchPredicateBuilder.apply(
                        cb, root.get("partyId"), request.getPartyId(), request.getPartyIdMatchMode()));
            }

            if (StringUtils.hasText(request.getProductId())) {
                Subquery<String> itemSubquery = query.subquery(String.class);
                Root<QuoteItem> itemRoot = itemSubquery.from(QuoteItem.class);
                itemSubquery.select(itemRoot.get("id").get("quoteId"));
                Predicate productMatch = SearchPredicateBuilder.apply(
                        cb,
                        itemRoot.get("productId"),
                        request.getProductId(),
                        request.getProductIdMatchMode());
                itemSubquery.where(productMatch);
                predicates.add(root.get("quoteId").in(itemSubquery));
            }

            if (request.getIssueDateFrom() != null) {
                predicates.add(cb.greaterThanOrEqualTo(root.get("issueDate"), request.getIssueDateFrom()));
            }
            if (request.getIssueDateTo() != null) {
                predicates.add(cb.lessThanOrEqualTo(root.get("issueDate"), request.getIssueDateTo()));
            }

            return cb.and(predicates.toArray(new Predicate[0]));
        };
    }

    private void validateItem(QuoteItemDto itemDto) {
        if (!StringUtils.hasText(itemDto.getProductId())) {
            throw new IllegalArgumentException("productId is required for each quote item");
        }
        if (itemDto.getQuantity() == null || itemDto.getQuantity().signum() <= 0) {
            throw new IllegalArgumentException("quantity must be positive for each quote item");
        }
        if (itemDto.getQuoteUnitPrice() == null) {
            throw new IllegalArgumentException("quoteUnitPrice is required for each quote item");
        }
    }
}
