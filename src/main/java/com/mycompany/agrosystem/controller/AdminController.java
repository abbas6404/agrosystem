package com.mycompany.agrosystem.controller;

import com.mycompany.agrosystem.dao.ContentDAO;
import com.mycompany.agrosystem.dao.UserDAO;
import com.mycompany.agrosystem.model.Farmer;
import com.mycompany.agrosystem.model.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AdminController", urlPatterns = {"/admin/dashboard"})
public class AdminController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null || !"ADMIN".equals(((User)session.getAttribute("loggedInUser")).getUserType())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        UserDAO userDAO = new UserDAO();
        ContentDAO contentDAO = new ContentDAO();
        List<Farmer> farmerList = userDAO.getAllFarmers();
        int farmerCount = userDAO.getFarmerCount();
        int cropCount = contentDAO.getCropCount();
        request.setAttribute("allFarmers", farmerList);
        request.setAttribute("farmerCount", farmerCount);
        request.setAttribute("cropCount", cropCount);
        request.getRequestDispatcher("/admin_dashboard.jsp").forward(request, response);
    }
}