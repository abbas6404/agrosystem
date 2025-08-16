package com.mycompany.agrosystem.service;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import org.json.JSONObject;
import org.json.JSONArray;

/**
 * This service is responsible for fetching weather data from an external API.
 * Provides comprehensive weather information for agricultural planning.
 */
public class WeatherService {

    /**
     * Fetches the 7-day weather forecast for Dhaka, Bangladesh.
     * @return A JSON string containing the weather forecast data.
     */
    public String getWeeklyForecast() {
        // Using Dhaka's coordinates for weather data
        String apiUrl = "https://api.open-meteo.com/v1/forecast?" +
                       "latitude=23.89&longitude=90.31" +
                       "&daily=weathercode,temperature_2m_max,temperature_2m_min,precipitation_sum,precipitation_probability_max" +
                       "&hourly=relative_humidity_2m,wind_speed_10m" +
                       "&timezone=Asia/Dhaka";
        
        try {
            HttpClient client = HttpClient.newHttpClient();
            HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(apiUrl))
                .timeout(java.time.Duration.ofSeconds(10))
                .build();

            // Send the request to the weather API and get the response
            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
            
            if (response.statusCode() == 200) {
                return response.body();
            } else {
                System.err.println("Weather API returned status: " + response.statusCode());
                return getFallbackWeatherData();
            }

        } catch (Exception e) {
            System.err.println("Error fetching weather data: " + e.getMessage());
            e.printStackTrace();
            // If the API call fails, return fallback data
            return getFallbackWeatherData();
        }
    }
    
    /**
     * Provides fallback weather data when the API is unavailable.
     * This ensures farmers always have some weather information.
     */
    private String getFallbackWeatherData() {
        try {
            JSONObject fallbackData = new JSONObject();
            JSONObject daily = new JSONObject();
            
            // Create 7 days of fallback data
            JSONArray time = new JSONArray();
            JSONArray weathercode = new JSONArray();
            JSONArray tempMax = new JSONArray();
            JSONArray tempMin = new JSONArray();
            JSONArray precipitation = new JSONArray();
            JSONArray precipProb = new JSONArray();
            
            java.time.LocalDate today = java.time.LocalDate.now();
            
            for (int i = 0; i < 7; i++) {
                java.time.LocalDate date = today.plusDays(i);
                time.put(date.toString());
                
                // Simple weather pattern: sunny first 3 days, then some rain
                if (i < 3) {
                    weathercode.put(0); // Sunny
                    tempMax.put(32 + (i * 2)); // Gradually warming
                    tempMin.put(24 + i);
                    precipitation.put(0.0);
                    precipProb.put(5);
                } else {
                    weathercode.put(51); // Light rain
                    tempMax.put(30 - (i - 3));
                    tempMin.put(22 - (i - 3));
                    precipitation.put(2.5 + (i - 3) * 1.5);
                    precipProb.put(60 + (i - 3) * 10);
                }
            }
            
            daily.put("time", time);
            daily.put("weathercode", weathercode);
            daily.put("temperature_2m_max", tempMax);
            daily.put("temperature_2m_min", tempMin);
            daily.put("precipitation_sum", precipitation);
            daily.put("precipitation_probability_max", precipProb);
            
            fallbackData.put("daily", daily);
            fallbackData.put("fallback", true);
            fallbackData.put("message", "আবহাওয়ার তথ্য অস্থায়ীভাবে অপ্রাপ্য। সাধারণ পূর্বাভাস দেখানো হচ্ছে।");
            
            return fallbackData.toString();
            
        } catch (Exception e) {
            // Ultimate fallback - very basic data
            return "{\"daily\":{\"time\":[\"" + java.time.LocalDate.now() + "\"]," +
                   "\"weathercode\":[0],\"temperature_2m_max\":[30]," +
                   "\"temperature_2m_min\":[24],\"precipitation_sum\":[0]}," +
                   "\"fallback\":true,\"message\":\"আবহাওয়ার তথ্য লোড করা যায়নি।\"}";
        }
    }
    
    /**
     * Gets weather data for a specific location (can be extended for multiple cities)
     * @param latitude The latitude of the location
     * @param longitude The longitude of the location
     * @return Weather forecast data for the specified location
     */
    public String getWeatherForLocation(double latitude, double longitude) {
        String apiUrl = String.format(
            "https://api.open-meteo.com/v1/forecast?" +
            "latitude=%.2f&longitude=%.2f" +
            "&daily=weathercode,temperature_2m_max,temperature_2m_min,precipitation_sum,precipitation_probability_max" +
            "&hourly=relative_humidity_2m,wind_speed_10m" +
            "&timezone=Asia/Dhaka",
            latitude, longitude
        );
        
        try {
            HttpClient client = HttpClient.newHttpClient();
            HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(apiUrl))
                .timeout(java.time.Duration.ofSeconds(10))
                .build();

            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
            
            if (response.statusCode() == 200) {
                return response.body();
            } else {
                return getFallbackWeatherData();
            }

        } catch (Exception e) {
            System.err.println("Error fetching weather for location: " + e.getMessage());
            return getFallbackWeatherData();
        }
    }
}
