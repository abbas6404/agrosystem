package com.mycompany.agrosystem.dao;

import com.mycompany.agrosystem.model.Settings;
import com.mycompany.agrosystem.util.DBConnection;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;
import java.util.logging.Level;

public class SettingsDAO {
    
    private static final Logger logger = Logger.getLogger(SettingsDAO.class.getName());
    
    public SettingsDAO() {
        initializeSettingsTable();
        createBackupHistoryTable();
    }
    
    private void initializeSettingsTable() {
        String createTableSQL = "CREATE TABLE IF NOT EXISTS settings (" +
            "id INT PRIMARY KEY AUTO_INCREMENT," +
            "site_name VARCHAR(255) DEFAULT 'AgroSystem'," +
            "site_description TEXT," +
            "contact_email VARCHAR(255)," +
            "contact_phone VARCHAR(50)," +
            "timezone VARCHAR(100) DEFAULT 'Asia/Dhaka'," +
            "date_format VARCHAR(50) DEFAULT 'dd/MM/yyyy'," +
            "default_language VARCHAR(10) DEFAULT 'bn'," +
            "allow_registration BOOLEAN DEFAULT TRUE," +
            "email_verification BOOLEAN DEFAULT FALSE," +
            "min_password_length INT DEFAULT 6," +
            "session_timeout INT DEFAULT 30," +
            "default_user_role VARCHAR(50) DEFAULT 'FARMER'," +
            "db_pool_size INT DEFAULT 10," +
            "db_timeout INT DEFAULT 30," +
            "max_file_size INT DEFAULT 10," +
            "allowed_file_types TEXT," +
            "log_level VARCHAR(20) DEFAULT 'INFO'," +
            "log_retention INT DEFAULT 30," +
            "email_notifications BOOLEAN DEFAULT FALSE," +
            "smtp_server VARCHAR(255) DEFAULT 'smtp.gmail.com'," +
            "smtp_port INT DEFAULT 587," +
            "smtp_username VARCHAR(255)," +
            "smtp_password VARCHAR(255)," +
            "notify_new_users BOOLEAN DEFAULT TRUE," +
            "notify_crop_updates BOOLEAN DEFAULT TRUE," +
            "notify_system_alerts BOOLEAN DEFAULT TRUE," +
            "notify_reports BOOLEAN DEFAULT FALSE," +
            "backup_frequency VARCHAR(50) DEFAULT 'weekly'," +
            "backup_time VARCHAR(10) DEFAULT '02:00'," +
            "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP," +
            "updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP" +
            ")";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {
            stmt.execute(createTableSQL);
            logger.info("Settings table initialized successfully");
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error initializing settings table", e);
        }
    }
    
    public Settings getSettings() {
        String sql = "SELECT * FROM settings ORDER BY id DESC LIMIT 1";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            if (rs.next()) {
                return mapResultSetToSettings(rs);
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving settings", e);
        }
        
        return null;
    }
    
