package com.playpro.playpro.orders.dto;

public class ReferenceItemDto {

    private String id;
    private String label;

    public ReferenceItemDto() {
    }

    public ReferenceItemDto(String id, String label) {
        this.id = id;
        this.label = label;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }
}
