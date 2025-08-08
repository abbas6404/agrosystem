package com.mycompany.agrosystem.controller;

import com.mycompany.agrosystem.service.WeatherService;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "WeatherServlet", urlPatterns = {"/weather"})
public class WeatherServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        WeatherService weatherService = new WeatherService();
        String forecastJson = weatherService.getWeeklyForecast();
        request.setAttribute("forecastData", forecastJson);
        request.getRequestDispatcher("/weather.jsp").forward(request, response);
    }
}
