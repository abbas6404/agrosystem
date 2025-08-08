package com.mycompany.agrosystem.controller;

import com.mycompany.agrosystem.service.AIService;
import java.io.IOException;
import java.io.InputStream;
import java.util.Base64;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/diseaseDetection")
@MultipartConfig
public class DiseaseDetectionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Part filePart = request.getPart("cropImage");
            InputStream fileContent = filePart.getInputStream();
            byte[] imageBytes = fileContent.readAllBytes();
            String base64ImageData = Base64.getEncoder().encodeToString(imageBytes);
            AIService aiService = new AIService();
            String analysisJson = aiService.analyzeCropImage(base64ImageData);
            request.setAttribute("analysisResult", analysisJson);
            request.setAttribute("uploadedImage", "data:image/jpeg;base64," + base64ImageData);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "ছবি আপলোড বা বিশ্লেষণ করতে সমস্যা হয়েছে।");
        }
        request.getRequestDispatcher("/disease_detection.jsp").forward(request, response);
    }
}
