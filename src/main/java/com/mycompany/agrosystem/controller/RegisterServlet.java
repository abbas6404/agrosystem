package com.mycompany.agrosystem.controller;

import com.mycompany.agrosystem.dao.UserDAO;
import com.mycompany.agrosystem.model.Farmer;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        try {
            Farmer farmerData = new Farmer();
            farmerData.setName(request.getParameter("name"));
            farmerData.setPhoneNumber(request.getParameter("phone"));
            farmerData.setPassword(request.getParameter("password"));
            farmerData.setLocation(request.getParameter("location"));
            farmerData.setLandSizeAcres(Double.parseDouble(request.getParameter("landSize")));
            farmerData.setSoilConditions(request.getParameter("soil"));
            UserDAO userDAO = new UserDAO();
            Farmer newFarmer = userDAO.registerFarmer(farmerData);
            if (newFarmer != null) {
                HttpSession session = request.getSession();
                session.setAttribute("loggedInUser", newFarmer);
                response.sendRedirect(request.getContextPath() + "/farmerDashboard");
            } else {
                request.setAttribute("errorMessage", "নিবন্ধন ব্যর্থ হয়েছে। এই ফোন নম্বরটি হয়তো ব্যবহৃত হয়েছে।");
                request.getRequestDispatcher("/registration.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "একটি অপ্রত্যাশিত সমস্যা হয়েছে।");
            request.getRequestDispatcher("/registration.jsp").forward(request, response);
        }
    }
}
