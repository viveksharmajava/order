package com.playpro.playpro.orders.controller;

import com.playpro.playpro.orders.dto.CreateQuoteRequest;
import com.playpro.playpro.orders.dto.QuoteDto;
import com.playpro.playpro.orders.dto.QuoteSearchRequest;
import com.playpro.playpro.orders.service.QuoteService;
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
@RequestMapping("/orders/quotes")
public class QuoteController {

    private final QuoteService quoteService;

    public QuoteController(QuoteService quoteService) {
        this.quoteService = quoteService;
    }

    @PostMapping
    public ResponseEntity<QuoteDto> createQuote(@RequestHeader(value = "X-User", required = false) String xUser,
                                                @RequestBody CreateQuoteRequest request) {
        return ResponseEntity.ok(quoteService.createQuote(request, resolvePrincipal(xUser)));
    }

    @PostMapping("/find")
    public ResponseEntity<Page<QuoteDto>> findQuotes(@RequestBody QuoteSearchRequest request) {
        return ResponseEntity.ok(quoteService.findQuotes(request));
    }

    @GetMapping("/{quoteId}")
    public ResponseEntity<QuoteDto> getQuote(@PathVariable String quoteId) {
        return ResponseEntity.ok(quoteService.getQuote(quoteId));
    }

    private String resolvePrincipal(String xUser) {
        if (xUser == null || !xUser.contains(":")) {
            return "system";
        }
        return xUser.split(":", 2)[0];
    }
}
