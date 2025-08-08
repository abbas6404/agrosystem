package com.mycompany.agrosystem.model;

/**
 * Represents an Admin user. Inherits from User.
 */
public class Admin extends User {
    private String email;
    private int experienceYears;

    // Getters and Setters
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public int getExperienceYears() { return experienceYears; }
    public void setExperienceYears(int experienceYears) { this.experienceYears = experienceYears; }

    @Override
    public String getUserType() {
        return "ADMIN";
    }
}
