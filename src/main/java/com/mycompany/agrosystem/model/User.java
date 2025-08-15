package com.mycompany.agrosystem.model;

import java.time.LocalDateTime;

/**
 * Abstract base class for all users in the system (Admin, Farmer).
 * It defines common properties.
 */
public abstract class User {
    private int id;
    private String name;
    private String phoneNumber;
    private String password;
    private LocalDateTime createdAt;

    // Getters and Setters for all fields
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    
    // Abstract method to be implemented by subclasses
    public abstract String getUserType();
}
