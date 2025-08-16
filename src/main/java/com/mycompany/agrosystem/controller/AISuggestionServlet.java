package com.mycompany.agrosystem.controller;

import com.mycompany.agrosystem.model.Farmer;
import com.mycompany.agrosystem.service.AIService;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AISuggestionServlet", urlPatterns = {"/getSuggestion"})
public class AISuggestionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !(session.getAttribute("loggedInUser") instanceof Farmer)) {
            response.sendRedirect("login.jsp");
            return;
        }
        Farmer farmer = (Farmer) session.getAttribute("loggedInUser");
        
        // Check if location and soil conditions are provided via URL parameters
        String location = request.getParameter("location");
        String soilConditions = request.getParameter("soilConditions");
        
        // If not in URL, check farmer profile
        if (location == null || soilConditions == null) {
            location = farmer.getLocation();
            soilConditions = farmer.getSoilConditions();
        }
        
        if (location == null || soilConditions == null) {
            request.setAttribute("errorMessage", "আপনার প্রোফাইলের তথ্য অসম্পূর্ণ।");
            request.getRequestDispatcher("ai_suggestion_simple.jsp").forward(request, response);
            return;
        }
        try {
            AIService aiService = new AIService();
            String suggestionsJson = aiService.getDetailedCropSuggestions(location, soilConditions);
            request.setAttribute("cropSuggestions", suggestionsJson);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "AI পরামর্শ আনতে সমস্যা হয়েছে।");
        }
        request.getRequestDispatcher("ai_suggestion_simple.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("test".equals(action)) {
            // Test the AI API directly
            try {
                AIService aiService = new AIService();
                String testResult = aiService.testAPI();
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write("API Test Result: " + testResult);
            } catch (Exception e) {
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write("Test Failed: " + e.getMessage());
            }
            return;
        }
        
        // Handle other POST requests if needed
        doGet(request, response);
    }
}