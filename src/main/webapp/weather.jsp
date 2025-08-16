<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.mycompany.agrosystem.model.User"%>
<%@page import="com.mycompany.agrosystem.model.Farmer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page session="true"%>
<!DOCTYPE html>
<html lang="bn">
<head>
    <title>আবহাওয়ার পূর্বাভাস - এগ্রো সিস্টেম</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary-color: #10b981;
            --secondary-color: #3b82f6;
            --weather-blue: #0ea5e9;
            --weather-purple: #8b5cf6;
            --gradient-primary: linear-gradient(135deg, #10b981 0%, #059669 100%);
            --gradient-weather: linear-gradient(135deg, #0ea5e9 0%, #0284c7 100%);
            --gradient-sunny: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
            --gradient-rainy: linear-gradient(135deg, #6366f1 0%, #4f46e5 100%);
            --border-radius: 12px;
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            --shadow-lg: 0 10px 25px rgba(0, 0, 0, 0.15);
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f9fafb;
        }

        .dashboard-container {
            display: flex;
            min-height: 100vh;
        }

        .sidebar {
            width: 280px;
            background: white;
            box-shadow: var(--shadow-md);
            border-right: 1px solid #e5e7eb;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
        }

        .sidebar-header {
            background: var(--gradient-primary);
            color: white;
            padding: 25px 20px;
            text-align: center;
        }

        .sidebar-header h3 {
            margin: 0;
            font-size: 1.5rem;
            font-weight: 700;
        }

        .sidebar-nav {
            padding: 20px 0;
        }

        .nav-item {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px 25px;
            color: #4b5563;
            text-decoration: none;
            transition: all 0.3s;
            border-left: 4px solid transparent;
        }

        .nav-item:hover {
            background: #f3f4f6;
            color: var(--primary-color);
            border-left-color: var(--primary-color);
        }

        .nav-item.active {
            background: var(--primary-color);
            color: white;
            border-left-color: white;
        }

        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 20px;
        }

        .main-header {
            background: white;
            padding: 25px 30px;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-md);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .main-header h2 {
            color: #1f2937;
            font-size: 2rem;
            margin: 0;
            font-weight: 700;
        }

        .welcome-section {
            background: var(--gradient-weather);
            color: white;
            padding: 40px 30px;
            border-radius: var(--border-radius);
            margin-bottom: 30px;
            text-align: center;
            box-shadow: var(--shadow-md);
        }

        .welcome-section h1 {
            font-size: 3rem;
            margin-bottom: 15px;
            font-weight: 800;
        }

        .welcome-section p {
            font-size: 1.3rem;
            opacity: 0.9;
            margin-bottom: 25px;
        }

        .weather-features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }

        .weather-feature {
            background: rgba(255, 255, 255, 0.15);
            padding: 25px;
            border-radius: var(--border-radius);
            border: 1px solid rgba(255, 255, 255, 0.2);
            text-align: center;
        }

        .weather-feature i {
            font-size: 2.5rem;
            margin-bottom: 15px;
            display: block;
        }

        .weather-feature h3 {
            font-size: 1.2rem;
            margin-bottom: 10px;
            font-weight: 600;
        }

        .content-area {
            background: white;
            padding: 30px;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-md);
            margin-bottom: 30px;
        }

        .content-area h3 {
            color: #1f2937;
            font-size: 1.8rem;
            margin-bottom: 25px;
        }

        .btn-primary {
            background: var(--gradient-primary);
            color: white;
            padding: 12px 24px;
            border-radius: var(--border-radius);
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .btn-secondary {
            background: white;
            color: #374151;
            border: 2px solid #d1d5db;
            padding: 12px 24px;
            border-radius: var(--border-radius);
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s;
        }

        .btn-secondary:hover {
            background: #f3f4f6;
            border-color: #9ca3af;
        }

        .logout-btn {
            background: var(--secondary-color);
            color: white;
            padding: 12px 24px;
            border-radius: var(--border-radius);
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s;
        }

        .logout-btn:hover {
            background: #1d4ed8;
            transform: translateY(-2px);
        }

        .weather-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .weather-card {
            background: white;
            border: 1px solid #e0e0e0;
            border-radius: var(--border-radius);
            padding: 25px;
            box-shadow: var(--shadow-md);
            text-align: center;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            animation: fadeInUp 0.6s ease-out;
            min-height: 280px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .weather-card:nth-child(1) { animation-delay: 0.1s; }
        .weather-card:nth-child(2) { animation-delay: 0.2s; }
        .weather-card:nth-child(3) { animation-delay: 0.3s; }
        .weather-card:nth-child(4) { animation-delay: 0.4s; }
        .weather-card:nth-child(5) { animation-delay: 0.5s; }
        .weather-card:nth-child(6) { animation-delay: 0.6s; }
        .weather-card:nth-child(7) { animation-delay: 0.7s; }

        .weather-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
            border-color: var(--weather-blue);
        }

        .weather-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--gradient-weather);
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }

        .weather-card:hover::before {
            transform: scaleX(1);
        }

        .day-name {
            font-size: 1.2rem;
            font-weight: 600;
            color: #374151;
            margin-bottom: 15px;
            text-transform: capitalize;
        }

        .weather-icon {
            font-size: 3rem;
            margin: 15px 0;
            display: block;
        }

        .weather-icon.sunny { color: #f59e0b; }
        .weather-icon.cloudy { color: #6b7280; }
        .weather-icon.rainy { color: #3b82f6; }
        .weather-icon.stormy { color: #7c3aed; }

        .temperature {
            font-size: 1.5rem;
            font-weight: 700;
            color: #1f2937;
            margin-bottom: 10px;
        }

        .temp-max {
            color: #dc2626;
        }

        .temp-min {
            color: #2563eb;
        }

        .weather-details {
            margin-top: auto;
            padding-top: 15px;
            border-top: 1px solid #f0f0f0;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 8px;
            font-size: 0.9rem;
            padding: 4px 0;
        }

        .detail-row:last-child {
            margin-bottom: 0;
        }

        .detail-label {
            color: #6b7280;
            font-weight: 500;
            text-align: left;
        }

        .detail-value {
            color: #374151;
            font-weight: 600;
            text-align: right;
        }

        .current-weather {
            background: var(--gradient-weather);
            color: white;
            padding: 30px;
            border-radius: var(--border-radius);
            margin-bottom: 30px;
            text-align: center;
            box-shadow: var(--shadow-md);
        }

        .current-weather h3 {
            margin-bottom: 20px;
            font-size: 1.8rem;
        }

        .current-temp {
            font-size: 4rem;
            font-weight: 800;
            margin-bottom: 10px;
        }

        .current-description {
            font-size: 1.2rem;
            opacity: 0.9;
        }

        .error-message {
            background: #fee2e2;
            color: #991b1b;
            padding: 20px;
            border-radius: var(--border-radius);
            border: 1px solid #fecaca;
            margin-bottom: 20px;
            text-align: center;
        }

        .loading-state {
            text-align: center;
            padding: 60px 40px;
            color: #6b7280;
        }

        .loading-state i {
            font-size: 4rem;
            margin-bottom: 20px;
            display: block;
            color: var(--weather-blue);
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.5; }
        }

        .fallback-message {
            background: #e0f2fe;
            color: #075985;
            padding: 15px;
            border-radius: var(--border-radius);
            border: 1px solid #90cdf4;
            margin-bottom: 30px;
            text-align: center;
            box-shadow: var(--shadow-md);
        }

        .fallback-message i {
            font-size: 1.2rem;
            margin-right: 8px;
        }

        .weather-insights {
            margin-top: 30px;
            padding: 25px;
            background: #f8fafc;
            border-radius: var(--border-radius);
            border: 1px solid #e2e8f0;
        }

        .weather-insights h4 {
            color: #1e293b;
            margin-bottom: 20px;
            font-size: 1.4rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .weather-insights h4 i {
            color: var(--primary-color);
        }

        .insights-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }

        .insight-card {
            background: white;
            padding: 20px;
            border-radius: var(--border-radius);
            border: 1px solid #e2e8f0;
            box-shadow: var(--shadow-md);
            text-align: center;
        }

        .insight-card i {
            font-size: 2rem;
            color: var(--weather-blue);
            margin-bottom: 15px;
        }

        .insight-card h5 {
            color: #374151;
            margin-bottom: 15px;
            font-size: 1.1rem;
        }

        .insight-card p {
            color: #6b7280;
            margin-bottom: 8px;
            font-size: 0.9rem;
        }

        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
                transition: transform 0.3s;
            }
            .sidebar.open {
                transform: translateX(0);
            }
            .main-content {
                margin-left: 0;
            }
            .welcome-section h1 {
                font-size: 2rem;
            }
            .weather-features {
                grid-template-columns: 1fr;
            }
            .weather-grid {
                grid-template-columns: 1fr;
                gap: 15px;
            }
            .weather-card {
                padding: 20px;
            }
            .current-temp {
                font-size: 3rem;
            }
            .insights-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <% 
        User user = (User) session.getAttribute("loggedInUser"); 
        if (user == null || !"FARMER".equals(user.getUserType())) { 
            response.sendRedirect(request.getContextPath() + "/login.jsp"); 
            return; 
        } 
        Farmer farmer = (Farmer) user;
    %>
    
    <div class="dashboard-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="sidebar-header">
                <h3><i class="fas fa-tractor"></i> এগ্রো সিস্টেম</h3>
            </div>
            <nav class="sidebar-nav">
                <a href="${pageContext.request.contextPath}/farmerDashboard" class="nav-item">
                    <i class="fas fa-tachometer-alt"></i> ড্যাশবোর্ড
                </a>
                <a href="${pageContext.request.contextPath}/myCrops" class="nav-item">
                    <i class="fas fa-leaf"></i> আমার ফসল
                </a>
                <a href="${pageContext.request.contextPath}/getSuggestion" class="nav-item">
                    <i class="fas fa-lightbulb"></i> AI পরামর্শ
                </a>
                <a href="${pageContext.request.contextPath}/weather" class="nav-item active">
                    <i class="fas fa-cloud-sun"></i> আবহাওয়া
                </a>
                <a href="${pageContext.request.contextPath}/disease_detection.jsp" class="nav-item">
                    <i class="fas fa-stethoscope"></i> রোগ শনাক্তকরণ
                </a>
                <a href="${pageContext.request.contextPath}/profile.jsp" class="nav-item">
                    <i class="fas fa-user"></i> প্রোফাইল
                </a>
                <a href="${pageContext.request.contextPath}/change_password.jsp" class="nav-item">
                    <i class="fas fa-key"></i> পাসওয়ার্ড পরিবর্তন
                </a>
                <a href="${pageContext.request.contextPath}/logout" class="nav-item">
                    <i class="fas fa-sign-out-alt"></i> লগ আউট
                </a>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <!-- Header -->
            <header class="main-header">
                <h2><i class="fas fa-cloud-sun"></i> আবহাওয়ার পূর্বাভাস</h2>
                <div>
                    <a href="${pageContext.request.contextPath}/farmerDashboard" class="btn-secondary">
                        <i class="fas fa-arrow-left"></i> ড্যাশবোর্ডে ফিরে যান
                    </a>
                    <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                        <i class="fas fa-sign-out-alt"></i> লগ আউট
                    </a>
                </div>
            </header>

            <!-- Welcome Section -->
            <div class="welcome-section">
                <h1><i class="fas fa-cloud-sun"></i> আবহাওয়ার পূর্বাভাস</h1>
                <p>আপনার এলাকার আবহাওয়া দেখে ফসলের সঠিক পরিচর্যা করুন</p>
                
                <div class="weather-features">
                    <div class="weather-feature">
                        <i class="fas fa-calendar-week"></i>
                        <h3>৭ দিনের পূর্বাভাস</h3>
                        <p>আগামী সপ্তাহের বিস্তারিত আবহাওয়া</p>
                    </div>
                    <div class="weather-feature">
                        <i class="fas fa-thermometer-half"></i>
                        <h3>তাপমাত্রা</h3>
                        <p>সর্বোচ্চ ও সর্বনিম্ন তাপমাত্রা</p>
                    </div>
                    <div class="weather-feature">
                        <i class="fas fa-cloud-rain"></i>
                        <h3>বৃষ্টিপাত</h3>
                        <p>বৃষ্টিপাতের সম্ভাবনা ও পরিমাণ</p>
                    </div>
                </div>
            </div>

            <!-- Content Area -->
            <div class="content-area">
                <h3><i class="fas fa-cloud-sun"></i> আবহাওয়ার পূর্বাভাস</h3>
                
                <% if (request.getAttribute("forecastData") != null) { %>
                    <% 
                        try { 
                            JSONObject forecast = new JSONObject((String)request.getAttribute("forecastData")); 
                            
                            // Check if there's an error
                            if (forecast.has("error")) {
                    %>
                        <div class="error-message">
                            <i class="fas fa-exclamation-triangle"></i>
                            <%= forecast.getString("error") %>
                        </div>
                    <% 
                            } else {
                                JSONObject daily = forecast.getJSONObject("daily"); 
                                JSONArray time = daily.getJSONArray("time"); 
                                JSONArray weathercode = daily.getJSONArray("weathercode"); 
                                JSONArray tempMax = daily.getJSONArray("temperature_2m_max"); 
                                JSONArray tempMin = daily.getJSONArray("temperature_2m_min");
                                JSONArray precipitation = daily.has("precipitation_sum") ? daily.getJSONArray("precipitation_sum") : null;
                                
                                // Get current day (first day)
                                String currentDay = time.getString(0);
                                int currentWeatherCode = weathercode.getInt(0);
                                double currentTempMax = tempMax.getDouble(0);
                                double currentTempMin = tempMin.getDouble(0);
                    %>
                        <!-- Current Weather -->
                        <div class="current-weather">
                            <h3><i class="fas fa-sun"></i> আজকের আবহাওয়া</h3>
                            <div class="current-temp"><%= String.format("%.0f", currentTempMax) %>°C</div>
                            <div class="current-description">
                                <%= getWeatherDescription(currentWeatherCode) %>
                            </div>
                        </div>

                        <!-- Fallback Message if applicable -->
                        <% if (forecast.has("fallback") && forecast.getBoolean("fallback")) { %>
                            <div class="fallback-message">
                                <i class="fas fa-info-circle"></i>
                                <%= forecast.optString("message", "আবহাওয়ার তথ্য অস্থায়ীভাবে অপ্রাপ্য। সাধারণ পূর্বাভাস দেখানো হচ্ছে।") %>
                            </div>
                        <% } %>

                        <!-- 7-Day Forecast -->
                        <div class="weather-grid">
                            <% for (int i = 0; i < time.length(); i++) { 
                                String dayName = getDayName(time.getString(i));
                                String iconClass = getWeatherIconClass(weathercode.getInt(i));
                                double maxTemp = tempMax.getDouble(i);
                                double minTemp = tempMin.getDouble(i);
                                double precip = precipitation != null ? precipitation.getDouble(i) : 0.0;
                                double precipProb = daily.has("precipitation_probability_max") ? daily.getJSONArray("precipitation_probability_max").getDouble(i) : 0.0;
                            %>
                                <div class="weather-card">
                                    <div class="day-name"><%= dayName %></div>
                                    <div class="weather-icon <%= iconClass %>">
                                        <i class="<%= getWeatherIcon(weathercode.getInt(i)) %>"></i>
                                    </div>
                                    <div class="temperature">
                                        <span class="temp-max"><%= String.format("%.0f", maxTemp) %>°</span> / 
                                        <span class="temp-min"><%= String.format("%.0f", minTemp) %>°</span>
                                    </div>
                                    <div class="weather-details">
                                        <div class="detail-row">
                                            <span class="detail-label">আবহাওয়া:</span>
                                            <span class="detail-value"><%= getWeatherDescription(weathercode.getInt(i)) %></span>
                                        </div>
                                        <% if (precipProb > 0) { %>
                                        <div class="detail-row">
                                            <span class="detail-label">বৃষ্টির সম্ভাবনা:</span>
                                            <span class="detail-value"><%= String.format("%.0f", precipProb) %>%</span>
                                        </div>
                                        <% } %>
                                        <% if (precip > 0) { %>
                                        <div class="detail-row">
                                            <span class="detail-label">বৃষ্টিপাত:</span>
                                            <span class="detail-value"><%= String.format("%.1f", precip) %> mm</span>
                                        </div>
                                        <% } %>
                                    </div>
                                </div>
                            <% } %>
                        </div>

                        <!-- Agricultural Weather Insights -->
                        <div class="weather-insights">
                            <h4><i class="fas fa-seedling"></i> আবহাওয়া ভিত্তিক কৃষি পরামর্শ</h4>
                            <div class="insights-grid">
                                <% 
                                    // Calculate average temperatures and precipitation for insights
                                    double avgMaxTemp = 0, avgMinTemp = 0, totalPrecip = 0;
                                    int sunnyDays = 0, rainyDays = 0;
                                    
                                    for (int i = 0; i < time.length(); i++) {
                                        avgMaxTemp += tempMax.getDouble(i);
                                        avgMinTemp += tempMin.getDouble(i);
                                        if (precipitation != null) totalPrecip += precipitation.getDouble(i);
                                        if (weathercode.getInt(i) == 0) sunnyDays++;
                                        if (weathercode.getInt(i) >= 51) rainyDays++;
                                    }
                                    
                                    avgMaxTemp /= time.length();
                                    avgMinTemp /= time.length();
                                %>
                                
                                <div class="insight-card">
                                    <i class="fas fa-thermometer-half"></i>
                                    <h5>তাপমাত্রা</h5>
                                    <p>গড় তাপমাত্রা: <%= String.format("%.1f", (avgMaxTemp + avgMinTemp) / 2) %>°C</p>
                                    <p>সর্বোচ্চ: <%= String.format("%.1f", avgMaxTemp) %>°C</p>
                                    <p>সর্বনিম্ন: <%= String.format("%.1f", avgMinTemp) %>°C</p>
                                </div>
                                
                                <div class="insight-card">
                                    <i class="fas fa-cloud-rain"></i>
                                    <h5>বৃষ্টিপাত</h5>
                                    <p>মোট বৃষ্টিপাত: <%= String.format("%.1f", totalPrecip) %> mm</p>
                                    <p>বৃষ্টির দিন: <%= rainyDays %> দিন</p>
                                    <p>সূর্যালোক: <%= sunnyDays %> দিন</p>
                                </div>
                                
                                <div class="insight-card">
                                    <i class="fas fa-leaf"></i>
                                    <h5>কৃষি পরামর্শ</h5>
                                    <% if (avgMaxTemp > 30) { %>
                                        <p>উচ্চ তাপমাত্রায় ফসলের সেচ বাড়ান</p>
                                    <% } else if (avgMaxTemp < 25) { %>
                                        <p>কম তাপমাত্রায় ফসলের সুরক্ষা নিশ্চিত করুন</p>
                                    <% } %>
                                    <% if (totalPrecip > 20) { %>
                                        <p>বৃষ্টিপাতের কারণে সেচ কমিয়ে দিন</p>
                                    <% } else if (totalPrecip < 5) { %>
                                        <p>শুষ্ক আবহাওয়ায় সেচ বাড়ান</p>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                    <% 
                            }
                        } catch (Exception e) { 
                    %>
                        <div class="error-message">
                            <i class="fas fa-exclamation-triangle"></i>
                            পূর্বাভাস লোড করা সম্ভব হয়নি। অনুগ্রহ করে আবার চেষ্টা করুন।
                        </div>
                    <% } %>
                <% } else { %>
                    <div class="loading-state">
                        <i class="fas fa-spinner fa-spin"></i>
                        <h4>আবহাওয়ার তথ্য লোড হচ্ছে...</h4>
                        <p>অনুগ্রহ করে অপেক্ষা করুন</p>
                    </div>
                <% } %>
            </div>
        </main>
    </div>

    <script>
        // Simple mobile menu toggle
        function toggleSidebar() {
            const sidebar = document.querySelector('.sidebar');
            sidebar.classList.toggle('open');
        }
    </script>
</body>
</html>

<%!
    // Helper method to get Bengali day names
    private String getDayName(String dateStr) {
        try {
            java.text.SimpleDateFormat inputFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
            java.util.Date date = inputFormat.parse(dateStr);
            java.text.SimpleDateFormat outputFormat = new java.text.SimpleDateFormat("EEEE");
            
            String englishDay = outputFormat.format(date);
            
            // Convert to Bengali
            switch (englishDay.toLowerCase()) {
                case "sunday": return "রবিবার";
                case "monday": return "সোমবার";
                case "tuesday": return "মঙ্গলবার";
                case "wednesday": return "বুধবার";
                case "thursday": return "বৃহস্পতিবার";
                case "friday": return "শুক্রবার";
                case "saturday": return "শনিবার";
                default: return englishDay;
            }
        } catch (Exception e) {
            return dateStr;
        }
    }
    
    // Helper method to get weather icon class
    private String getWeatherIconClass(int weatherCode) {
        if (weatherCode == 0) return "sunny";
        if (weatherCode >= 1 && weatherCode <= 3) return "cloudy";
        if (weatherCode >= 51 && weatherCode <= 67) return "rainy";
        if (weatherCode >= 95 && weatherCode <= 99) return "stormy";
        return "cloudy";
    }
    
    // Helper method to get weather icon
    private String getWeatherIcon(int weatherCode) {
        if (weatherCode == 0) return "fas fa-sun";
        if (weatherCode >= 1 && weatherCode <= 3) return "fas fa-cloud-sun";
        if (weatherCode >= 51 && weatherCode <= 67) return "fas fa-cloud-rain";
        if (weatherCode >= 95 && weatherCode <= 99) return "fas fa-bolt";
        return "fas fa-cloud";
    }
    
    // Helper method to get weather description in Bengali
    private String getWeatherDescription(int weatherCode) {
        if (weatherCode == 0) return "পরিষ্কার আকাশ";
        if (weatherCode >= 1 && weatherCode <= 3) return "আংশিক মেঘলা";
        if (weatherCode >= 51 && weatherCode <= 55) return "হালকা বৃষ্টি";
        if (weatherCode >= 56 && weatherCode <= 67) return "মাঝারি বৃষ্টি";
        if (weatherCode >= 95 && weatherCode <= 99) return "বজ্রসহ বৃষ্টি";
        return "মেঘলা";
    }
%>
