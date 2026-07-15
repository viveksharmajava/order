package com.playpro.playpro.orders.client;

import com.playpro.playpro.orders.client.dto.InventoryOperationClientRequest;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

@Component
public class FacilityClient {

    private final RestTemplate restTemplate;
    private final String facilityBaseUrl;

    public FacilityClient(RestTemplate restTemplate,
                          @Value("${facility.service.base-url:http://localhost:8084}") String facilityBaseUrl) {
        this.restTemplate = restTemplate;
        this.facilityBaseUrl = facilityBaseUrl;
    }

    public void reserveInventory(InventoryOperationClientRequest request, String xUser) {
        post("/facility/inventory/reserve", request, xUser);
    }

    public void issueInventory(InventoryOperationClientRequest request, String xUser) {
        post("/facility/inventory/issue", request, xUser);
    }

    public void releaseInventory(InventoryOperationClientRequest request, String xUser) {
        post("/facility/inventory/release", request, xUser);
    }

    private void post(String path, InventoryOperationClientRequest request, String xUser) {
        try {
            restTemplate.exchange(
                    facilityBaseUrl + path,
                    HttpMethod.POST,
                    new HttpEntity<>(request, headers(xUser)),
                    Object.class);
        } catch (RestClientException ex) {
            throw new IllegalArgumentException("Facility inventory operation failed: " + ex.getMessage());
        }
    }

    private HttpHeaders headers(String xUser) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        if (xUser != null && !xUser.trim().isEmpty()) {
            headers.set("X-User", xUser);
        } else {
            headers.set("X-User", "system:ADMIN");
        }
        return headers;
    }
}
