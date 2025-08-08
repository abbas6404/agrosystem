-- AgroSyst Database Setup Script
-- Run this script in your MySQL database (agro_system_db)

-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS agro_system_db;
USE agro_system_db;

-- Users table (base table for all users)
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    user_type ENUM('FARMER', 'ADMIN') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Farmers table (extends users)
CREATE TABLE farmers (
    user_id INT PRIMARY KEY,
    location VARCHAR(200) NOT NULL,
    land_size_acres DECIMAL(10,2) NOT NULL,
    soil_conditions TEXT,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Admins table (extends users)
CREATE TABLE admins (
    user_id INT PRIMARY KEY,
    email VARCHAR(100) UNIQUE NOT NULL,
    experience_years INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Crops table (master data)
CREATE TABLE crops (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Farmer-Crops relationship table
CREATE TABLE farmer_crops (
    id INT PRIMARY KEY AUTO_INCREMENT,
    farmer_user_id INT NOT NULL,
    crop_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (farmer_user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (crop_id) REFERENCES crops(id) ON DELETE CASCADE,
    UNIQUE KEY unique_farmer_crop (farmer_user_id, crop_id)
);

-- Notices table
CREATE TABLE notices (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    content TEXT NOT NULL,
    created_by_admin_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by_admin_id) REFERENCES users(id) ON DELETE SET NULL
);

-- Insert sample admin user (password: admin123)
INSERT INTO users (name, phone_number, password, user_type) 
VALUES ('System Admin', 'admin', 'admin123', 'ADMIN');

INSERT INTO admins (user_id, email, experience_years) 
VALUES (1, 'admin@agrosyst.com', 5);

-- Insert sample crops
INSERT INTO crops (name, description) VALUES 
('Rice', 'Staple food crop, requires plenty of water'),
('Wheat', 'Cereal grain, good for bread making'),
('Corn', 'Maize crop, versatile for food and feed'),
('Soybeans', 'Legume crop, high protein content'),
('Cotton', 'Fiber crop, used in textile industry');

-- Create indexes for better performance
CREATE INDEX idx_users_phone ON users(phone_number);
CREATE INDEX idx_users_type ON users(user_type);
CREATE INDEX idx_crops_name ON crops(name);
CREATE INDEX idx_notices_created_at ON notices(created_at);
CREATE INDEX idx_farmer_crops_farmer ON farmer_crops(farmer_user_id);
CREATE INDEX idx_farmer_crops_crop ON farmer_crops(crop_id);
