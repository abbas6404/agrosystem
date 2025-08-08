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
        if (farmer.getLocation() == null || farmer.getSoilConditions() == null) {
            request.setAttribute("errorMessage", "আপনার প্রোফাইলের তথ্য অসম্পূর্ণ।");
            request.getRequestDispatcher("farmer_dashboard.jsp").forward(request, response);
            return;
        }
        try {
            AIService aiService = new AIService();
            String suggestionsJson = aiService.getDetailedCropSuggestions(farmer.getLocation(), farmer.getSoilConditions());
            request.setAttribute("cropSuggestions", suggestionsJson);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "AI পরামর্শ আনতে সমস্যা হয়েছে।");
        }
        request.getRequestDispatcher("farmer_dashboard.jsp").forward(request, response);
    }
}