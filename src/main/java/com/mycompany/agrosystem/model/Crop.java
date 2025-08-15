package com.mycompany.agrosystem.model;

import java.time.LocalDateTime;

/**
 * Represents a Crop from the master 'crops' table.
 */
public class Crop {
    private int id;
    private String name;
    private String description;
    private String type;
    private String season;
    private LocalDateTime createdAt;
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public String getSeason() { return season; }
    public void setSeason(String season) { this.season = season; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}