    public boolean saveSettings(Settings settings) {
        String sql = "INSERT INTO settings (" +
            "site_name, site_description, contact_email, contact_phone," +
            "timezone, date_format, default_language, allow_registration," +
            "email_verification, min_password_length, session_timeout," +
            "default_user_role, db_pool_size, db_timeout, max_file_size," +
            "allowed_file_types, log_level, log_retention, email_notifications," +
            "smtp_server, smtp_port, smtp_username, smtp_password," +
            "notify_new_users, notify_crop_updates, notify_system_alerts," +
            "notify_reports, backup_frequency, backup_time" +
            ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) " +
            "ON DUPLICATE KEY UPDATE " +
            "site_name = VALUES(site_name)," +
            "site_description = VALUES(site_description)," +
            "contact_email = VALUES(contact_email)," +
            "contact_phone = VALUES(contact_phone)," +
            "timezone = VALUES(timezone)," +
            "date_format = VALUES(date_format)," +
            "default_language = VALUES(default_language)," +
            "allow_registration = VALUES(allow_registration)," +
            "email_verification = VALUES(email_verification)," +
            "min_password_length = VALUES(min_password_length)," +
            "session_timeout = VALUES(session_timeout)," +
            "default_user_role = VALUES(default_user_role)," +
            "db_pool_size = VALUES(db_pool_size)," +
            "db_timeout = VALUES(db_timeout)," +
            "max_file_size = VALUES(max_file_size)," +
            "allowed_file_types = VALUES(allowed_file_types)," +
            "log_level = VALUES(log_level)," +
            "log_retention = VALUES(log_retention)," +
            "email_notifications = VALUES(email_notifications)," +
            "smtp_server = VALUES(smtp_server)," +
            "smtp_port = VALUES(smtp_port)," +
            "smtp_username = VALUES(smtp_username)," +
            "smtp_password = VALUES(smtp_password)," +
            "notify_new_users = VALUES(notify_new_users)," +
            "notify_crop_updates = VALUES(notify_crop_updates)," +
            "notify_system_alerts = VALUES(notify_system_alerts)," +
            "notify_reports = VALUES(notify_reports)," +
            "backup_frequency = VALUES(backup_frequency)," +
            "backup_time = VALUES(backup_time)," +
            "updated_at = CURRENT_TIMESTAMP";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            int paramIndex = 1;
            pstmt.setString(paramIndex++, settings.getSiteName());
            pstmt.setString(paramIndex++, settings.getSiteDescription());
            pstmt.setString(paramIndex++, settings.getContactEmail());
            pstmt.setString(paramIndex++, settings.getContactPhone());
            pstmt.setString(paramIndex++, settings.getTimezone());
            pstmt.setString(paramIndex++, settings.getDateFormat());
            pstmt.setString(paramIndex++, settings.getDefaultLanguage());
            pstmt.setBoolean(paramIndex++, settings.isAllowRegistration());
            pstmt.setBoolean(paramIndex++, settings.isEmailVerification());
            pstmt.setInt(paramIndex++, settings.getMinPasswordLength());
            pstmt.setInt(paramIndex++, settings.getSessionTimeout());
            pstmt.setString(paramIndex++, settings.getDefaultUserRole());
            pstmt.setInt(paramIndex++, settings.getDbPoolSize());
            pstmt.setInt(paramIndex++, settings.getDbTimeout());
            pstmt.setInt(paramIndex++, settings.getMaxFileSize());
            pstmt.setString(paramIndex++, settings.getAllowedFileTypes());
            pstmt.setString(paramIndex++, settings.getLogLevel());
            pstmt.setInt(paramIndex++, settings.getLogRetention());
            pstmt.setBoolean(paramIndex++, settings.isEmailNotifications());
            pstmt.setString(paramIndex++, settings.getSmtpServer());
            pstmt.setInt(paramIndex++, settings.getSmtpPort());
            pstmt.setString(paramIndex++, settings.getSmtpUsername());
            pstmt.setString(paramIndex++, settings.getSmtpPassword());
            pstmt.setBoolean(paramIndex++, settings.isNotifyNewUsers());
            pstmt.setBoolean(paramIndex++, settings.isNotifyCropUpdates());
            pstmt.setBoolean(paramIndex++, settings.isNotifySystemAlerts());
            pstmt.setBoolean(paramIndex++, settings.isNotifyReports());
            pstmt.setString(paramIndex++, settings.getBackupFrequency());
            pstmt.setString(paramIndex++, settings.getBackupTime());
            
