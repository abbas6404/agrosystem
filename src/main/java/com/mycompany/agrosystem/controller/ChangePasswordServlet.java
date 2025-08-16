package com.mycompany.agrosystem.controller;

import com.mycompany.agrosystem.model.User;
import com.mycompany.agrosystem.model.Farmer;
import com.mycompany.agrosystem.dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

@WebServlet(name = "ChangePasswordServlet", urlPatterns = {"/changePassword"})
public class ChangePasswordServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !(session.getAttribute("loggedInUser") instanceof User)) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Determine which page to forward to based on user type
        String forwardPage = "ADMIN".equals(loggedInUser.getUserType()) ? "admin_change_password.jsp" : "change_password.jsp";
        
        // Validate input parameters
        if (currentPassword == null || newPassword == null || confirmPassword == null ||
            currentPassword.trim().isEmpty() || newPassword.trim().isEmpty() || confirmPassword.trim().isEmpty()) {
            request.setAttribute("errorMessage", "সব ফিল্ড পূরণ করুন");
            request.getRequestDispatcher(forwardPage).forward(request, response);
            return;
        }
        
        // Check if new password matches confirmation
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "নতুন পাসওয়ার্ড এবং নিশ্চিতকরণ মিলছে না");
            request.getRequestDispatcher(forwardPage).forward(request, response);
            return;
        }
        
        // Validate new password strength
        if (!isPasswordStrong(newPassword)) {
            request.setAttribute("errorMessage", "পাসওয়ার্ড খুব দুর্বল। কমপক্ষে ৮টি অক্ষর, একটি বড় হাতের অক্ষর, একটি ছোট হাতের অক্ষর, একটি সংখ্যা এবং একটি বিশেষ অক্ষর ব্যবহার করুন");
            request.getRequestDispatcher(forwardPage).forward(request, response);
            return;
        }
        
        try {
            UserDAO userDAO = new UserDAO();
            
            // Verify current password - handle both hashed and plain text
            String storedPassword = loggedInUser.getPassword();
            
            // If password is null, try to refresh user data from database
            if (storedPassword == null) {
                System.out.println("Password is null in session, refreshing user data from database...");
                User refreshedUser = userDAO.getUserById(loggedInUser.getId());
                if (refreshedUser != null && refreshedUser.getPassword() != null) {
                    loggedInUser = refreshedUser;
                    storedPassword = refreshedUser.getPassword();
                    // Update session with refreshed user
                    session.setAttribute("loggedInUser", refreshedUser);
                    System.out.println("User data refreshed successfully from database");
                } else {
                    System.out.println("Failed to refresh user data from database");
                    request.setAttribute("errorMessage", "ডাটাবেসে পাসওয়ার্ড পাওয়া যায়নি। অনুগ্রহ করে অ্যাডমিনের সাথে যোগাযোগ করুন।");
                    request.getRequestDispatcher(forwardPage).forward(request, response);
                    return;
                }
            }
            
            boolean currentPasswordCorrect = false;
            
            System.out.println("=== Password Change Debug ===");
            System.out.println("User ID: " + loggedInUser.getId());
            System.out.println("User Type: " + loggedInUser.getUserType());
            System.out.println("Stored password: " + (storedPassword != null ? storedPassword : "NULL"));
            System.out.println("Stored password length: " + (storedPassword != null ? storedPassword.length() : "null"));
            System.out.println("Current password length: " + currentPassword.length());
            
            // Check if stored password is null
            if (storedPassword == null || storedPassword.trim().isEmpty()) {
                System.out.println("Stored password is null or empty - this indicates a database issue");
                request.setAttribute("errorMessage", "ডাটাবেসে পাসওয়ার্ড পাওয়া যায়নি। অনুগ্রহ করে অ্যাডমিনের সাথে যোগাযোগ করুন।");
                request.getRequestDispatcher(forwardPage).forward(request, response);
                return;
            }
            
            // First try to compare with stored password directly (for plain text)
            if (storedPassword.equals(currentPassword)) {
                currentPasswordCorrect = true;
                System.out.println("Password matched as plain text");
            } else {
                // If direct comparison fails, try hashed comparison
                String hashedCurrentPassword = hashPassword(currentPassword);
                if (storedPassword.equals(hashedCurrentPassword)) {
                    currentPasswordCorrect = true;
                    System.out.println("Password matched as hashed text");
                } else {
                    System.out.println("Password did not match");
                    System.out.println("Stored: '" + storedPassword + "'");
                    System.out.println("Entered: '" + currentPassword + "'");
                    System.out.println("Hashed: '" + hashedCurrentPassword + "'");
                }
            }
            
            if (!currentPasswordCorrect) {
                request.setAttribute("errorMessage", "বর্তমান পাসওয়ার্ড ভুল");
                request.getRequestDispatcher(forwardPage).forward(request, response);
                return;
            }
            
            // For new password, we can choose to store as plain text or hashed
            // Since your database stores plain text, we'll store the new password as plain text
            String passwordToStore = newPassword; // Store as plain text
            
            System.out.println("New password will be stored as plain text");
            System.out.println("New password length: " + passwordToStore.length());
            
            // Update password in database
            boolean updateSuccess = userDAO.updatePassword(loggedInUser.getId(), passwordToStore);
            
            if (updateSuccess) {
                // Update session user object
                loggedInUser.setPassword(passwordToStore);
                session.setAttribute("loggedInUser", loggedInUser);
                
                System.out.println("Password updated successfully in database");
                request.setAttribute("successMessage", "পাসওয়ার্ড সফলভাবে পরিবর্তন করা হয়েছে");
                request.getRequestDispatcher(forwardPage).forward(request, response);
            } else {
                System.out.println("Failed to update password in database");
                request.setAttribute("errorMessage", "পাসওয়ার্ড পরিবর্তন করতে সমস্যা হয়েছে। অনুগ্রহ করে আবার চেষ্টা করুন");
                request.getRequestDispatcher(forwardPage).forward(request, response);
            }
            
        } catch (Exception e) {
            System.err.println("Error in password change: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "সিস্টেমে সমস্যা হয়েছে। অনুগ্রহ করে আবার চেষ্টা করুন");
            request.getRequestDispatcher(forwardPage).forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check user type and redirect to appropriate page
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("loggedInUser") instanceof User) {
            User user = (User) session.getAttribute("loggedInUser");
            if ("ADMIN".equals(user.getUserType())) {
                response.sendRedirect("admin_change_password.jsp");
            } else {
                response.sendRedirect("change_password.jsp");
            }
        } else {
            response.sendRedirect("login.jsp");
        }
    }
    
    /**
     * Validates password strength
     */
    private boolean isPasswordStrong(String password) {
        if (password.length() < 8) return false;
        
        boolean hasUppercase = false;
        boolean hasLowercase = false;
        boolean hasNumber = false;
        boolean hasSpecial = false;
        
        for (char c : password.toCharArray()) {
            if (Character.isUpperCase(c)) hasUppercase = true;
            else if (Character.isLowerCase(c)) hasLowercase = true;
            else if (Character.isDigit(c)) hasNumber = true;
            else if ("!@#$%^&*".indexOf(c) != -1) hasSpecial = true;
        }
        
        return hasUppercase && hasLowercase && hasNumber && hasSpecial;
    }
    
    /**
     * Hashes password using SHA-256
     */
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());
            
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-256 algorithm not available", e);
        }
    }
}
