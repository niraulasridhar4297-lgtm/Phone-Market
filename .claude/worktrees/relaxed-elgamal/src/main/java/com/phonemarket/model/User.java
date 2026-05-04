package com.phonemarket.model;

import java.sql.Timestamp;

public class User {
    private int userId;
    private String fullName;
    private String email;
    private String passwordHash;
    private String phoneNumber;
    private String role;          // "user" or "admin"
    private boolean isLocked;
    private int failedAttempts;
    private Timestamp createdAt;

    public User() {}

    // Getters and Setters
    public int getUserId()                   { return userId; }
    public void setUserId(int userId)        { this.userId = userId; }

    public String getFullName()                   { return fullName; }
    public void setFullName(String fullName)      { this.fullName = fullName; }

    public String getEmail()                  { return email; }
    public void setEmail(String email)        { this.email = email; }

    public String getPasswordHash()                        { return passwordHash; }
    public void setPasswordHash(String passwordHash)       { this.passwordHash = passwordHash; }

    public String getPhoneNumber()                    { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber)    { this.phoneNumber = phoneNumber; }

    public String getRole()               { return role; }
    public void setRole(String role)      { this.role = role; }

    public boolean isLocked()                   { return isLocked; }
    public void setLocked(boolean locked)       { isLocked = locked; }

    public int getFailedAttempts()                       { return failedAttempts; }
    public void setFailedAttempts(int failedAttempts)    { this.failedAttempts = failedAttempts; }

    public Timestamp getCreatedAt()                    { return createdAt; }
    public void setCreatedAt(Timestamp createdAt)      { this.createdAt = createdAt; }
}
