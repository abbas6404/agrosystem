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

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        try {
            UserDAO userDAO = new UserDAO();
            User user = userDAO.loginUser(phone, password);
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("loggedInUser", user);
                if ("FARMER".equals(user.getUserType())) {
                    response.sendRedirect(request.getContextPath() + "/farmerDashboard");
                } else if ("ADMIN".equals(user.getUserType())) {
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                }
            } else {
                request.setAttribute("errorMessage", "আপনার ফোন নম্বর বা পাসওয়ার্ড সঠিক নয়।");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "একটি অপ্রত্যাশিত সমস্যা হয়েছে।");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}