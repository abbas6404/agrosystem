package com.mycompany.agrosystem.service;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

/**
 * This service is responsible for fetching weather data from an external API.
 */
public class WeatherService {

    /**
     * Fetches the 7-day weather forecast for a specific location (e.g., Dhaka).
     * @return A JSON string containing the weather forecast data.
     */
    public String getWeeklyForecast() {
        // We are using Ashulia, Dhaka's approximate coordinates for this example.
        String apiUrl = "https://api.open-meteo.com/v1/forecast?latitude=23.89&longitude=90.31&daily=weathercode,temperature_2m_max,temperature_2m_min,precipitation_sum&timezone=Asia/Dhaka";
        
        try {
            HttpClient client = HttpClient.newHttpClient();
            HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(apiUrl))
                .build();

            // Send the request to the weather API and get the response.
            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
            
            return response.body();

        } catch (Exception e) {
            e.printStackTrace();
            // If the API call fails, return an error message in JSON format.
            return "{\"error\": \"আবহাওয়ার পূর্বাভাস আনতে সমস্যা হয়েছে।\"}";
        }
    }
}
