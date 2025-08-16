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

@WebServlet("/updateProfile")
public class UpdateProfileServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedInUser");
        
        // Check if user is logged in and is a farmer
        if (user == null || !"FARMER".equals(user.getUserType())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        try {
            // Get form parameters
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String dateOfBirth = request.getParameter("dateOfBirth");
            String farmName = request.getParameter("farmName");
            String farmSizeStr = request.getParameter("farmSize");
            String location = request.getParameter("location");
            String soilConditions = request.getParameter("soilConditions");
            String experienceStr = request.getParameter("experience");
            String specialization = request.getParameter("specialization");
            String goals = request.getParameter("goals");
            
            // Validate required fields
            if (firstName == null || firstName.trim().isEmpty() ||
                lastName == null || lastName.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                phone == null || phone.trim().isEmpty()) {
                
                request.setAttribute("errorMessage", "অনুগ্রহ করে সব প্রয়োজনীয় ক্ষেত্র পূরণ করুন।");
                request.getRequestDispatcher("/profile.jsp").forward(request, response);
                return;
            }
            
            // Parse numeric fields
            Double farmSize = null;
            if (farmSizeStr != null && !farmSizeStr.trim().isEmpty()) {
                try {
                    farmSize = Double.parseDouble(farmSizeStr);
                } catch (NumberFormatException e) {
                    // Invalid number format, keep as null
                }
            }
            
            Integer experience = null;
            if (experienceStr != null && !experienceStr.trim().isEmpty()) {
                try {
                    experience = Integer.parseInt(experienceStr);
                } catch (NumberFormatException e) {
                    // Invalid number format, keep as null
                }
            }
            
            // Create updated farmer object
            Farmer updatedFarmer = new Farmer();
            updatedFarmer.setId(user.getId());
            updatedFarmer.setUsername(user.getUsername());
            updatedFarmer.setPassword(user.getPassword());
            updatedFarmer.setUserType("FARMER");
            updatedFarmer.setFirstName(firstName.trim());
            updatedFarmer.setLastName(lastName.trim());
            updatedFarmer.setEmail(email.trim());
            updatedFarmer.setPhone(phone.trim());
            updatedFarmer.setDateOfBirth(dateOfBirth != null ? dateOfBirth.trim() : null);
            updatedFarmer.setFarmName(farmName != null ? farmName.trim() : null);
            updatedFarmer.setFarmSize(farmSize);
            updatedFarmer.setLocation(location != null ? location.trim() : null);
            updatedFarmer.setSoilConditions(soilConditions != null ? soilConditions.trim() : null);
            updatedFarmer.setExperience(experience);
            updatedFarmer.setSpecialization(specialization != null ? specialization.trim() : null);
            updatedFarmer.setGoals(goals != null ? goals.trim() : null);
            
            // Update in database
            UserDAO userDAO = new UserDAO();
            boolean success = userDAO.updateFarmer(updatedFarmer);
            
            if (success) {
                // Update session with new user data
                session.setAttribute("loggedInUser", updatedFarmer);
                request.setAttribute("successMessage", "আপনার প্রোফাইল সফলভাবে আপডেট করা হয়েছে!");
            } else {
                request.setAttribute("errorMessage", "প্রোফাইল আপডেট করতে সমস্যা হয়েছে। অনুগ্রহ করে আবার চেষ্টা করুন।");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "সিস্টেমে একটি ত্রুটি ঘটেছে। অনুগ্রহ করে আবার চেষ্টা করুন।");
        }
        
        // Forward back to profile page
        request.getRequestDispatcher("/profile.jsp").forward(request, response);
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirect GET requests to profile page
        response.sendRedirect(request.getContextPath() + "/profile.jsp");
    }
}
