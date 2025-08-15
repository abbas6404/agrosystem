<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="bn">
<head>
    <title>আবহাওয়ার পূর্বাভাস</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="[https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css](https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css)">
</head>
<body>
    <div class="dashboard-container">
        <aside class="sidebar"><div class="sidebar-header"><h3><i class="fas fa-tractor"></i> এগ্রো সিস্টেম</h3></div><nav class="sidebar-nav"><a href="${pageContext.request.contextPath}/farmerDashboard" class="nav-item"><i class="fas fa-tachometer-alt"></i> ড্যাশবোর্ড</a><a href="${pageContext.request.contextPath}/weather" class="nav-item active"><i class="fas fa-cloud-sun"></i> আবহাওয়া</a></nav></aside>
        <main class="main-content">
            <header class="main-header"><h2><i class="fas fa-cloud-sun"></i> আগামী ৭ দিনের পূর্বাভাস</h2><div class="header-actions"><a href="${pageContext.request.contextPath}/logout" class="logout-btn"><i class="fas fa-sign-out-alt"></i> লগ আউট</a></div></header>
            <div class="content-area">
                <div class="weather-grid">
                    <% try { JSONObject forecast = new JSONObject((String)request.getAttribute("forecastData")); JSONObject daily = forecast.getJSONObject("daily"); JSONArray time = daily.getJSONArray("time"); JSONArray weathercode = daily.getJSONArray("weathercode"); JSONArray tempMax = daily.getJSONArray("temperature_2m_max"); JSONArray tempMin = daily.getJSONArray("temperature_2m_min"); for (int i = 0; i < time.length(); i++) { String iconClass = "fas fa-sun"; if(weathercode.getInt(i) > 0) iconClass = "fas fa-cloud-sun"; %>
                    <div class="weather-card"><div><%= new java.text.SimpleDateFormat("EEEE").format(new java.text.SimpleDateFormat("yyyy-MM-dd").parse(time.getString(i))) %></div><div class="icon"><i class="<%= iconClass %>"></i></div><div><%= String.format("%.0f", tempMax.getDouble(i)) %>°C / <%= String.format("%.0f", tempMin.getDouble(i)) %>°C</div></div>
                    <% }} catch (Exception e) { %><p style="color:red;">পূর্বাভাস লোড করা সম্ভব হয়নি।</p><% } %>
                </div>
            </div>
        </main>
    </div>
</body>
</html>