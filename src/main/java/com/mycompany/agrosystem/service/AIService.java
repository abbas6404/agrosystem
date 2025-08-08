package com.mycompany.agrosystem.service;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 * This service class acts as the "brain" for AI-related functionalities.
 * It handles all communications with the Google Gemini API for both text and image analysis.
 */
public class AIService {
    // WARNING: Do not hardcode API keys in production code! For this project, it's okay.
    private static final String API_KEY = "AIzaSyB3OVu6txfOQjVhdSSSYqb_j1E-ty7I9ug";

    /**
     * Gets detailed crop suggestions (text-only) from the Gemini Pro model.
     * @param location Farmer's location.
     * @param soilConditions Farmer's soil conditions.
     * @return A JSON string with detailed crop suggestions.
     */
    public String getDetailedCropSuggestions(String location, String soilConditions) {
        String textApiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=" + API_KEY;
        String prompt = String.format(
            "I am a farmer in %s, Bangladesh. My farm's soil is %s. " +
            "Please suggest 3 suitable crops for me. " +
            "Provide the response as a JSON array of objects. " +
            "For each object, provide these keys in Bengali: 'ফসলের নাম', 'কারণ', 'উপযুক্ত বীজ', 'প্রয়োজনীয় সার', and 'রোপণের সেরা সময়'. " +
            "Keep all text values in simple Bengali language for easy understanding.",
            location, soilConditions
        );

        try {
            return callTextAPI(prompt, textApiUrl);
        } catch (Exception e) {
            e.printStackTrace();
            return "[{\"error\": \"AI পরামর্শ পেতে সমস্যা হচ্ছে।\"}]";
        }
    }

    /**
     * Analyzes an image of a crop leaf using the Gemini Pro Vision model.
     * @param base64ImageData The Base64 encoded string of the image.
     * @return A JSON string with the analysis (disease name, description, and remedy).
     */
    public String analyzeCropImage(String base64ImageData) {
        String visionApiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro-vision:generateContent?key=" + API_KEY;
        String prompt = "এই ছবিতে ফসলের পাতায় যে রোগ বা পোকার আক্রমণ দেখা যাচ্ছে, সেটি শনাক্ত করুন। রোগের নাম, এর একটি সংক্ষিপ্ত বিবরণ এবং এটি প্রতিকারের জন্য সহজ বাংলায় একটি উপায় বলুন। ফলাফলটি একটি JSON অবজেক্ট হিসেবে দিন যেখানে 'রোগের_নাম', 'বিবরণ', এবং 'প্রতিকার' নামে তিনটি কী থাকবে।";

        try {
            HttpClient client = HttpClient.newHttpClient();

            JSONObject textPart = new JSONObject().put("text", prompt);
            JSONObject inlineData = new JSONObject().put("mime_type", "image/jpeg").put("data", base64ImageData);
            JSONObject imagePart = new JSONObject().put("inline_data", inlineData);

            JSONArray parts = new JSONArray().put(textPart).put(imagePart);
            JSONObject payload = new JSONObject().put("contents", new JSONArray().put(new JSONObject().put("parts", parts)));

            HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(visionApiUrl))
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(payload.toString()))
                .build();

            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
            
            JSONObject responseJson = new JSONObject(response.body());
            return responseJson.getJSONArray("candidates").getJSONObject(0).getJSONObject("content").getJSONArray("parts").getJSONObject(0).getString("text");

        } catch (Exception e) {
            e.printStackTrace();
            return "{\"error\": \"ছবি বিশ্লেষণ করতে সমস্যা হয়েছে। অনুগ্রহ করে আবার চেষ্টা করুন।\"}";
        }
    }
    
    // Helper method for simple text-based API calls
    private String callTextAPI(String prompt, String apiUrl) throws Exception {
        HttpClient client = HttpClient.newHttpClient();
        String jsonPayload = new JSONObject()
            .put("contents", new JSONArray().put(new JSONObject().put("parts", new JSONArray().put(new JSONObject().put("text", prompt)))))
            .toString();

        HttpRequest request = HttpRequest.newBuilder()
            .uri(URI.create(apiUrl))
            .header("Content-Type", "application/json")
            .POST(HttpRequest.BodyPublishers.ofString(jsonPayload))
            .build();

        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
        
        JSONObject responseJson = new JSONObject(response.body());
        return responseJson.getJSONArray("candidates").getJSONObject(0).getJSONObject("content").getJSONArray("parts").getJSONObject(0).getString("text");
    }
}
