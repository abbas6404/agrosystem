package com.mycompany.agrosystem.model;

/**
 * Represents a Farmer user. Inherits from User.
 */
public class Farmer extends User {
    private String location;
    private double landSizeAcres;
    private String soilConditions;

    // Getters and Setters
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    public double getLandSizeAcres() { return landSizeAcres; }
    public void setLandSizeAcres(double landSizeAcres) { this.landSizeAcres = landSizeAcres; }
    public String getSoilConditions() { return soilConditions; }
    public void setSoilConditions(String soilConditions) { this.soilConditions = soilConditions; }

    @Override
    public String getUserType() {
        return "FARMER";
    }
}