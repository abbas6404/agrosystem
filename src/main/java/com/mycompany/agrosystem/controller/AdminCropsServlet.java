package com.mycompany.agrosystem.controller;

import com.mycompany.agrosystem.dao.ContentDAO;
import com.mycompany.agrosystem.model.Crop;
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

@WebServlet("/admin/crops/*")
public class AdminCropsServlet extends HttpServlet {
    
    private static final Logger logger = Logger.getLogger(AdminCropsServlet.class.getName());
    private ContentDAO contentDAO;
    
    @Override
    public void init() throws ServletException {
        try {
            contentDAO = new ContentDAO();
            logger.info("AdminCropsServlet initialized successfully");
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error initializing AdminCropsServlet", e);
            throw new ServletException("Failed to initialize servlet", e);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        logger.info("AdminCropsServlet doGet called");
        
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
            
            logger.info("Admin user authenticated, proceeding to fetch crops data");
            
            // Get the path info to determine the action
            String pathInfo = request.getPathInfo();
            
            if (pathInfo != null && pathInfo.startsWith("/edit/")) {
                // Handle edit request
                handleEditCrop(request, response);
            } else if (pathInfo != null && pathInfo.startsWith("/view/")) {
                // Handle view request
                handleViewCrop(request, response);
            } else {
                // Handle main crops listing
                handleCropsListing(request, response);
            }
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error in AdminCropsServlet doGet", e);
            e.printStackTrace();
            
            request.setAttribute("error", "Error loading crops data: " + e.getMessage());
            request.setAttribute("cropList", new ArrayList<>());
            request.setAttribute("cropCount", 0);
            request.setAttribute("farmerCropCount", 0);
            request.setAttribute("monthlyCropCount", 0);
            
            request.getRequestDispatcher("/crop_management.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        logger.info("AdminCropsServlet doPost called");
        
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
                handleAddCrop(request, response);
            } else if ("update".equals(action)) {
                handleUpdateCrop(request, response);
            } else if ("delete".equals(action)) {
                handleDeleteCrop(request, response);
            } else {
                logger.warning("Unknown action: " + action);
                response.sendRedirect(request.getContextPath() + "/admin/crops");
            }
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error in AdminCropsServlet doPost", e);
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/crops?error=" + e.getMessage());
        }
    }
    
    private void handleCropsListing(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Crop> allCrops = contentDAO.getAllCrops();
        logger.info("Retrieved " + (allCrops != null ? allCrops.size() : 0) + " crops");
        
        if (allCrops == null) {
            allCrops = new ArrayList<>();
            logger.warning("getAllCrops returned null, using empty list");
        }
        
        int cropCount = allCrops.size();
        int farmerCropCount = contentDAO.getFarmerCropCount();
        int monthlyCropCount = contentDAO.getMonthlyCropCount();
        
        logger.info("Statistics calculated - Total: " + cropCount + 
                   ", Farmer Crops: " + farmerCropCount + 
                   ", Monthly: " + monthlyCropCount);
        
        request.setAttribute("cropList", allCrops);
        request.setAttribute("cropCount", cropCount);
        request.setAttribute("farmerCropCount", farmerCropCount);
        request.setAttribute("monthlyCropCount", monthlyCropCount);
        
        logger.info("All attributes set, forwarding to crop_management.jsp");
        request.getRequestDispatcher("/crop_management.jsp").forward(request, response);
    }
    
    private void handleAddCrop(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String cropName = request.getParameter("cropName");
        String description = request.getParameter("description");
        String type = request.getParameter("cropType");
        String season = request.getParameter("season");
        
        logger.info("Adding crop: " + cropName + ", Type: " + type + ", Season: " + season);
        
        if (cropName == null || cropName.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/crops?error=ফসলের নাম প্রয়োজন");
            return;
        }
        
        boolean success = contentDAO.addCrop(cropName.trim(), description, type, season);
        
        if (success) {
            logger.info("Crop added successfully: " + cropName);
            response.sendRedirect(request.getContextPath() + "/admin/crops?success=ফসল সফলভাবে যোগ করা হয়েছে");
        } else {
            logger.warning("Failed to add crop: " + cropName);
            response.sendRedirect(request.getContextPath() + "/admin/crops?error=ফসল যোগ করতে ব্যর্থ");
        }
    }
    
