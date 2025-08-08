package com.mycompany.agrosystem.controller;

import com.mycompany.agrosystem.dao.ContentDAO;
import com.mycompany.agrosystem.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AddCropServlet", urlPatterns = {"/addCrop"})
public class AddCropServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        User user = (User) session.getAttribute("loggedInUser");
        String cropName = request.getParameter("cropName");
        if (cropName != null && !cropName.trim().isEmpty()) {
            ContentDAO dao = new ContentDAO();
            if (dao.addCropToFarmer(user.getId(), cropName)) {
                session.setAttribute("message", "ফসল '" + cropName + "' আপনার তালিকায় যোগ করা হয়েছে।");
            } else {
                session.setAttribute("errorMessage", "ফসলটি যোগ করতে সমস্যা হয়েছে।");
            }
        }
        response.sendRedirect(request.getContextPath() + "/farmerDashboard");
    }
}