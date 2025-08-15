package com.mycompany.agrosystem.controller;

import com.mycompany.agrosystem.dao.ContentDAO;
import com.mycompany.agrosystem.dao.UserDAO;
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

@WebServlet("/admin/reports/*")
public class AdminReportsServlet extends HttpServlet {
    
    private static final Logger logger = Logger.getLogger(AdminReportsServlet.class.getName());
    private UserDAO userDAO;
    private ContentDAO contentDAO;
    
    @Override
    public void init() throws ServletException {
        try {
            userDAO = new UserDAO();
            contentDAO = new ContentDAO();
            logger.info("AdminReportsServlet initialized successfully");
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error initializing AdminReportsServlet", e);
            throw new ServletException("Failed to initialize servlet", e);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        logger.info("AdminReportsServlet doGet called");
        
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
            
            if (pathInfo != null && pathInfo.startsWith("/generate")) {
                handleReportGeneration(request, response);
            } else if (pathInfo != null && pathInfo.startsWith("/download")) {
                handleReportDownload(request, response);
            } else if (pathInfo != null && pathInfo.startsWith("/view")) {
                handleReportView(request, response);
            } else if (pathInfo != null && pathInfo.startsWith("/delete")) {
                handleReportDelete(request, response);
            } else {
                // Handle main reports page
                handleReportsPage(request, response);
            }
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error in AdminReportsServlet doGet", e);
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/reports?error=" + e.getMessage());
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        logger.info("AdminReportsServlet doPost called");
        
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
                response.sendRedirect(request.getContextPath() + "/admin/reports");
                return;
            }
            
            String action = request.getParameter("action");
            logger.info("Action: " + action);
            
            if ("generate".equals(action)) {
                handleReportGeneration(request, response);
            } else if ("save".equals(action)) {
                handleReportSave(request, response);
            } else {
                logger.warning("Unknown action: " + action);
                response.sendRedirect(request.getContextPath() + "/admin/reports");
            }
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error in AdminReportsServlet doPost", e);
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/reports?error=" + e.getMessage());
        }
    }
    
    private void handleReportsPage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        logger.info("Handling reports page");
        
        try {
            // Get statistics for the dashboard
            int totalFarmers = userDAO.getTotalFarmers();
            int newFarmersThisMonth = userDAO.getNewFarmersThisMonth();
            int totalCrops = contentDAO.getCropCount();
            int newCropsThisMonth = contentDAO.getMonthlyCropCount();
            double totalLandArea = userDAO.getTotalLandArea();
            double newLandArea = userDAO.getNewLandAreaThisMonth();
            double growthRate = userDAO.getGrowthRate();
            
            // Get saved reports (if any)
            List<Map<String, Object>> savedReports = userDAO.getSavedReports();
            
            // Set attributes
            request.setAttribute("totalFarmers", totalFarmers);
            request.setAttribute("newFarmersThisMonth", newFarmersThisMonth);
            request.setAttribute("totalCrops", totalCrops);
            request.setAttribute("newCropsThisMonth", newCropsThisMonth);
            request.setAttribute("totalLandArea", String.format("%.2f", totalLandArea));
            request.setAttribute("newLandArea", String.format("%.2f", newLandArea));
            request.setAttribute("growthRate", String.format("%.1f", growthRate));
            request.setAttribute("savedReports", savedReports);
            
            logger.info("Reports page attributes set - Total Farmers: " + totalFarmers + 
                       ", Total Crops: " + totalCrops + ", Growth Rate: " + growthRate + "%");
            
            request.getRequestDispatcher("/admin_reports.jsp").forward(request, response);
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error handling reports page", e);
            request.setAttribute("error", "Error loading reports data: " + e.getMessage());
            request.getRequestDispatcher("/admin_reports.jsp").forward(request, response);
        }
    }
    
    private void handleReportGeneration(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String reportType = request.getParameter("reportType");
        String timePeriod = request.getParameter("timePeriod");
        String filterBy = request.getParameter("filterBy");
        String filterValue = request.getParameter("filterValue");
        String outputFormat = request.getParameter("outputFormat");
        
        logger.info("Generating report - Type: " + reportType + ", Period: " + timePeriod);
        
        try {
            Map<String, Object> reportData = new HashMap<>();
            
            switch (reportType) {
                case "farmer_summary":
                    reportData = generateFarmerSummaryReport(timePeriod, filterBy, filterValue);
                    break;
                case "crop_analysis":
                    reportData = generateCropAnalysisReport(timePeriod, filterBy, filterValue);
                    break;
                case "location_distribution":
                    reportData = generateLocationDistributionReport(timePeriod, filterBy, filterValue);
                    break;
                case "growth_trends":
                    reportData = generateGrowthTrendsReport(timePeriod, filterBy, filterValue);
                    break;
                case "seasonal_analysis":
                    reportData = generateSeasonalAnalysisReport(timePeriod, filterBy, filterValue);
                    break;
                case "performance_metrics":
                    reportData = generatePerformanceMetricsReport(timePeriod, filterBy, filterValue);
                    break;
                default:
                    throw new IllegalArgumentException("Unknown report type: " + reportType);
            }
            
            // Set response type based on output format
            if ("json".equals(outputFormat)) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                // Convert reportData to JSON and send
                response.getWriter().write(convertToJson(reportData));
            } else {
                // Default HTML response
                request.setAttribute("reportData", reportData);
                request.setAttribute("reportType", reportType);
                request.setAttribute("outputFormat", outputFormat);
                
                // Also set the main page attributes
                setMainPageAttributes(request);
                
                // Set report display flag
                request.setAttribute("showReport", true);
                
                request.getRequestDispatcher("/admin_reports.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error generating report", e);
            request.setAttribute("error", "Error generating report: " + e.getMessage());
            setMainPageAttributes(request);
            request.getRequestDispatcher("/admin_reports.jsp").forward(request, response);
        }
    }
    
    private void setMainPageAttributes(HttpServletRequest request) {
        try {
            // Get statistics for the dashboard
            int totalFarmers = userDAO.getTotalFarmers();
            int newFarmersThisMonth = userDAO.getNewFarmersThisMonth();
            int totalCrops = contentDAO.getCropCount();
            int newCropsThisMonth = contentDAO.getMonthlyCropCount();
            double totalLandArea = userDAO.getTotalLandArea();
            double newLandArea = userDAO.getNewLandAreaThisMonth();
            double growthRate = userDAO.getGrowthRate();
            
            // Get saved reports (if any)
            List<Map<String, Object>> savedReports = userDAO.getSavedReports();
            
            // Set attributes
            request.setAttribute("totalFarmers", totalFarmers);
            request.setAttribute("newFarmersThisMonth", newFarmersThisMonth);
            request.setAttribute("totalCrops", totalCrops);
            request.setAttribute("newCropsThisMonth", newCropsThisMonth);
            request.setAttribute("totalLandArea", String.format("%.2f", totalLandArea));
            request.setAttribute("newLandArea", String.format("%.2f", newLandArea));
            request.setAttribute("growthRate", String.format("%.1f", growthRate));
            request.setAttribute("savedReports", savedReports);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error setting main page attributes", e);
        }
    }
    
    private Map<String, Object> generateFarmerSummaryReport(String timePeriod, String filterBy, String filterValue) {
        Map<String, Object> reportData = new HashMap<>();
        
        try {
            int totalFarmers = userDAO.getTotalFarmers();
            int newFarmersThisMonth = userDAO.getNewFarmersThisMonth();
            int activeFarmers = userDAO.getActiveFarmers();
            List<Map<String, Object>> farmersByLocation = userDAO.getFarmersByLocation();
            List<Map<String, Object>> registrationTrends = userDAO.getRegistrationTrends(timePeriod);
            
            reportData.put("totalFarmers", totalFarmers);
            reportData.put("newFarmersThisMonth", newFarmersThisMonth);
            reportData.put("activeFarmers", activeFarmers);
            reportData.put("farmersByLocation", farmersByLocation);
            reportData.put("registrationTrends", registrationTrends);
            reportData.put("reportType", "farmer_summary");
            reportData.put("title", "কৃষক সারসংক্ষেপ রিপোর্ট");
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error generating farmer summary report", e);
            reportData.put("error", "Error generating farmer summary report: " + e.getMessage());
        }
        
        return reportData;
    }
    
    private Map<String, Object> generateCropAnalysisReport(String timePeriod, String filterBy, String filterValue) {
        Map<String, Object> reportData = new HashMap<>();
        
        try {
            int totalCrops = contentDAO.getCropCount();
            int newCropsThisMonth = contentDAO.getMonthlyCropCount();
            List<Map<String, Object>> cropsByType = contentDAO.getCropsByType();
            List<Map<String, Object>> cropsBySeason = contentDAO.getCropsBySeason();
            List<Map<String, Object>> cropTrends = contentDAO.getCropTrends(timePeriod);
            
            reportData.put("totalCrops", totalCrops);
            reportData.put("newCropsThisMonth", newCropsThisMonth);
            reportData.put("cropsByType", cropsByType);
            reportData.put("cropsBySeason", cropsBySeason);
            reportData.put("cropTrends", cropTrends);
            reportData.put("reportType", "crop_analysis");
            reportData.put("title", "ফসল বিশ্লেষণ রিপোর্ট");
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error generating crop analysis report", e);
            reportData.put("error", "Error generating crop analysis report: " + e.getMessage());
        }
        
        return reportData;
    }
    
    private Map<String, Object> generateLocationDistributionReport(String timePeriod, String filterBy, String filterValue) {
        Map<String, Object> reportData = new HashMap<>();
        
        try {
            List<Map<String, Object>> locationDistribution = userDAO.getLocationDistribution();
            List<Map<String, Object>> landAreaByLocation = userDAO.getLandAreaByLocation();
            List<Map<String, Object>> farmersByLocation = userDAO.getFarmersByLocation();
            
            reportData.put("locationDistribution", locationDistribution);
            reportData.put("landAreaByLocation", landAreaByLocation);
            reportData.put("farmersByLocation", farmersByLocation);
            reportData.put("reportType", "location_distribution");
            reportData.put("title", "অবস্থান বণ্টন রিপোর্ট");
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error generating location distribution report", e);
            reportData.put("error", "Error generating location distribution report: " + e.getMessage());
        }
        
        return reportData;
    }
    
    private Map<String, Object> generateGrowthTrendsReport(String timePeriod, String filterBy, String filterValue) {
        Map<String, Object> reportData = new HashMap<>();
        
        try {
            List<Map<String, Object>> growthTrends = userDAO.getGrowthTrends(timePeriod);
            double growthRate = userDAO.getGrowthRate();
            List<Map<String, Object>> monthlyGrowth = userDAO.getMonthlyGrowth();
            
            reportData.put("growthTrends", growthTrends);
            reportData.put("growthRate", growthRate);
            reportData.put("monthlyGrowth", monthlyGrowth);
            reportData.put("reportType", "growth_trends");
            reportData.put("title", "বৃদ্ধির প্রবণতা রিপোর্ট");
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error generating growth trends report", e);
            reportData.put("error", "Error generating growth trends report: " + e.getMessage());
        }
        
        return reportData;
    }
    
    private Map<String, Object> generateSeasonalAnalysisReport(String timePeriod, String filterBy, String filterValue) {
        Map<String, Object> reportData = new HashMap<>();
        
        try {
            List<Map<String, Object>> seasonalData = contentDAO.getSeasonalAnalysis();
            List<Map<String, Object>> cropSeasonDistribution = contentDAO.getCropSeasonDistribution();
            
            reportData.put("seasonalData", seasonalData);
            reportData.put("cropSeasonDistribution", cropSeasonDistribution);
            reportData.put("reportType", "seasonal_analysis");
            reportData.put("title", "মৌসুমি বিশ্লেষণ রিপোর্ট");
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error generating seasonal analysis report", e);
            reportData.put("error", "Error generating seasonal analysis report: " + e.getMessage());
        }
        
        return reportData;
    }
    
    private Map<String, Object> generatePerformanceMetricsReport(String timePeriod, String filterBy, String filterValue) {
        Map<String, Object> reportData = new HashMap<>();
        
        try {
            Map<String, Object> performanceMetrics = userDAO.getPerformanceMetrics(timePeriod);
            List<Map<String, Object>> keyMetrics = userDAO.getKeyMetrics();
            
            reportData.put("performanceMetrics", performanceMetrics);
            reportData.put("keyMetrics", keyMetrics);
            reportData.put("reportType", "performance_metrics");
            reportData.put("title", "কর্মক্ষমতা মেট্রিক রিপোর্ট");
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error generating performance metrics report", e);
            reportData.put("error", "Error generating performance metrics report: " + e.getMessage());
        }
        
        return reportData;
    }
    
    private void handleReportDownload(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Implementation for downloading reports
        logger.info("Handling report download");
        response.sendRedirect(request.getContextPath() + "/admin/reports?message=Download feature coming soon");
    }
    
    private void handleReportView(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Implementation for viewing saved reports
        logger.info("Handling report view");
        response.sendRedirect(request.getContextPath() + "/admin/reports?message=View feature coming soon");
    }
    
    private void handleReportDelete(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Implementation for deleting saved reports
        logger.info("Handling report delete");
        response.sendRedirect(request.getContextPath() + "/admin/reports?message=Delete feature coming soon");
    }
    
    private void handleReportSave(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Implementation for saving reports
        logger.info("Handling report save");
        response.sendRedirect(request.getContextPath() + "/admin/reports?message=Save feature coming soon");
    }
    
    private String convertToJson(Map<String, Object> data) {
        // Simple JSON conversion - in production, use a proper JSON library
        StringBuilder json = new StringBuilder("{");
        boolean first = true;
        for (Map.Entry<String, Object> entry : data.entrySet()) {
            if (!first) json.append(",");
            json.append("\"").append(entry.getKey()).append("\":");
            if (entry.getValue() instanceof String) {
                json.append("\"").append(entry.getValue()).append("\"");
            } else {
                json.append(entry.getValue());
            }
            first = false;
        }
        json.append("}");
        return json.toString();
    }
}