    private void handleUpdateCrop(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String cropIdStr = request.getParameter("cropId");
        String cropName = request.getParameter("cropName");
        String description = request.getParameter("description");
        String type = request.getParameter("cropType");
        String season = request.getParameter("season");
        
        if (cropIdStr == null || cropIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/crops?error=ফসলের আইডি প্রয়োজন");
            return;
        }
        
        try {
            int cropId = Integer.parseInt(cropIdStr);
            logger.info("Updating crop ID: " + cropId + ", Name: " + cropName);
            
            boolean success = contentDAO.updateCrop(cropId, cropName.trim(), description, type, season);
            
            if (success) {
                logger.info("Crop updated successfully: " + cropId);
                response.sendRedirect(request.getContextPath() + "/admin/crops?success=ফসল সফলভাবে আপডেট করা হয়েছে");
            } else {
                logger.warning("Failed to update crop: " + cropId);
                response.sendRedirect(request.getContextPath() + "/admin/crops?error=ফসল আপডেট করতে ব্যর্থ");
            }
            
        } catch (NumberFormatException e) {
            logger.warning("Invalid crop ID: " + cropIdStr);
            response.sendRedirect(request.getContextPath() + "/admin/crops?error=অবৈধ ফসল আইডি");
        }
    }
    
    private void handleDeleteCrop(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String cropIdStr = request.getParameter("cropId");
        
        if (cropIdStr == null || cropIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/crops?error=ফসলের আইডি প্রয়োজন");
            return;
        }
        
        try {
            int cropId = Integer.parseInt(cropIdStr);
            logger.info("Deleting crop ID: " + cropId);
            
            boolean success = contentDAO.deleteCrop(cropId);
            
            if (success) {
                logger.info("Crop deleted successfully: " + cropId);
                response.sendRedirect(request.getContextPath() + "/admin/crops?success=ফসল সফলভাবে মুছে ফেলা হয়েছে");
            } else {
                logger.warning("Failed to delete crop: " + cropId);
                response.sendRedirect(request.getContextPath() + "/admin/crops?error=ফসল মুছতে ব্যর্থ");
            }
            
        } catch (NumberFormatException e) {
            logger.warning("Invalid crop ID: " + cropIdStr);
            response.sendRedirect(request.getContextPath() + "/admin/crops?error=অবৈধ ফসল আইডি");
        }
    }
    
    private void handleEditCrop(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        String cropIdStr = pathInfo.substring(6); // Remove "/edit/" prefix
        
        try {
            int cropId = Integer.parseInt(cropIdStr);
            logger.info("Editing crop ID: " + cropId);
            
            Crop crop = contentDAO.getCropById(cropId);
            if (crop != null) {
                request.setAttribute("editCrop", crop);
                request.setAttribute("cropList", contentDAO.getAllCrops());
                request.setAttribute("cropCount", contentDAO.getCropCount());
                request.setAttribute("farmerCropCount", contentDAO.getFarmerCropCount());
                request.setAttribute("monthlyCropCount", contentDAO.getMonthlyCropCount());
                
                request.getRequestDispatcher("/crop_management.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/crops?error=ফসল পাওয়া যায়নি");
            }
            
        } catch (NumberFormatException e) {
            logger.warning("Invalid crop ID: " + cropIdStr);
            response.sendRedirect(request.getContextPath() + "/admin/crops?error=অবৈধ ফসল আইডি");
        }
    }
    
    private void handleViewCrop(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        String cropIdStr = pathInfo.substring(6); // Remove "/view/" prefix
        
        try {
            int cropId = Integer.parseInt(cropIdStr);
            logger.info("Viewing crop ID: " + cropId);
            
            Crop crop = contentDAO.getCropById(cropId);
            if (crop != null) {
                request.setAttribute("viewCrop", crop);
                request.setAttribute("cropList", contentDAO.getAllCrops());
                request.setAttribute("cropCount", contentDAO.getCropCount());
                request.setAttribute("farmerCropCount", contentDAO.getFarmerCropCount());
                request.setAttribute("monthlyCropCount", contentDAO.getMonthlyCropCount());
                
                request.getRequestDispatcher("/crop_management.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/crops?error=ফসল পাওয়া যায়নি");
            }
            
        } catch (NumberFormatException e) {
            logger.warning("Invalid crop ID: " + cropIdStr);
            response.sendRedirect(request.getContextPath() + "/admin/crops?error=অবৈধ ফসল আইডি");
        }
    }
}
