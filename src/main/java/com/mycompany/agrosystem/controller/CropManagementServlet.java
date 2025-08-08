package com.mycompany.agrosystem.controller;

import com.mycompany.agrosystem.dao.ContentDAO;
import com.mycompany.agrosystem.model.Crop;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/crops")
public class CropManagementServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ContentDAO dao = new ContentDAO();
        List<Crop> cropList = dao.getAllCrops();
        request.setAttribute("cropList", cropList);
        request.getRequestDispatcher("/crop_management.jsp").forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        ContentDAO dao = new ContentDAO();
        if ("add".equals(action)) {
            dao.addCrop(request.getParameter("cropName"), request.getParameter("description"));
        } else if ("delete".equals(action)) {
            dao.deleteCrop(Integer.parseInt(request.getParameter("cropId")));
        }
        response.sendRedirect(request.getContextPath() + "/admin/crops");
    }
}
