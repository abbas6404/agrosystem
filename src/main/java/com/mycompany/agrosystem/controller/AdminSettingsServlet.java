package com.mycompany.agrosystem.controller;

import com.mycompany.agrosystem.dao.SettingsDAO;
import com.mycompany.agrosystem.model.Settings;
import com.mycompany.agrosystem.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;
import java.util.logging.Level;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/admin/settings/*")
public class AdminSettingsServlet extends HttpServlet {
    
    private static final Logger logger = Logger.getLogger(AdminSettingsServlet.class.getName());
    private SettingsDAO settingsDAO;
    
    @Override
    public void init() throws ServletException {
        try {
            settingsDAO = new SettingsDAO();
            logger.info("AdminSettingsServlet initialized successfully");
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error initializing AdminSettingsServlet", e);
            throw new ServletException("Failed to initialize servlet", e);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        logger.info("AdminSettingsServlet doGet called");
        
        try {
            // Check session and authentication
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("loggedInUser") == null) {
                logger.warning("No valid session found, redirecting to login");
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }
            
            // Check if user is admin
            User user = (User) session.getAttribute("loggedInUser");
            if (!"ADMIN".equals(user.getUserType())) {
                logger.warning("User is not admin, redirecting to login");
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }
            
            // Get the path info to determine the action
            String pathInfo = request.getPathInfo();
            
            if (pathInfo != null && pathInfo.startsWith("/download")) {
                handleBackupDownload(request, response);
            } else if (pathInfo != null && pathInfo.startsWith("/restore")) {
                handleBackupRestore(request, response);
            } else if (pathInfo != null && pathInfo.startsWith("/delete")) {
                handleBackupDelete(request, response);
            } else {
                // Handle main settings page
                handleSettingsPage(request, response);
            }
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error in AdminSettingsServlet doGet", e);
            request.setAttribute("error", "Error loading settings: " + e.getMessage());
            request.getRequestDispatcher("/admin_settings.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        logger.info("AdminSettingsServlet doPost called");
        
        try {
            // Check session and authentication
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("loggedInUser") == null) {
                logger.warning("No valid session found, redirecting to login");
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }
            
            // Check if user is admin
            User user = (User) session.getAttribute("loggedInUser");
            if (!"ADMIN".equals(user.getUserType())) {
                logger.warning("User is not admin, redirecting to login");
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }
            
            String action = request.getParameter("action");
            
            switch (action) {
                case "updateGeneral":
                    handleUpdateGeneral(request, response);
                    break;
                case "updateUsers":
                    handleUpdateUsers(request, response);
                    break;
                case "updateSystem":
                    handleUpdateSystem(request, response);
                    break;
                case "updateNotifications":
                    handleUpdateNotifications(request, response);
                    break;
                case "updateBackupSchedule":
                    handleUpdateBackupSchedule(request, response);
                    break;
                case "createBackup":
                    handleCreateBackup(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/admin/settings");
                    break;
            }
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error in AdminSettingsServlet doPost", e);
            request.setAttribute("error", "Error updating settings: " + e.getMessage());
            request.getRequestDispatcher("/admin_settings.jsp").forward(request, response);
        }
    }
    
    private void handleSettingsPage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Load current settings
            Settings settings = settingsDAO.getSettings();
            if (settings == null) {
                // Create default settings if none exist
                settings = createDefaultSettings();
                settingsDAO.saveSettings(settings);
            }
            
            // Load backup history
            List<Map<String, Object>> backups = settingsDAO.getBackupHistory();
            
            request.setAttribute("settings", settings);
            request.setAttribute("backups", backups);
            
            request.getRequestDispatcher("/admin_settings.jsp").forward(request, response);
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error loading settings page", e);
            request.setAttribute("error", "Error loading settings: " + e.getMessage());
            request.getRequestDispatcher("/admin_settings.jsp").forward(request, response);
        }
    }
    
    private void handleUpdateGeneral(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            Settings settings = settingsDAO.getSettings();
            if (settings == null) {
                settings = createDefaultSettings();
            }
            
            // Update general settings
            settings.setSiteName(request.getParameter("siteName"));
            settings.setSiteDescription(request.getParameter("siteDescription"));
            settings.setContactEmail(request.getParameter("contactEmail"));
            settings.setContactPhone(request.getParameter("contactPhone"));
            settings.setTimezone(request.getParameter("timezone"));
            settings.setDateFormat(request.getParameter("dateFormat"));
            settings.setDefaultLanguage(request.getParameter("defaultLanguage"));
            
            settingsDAO.saveSettings(settings);
            
            request.setAttribute("success", "সাধারণ সেটিংস সফলভাবে আপডেট হয়েছে!");
            handleSettingsPage(request, response);
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error updating general settings", e);
            request.setAttribute("error", "Error updating general settings: " + e.getMessage());
            handleSettingsPage(request, response);
        }
    }
    
    private void handleUpdateUsers(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            Settings settings = settingsDAO.getSettings();
            if (settings == null) {
                settings = createDefaultSettings();
            }
            
            // Update user management settings
            settings.setAllowRegistration("true".equals(request.getParameter("allowRegistration")));
            settings.setEmailVerification("true".equals(request.getParameter("emailVerification")));
            settings.setMinPasswordLength(Integer.parseInt(request.getParameter("minPasswordLength")));
            settings.setSessionTimeout(Integer.parseInt(request.getParameter("sessionTimeout")));
            settings.setDefaultUserRole(request.getParameter("defaultUserRole"));
            
            settingsDAO.saveSettings(settings);
            
            request.setAttribute("success", "ব্যবহারকারী ব্যবস্থাপনা সেটিংস সফলভাবে আপডেট হয়েছে!");
            handleSettingsPage(request, response);
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error updating user settings", e);
            request.setAttribute("error", "Error updating user settings: " + e.getMessage());
            handleSettingsPage(request, response);
        }
    }
    
    private void handleUpdateSystem(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            Settings settings = settingsDAO.getSettings();
            if (settings == null) {
                settings = createDefaultSettings();
            }
            
            // Update system settings
            settings.setDbPoolSize(Integer.parseInt(request.getParameter("dbPoolSize")));
            settings.setDbTimeout(Integer.parseInt(request.getParameter("dbTimeout")));
            settings.setMaxFileSize(Integer.parseInt(request.getParameter("maxFileSize")));
            settings.setAllowedFileTypes(request.getParameter("allowedFileTypes"));
            settings.setLogLevel(request.getParameter("logLevel"));
            settings.setLogRetention(Integer.parseInt(request.getParameter("logRetention")));
            
            settingsDAO.saveSettings(settings);
            
            request.setAttribute("success", "সিস্টেম সেটিংস সফলভাবে আপডেট হয়েছে!");
            handleSettingsPage(request, response);
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error updating system settings", e);
            request.setAttribute("error", "Error updating system settings: " + e.getMessage());
            handleSettingsPage(request, response);
        }
    }
    
    private void handleUpdateNotifications(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            Settings settings = settingsDAO.getSettings();
            if (settings == null) {
                settings = createDefaultSettings();
            }
            
            // Update notification settings
            settings.setEmailNotifications("true".equals(request.getParameter("emailNotifications")));
            settings.setSmtpServer(request.getParameter("smtpServer"));
            settings.setSmtpPort(Integer.parseInt(request.getParameter("smtpPort")));
            settings.setSmtpUsername(request.getParameter("smtpUsername"));
            settings.setNotifyNewUsers("true".equals(request.getParameter("notifyNewUsers")));
            settings.setNotifyCropUpdates("true".equals(request.getParameter("notifyCropUpdates")));
            settings.setNotifySystemAlerts("true".equals(request.getParameter("notifySystemAlerts")));
            settings.setNotifyReports("true".equals(request.getParameter("notifyReports")));
            
            settingsDAO.saveSettings(settings);
            
            request.setAttribute("success", "বিজ্ঞপ্তি সেটিংস সফলভাবে আপডেট হয়েছে!");
            handleSettingsPage(request, response);
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error updating notification settings", e);
            request.setAttribute("error", "Error updating notification settings: " + e.getMessage());
            handleSettingsPage(request, response);
        }
    }
    
    private void handleUpdateBackupSchedule(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            Settings settings = settingsDAO.getSettings();
            if (settings == null) {
                settings = createDefaultSettings();
            }
            
            // Update backup schedule
            settings.setBackupFrequency(request.getParameter("backupFrequency"));
            settings.setBackupTime(request.getParameter("backupTime"));
            
            settingsDAO.saveSettings(settings);
            
            request.setAttribute("success", "ব্যাকআপ সময়সূচী সফলভাবে আপডেট হয়েছে!");
            handleSettingsPage(request, response);
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error updating backup schedule", e);
            request.setAttribute("error", "Error updating backup schedule: " + e.getMessage());
            handleSettingsPage(request, response);
        }
    }
    
    private void handleCreateBackup(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Create backup
            boolean success = settingsDAO.createBackup();
            
            if (success) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": true, \"message\": \"ব্যাকআপ সফলভাবে তৈরি হয়েছে!\"}");
            } else {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": false, \"message\": \"ব্যাকআপ তৈরি করতে ব্যর্থ!\"}");
            }
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error creating backup", e);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"success\": false, \"message\": \"Error creating backup: " + e.getMessage() + "\"}");
        }
    }
    
    private void handleBackupDownload(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String filename = request.getParameter("file");
            if (filename != null && !filename.isEmpty()) {
                settingsDAO.downloadBackup(filename, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/settings");
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error downloading backup", e);
            response.sendRedirect(request.getContextPath() + "/admin/settings?error=Download failed");
        }
    }
    
    private void handleBackupRestore(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String filename = request.getParameter("file");
            if (filename != null && !filename.isEmpty()) {
                boolean success = settingsDAO.restoreBackup(filename);
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/admin/settings?success=Backup restored successfully");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/settings?error=Restore failed");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/settings");
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error restoring backup", e);
            response.sendRedirect(request.getContextPath() + "/admin/settings?error=Restore failed");
        }
    }
    
    private void handleBackupDelete(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String filename = request.getParameter("file");
            if (filename != null && !filename.isEmpty()) {
                boolean success = settingsDAO.deleteBackup(filename);
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/admin/settings?success=Backup deleted successfully");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/settings?error=Delete failed");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/settings");
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error deleting backup", e);
            response.sendRedirect(request.getContextPath() + "/admin/settings?error=Delete failed");
        }
    }
    
    private Settings createDefaultSettings() {
        Settings settings = new Settings();
        settings.setSiteName("AgroSystem");
        settings.setSiteDescription("কৃষি ব্যবস্থাপনা সিস্টেম");
        settings.setContactEmail("admin@agrosystem.com");
        settings.setContactPhone("+880-1234567890");
        settings.setTimezone("Asia/Dhaka");
        settings.setDateFormat("dd/MM/yyyy");
        settings.setDefaultLanguage("bn");
        settings.setAllowRegistration(true);
        settings.setEmailVerification(false);
        settings.setMinPasswordLength(6);
        settings.setSessionTimeout(30);
        settings.setDefaultUserRole("FARMER");
        settings.setDbPoolSize(10);
        settings.setDbTimeout(30);
        settings.setMaxFileSize(10);
        settings.setAllowedFileTypes("jpg,jpeg,png,pdf,doc,docx");
        settings.setLogLevel("INFO");
        settings.setLogRetention(30);
        settings.setEmailNotifications(false);
        settings.setSmtpServer("smtp.gmail.com");
        settings.setSmtpPort(587);
        settings.setSmtpUsername("");
        settings.setNotifyNewUsers(true);
        settings.setNotifyCropUpdates(true);
        settings.setNotifySystemAlerts(true);
        settings.setNotifyReports(false);
        settings.setBackupFrequency("weekly");
        settings.setBackupTime("02:00");
        return settings;
    }
}
