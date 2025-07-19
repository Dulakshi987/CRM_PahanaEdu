package com.billsystem.models;

import java.sql.Timestamp;

public class Item {
    private int itemId;
    private String itemCode;
    private String itemName;
    private String description;
    private double pricePerUnit;
    private int stockQuantity;
    private String status;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Getters and setters
    public int getItemId() { return itemId; }
    public void setItemId(int itemId) { this.itemId = itemId; }

    public String getItemCode() {return itemCode;}
    public void setItemCode(String itemCode) {this.itemCode = itemCode;}

    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getPricePerUnit() { return pricePerUnit; }
    public void setPricePerUnit(double pricePerUnit) { this.pricePerUnit = pricePerUnit; }

    public int getStockQuantity() { return stockQuantity; }
    public void setStockQuantity(int stockQuantity) { this.stockQuantity = stockQuantity; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getCreatedAt() {return createdAt;}

    public void setCreatedAt(Timestamp createdAt) {this.createdAt = createdAt;}

    public Timestamp getUpdatedAt() {return updatedAt;}

    public void setUpdatedAt(Timestamp updatedAt) {this.updatedAt = updatedAt;}
}