            int rowsAffected = pstmt.executeUpdate();
            logger.info("Settings saved successfully. Rows affected: " + rowsAffected);
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error saving settings", e);
            return false;
        }
    }
    
    public List<Map<String, Object>> getBackupHistory() {
        List<Map<String, Object>> backups = new ArrayList<>();
        String sql = "SELECT * FROM backup_history ORDER BY created_at DESC LIMIT 10";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Map<String, Object> backup = new HashMap<>();
                backup.put("id", rs.getInt("id"));
                backup.put("filename", rs.getString("filename"));
                backup.put("size", rs.getLong("size"));
                backup.put("status", rs.getString("status"));
                backup.put("createdAt", rs.getTimestamp("created_at"));
                backups.add(backup);
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving backup history", e);
        }
        
        return backups;
    }
    
    public boolean createBackup() {
        // This is a placeholder implementation
        // In a real application, you would implement actual database backup logic
        try {
            // Create backup history table if it doesn't exist
            createBackupHistoryTable();
            
            // Simulate backup creation
            String filename = "backup_" + System.currentTimeMillis() + ".sql";
            long size = 1024 * 1024; // 1MB placeholder
            
            String sql = "INSERT INTO backup_history (filename, size, status) VALUES (?, ?, ?)";
            
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                
                pstmt.setString(1, filename);
                pstmt.setLong(2, size);
                pstmt.setString(3, "completed");
                
                int rowsAffected = pstmt.executeUpdate();
                logger.info("Backup created successfully: " + filename);
                return rowsAffected > 0;
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error creating backup", e);
            return false;
        }
    }
    
    public boolean downloadBackup(String filename, jakarta.servlet.http.HttpServletResponse response) {
        // This is a placeholder implementation
        // In a real application, you would implement actual file download logic
        try {
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
            
            // Write placeholder content
            String content = "-- Backup file: " + filename + " --\n";
            content += "Generated on: " + LocalDateTime.now() + "\n";
            content += "This is a placeholder backup file.\n";
            
            response.getWriter().write(content);
            return true;
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error downloading backup", e);
            return false;
        }
    }
    
    public boolean restoreBackup(String filename) {
        // This is a placeholder implementation
        // In a real application, you would implement actual database restore logic
        try {
            logger.info("Restoring backup: " + filename);
            // Simulate restore process
            Thread.sleep(2000); // Simulate processing time
            return true;
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error restoring backup", e);
            return false;
        }
    }
    
    public boolean deleteBackup(String filename) {
        String sql = "DELETE FROM backup_history WHERE filename = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, filename);
            int rowsAffected = pstmt.executeUpdate();
            
            logger.info("Backup deleted successfully: " + filename);
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error deleting backup", e);
            return false;
        }
    }
    
    private void createBackupHistoryTable() {
        String createTableSQL = "CREATE TABLE IF NOT EXISTS backup_history (" +
            "id INT PRIMARY KEY AUTO_INCREMENT," +
            "filename VARCHAR(255) NOT NULL," +
            "size BIGINT DEFAULT 0," +
            "status VARCHAR(50) DEFAULT 'pending'," +
            "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP," +
            "updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP" +
            ")";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {
            stmt.execute(createTableSQL);
            logger.info("Backup history table initialized successfully");
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error initializing backup history table", e);
        }
    }
    
    private Settings mapResultSetToSettings(ResultSet rs) throws SQLException {
        Settings settings = new Settings();
        settings.setId(rs.getInt("id"));
        settings.setSiteName(rs.getString("site_name"));
        settings.setSiteDescription(rs.getString("site_description"));
        settings.setContactEmail(rs.getString("contact_email"));
        settings.setContactPhone(rs.getString("contact_phone"));
        settings.setTimezone(rs.getString("timezone"));
        settings.setDateFormat(rs.getString("date_format"));
        settings.setDefaultLanguage(rs.getString("default_language"));
        settings.setAllowRegistration(rs.getBoolean("allow_registration"));
        settings.setEmailVerification(rs.getBoolean("email_verification"));
        settings.setMinPasswordLength(rs.getInt("min_password_length"));
        settings.setSessionTimeout(rs.getInt("session_timeout"));
        settings.setDefaultUserRole(rs.getString("default_user_role"));
        settings.setDbPoolSize(rs.getInt("db_pool_size"));
        settings.setDbTimeout(rs.getInt("db_timeout"));
        settings.setMaxFileSize(rs.getInt("max_file_size"));
        settings.setAllowedFileTypes(rs.getString("allowed_file_types"));
        settings.setLogLevel(rs.getString("log_level"));
        settings.setLogRetention(rs.getInt("log_retention"));
        settings.setEmailNotifications(rs.getBoolean("email_notifications"));
        settings.setSmtpServer(rs.getString("smtp_server"));
        settings.setSmtpPort(rs.getInt("smtp_port"));
        settings.setSmtpUsername(rs.getString("smtp_username"));
        settings.setSmtpPassword(rs.getString("smtp_password"));
        settings.setNotifyNewUsers(rs.getBoolean("notify_new_users"));
        settings.setNotifyCropUpdates(rs.getBoolean("notify_crop_updates"));
        settings.setNotifySystemAlerts(rs.getBoolean("notify_system_alerts"));
        settings.setNotifyReports(rs.getBoolean("notify_reports"));
        settings.setBackupFrequency(rs.getString("backup_frequency"));
        settings.setBackupTime(rs.getString("backup_time"));
        
        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            settings.setCreatedAt(createdAt.toLocalDateTime());
        }
        
        Timestamp updatedAt = rs.getTimestamp("updated_at");
        if (updatedAt != null) {
            settings.setUpdatedAt(updatedAt.toLocalDateTime());
        }
        
        return settings;
    }
}
