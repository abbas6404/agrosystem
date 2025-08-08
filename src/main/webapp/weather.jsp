<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.mycompany.agrosystem.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="bn">
<head>
    <title>আবহাওয়ার পূর্বাভাস</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <% User user = (User) session.getAttribute("loggedInUser"); 
       if (user == null || !"FARMER".equals(user.getUserType())) { 
           response.sendRedirect(request.getContextPath() + "/login.jsp"); 
           return; 
       } %>
    
    <div class="dashboard-container">
        <!-- Include Farmer Sidebar -->
        <jsp:include page="includes/farmer-sidebar.jsp">
            <jsp:param name="active" value="weather"/>
        </jsp:include>
        
        <main class="main-content">
            <!-- Include Header -->
            <jsp:include page="includes/header.jsp">
                <jsp:param name="pageTitle" value="আবহাওয়ার পূর্বাভাস"/>
                <jsp:param name="userName" value="<%= user.getName() %>"/>
            </jsp:include>
            
            <!-- Include Alerts -->
            <jsp:include page="includes/alerts.jsp"/>
            
            <!-- Content Area -->
            <div class="content-area">
                <h3><i class="fas fa-calendar-alt"></i> আগামী ৭ দিনের পূর্বাভাস</h3>
                <div class="weather-grid">
                    <% try { 
                        JSONObject forecast = new JSONObject((String)request.getAttribute("forecastData")); 
                        JSONObject daily = forecast.getJSONObject("daily"); 
                        JSONArray time = daily.getJSONArray("time"); 
                        JSONArray weathercode = daily.getJSONArray("weathercode"); 
                        JSONArray tempMax = daily.getJSONArray("temperature_2m_max"); 
                        JSONArray tempMin = daily.getJSONArray("temperature_2m_min"); 
                        
                        for (int i = 0; i < time.length(); i++) { 
                            String iconClass = "fas fa-sun"; 
                            if(weathercode.getInt(i) > 0) iconClass = "fas fa-cloud-sun"; 
                    %>
                        <div class="weather-card">
                            <div><%= new java.text.SimpleDateFormat("EEEE").format(new java.text.SimpleDateFormat("yyyy-MM-dd").parse(time.getString(i))) %></div>
                            <div class="icon"><i class="<%= iconClass %>"></i></div>
                            <div><%= String.format("%.0f", tempMax.getDouble(i)) %>°C / <%= String.format("%.0f", tempMin.getDouble(i)) %>°C</div>
                        </div>
                    <% }} catch (Exception e) { %>
                        <p style="color:red;">পূর্বাভাস লোড করা সম্ভব হয়নি।</p>
                    <% } %>
                </div>
            </div>
        </main>
    </div>
</body>
</html>