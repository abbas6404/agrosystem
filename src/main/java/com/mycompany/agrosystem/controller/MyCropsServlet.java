package com.mycompany.agrosystem.controller;

import com.mycompany.agrosystem.dao.ContentDAO;
import com.mycompany.agrosystem.model.Crop;
import com.mycompany.agrosystem.model.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "MyCropsServlet", urlPatterns = {"/myCrops"})
public class MyCropsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !(session.getAttribute("loggedInUser") instanceof User)) {
            response.sendRedirect("login.jsp");
            return;
        }
        User user = (User) session.getAttribute("loggedInUser");
        ContentDAO contentDAO = new ContentDAO();
        List<Crop> myCrops = contentDAO.getFarmerCrops(user.getId());
        request.setAttribute("myCropsList", myCrops);
        request.getRequestDispatcher("/my_crops.jsp").forward(request, response);
    }
}