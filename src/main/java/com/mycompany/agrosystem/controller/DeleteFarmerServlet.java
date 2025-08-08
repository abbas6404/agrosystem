package com.mycompany.agrosystem.controller;

import com.mycompany.agrosystem.dao.UserDAO;
import com.mycompany.agrosystem.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "DeleteFarmerServlet", urlPatterns = {"/admin/deleteFarmer"})
public class DeleteFarmerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null || !"ADMIN".equals(((User)session.getAttribute("loggedInUser")).getUserType())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        try {
            int farmerId = Integer.parseInt(request.getParameter("id"));
            UserDAO userDAO = new UserDAO();
            userDAO.deleteFarmer(farmerId);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
    }
}