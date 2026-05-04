package com.phonemarket.model;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

public class PhoneListing {
    private int listingId;
    private int sellerId;
    private String sellerName;    // joined from users table
    private String sellerEmail;
    private String title;
    private String brand;
    private String modelName;
    private Date firstBuyDate;
    private int ramGb;
    private int storageGb;
    private int batteryMah;
    private BigDecimal screenSizeInch;
    private String color;
    private String conditionGrade;  // Excellent / Good / Fair / Poor
    private BigDecimal price;
    private String description;
    private String imagePath;
    private String status;           // available / sold / pending_review / rejected
    private int listingOrder;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public PhoneListing() {}

    // ---- Getters & Setters ----
    public int getListingId()                       { return listingId; }
    public void setListingId(int listingId)         { this.listingId = listingId; }

    public int getSellerId()                        { return sellerId; }
    public void setSellerId(int sellerId)           { this.sellerId = sellerId; }

    public String getSellerName()                   { return sellerName; }
    public void setSellerName(String sellerName)    { this.sellerName = sellerName; }

    public String getSellerEmail()                  { return sellerEmail; }
    public void setSellerEmail(String sellerEmail)  { this.sellerEmail = sellerEmail; }

    public String getTitle()                    { return title; }
    public void setTitle(String title)          { this.title = title; }

    public String getBrand()                    { return brand; }
    public void setBrand(String brand)          { this.brand = brand; }

    public String getModelName()                       { return modelName; }
    public void setModelName(String modelName)         { this.modelName = modelName; }

    public Date getFirstBuyDate()                      { return firstBuyDate; }
    public void setFirstBuyDate(Date firstBuyDate)     { this.firstBuyDate = firstBuyDate; }

    public int getRamGb()                   { return ramGb; }
    public void setRamGb(int ramGb)         { this.ramGb = ramGb; }

    public int getStorageGb()               { return storageGb; }
    public void setStorageGb(int storageGb) { this.storageGb = storageGb; }

    public int getBatteryMah()                  { return batteryMah; }
    public void setBatteryMah(int batteryMah)   { this.batteryMah = batteryMah; }

    public BigDecimal getScreenSizeInch()                           { return screenSizeInch; }
    public void setScreenSizeInch(BigDecimal screenSizeInch)        { this.screenSizeInch = screenSizeInch; }

    public String getColor()                { return color; }
    public void setColor(String color)      { this.color = color; }

    public String getConditionGrade()                       { return conditionGrade; }
    public void setConditionGrade(String conditionGrade)    { this.conditionGrade = conditionGrade; }

    public BigDecimal getPrice()                { return price; }
    public void setPrice(BigDecimal price)      { this.price = price; }

    public String getDescription()                    { return description; }
    public void setDescription(String description)    { this.description = description; }

    public String getImagePath()                  { return imagePath; }
    public void setImagePath(String imagePath)    { this.imagePath = imagePath; }

    public String getStatus()               { return status; }
    public void setStatus(String status)    { this.status = status; }

    public int getListingOrder()                        { return listingOrder; }
    public void setListingOrder(int listingOrder)       { this.listingOrder = listingOrder; }

    public Timestamp getCreatedAt()                    { return createdAt; }
    public void setCreatedAt(Timestamp createdAt)      { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt()                    { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt)      { this.updatedAt = updatedAt; }
}
