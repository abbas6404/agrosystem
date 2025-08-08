package com.mycompany.agrosystem.controller;

import com.mycompany.agrosystem.dao.UserDAO;
import com.mycompany.agrosystem.model.Farmer;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "EditFarmerServlet", urlPatterns = {"/admin/editFarmer"})
public class EditFarmerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int farmerId = Integer.parseInt(request.getParameter("id"));
        UserDAO userDAO = new UserDAO();
        Farmer farmer = userDAO.getFarmerById(farmerId);
        request.setAttribute("farmer", farmer);
        request.getRequestDispatcher("/edit_farmer.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        Farmer farmer = new Farmer();
        farmer.setId(Integer.parseInt(request.getParameter("id")));
        farmer.setName(request.getParameter("name"));
        farmer.setPhoneNumber(request.getParameter("phone"));
        farmer.setLocation(request.getParameter("location"));
        farmer.setLandSizeAcres(Double.parseDouble(request.getParameter("landSize")));
        farmer.setSoilConditions(request.getParameter("soil"));
        UserDAO userDAO = new UserDAO();
        userDAO.updateFarmer(farmer);
        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
    }
}
