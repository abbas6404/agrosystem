-- AgroSyst Database Setup Script
-- Run this script in your MySQL database (agro_system_db)

-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS agro_system_db;
USE agro_system_db;

-- Drop existing tables if they exist (in reverse order of dependencies)
DROP TABLE IF EXISTS farmer_crops;
DROP TABLE IF EXISTS notices;
DROP TABLE IF EXISTS crops;
DROP TABLE IF EXISTS admins;
DROP TABLE IF EXISTS farmers;
DROP TABLE IF EXISTS users;

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
    type VARCHAR(50),
    season VARCHAR(50),
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

-- Notices table (with all new columns)
CREATE TABLE notices (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    content TEXT NOT NULL,
    type VARCHAR(50) DEFAULT 'general',
    target_group VARCHAR(100) DEFAULT 'all',
    expiry INT DEFAULT 30,
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
INSERT INTO crops (name, description, type, season) VALUES 
('ধান', 'বাংলাদেশের প্রধান খাদ্যশস্য, প্রচুর পানি প্রয়োজন', 'ধান', 'খরিফ'),
('গম', 'শস্যজাতীয় ফসল, রুটি তৈরির জন্য ভালো', 'গম', 'রবি'),
('ভুট্টা', 'মেইজ ফসল, খাদ্য ও খাদ্যের জন্য বহুমুখী', 'ভুট্টা', 'খরিফ'),
('মসুর ডাল', 'ডালজাতীয় ফসল, উচ্চ প্রোটিন সমৃদ্ধ', 'ডাল', 'রবি'),
('আলু', 'মূলজাতীয় সবজি, সারা বছর চাষ করা যায়', 'সবজি', 'রবি'),
('টমেটো', 'ফলজাতীয় সবজি, সালাদ ও রান্নায় ব্যবহৃত', 'সবজি', 'জায়েদ'),
('আম', 'বাংলাদেশের জাতীয় ফল, গ্রীষ্মকালীন', 'ফল', 'জায়েদ'),
('কলা', 'সারা বছর পাওয়া যায়, উচ্চ পটাশিয়াম সমৃদ্ধ', 'ফল', 'সারা বছর');

-- Insert sample notices
INSERT INTO notices (title, content, type, target_group, expiry, created_by_admin_id, created_at) VALUES 
('কৃষি সহায়তা প্রোগ্রাম', 'সরকারি কৃষি সহায়তা প্রোগ্রাম সম্পর্কে জানুন। যোগাযোগ করুন: ০১৭১১-১২৩৪৫৬', 'announcement', 'all', 30, 1, CURRENT_TIMESTAMP),
('ধান চাষের নির্দেশনা', 'বর্তমান মৌসুমে ধান চাষের জন্য গুরুত্বপূর্ণ নির্দেশনা। সঠিক সময়ে রোপণ করুন।', 'important', 'rice', 7, 1, CURRENT_TIMESTAMP),
('জরুরি আবহাওয়া সতর্কতা', 'আপনার এলাকায় ভারী বৃষ্টিপাতের সম্ভাবনা। ফসল রক্ষার ব্যবস্থা নিন।', 'urgent', 'all', 1, 1, CURRENT_TIMESTAMP),
('নতুন কৃষি প্রযুক্তি', 'হাইব্রিড বীজ ব্যবহার করে ফলন বৃদ্ধি করুন। প্রশিক্ষণ সেশনে অংশগ্রহণ করুন।', 'educational', 'all', 60, 1, CURRENT_TIMESTAMP),
('বাজার মূল্য তথ্য', 'সপ্তাহের বাজার মূল্য: ধান ১২০০ টাকা/মন, গম ১৪০০ টাকা/মন', 'general', 'all', 7, 1, CURRENT_TIMESTAMP);

-- Create indexes for better performance
CREATE INDEX idx_users_phone ON users(phone_number);
CREATE INDEX idx_users_type ON users(user_type);
CREATE INDEX idx_crops_name ON crops(name);
CREATE INDEX idx_notices_created_at ON notices(created_at);
CREATE INDEX idx_farmer_crops_farmer ON farmer_crops(farmer_user_id);
CREATE INDEX idx_farmer_crops_crop ON farmer_crops(crop_id);
