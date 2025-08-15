package com.mycompany.agrosystem.model;

import java.time.LocalDateTime;

public class Settings {
    private int id;
    private String siteName;
    private String siteDescription;
    private String contactEmail;
    private String contactPhone;
    private String timezone;
    private String dateFormat;
    private String defaultLanguage;
    private boolean allowRegistration;
    private boolean emailVerification;
    private int minPasswordLength;
    private int sessionTimeout;
    private String defaultUserRole;
    private int dbPoolSize;
    private int dbTimeout;
    private int maxFileSize;
    private String allowedFileTypes;
    private String logLevel;
    private int logRetention;
    private boolean emailNotifications;
    private String smtpServer;
    private int smtpPort;
    private String smtpUsername;
    private String smtpPassword;
    private boolean notifyNewUsers;
    private boolean notifyCropUpdates;
    private boolean notifySystemAlerts;
    private boolean notifyReports;
    private String backupFrequency;
    private String backupTime;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    
    // Default constructor
    public Settings() {
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getSiteName() {
        return siteName;
    }
    
    public void setSiteName(String siteName) {
        this.siteName = siteName;
    }
    
    public String getSiteDescription() {
        return siteDescription;
    }
    
    public void setSiteDescription(String siteDescription) {
        this.siteDescription = siteDescription;
    }
    
    public String getContactEmail() {
        return contactEmail;
    }
    
    public void setContactEmail(String contactEmail) {
        this.contactEmail = contactEmail;
    }
    
    public String getContactPhone() {
        return contactPhone;
    }
    
    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }
    
    public String getTimezone() {
        return timezone;
    }
    
    public void setTimezone(String timezone) {
        this.timezone = timezone;
    }
    
    public String getDateFormat() {
        return dateFormat;
    }
    
    public void setDateFormat(String dateFormat) {
        this.dateFormat = dateFormat;
    }
    
    public String getDefaultLanguage() {
        return defaultLanguage;
    }
    
    public void setDefaultLanguage(String defaultLanguage) {
        this.defaultLanguage = defaultLanguage;
    }
    
    public boolean isAllowRegistration() {
        return allowRegistration;
    }
    
    public void setAllowRegistration(boolean allowRegistration) {
        this.allowRegistration = allowRegistration;
    }
    
    public boolean isEmailVerification() {
        return emailVerification;
    }
    
    public void setEmailVerification(boolean emailVerification) {
        this.emailVerification = emailVerification;
    }
    
    public int getMinPasswordLength() {
        return minPasswordLength;
    }
    
    public void setMinPasswordLength(int minPasswordLength) {
        this.minPasswordLength = minPasswordLength;
    }
    
    public int getSessionTimeout() {
        return sessionTimeout;
    }
    
    public void setSessionTimeout(int sessionTimeout) {
        this.sessionTimeout = sessionTimeout;
    }
    
    public String getDefaultUserRole() {
        return defaultUserRole;
    }
    
    public void setDefaultUserRole(String defaultUserRole) {
        this.defaultUserRole = defaultUserRole;
    }
    
    public int getDbPoolSize() {
        return dbPoolSize;
    }
    
    public void setDbPoolSize(int dbPoolSize) {
        this.dbPoolSize = dbPoolSize;
    }
    
    public int getDbTimeout() {
        return dbTimeout;
    }
    
    public void setDbTimeout(int dbTimeout) {
        this.dbTimeout = dbTimeout;
    }
    
    public int getMaxFileSize() {
        return maxFileSize;
    }
    
    public void setMaxFileSize(int maxFileSize) {
        this.maxFileSize = maxFileSize;
    }
    
    public String getAllowedFileTypes() {
        return allowedFileTypes;
    }
    
    public void setAllowedFileTypes(String allowedFileTypes) {
        this.allowedFileTypes = allowedFileTypes;
    }
    
    public String getLogLevel() {
        return logLevel;
    }
    
    public void setLogLevel(String logLevel) {
        this.logLevel = logLevel;
    }
    
