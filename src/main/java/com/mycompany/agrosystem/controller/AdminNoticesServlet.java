package com.mycompany.agrosystem.controller;

import com.mycompany.agrosystem.dao.ContentDAO;
import com.mycompany.agrosystem.model.Notice;
import com.mycompany.agrosystem.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;
import java.util.logging.Level;
import java.util.ArrayList;

@WebServlet("/admin/notices/*")
public class AdminNoticesServlet extends HttpServlet {
    
    private static final Logger logger = Logger.getLogger(AdminNoticesServlet.class.getName());
    private ContentDAO contentDAO;
    
    @Override
    public void init() throws ServletException {
        try {
            contentDAO = new ContentDAO();
            logger.info("AdminNoticesServlet initialized successfully");
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error initializing AdminNoticesServlet", e);
            throw new ServletException("Failed to initialize servlet", e);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        logger.info("AdminNoticesServlet doGet called");
        
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
            logger.info("User type: " + user.getUserType());
            
            if (!"ADMIN".equals(user.getUserType())) {
                logger.warning("User is not admin, redirecting to login");
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }
            
            logger.info("Admin user authenticated, proceeding to fetch notices data");
            
            // Get the path info to determine the action
            String pathInfo = request.getPathInfo();
            
            if (pathInfo != null && pathInfo.startsWith("/edit/")) {
                // Handle edit request
                handleEditNotice(request, response);
            } else if (pathInfo != null && pathInfo.startsWith("/view/")) {
                // Handle view request
                handleViewNotice(request, response);
            } else if (pathInfo != null && pathInfo.startsWith("/delete/")) {
                // Handle delete request
                handleDeleteNotice(request, response);
            } else {
                // Handle main notices listing
                handleNoticesListing(request, response);
            }
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error in AdminNoticesServlet doGet", e);
            e.printStackTrace();
            
            request.setAttribute("error", "Error loading notices data: " + e.getMessage());
            request.setAttribute("notices", new ArrayList<>());
            request.setAttribute("noticeCount", 0);
            request.setAttribute("todayViews", 0);
            request.setAttribute("monthlyNotices", 0);
            request.setAttribute("importantNotices", 0);
            
            request.getRequestDispatcher("/admin_notices.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        logger.info("AdminNoticesServlet doPost called");
        
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
            logger.info("Action: " + action);
            
            if ("add".equals(action)) {
                handleAddNotice(request, response);
            } else if ("update".equals(action)) {
                handleUpdateNotice(request, response);
            } else if ("delete".equals(action)) {
                handleDeleteNoticePost(request, response);
            } else {
                logger.warning("Unknown action: " + action);
                response.sendRedirect(request.getContextPath() + "/admin/notices");
            }
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error in AdminNoticesServlet doPost", e);
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/notices?error=" + e.getMessage());
        }
    }
    
    private void handleNoticesListing(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        logger.info("handleNoticesListing called");
        
        List<Notice> allNotices = contentDAO.getAllNotices();
        logger.info("Retrieved " + (allNotices != null ? allNotices.size() : 0) + " notices");
        
        if (allNotices == null) {
            allNotices = new ArrayList<>();
            logger.warning("getAllNotices returned null, using empty list");
        }
        
        // Log each notice for debugging
        for (int i = 0; i < allNotices.size(); i++) {
            Notice notice = allNotices.get(i);
            logger.info("Notice " + i + ": ID=" + notice.getId() + ", Title=" + notice.getTitle() + ", Type=" + notice.getType());
        }
        
        int noticeCount = contentDAO.getNoticeCount();
        int todayViews = contentDAO.getTodayViewCount();
        int monthlyNotices = contentDAO.getMonthlyNoticeCount();
        int importantNotices = contentDAO.getImportantNoticeCount();
        
        logger.info("Statistics calculated - Total: " + noticeCount + 
                   ", Today Views: " + todayViews + 
                   ", Monthly: " + monthlyNotices + 
                   ", Important: " + importantNotices);
        
        request.setAttribute("notices", allNotices);
        request.setAttribute("noticeCount", noticeCount);
        request.setAttribute("todayViews", todayViews);
        request.setAttribute("monthlyNotices", monthlyNotices);
        request.setAttribute("importantNotices", importantNotices);
        
        logger.info("All attributes set, forwarding to admin_notices.jsp");
        request.getRequestDispatcher("/admin_notices.jsp").forward(request, response);
    }
    
    private void handleAddNotice(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String type = request.getParameter("noticeType");
        String targetGroup = request.getParameter("targetGroup");
        String expiryStr = request.getParameter("expiry");
        
        logger.info("Adding notice: " + title + ", Type: " + type + ", Target: " + targetGroup);
        
        if (title == null || title.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/notices?error=নোটিশের শিরোনাম প্রয়োজন");
            return;
        }
        
        if (content == null || content.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/notices?error=নোটিশের বিষয়বস্তু প্রয়োজন");
            return;
        }
        
        int expiry = 30; // Default expiry
        if (expiryStr != null && !expiryStr.trim().isEmpty()) {
            try {
                expiry = Integer.parseInt(expiryStr);
            } catch (NumberFormatException e) {
                logger.warning("Invalid expiry value: " + expiryStr + ", using default");
            }
        }
        
        // Set defaults if not provided
        if (type == null || type.trim().isEmpty()) {
            type = "general";
        }
        if (targetGroup == null || targetGroup.trim().isEmpty()) {
            targetGroup = "all";
        }
        
        User admin = (User) request.getSession().getAttribute("loggedInUser");
        boolean success = contentDAO.addNotice(title.trim(), content.trim(), type, targetGroup, expiry, admin.getId());
        
        if (success) {
            logger.info("Notice added successfully: " + title);
            response.sendRedirect(request.getContextPath() + "/admin/notices?success=নোটিশ সফলভাবে প্রকাশ করা হয়েছে");
        } else {
            logger.warning("Failed to add notice: " + title);
            response.sendRedirect(request.getContextPath() + "/admin/notices?error=নোটিশ প্রকাশ করতে ব্যর্থ");
        }
    }
    
    private void handleUpdateNotice(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String noticeIdStr = request.getParameter("noticeId");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String type = request.getParameter("noticeType");
        String targetGroup = request.getParameter("targetGroup");
        String expiryStr = request.getParameter("expiry");
        
        if (noticeIdStr == null || noticeIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/notices?error=নোটিশের আইডি প্রয়োজন");
            return;
        }
        
        try {
            int noticeId = Integer.parseInt(noticeIdStr);
            logger.info("Updating notice ID: " + noticeId + ", Title: " + title);
            
            int expiry = 30; // Default expiry
            if (expiryStr != null && !expiryStr.trim().isEmpty()) {
                try {
                    expiry = Integer.parseInt(expiryStr);
                } catch (NumberFormatException e) {
                    logger.warning("Invalid expiry value: " + expiryStr + ", using default");
                }
            }
            
            // Set defaults if not provided
            if (type == null || type.trim().isEmpty()) {
                type = "general";
            }
            if (targetGroup == null || targetGroup.trim().isEmpty()) {
                targetGroup = "all";
            }
            
            boolean success = contentDAO.updateNotice(noticeId, title.trim(), content.trim(), type, targetGroup, expiry);
            
            if (success) {
                logger.info("Notice updated successfully: " + noticeId);
                response.sendRedirect(request.getContextPath() + "/admin/notices?success=নোটিশ সফলভাবে আপডেট করা হয়েছে");
            } else {
                logger.warning("Failed to update notice: " + noticeId);
                response.sendRedirect(request.getContextPath() + "/admin/notices?error=নোটিশ আপডেট করতে ব্যর্থ");
            }
            
        } catch (NumberFormatException e) {
            logger.warning("Invalid notice ID: " + noticeIdStr);
            response.sendRedirect(request.getContextPath() + "/admin/notices?error=অবৈধ নোটিশ আইডি");
        }
    }
    
    private void handleDeleteNotice(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        String noticeIdStr = pathInfo.substring(8); // Remove "/delete/" prefix
        
        try {
            int noticeId = Integer.parseInt(noticeIdStr);
            logger.info("Deleting notice ID: " + noticeId);
            
            boolean success = contentDAO.deleteNotice(noticeId);
            
            if (success) {
                logger.info("Notice deleted successfully: " + noticeId);
                response.sendRedirect(request.getContextPath() + "/admin/notices?success=নোটিশ সফলভাবে মুছে ফেলা হয়েছে");
            } else {
                logger.warning("Failed to delete notice: " + noticeId);
                response.sendRedirect(request.getContextPath() + "/admin/notices?error=নোটিশ মুছতে ব্যর্থ");
            }
            
        } catch (NumberFormatException e) {
            logger.warning("Invalid notice ID: " + noticeIdStr);
            response.sendRedirect(request.getContextPath() + "/admin/notices?error=অবৈধ নোটিশ আইডি");
        }
    }
    
    private void handleDeleteNoticePost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String noticeIdStr = request.getParameter("noticeId");
        
        if (noticeIdStr == null || noticeIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/notices?error=নোটিশের আইডি প্রয়োজন");
            return;
        }
        
        try {
            int noticeId = Integer.parseInt(noticeIdStr);
            logger.info("Deleting notice ID: " + noticeId);
            
            boolean success = contentDAO.deleteNotice(noticeId);
            
            if (success) {
                logger.info("Notice deleted successfully: " + noticeId);
                response.sendRedirect(request.getContextPath() + "/admin/notices?success=নোটিশ সফলভাবে মুছে ফেলা হয়েছে");
            } else {
                logger.warning("Failed to delete notice: " + noticeId);
                response.sendRedirect(request.getContextPath() + "/admin/notices?error=নোটিশ মুছতে ব্যর্থ");
            }
            
        } catch (NumberFormatException e) {
            logger.warning("Invalid notice ID: " + noticeIdStr);
            response.sendRedirect(request.getContextPath() + "/admin/notices?error=অবৈধ নোটিশ আইডি");
        }
    }
    
