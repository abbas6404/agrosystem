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

@WebServlet("/admin/notices")
public class NoticeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User admin = (User) session.getAttribute("loggedInUser");
        if (admin != null && "ADMIN".equals(admin.getUserType())) {
            ContentDAO dao = new ContentDAO();
            dao.addNotice(request.getParameter("title"), request.getParameter("content"), admin.getId());
        }
        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
    }
}

