package com.mycompany.agrosystem.model;

import java.util.List;

/**
 * Represents a Farmer user. Inherits from User.
 */
public class Farmer extends User {
    private String location;
    private double landSizeAcres;
    private String soilConditions;
    private List<Crop> crops;

    // Getters and Setters
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    public double getLandSizeAcres() { return landSizeAcres; }
    public void setLandSizeAcres(double landSizeAcres) { this.landSizeAcres = landSizeAcres; }
    public String getSoilConditions() { return soilConditions; }
    public void setSoilConditions(String soilConditions) { this.soilConditions = soilConditions; }
    public List<Crop> getCrops() { return crops; }
    public void setCrops(List<Crop> crops) { this.crops = crops; }

    @Override
    public String getUserType() {
        return "FARMER";
    }
}