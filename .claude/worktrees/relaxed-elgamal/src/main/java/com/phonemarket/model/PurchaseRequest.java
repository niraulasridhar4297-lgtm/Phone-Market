package com.phonemarket.model;

import java.sql.Timestamp;

public class PurchaseRequest {
    private int requestId;
    private int listingId;
    private int buyerId;
    private String buyerName;
    private String buyerEmail;
    private String listingTitle;
    private String message;
    private String status;   // pending / accepted / rejected / cancelled
    private Timestamp createdAt;

    public PurchaseRequest() {}

    public int getRequestId()                       { return requestId; }
    public void setRequestId(int requestId)         { this.requestId = requestId; }

    public int getListingId()                       { return listingId; }
    public void setListingId(int listingId)         { this.listingId = listingId; }

    public int getBuyerId()                         { return buyerId; }
    public void setBuyerId(int buyerId)             { this.buyerId = buyerId; }

    public String getBuyerName()                    { return buyerName; }
    public void setBuyerName(String buyerName)      { this.buyerName = buyerName; }

    public String getBuyerEmail()                   { return buyerEmail; }
    public void setBuyerEmail(String buyerEmail)    { this.buyerEmail = buyerEmail; }

    public String getListingTitle()                         { return listingTitle; }
    public void setListingTitle(String listingTitle)        { this.listingTitle = listingTitle; }

    public String getMessage()                  { return message; }
    public void setMessage(String message)      { this.message = message; }

    public String getStatus()               { return status; }
    public void setStatus(String status)    { this.status = status; }

    public Timestamp getCreatedAt()                    { return createdAt; }
    public void setCreatedAt(Timestamp createdAt)      { this.createdAt = createdAt; }
}
