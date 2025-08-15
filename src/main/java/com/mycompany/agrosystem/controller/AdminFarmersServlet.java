package com.mycompany.agrosystem.controller;

import com.mycompany.agrosystem.dao.UserDAO;
import com.mycompany.agrosystem.model.Farmer;
import com.mycompany.agrosystem.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import java.util.logging.Logger;
import java.util.logging.Level;

@WebServlet("/admin/farmers")
public class AdminFarmersServlet extends HttpServlet {
    
    private static final Logger logger = Logger.getLogger(AdminFarmersServlet.class.getName());
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        try {
            userDAO = new UserDAO();
            logger.info("AdminFarmersServlet initialized successfully");
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error initializing AdminFarmersServlet", e);
            throw new ServletException("Failed to initialize servlet", e);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        logger.info("AdminFarmersServlet doGet called");
        
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
            
            logger.info("Admin user authenticated, proceeding to fetch farmers data");
            
            // Get all farmers
            List<Farmer> allFarmers = userDAO.getAllFarmers();
            logger.info("Retrieved " + (allFarmers != null ? allFarmers.size() : 0) + " farmers");
            
            if (allFarmers == null) {
                allFarmers = new ArrayList<>();
                logger.warning("getAllFarmers returned null, using empty list");
            }
            
            // Calculate statistics
            int farmerCount = allFarmers.size();
            int monthlyFarmerCount = calculateMonthlyFarmerCount(allFarmers);
            int activeLocations = calculateActiveLocations(allFarmers);
            int activeFarmers = calculateActiveFarmers(allFarmers);
            
            logger.info("Statistics calculated - Total: " + farmerCount + 
                       ", Monthly: " + monthlyFarmerCount + 
                       ", Locations: " + activeLocations + 
                       ", Active: " + activeFarmers);
            
            // Get unique locations for filter
            List<String> locations = userDAO.getUniqueLocations();
            logger.info("Retrieved " + (locations != null ? locations.size() : 0) + " unique locations");
            
            if (locations == null) {
                locations = new ArrayList<>();
                logger.warning("getUniqueLocations returned null, using empty list");
            }
            
            // Set attributes for JSP
            request.setAttribute("allFarmers", allFarmers);
            request.setAttribute("farmerCount", farmerCount);
            request.setAttribute("monthlyFarmerCount", monthlyFarmerCount);
            request.setAttribute("activeLocations", activeLocations);
            request.setAttribute("activeFarmers", activeFarmers);
            request.setAttribute("locations", locations);
            
            // Pagination attributes (simple implementation)
            request.setAttribute("currentPage", 1);
            request.setAttribute("totalPages", 1);
            
            logger.info("All attributes set, forwarding to admin_farmers.jsp");
            
            // Forward to JSP
            request.getRequestDispatcher("/admin_farmers.jsp").forward(request, response);
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error in AdminFarmersServlet doGet", e);
            e.printStackTrace();
            
            // Set error attributes for JSP
            request.setAttribute("error", "Error loading farmers data: " + e.getMessage());
            request.setAttribute("allFarmers", new ArrayList<>());
            request.setAttribute("farmerCount", 0);
            request.setAttribute("monthlyFarmerCount", 0);
            request.setAttribute("activeLocations", 0);
            request.setAttribute("activeFarmers", 0);
            request.setAttribute("locations", new ArrayList<>());
            request.setAttribute("currentPage", 1);
            request.setAttribute("totalPages", 1);
            
            // Still forward to JSP but with error information
            request.getRequestDispatcher("/admin_farmers.jsp").forward(request, response);
        }
    }
    
    private int calculateMonthlyFarmerCount(List<Farmer> farmers) {
        try {
            // Simple calculation - count farmers created in current month
            java.time.LocalDateTime now = java.time.LocalDateTime.now();
            return (int) farmers.stream()
                    .filter(farmer -> farmer.getCreatedAt() != null && 
                            farmer.getCreatedAt().getMonth() == now.getMonth() &&
                            farmer.getCreatedAt().getYear() == now.getYear())
                    .count();
        } catch (Exception e) {
            logger.log(Level.WARNING, "Error calculating monthly farmer count", e);
            return 0;
        }
    }
    
    private int calculateActiveLocations(List<Farmer> farmers) {
        try {
            // Count unique locations
            return (int) farmers.stream()
                    .map(Farmer::getLocation)
                    .filter(location -> location != null && !location.trim().isEmpty())
                    .distinct()
                    .count();
        } catch (Exception e) {
            logger.log(Level.WARNING, "Error calculating active locations", e);
            return 0;
        }
    }
    
    private int calculateActiveFarmers(List<Farmer> farmers) {
        try {
            // Count farmers with crops
            return (int) farmers.stream()
                    .filter(farmer -> farmer.getCrops() != null && !farmer.getCrops().isEmpty())
                    .count();
        } catch (Exception e) {
            logger.log(Level.WARNING, "Error calculating active farmers", e);
            return 0;
        }
    }
}
