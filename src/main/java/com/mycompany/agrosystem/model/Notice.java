package com.mycompany.agrosystem.model;

import java.sql.Timestamp;
import java.time.LocalDateTime;

/**
 * Represents a Notice from the 'notices' table.
 */
public class Notice {
    private int id;
    private String title;
    private String content;
    private String type;
    private String targetGroup;
    private int expiry;
    private Timestamp createdAt;
    private int adminId;
    
    // Default constructor
    public Notice() {
        this.type = "general";
        this.targetGroup = "all";
        this.expiry = 30;
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    
    public String getTargetGroup() { return targetGroup; }
    public void setTargetGroup(String targetGroup) { this.targetGroup = targetGroup; }
    
    public int getExpiry() { return expiry; }
    public void setExpiry(int expiry) { this.expiry = expiry; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    public int getAdminId() { return adminId; }
    public void setAdminId(int adminId) { this.adminId = adminId; }
    
    // Helper methods
    public boolean isImportant() {
        return "important".equals(type) || "urgent".equals(type);
    }
    
    public boolean isExpired() {
        if (expiry == 0) return false; // Unlimited
        if (createdAt == null) return false;
        
        try {
            LocalDateTime expiryDate = createdAt.toLocalDateTime().plusDays(expiry);
            return LocalDateTime.now().isAfter(expiryDate);
        } catch (Exception e) {
            return false;
        }
    }
    
    public boolean isActive() {
        return !isExpired();
    }
    
    @Override
    public String toString() {
        return "Notice{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", type='" + type + '\'' +
                ", targetGroup='" + targetGroup + '\'' +
                ", expiry=" + expiry +
                '}';
    }
}