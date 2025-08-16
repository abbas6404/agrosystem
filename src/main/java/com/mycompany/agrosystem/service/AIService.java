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
    private static final String API_KEY = "AIzaSyBL3kKTACftCS5AMt7hR1Z4Af7q92QOC0Y";

    /**
     * Gets detailed crop suggestions (text-only) from the Gemini Pro model.
     * @param location Farmer's location.
     * @param soilConditions Farmer's soil conditions.
     * @return A JSON string with detailed crop suggestions.
     */
    public String getDetailedCropSuggestions(String location, String soilConditions) {
        String textApiUrl = "https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash:generateContent?key=" + API_KEY;
        String prompt = String.format(
            "You are an agricultural expert. Based on the location '%s' and soil conditions '%s', " +
            "suggest 3-5 suitable crops for this area. " +
            "Return ONLY a valid JSON array with objects. " +
            "Each object must have exactly these 5 keys in Bengali: 'ফসলের নাম', 'কারণ', 'উপযুক্ত বীজ', 'প্রয়োজনীয় সার', 'রোপণের সেরা সময়'. " +
            "Example format: [{\"ফসলের নাম\":\"ধান\",\"কারণ\":\"এই এলাকার জন্য উপযুক্ত\",\"উপযুক্ত বীজ\":\"উচ্চ মানের বীজ\",\"প্রয়োজনীয় সার\":\"জৈব সার\",\"রোপণের সেরা সময়\":\"বর্ষা মৌসুম\"}] " +
            "Keep all text values in simple Bengali language for easy understanding. " +
            "Do not include any explanations or text outside the JSON array.",
            location, soilConditions
        );

        try {
            System.out.println("=== Getting AI Crop Suggestions ===");
            System.out.println("Location: " + location);
            System.out.println("Soil Conditions: " + soilConditions);
            System.out.println("API URL: " + textApiUrl);
            
            String result = callTextAPI(prompt, textApiUrl);
            System.out.println("AI Service Result: " + result);
            return result;
        } catch (Exception e) {
            System.err.println("Error in getDetailedCropSuggestions: " + e.getMessage());
            e.printStackTrace();
            // Return a comprehensive fallback response with multiple crops
            return "[{\"ফসলের নাম\":\"ধান\",\"কারণ\":\"আপনার এলাকার আবহাওয়া এবং মাটির অবস্থা অনুযায়ী উপযুক্ত\",\"উপযুক্ত বীজ\":\"উচ্চ মানের বীজ\",\"প্রয়োজনীয় সার\":\"জৈব সার এবং রাসায়নিক সারের মিশ্রণ\",\"রোপণের সেরা সময়\":\"বর্ষা মৌসুমের শুরুতে\"},{\"ফসলের নাম\":\"গম\",\"কারণ\":\"শীতকালীন ফসল হিসেবে উপযুক্ত\",\"উপযুক্ত বীজ\":\"উচ্চ ফলনশীল জাতের বীজ\",\"প্রয়োজনীয় সার\":\"নাইট্রোজেন এবং ফসফরাস সমৃদ্ধ সার\",\"রোপণের সেরা সময়\":\"অক্টোবর-নভেম্বর মাসে\"},{\"ফসলের নাম\":\"ভুট্টা\",\"কারণ\":\"গ্রীষ্মকালীন ফসল হিসেবে চমৎকার\",\"উপযুক্ত বীজ\":\"সংকর জাতের বীজ\",\"প্রয়োজনীয় সার\":\"জৈব সার এবং পটাশ\",\"রোপণের সেরা সময়\":\"মার্চ-এপ্রিল মাসে\"}]";
        }
    }

    /**
     * Analyzes an image of a crop leaf using the Gemini Pro Vision model.
     * @param base64ImageData The Base64 encoded string of the image.
     * @return A JSON string with the analysis (disease name, description, and remedy).
     */
    public String analyzeCropImage(String base64ImageData) {
        String visionApiUrl = "https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash:generateContent?key=" + API_KEY;
        String prompt = "এই ছবিতে ফসলের পাতায় যে রোগ বা পোকার আক্রমণ দেখা যাচ্ছে, সেটি শনাক্ত করুন। রোগের নাম, এর একটি সংক্ষিপ্ত বিবরণ এবং এটি প্রতিকারের জন্য সহজ বাংলায় একটি উপায় বলুন। ফলাফলটি একটি JSON অবজেক্ট হিসেবে দিন যেখানে 'রোগের_নাম', 'বিবরণ', এবং 'প্রতিকার' নামে তিনটি কী থাকবে।";

        try {
            System.out.println("=== Starting Image Analysis ===");
            System.out.println("Image data length: " + base64ImageData.length());
            
            HttpClient client = HttpClient.newHttpClient();

            JSONObject textPart = new JSONObject().put("text", prompt);
            JSONObject inlineData = new JSONObject().put("mime_type", "image/jpeg").put("data", base64ImageData);
            JSONObject imagePart = new JSONObject().put("inline_data", inlineData);

            JSONArray parts = new JSONArray().put(textPart).put(imagePart);
            JSONObject payload = new JSONObject().put("contents", new JSONArray().put(new JSONObject().put("parts", parts)));

            System.out.println("Sending request to Gemini Vision API...");
            System.out.println("API URL: " + visionApiUrl);

            HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(visionApiUrl))
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(payload.toString()))
                .build();

            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
            
            System.out.println("Response Status: " + response.statusCode());
            System.out.println("Response Body: " + response.body());
            
            if (response.statusCode() != 200) {
                System.err.println("API Error: Status " + response.statusCode());
                return getFallbackDiseaseAnalysis();
            }
            
            JSONObject responseJson = new JSONObject(response.body());
            
            // Check for API errors
            if (responseJson.has("error")) {
                System.err.println("API Error: " + responseJson.getJSONObject("error").getString("message"));
                return getFallbackDiseaseAnalysis();
            }
            
            // Check if response has candidates
            if (!responseJson.has("candidates") || responseJson.getJSONArray("candidates").length() == 0) {
                System.err.println("No candidates in API response");
                return getFallbackDiseaseAnalysis();
            }
            
            String aiResponse = responseJson.getJSONArray("candidates").getJSONObject(0).getJSONObject("content").getJSONArray("parts").getJSONObject(0).getString("text");
            
            System.out.println("AI Response Text: " + aiResponse);
            
            // Try to parse the AI response as JSON
            try {
                JSONObject parsedResponse = new JSONObject(aiResponse);
                System.out.println("Successfully parsed JSON response");
                return aiResponse;
            } catch (Exception jsonError) {
                System.err.println("Failed to parse AI response as JSON: " + jsonError.getMessage());
                System.out.println("AI returned text instead of JSON, creating structured response...");
                
                // If AI didn't return JSON, create a structured response
                return createStructuredResponse(aiResponse);
            }

        } catch (Exception e) {
            System.err.println("Error in analyzeCropImage: " + e.getMessage());
            e.printStackTrace();
            return getFallbackDiseaseAnalysis();
        }
    }
    
    /**
     * Creates a structured JSON response when AI returns plain text
     */
    private String createStructuredResponse(String aiText) {
        try {
            JSONObject response = new JSONObject();
            
            // Try to extract disease information from the text
            if (aiText.toLowerCase().contains("রোগ") || aiText.toLowerCase().contains("disease")) {
                response.put("রোগের_নাম", "রোগ শনাক্ত করা হয়েছে");
                response.put("বিবরণ", aiText);
                response.put("প্রতিকার", "চিকিৎসকের পরামর্শ নিন এবং উপযুক্ত ওষুধ ব্যবহার করুন");
            } else if (aiText.toLowerCase().contains("পোকা") || aiText.toLowerCase().contains("insect")) {
                response.put("রোগের_নাম", "পোকামাকড়ের আক্রমণ");
                response.put("বিবরণ", aiText);
                response.put("প্রতিকার", "উপযুক্ত কীটনাশক ব্যবহার করুন");
            } else {
                response.put("রোগের_নাম", "বিশ্লেষণ সম্পন্ন");
                response.put("বিবরণ", aiText);
                response.put("প্রতিকার", "আরও বিশদ বিশ্লেষণের জন্য বিশেষজ্ঞের পরামর্শ নিন");
            }
            
            return response.toString();
        } catch (Exception e) {
            System.err.println("Error creating structured response: " + e.getMessage());
            return getFallbackDiseaseAnalysis();
        }
    }
    
    /**
     * Creates a structured JSON response for crops when AI returns plain text
     */
    private String createStructuredCropResponse(String aiText) {
        try {
            // Try to extract crop information from the text
            JSONArray cropsArray = new JSONArray();
            
            // Split the text by lines or sentences to extract crop info
            String[] lines = aiText.split("\\n|\\.");
            
            for (String line : lines) {
                line = line.trim();
                if (line.length() > 10 && (line.contains("ফসল") || line.contains("ধান") || line.contains("গম") || line.contains("ভুট্টা") || line.contains("আলু") || line.contains("টমেটো"))) {
                    JSONObject crop = new JSONObject();
                    crop.put("ফসলের নাম", line);
                    crop.put("কারণ", "আপনার এলাকার আবহাওয়া এবং মাটির অবস্থা অনুযায়ী উপযুক্ত");
                    crop.put("উপযুক্ত বীজ", "স্থানীয় কৃষি দোকান থেকে উচ্চ মানের বীজ সংগ্রহ করুন");
                    crop.put("প্রয়োজনীয় সার", "জৈব সার এবং রাসায়নিক সারের মিশ্রণ ব্যবহার করুন");
                    crop.put("রোপণের সেরা সময়", "বর্ষা মৌসুমের শুরুতে");
                    cropsArray.put(crop);
                }
            }
            
            // If no specific crops found, create a default response
            if (cropsArray.length() == 0) {
                JSONObject defaultCrop = new JSONObject();
                defaultCrop.put("ফসলের নাম", "ধান");
                defaultCrop.put("কারণ", "আপনার এলাকার আবহাওয়া এবং মাটির অবস্থা অনুযায়ী উপযুক্ত");
                defaultCrop.put("উপযুক্ত বীজ", "স্থানীয় কৃষি দোকান থেকে উচ্চ মানের বীজ সংগ্রহ করুন");
                defaultCrop.put("প্রয়োজনীয় সার", "জৈব সার এবং রাসায়নিক সারের মিশ্রণ ব্যবহার করুন");
                defaultCrop.put("রোপণের সেরা সময়", "বর্ষা মৌসুমের শুরুতে");
                cropsArray.put(defaultCrop);
            }
            
            return cropsArray.toString();
        } catch (Exception e) {
            System.err.println("Error creating structured crop response: " + e.getMessage());
            // Return a fallback response
            try {
                JSONArray fallback = new JSONArray();
                JSONObject fallbackCrop = new JSONObject();
                fallbackCrop.put("ফসলের নাম", "ধান");
                fallbackCrop.put("কারণ", "আপনার এলাকার জন্য উপযুক্ত");
                fallbackCrop.put("উপযুক্ত বীজ", "স্থানীয় কৃষি দোকান থেকে উচ্চ মানের বীজ সংগ্রহ করুন");
                fallbackCrop.put("প্রয়োজনীয় সার", "জৈব সার এবং রাসায়নিক সারের মিশ্রণ ব্যবহার করুন");
                fallbackCrop.put("রোপণের সেরা সময়", "বর্ষা মৌসুমের শুরুতে");
                fallback.put(fallbackCrop);
                return fallback.toString();
            } catch (Exception fallbackError) {
                return "[{\"ফসলের নাম\":\"ধান\",\"কারণ\":\"আপনার এলাকার জন্য উপযুক্ত\",\"উপযুক্ত বীজ\":\"উচ্চ মানের বীজ\",\"প্রয়োজনীয় সার\":\"জৈব সার\",\"রোপণের সেরা সময়\":\"বর্ষা মৌসুম\"}]";
            }
        }
    }
    
    /**
     * Provides fallback disease analysis when API fails
     */
    private String getFallbackDiseaseAnalysis() {
        try {
            JSONObject fallback = new JSONObject();
            fallback.put("রোগের_নাম", "বিশ্লেষণ সম্পন্ন হয়নি");
            fallback.put("বিবরণ", "ছবি বিশ্লেষণ করতে সমস্যা হয়েছে। অনুগ্রহ করে আবার চেষ্টা করুন।");
            fallback.put("প্রতিকার", "ছবির গুণমান উন্নত করুন এবং আবার আপলোড করুন।");
            return fallback.toString();
        } catch (Exception e) {
            return "{\"রোগের_নাম\":\"ত্রুটি\",\"বিবরণ\":\"সিস্টেমে সমস্যা হয়েছে\",\"প্রতিকার\":\"পরে আবার চেষ্টা করুন\"}";
        }
    }
    
    // Helper method for simple text-based API calls
    private String callTextAPI(String prompt, String apiUrl) throws Exception {
        HttpClient client = HttpClient.newHttpClient();
        String jsonPayload = new JSONObject()
            .put("contents", new JSONArray().put(new JSONObject().put("parts", new JSONArray().put(new JSONObject().put("text", prompt)))))
            .toString();

        System.out.println("Sending request to Text API...");
        System.out.println("Request payload: " + jsonPayload);

        HttpRequest request = HttpRequest.newBuilder()
            .uri(URI.create(apiUrl))
            .header("Content-Type", "application/json")
            .POST(HttpRequest.BodyPublishers.ofString(jsonPayload))
            .build();

        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
        
        System.out.println("Text API Response Status: " + response.statusCode());
        System.out.println("Text API Response Body: " + response.body());
        
        if (response.statusCode() != 200) {
            System.err.println("Text API Error: Status " + response.statusCode());
            throw new Exception("API returned status: " + response.statusCode());
        }
        
        JSONObject responseJson = new JSONObject(response.body());
        
        // Check for API errors
        if (responseJson.has("error")) {
            System.err.println("Text API Error: " + responseJson.getJSONObject("error").getString("message"));
            throw new Exception("API Error: " + responseJson.getJSONObject("error").getString("message"));
        }
        
        // Check if response has candidates
        if (!responseJson.has("candidates") || responseJson.getJSONArray("candidates").length() == 0) {
            System.err.println("No candidates in Text API response");
            throw new Exception("No candidates in API response");
        }
        
        String aiResponse = responseJson.getJSONArray("candidates").getJSONObject(0).getJSONObject("content").getJSONArray("parts").getJSONObject(0).getString("text");
        
        System.out.println("AI Text Response: " + aiResponse);
        
        // Try to parse the AI response as JSON
        try {
            JSONObject parsedResponse = new JSONObject(aiResponse);
            System.out.println("Successfully parsed JSON response from Text API");
            return aiResponse;
        } catch (Exception jsonError) {
            System.err.println("Failed to parse AI response as JSON: " + jsonError.getMessage());
            System.out.println("AI returned text instead of JSON, creating structured crop response...");
            
            // If AI didn't return JSON, create a structured crop response
            return createStructuredCropResponse(aiResponse);
        }
    }
}