    private void handleEditNotice(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        String noticeIdStr = pathInfo.substring(6); // Remove "/edit/" prefix
        
        try {
            int noticeId = Integer.parseInt(noticeIdStr);
            logger.info("Editing notice ID: " + noticeId);
            
            Notice notice = contentDAO.getNoticeById(noticeId);
            if (notice != null) {
                request.setAttribute("editNotice", notice);
                request.setAttribute("notices", contentDAO.getAllNotices());
                request.setAttribute("noticeCount", contentDAO.getNoticeCount());
                request.setAttribute("todayViews", contentDAO.getTodayViewCount());
                request.setAttribute("monthlyNotices", contentDAO.getMonthlyNoticeCount());
                request.setAttribute("importantNotices", contentDAO.getImportantNoticeCount());
                
                request.getRequestDispatcher("/admin_notices.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/notices?error=নোটিশ পাওয়া যায়নি");
            }
            
        } catch (NumberFormatException e) {
            logger.warning("Invalid notice ID: " + noticeIdStr);
            response.sendRedirect(request.getContextPath() + "/admin/notices?error=অবৈধ নোটিশ আইডি");
        }
    }
    
    private void handleViewNotice(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        String noticeIdStr = pathInfo.substring(6); // Remove "/view/" prefix
        
        try {
            int noticeId = Integer.parseInt(noticeIdStr);
            logger.info("Viewing notice ID: " + noticeId);
            
            Notice notice = contentDAO.getNoticeById(noticeId);
            if (notice != null) {
                request.setAttribute("viewNotice", notice);
                request.setAttribute("notices", contentDAO.getAllNotices());
                request.setAttribute("noticeCount", contentDAO.getNoticeCount());
                request.setAttribute("todayViews", contentDAO.getTodayViewCount());
                request.setAttribute("monthlyNotices", contentDAO.getMonthlyNoticeCount());
                request.setAttribute("importantNotices", contentDAO.getImportantNoticeCount());
                
                request.getRequestDispatcher("/admin_notices.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/notices?error=নোটিশ পাওয়া যায়নি");
            }
            
        } catch (NumberFormatException e) {
            logger.warning("Invalid notice ID: " + noticeIdStr);
            response.sendRedirect(request.getContextPath() + "/admin/notices?error=অবৈধ নোটিশ আইডি");
        }
    }
}
