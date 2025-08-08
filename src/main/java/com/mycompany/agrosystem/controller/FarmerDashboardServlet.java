package com.mycompany.agrosystem.controller;

import com.mycompany.agrosystem.dao.ContentDAO;
import com.mycompany.agrosystem.model.Notice;
import com.mycompany.agrosystem.model.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "FarmerDashboardServlet", urlPatterns = {"/farmerDashboard"})
public class FarmerDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !"FARMER".equals(((User)session.getAttribute("loggedInUser")).getUserType())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        User user = (User) session.getAttribute("loggedInUser");
        ContentDAO contentDAO = new ContentDAO();
        List<Notice> noticeList = contentDAO.getRecentNotices(5);
        int myCropsCount = contentDAO.getFarmerCrops(user.getId()).size();
        request.setAttribute("noticeList", noticeList);
        request.setAttribute("myCropsCount", myCropsCount);
        request.getRequestDispatcher("/farmer_dashboard.jsp").forward(request, response);
    }
}