    public int getLogRetention() {
        return logRetention;
    }
    
    public void setLogRetention(int logRetention) {
        this.logRetention = logRetention;
    }
    
    public boolean isEmailNotifications() {
        return emailNotifications;
    }
    
    public void setEmailNotifications(boolean emailNotifications) {
        this.emailNotifications = emailNotifications;
    }
    
    public String getSmtpServer() {
        return smtpServer;
    }
    
    public void setSmtpServer(String smtpServer) {
        this.smtpServer = smtpServer;
    }
    
    public int getSmtpPort() {
        return smtpPort;
    }
    
    public void setSmtpPort(int smtpPort) {
        this.smtpPort = smtpPort;
    }
    
    public String getSmtpUsername() {
        return smtpUsername;
    }
    
    public void setSmtpUsername(String smtpUsername) {
        this.smtpUsername = smtpUsername;
    }
    
    public String getSmtpPassword() {
        return smtpPassword;
    }
    
    public void setSmtpPassword(String smtpPassword) {
        this.smtpPassword = smtpPassword;
    }
    
    public boolean isNotifyNewUsers() {
        return notifyNewUsers;
    }
    
    public void setNotifyNewUsers(boolean notifyNewUsers) {
        this.notifyNewUsers = notifyNewUsers;
    }
    
    public boolean isNotifyCropUpdates() {
        return notifyCropUpdates;
    }
    
    public void setNotifyCropUpdates(boolean notifyCropUpdates) {
        this.notifyCropUpdates = notifyCropUpdates;
    }
    
    public boolean isNotifySystemAlerts() {
        return notifySystemAlerts;
    }
    
    public void setNotifySystemAlerts(boolean notifySystemAlerts) {
        this.notifySystemAlerts = notifySystemAlerts;
    }
    
    public boolean isNotifyReports() {
        return notifyReports;
    }
    
    public void setNotifyReports(boolean notifyReports) {
        this.notifyReports = notifyReports;
    }
    
    public String getBackupFrequency() {
        return backupFrequency;
    }
    
    public void setBackupFrequency(String backupFrequency) {
        this.backupFrequency = backupFrequency;
    }
    
    public String getBackupTime() {
        return backupTime;
    }
    
    public void setBackupTime(String backupTime) {
        this.backupTime = backupTime;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    @Override
    public String toString() {
        return "Settings{" +
                "id=" + id +
                ", siteName='" + siteName + '\'' +
                ", siteDescription='" + siteDescription + '\'' +
                ", contactEmail='" + contactEmail + '\'' +
                ", contactPhone='" + contactPhone + '\'' +
                ", timezone='" + timezone + '\'' +
                ", dateFormat='" + dateFormat + '\'' +
                ", defaultLanguage='" + defaultLanguage + '\'' +
                ", allowRegistration=" + allowRegistration +
                ", emailVerification=" + emailVerification +
                ", minPasswordLength=" + minPasswordLength +
                ", sessionTimeout=" + sessionTimeout +
                ", defaultUserRole='" + defaultUserRole + '\'' +
                ", dbPoolSize=" + dbPoolSize +
                ", dbTimeout=" + dbTimeout +
                ", maxFileSize=" + maxFileSize +
                ", allowedFileTypes='" + allowedFileTypes + '\'' +
                ", logLevel='" + logLevel + '\'' +
                ", logRetention=" + logRetention +
                ", emailNotifications=" + emailNotifications +
                ", smtpServer='" + smtpServer + '\'' +
                ", smtpPort=" + smtpPort +
                ", smtpUsername='" + smtpUsername + '\'' +
                ", notifyNewUsers=" + notifyNewUsers +
                ", notifyCropUpdates=" + notifyCropUpdates +
                ", notifySystemAlerts=" + notifySystemAlerts +
                ", notifyReports=" + notifyReports +
                ", backupFrequency='" + backupFrequency + '\'' +
                ", backupTime='" + backupTime + '\'' +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}
