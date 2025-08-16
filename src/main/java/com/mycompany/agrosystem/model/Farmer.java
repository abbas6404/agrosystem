package com.mycompany.agrosystem.model;

import java.util.List;

public class Farmer extends User {
    private String location;
    private double landSizeAcres;
    private String soilConditions;
    private String farmName;
    private Integer experience;
    private String specialization;
    private String goals;
    private String firstName;
    private String lastName;
    private String email;
    private String phone;
    private String dateOfBirth;
    private Double farmSize;
    private List<Crop> crops; // Add crops field

    // Default constructor
    public Farmer() {
        super();
    }

    // Constructor with parameters
    public Farmer(String username, String password, String userType) {
        super(username, password, userType);
    }

    // Getters and Setters
    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public double getLandSizeAcres() {
        return landSizeAcres;
    }

    public void setLandSizeAcres(double landSizeAcres) {
        this.landSizeAcres = landSizeAcres;
    }

    public String getSoilConditions() {
        return soilConditions;
    }

    public void setSoilConditions(String soilConditions) {
        this.soilConditions = soilConditions;
    }

    public String getFarmName() {
        return farmName;
    }

    public void setFarmName(String farmName) {
        this.farmName = farmName;
    }

    public Integer getExperience() {
        return experience;
    }

    public void setExperience(Integer experience) {
        this.experience = experience;
    }

    public String getSpecialization() {
        return specialization;
    }

    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }

    public String getGoals() {
        return goals;
    }

    public void setGoals(String goals) {
        this.goals = goals;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(String dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public Double getFarmSize() {
        return farmSize;
    }

    public void setFarmSize(Double farmSize) {
        this.farmSize = farmSize;
    }

    // Add crops getter and setter
    public List<Crop> getCrops() {
        return crops;
    }

    public void setCrops(List<Crop> crops) {
        this.crops = crops;
    }

    @Override
    public String getUserType() {
        return "FARMER";
    }

    @Override
    public String toString() {
        return "Farmer{" +
                "location='" + location + '\'' +
                ", landSizeAcres=" + landSizeAcres +
                ", soilConditions='" + soilConditions + '\'' +
                ", farmName='" + farmName + '\'' +
                ", experience=" + experience +
                ", specialization='" + specialization + '\'' +
                ", goals='" + goals + '\'' +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", dateOfBirth='" + dateOfBirth + '\'' +
                ", farmSize=" + farmSize +
                ", crops=" + crops +
                '}';
    }
}