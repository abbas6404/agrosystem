<%@page import="com.mycompany.agrosystem.model.User"%>
<%@page import="com.mycompany.agrosystem.model.Farmer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page session="true"%>
<!DOCTYPE html>
<html lang="bn">
<head>
    <title>AI কৃষি পরামর্শ - এগ্রো সিস্টেম</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary-color: #10b981;
            --secondary-color: #3b82f6;
            --gradient-primary: linear-gradient(135deg, #10b981 0%, #059669 100%);
            --gradient-ai: linear-gradient(135deg, #8b5cf6 0%, #7c3aed 100%);
            --border-radius: 12px;
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
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
            background: var(--gradient-ai);
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

        .ai-features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }

        .ai-feature {
            background: rgba(255, 255, 255, 0.15);
            padding: 25px;
            border-radius: var(--border-radius);
            border: 1px solid rgba(255, 255, 255, 0.2);
            text-align: center;
        }

        .ai-feature i {
            font-size: 2.5rem;
            margin-bottom: 15px;
            display: block;
        }

        .ai-feature h3 {
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
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
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

        .error-message {
            background: #fee2e2;
            color: #991b1b;
            padding: 20px;
            border-radius: var(--border-radius);
            border: 1px solid #fecaca;
            margin-bottom: 20px;
        }

        .suggestions-content {
            background: #f0f9ff;
            border: 1px solid #0ea5e9;
            border-radius: var(--border-radius);
            padding: 20px;
            margin-bottom: 20px;
        }

        .ready-state {
            text-align: center;
            padding: 40px;
            color: #6b7280;
        }

        .ready-state i {
            font-size: 3rem;
            margin-bottom: 20px;
            display: block;
            opacity: 0.5;
        }

        .suggestions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
        }

        .suggestion-card {
            background: #ffffff;
            border: 1px solid #e0e0e0;
            border-radius: var(--border-radius);
            padding: 20px;
            box-shadow: var(--shadow-md);
            display: flex;
            flex-direction: column;
            gap: 10px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            animation: fadeInUp 0.6s ease-out;
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

        .suggestion-card:nth-child(1) { animation-delay: 0.1s; }
        .suggestion-card:nth-child(2) { animation-delay: 0.2s; }
        .suggestion-card:nth-child(3) { animation-delay: 0.3s; }

        .suggestion-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
            border-color: var(--primary-color);
        }

        .suggestion-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--gradient-primary);
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }

        .suggestion-card:hover::before {
            transform: scaleX(1);
        }

        .suggestion-header {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 10px;
        }

        .suggestion-header i {
            font-size: 1.8rem;
            color: var(--primary-color);
        }

        .suggestion-header h5 {
            margin: 0;
            font-size: 1.1rem;
            font-weight: 600;
            color: #333;
        }

        .suggestion-details {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .detail-item {
            display: flex;
            align-items: flex-start;
            gap: 12px;
            padding: 8px 0;
            border-bottom: 1px solid #f0f0f0;
        }

        .detail-item:last-child {
            border-bottom: none;
        }

        .detail-item i {
            font-size: 1rem;
            color: var(--primary-color);
            margin-top: 2px;
            min-width: 16px;
        }

        .label {
            font-weight: 600;
            color: #374151;
            font-size: 0.9rem;
            min-width: 120px;
        }

        .value {
            font-size: 0.95rem;
            color: #1f2937;
            line-height: 1.4;
            flex: 1;
        }

        .success-header {
            background: #d1fae5; /* Light green background */
            color: #065f46; /* Dark green text */
            padding: 20px;
            border-radius: var(--border-radius);
            border: 1px solid #a7f3d0; /* Lighter green border */
            margin-bottom: 20px;
            text-align: center;
            box-shadow: var(--shadow-md);
        }

        .success-header i {
            font-size: 2.5rem;
            margin-bottom: 10px;
        }

        .success-header h4 {
            margin-bottom: 10px;
        }

        .success-header p {
            font-size: 1rem;
            opacity: 0.9;
        }

        .info-tip {
            background: #e0f2fe; /* Light blue background */
            color: #075985; /* Dark blue text */
            padding: 15px;
            border-radius: var(--border-radius);
            border: 1px solid #90cdf4; /* Lighter blue border */
            margin-top: 20px;
            text-align: center;
            box-shadow: var(--shadow-md);
        }

        .info-tip i {
            font-size: 1.5rem;
            margin-bottom: 10px;
        }

        .info-tip strong {
            font-weight: 600;
        }

        .loading-state {
            text-align: center;
            padding: 60px 40px;
            color: #6b7280;
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-md);
        }

        .loading-state i {
            font-size: 4rem;
            margin-bottom: 20px;
            display: block;
            color: var(--primary-color);
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.5; }
        }

        .loading-state h4 {
            color: #374151;
            margin-bottom: 15px;
            font-size: 1.3rem;
        }

        .loading-state p {
            color: #6b7280;
            font-size: 1rem;
            line-height: 1.5;
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
            .ai-features {
                grid-template-columns: 1fr;
            }
            .suggestions-grid {
                grid-template-columns: 1fr;
                gap: 15px;
            }
            .suggestion-card {
                padding: 15px;
            }
            .detail-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 5px;
            }
            .label {
                min-width: auto;
                font-size: 0.85rem;
            }
            .value {
                font-size: 0.9rem;
                margin-left: 0;
            }
            .success-header {
                padding: 15px;
            }
            .success-header h4 {
                font-size: 1.1rem;
            }
            .success-header p {
                font-size: 0.9rem;
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
                <a href="${pageContext.request.contextPath}/getSuggestion" class="nav-item active">
                    <i class="fas fa-lightbulb"></i> AI পরামর্শ
                </a>
                <a href="${pageContext.request.contextPath}/weather" class="nav-item">
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
                <h2><i class="fas fa-robot"></i> AI কৃষি পরামর্শ</h2>
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
                <h1><i class="fas fa-brain"></i> AI কৃষি পরামর্শ</h1>
                <p>আর্টিফিশিয়াল ইন্টেলিজেন্স ব্যবহার করে আপনার এলাকার জন্য সর্বোত্তম ফসলের পরামর্শ পান</p>
                
                <div class="ai-features">
                    <div class="ai-feature">
                        <i class="fas fa-map-marker-alt"></i>
                        <h3>অবস্থান ভিত্তিক</h3>
                        <p>আপনার এলাকার আবহাওয়া ও মাটি অনুযায়ী পরামর্শ</p>
                    </div>
                    <div class="ai-feature">
                        <i class="fas fa-seedling"></i>
                        <h3>ফসল নির্বাচন</h3>
                        <p>সর্বোত্তম ফসল নির্বাচনে বিজ্ঞানসম্মত পরামর্শ</p>
                    </div>
                    <div class="ai-feature">
                        <i class="fas fa-clock"></i>
                        <h3>সময় নির্দেশনা</h3>
                        <p>ফসল রোপণের সেরা সময় ও পরিচর্যা নির্দেশনা</p>
                    </div>
                </div>
            </div>

            <!-- Content Area -->
            <div class="content-area">
                <h3><i class="fas fa-lightbulb"></i> AI পরামর্শ</h3>
                
                <% if (request.getAttribute("errorMessage") != null) { %>
                    <div class="error-message">
                        <i class="fas fa-exclamation-triangle"></i> <%= request.getAttribute("errorMessage") %>
                        <p style="margin-top: 15px; font-size: 0.95rem;">
                            <strong>সমাধান:</strong> নিচের ফর্মে আপনার এলাকার নাম এবং মাটির অবস্থা দিন, তারপর "AI পরামর্শ পান" বোতামে ক্লিক করুন।
                        </p>
                    </div>
                    
                    <!-- Quick Profile Update Form -->
                    <div style="background: #f8fafc; padding: 25px; border-radius: var(--border-radius); border: 1px solid #e2e8f0; margin-bottom: 25px;">
                        <h4 style="color: #1e293b; margin-bottom: 20px; display: flex; align-items: center; gap: 10px;">
                            <i class="fas fa-edit" style="color: var(--primary-color);"></i>
                            আপনার প্রোফাইল তথ্য আপডেট করুন
                        </h4>
                        
                        <form id="profileUpdateForm" method="post" action="${pageContext.request.contextPath}/updateProfile">
                            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; margin-bottom: 20px;">
                                <div>
                                    <label style="display: block; font-weight: 600; color: #374151; margin-bottom: 8px;">
                                        <i class="fas fa-map-marker-alt"></i> আপনার এলাকার নাম *
                                    </label>
                                    <input type="text" name="location" value="<%= farmer.getLocation() != null ? farmer.getLocation() : "" %>" 
                                           placeholder="যেমন: ঢাকা, চট্টগ্রাম, রাজশাহী" required
                                           style="width: 100%; padding: 12px; border: 2px solid #d1d5db; border-radius: var(--border-radius); font-size: 1rem;">
                                </div>
                                
                                <div>
                                    <label style="display: block; font-weight: 600; color: #374151; margin-bottom: 8px;">
                                        <i class="fas fa-seedling"></i> মাটির অবস্থা *
                                    </label>
                                    <select name="soilConditions" required
                                            style="width: 100%; padding: 12px; border: 2px solid #d1d5db; border-radius: var(--border-radius); font-size: 1rem;">
                                        <option value="">মাটির অবস্থা নির্বাচন করুন</option>
                                        <option value="clay" <%= "clay".equals(farmer.getSoilConditions()) ? "selected" : "" %> >কাদামাটি</option>
                                        <option value="loamy" <%= "loamy".equals(farmer.getSoilConditions()) ? "selected" : "" %> >দোআঁশ মাটি</option>
                                        <option value="sandy" <%= "sandy".equals(farmer.getSoilConditions()) ? "selected" : "" %> >বালু মাটি</option>
                                        <option value="silty" <%= "silty".equals(farmer.getSoilConditions()) ? "selected" : "" %> >পলি মাটি</option>
                                        <option value="black" <%= "black".equals(farmer.getSoilConditions()) ? "selected" : "" %> >কালো মাটি</option>
                                        <option value="red" <%= "red".equals(farmer.getSoilConditions()) ? "selected" : "" %> >লাল মাটি</option>
                                    </select>
                                </div>
                            </div>
                            
                            <div style="display: flex; gap: 15px; flex-wrap: wrap;">
                                <button type="submit" style="background: var(--gradient-primary); color: white; padding: 12px 24px; border: none; border-radius: var(--border-radius); font-weight: 600; cursor: pointer; display: flex; align-items: center; gap: 10px;">
                                    <i class="fas fa-save"></i> প্রোফাইল আপডেট করুন
                                </button>
                                <button type="button" onclick="getAISuggestions()" style="background: var(--gradient-ai); color: white; padding: 12px 24px; border: none; border-radius: var(--border-radius); font-weight: 600; cursor: pointer; display: flex; align-items: center; gap: 10px;">
                                    <i class="fas fa-robot"></i> AI পরামর্শ পান
                                </button>
                            </div>
                        </form>
                    </div>
                <% } %>

                <% if (request.getAttribute("cropSuggestions") != null) { %>
                    <div class="suggestions-content">
                        <div class="success-header">
                            <i class="fas fa-check-circle"></i>
                            <h4>আপনার এলাকার জন্য AI পরামর্শ</h4>
                            <p>AI সফলভাবে আপনার এলাকার জন্য উপযুক্ত ফসল নির্বাচন করেছে</p>
                        </div>
                        
                        <% 
                            String suggestionsJson = (String) request.getAttribute("cropSuggestions");
                            try {
                                // Try to parse JSON and display nicely
                                if (suggestionsJson.startsWith("[") && suggestionsJson.endsWith("]")) {
                                    // It's a JSON array, display each suggestion
                                    org.json.JSONArray suggestions = new org.json.JSONArray(suggestionsJson);
                        %>
                            <div class="suggestions-grid">
                                <% for (int i = 0; i < suggestions.length(); i++) { 
                                    org.json.JSONObject suggestion = suggestions.getJSONObject(i);
                                %>
                                    <div class="suggestion-card">
                                        <div class="suggestion-header">
                                            <i class="fas fa-seedling"></i>
                                            <h5><%= suggestion.optString("ফসলের নাম", "Unknown Crop") %></h5>
                                        </div>
                                        <div class="suggestion-details">
                                            <div class="detail-item">
                                                <i class="fas fa-lightbulb"></i>
                                                <span class="label">কারণ:</span>
                                                <span class="value"><%= suggestion.optString("কারণ", "N/A") %></span>
                                            </div>
                                            <div class="detail-item">
                                                <i class="fas fa-seedling"></i>
                                                <span class="label">উপযুক্ত বীজ:</span>
                                                <span class="value"><%= suggestion.optString("উপযুক্ত বীজ", "N/A") %></span>
                                            </div>
                                            <div class="detail-item">
                                                <i class="fas fa-flask"></i>
                                                <span class="label">প্রয়োজনীয় সার:</span>
                                                <span class="value"><%= suggestion.optString("প্রয়োজনীয় সার", "N/A") %></span>
                                            </div>
                                            <div class="detail-item">
                                                <i class="fas fa-calendar-alt"></i>
                                                <span class="label">রোপণের সেরা সময়:</span>
                                                <span class="value"><%= suggestion.optString("রোপণের সেরা সময়", "N/A") %></span>
                                            </div>
                                        </div>
                                    </div>
                                <% } %>
                            </div>
                        <% 
                                } else {
                                    // Fallback: display as raw text
                        %>
                            <div style="background: white; padding: 20px; border-radius: var(--border-radius); border: 1px solid #d1d5db;">
                                <pre style="white-space: pre-wrap; font-family: inherit; margin: 0;"><%= suggestionsJson %></pre>
                            </div>
                        <% 
                                }
                            } catch (Exception e) {
                                // If JSON parsing fails, display as raw text
                        %>
                            <div style="background: white; padding: 20px; border-radius: var(--border-radius); border: 1px solid #d1d5db;">
                                <pre style="white-space: pre-wrap; font-family: inherit; margin: 0;"><%= suggestionsJson %></pre>
                            </div>
                        <% } %>
                        
                        <div class="info-tip">
                            <i class="fas fa-info-circle"></i> 
                            <strong>টিপ:</strong> এই পরামর্শগুলি আপনার এলাকার আবহাওয়া এবং মাটির অবস্থা অনুযায়ী তৈরি করা হয়েছে।
                        </div>
                    </div>
                <% } else { %>
                    <div class="ready-state">
                        <i class="fas fa-robot"></i>
                        <h4>AI পরামর্শের জন্য প্রস্তুত</h4>
                        <p>আপনার এলাকার তথ্য দিয়ে AI পরামর্শ পান</p>
                        <a href="${pageContext.request.contextPath}/farmerDashboard" class="btn-primary">
                            <i class="fas fa-arrow-left"></i> ড্যাশবোর্ডে ফিরে যান
                        </a>
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
        
        // Get AI suggestions with current form data
        function getAISuggestions() {
            const location = document.querySelector('input[name="location"]').value;
            const soilConditions = document.querySelector('select[name="soilConditions"]').value;
            
            if (!location || !soilConditions) {
                alert('অনুগ্রহ করে সব প্রয়োজনীয় তথ্য পূরণ করুন।');
                return;
            }
            
            // Show loading state
            showLoading();
            
            // Redirect to getSuggestion with the form data
            window.location.href = '${pageContext.request.contextPath}/getSuggestion?location=' + encodeURIComponent(location) + '&soilConditions=' + encodeURIComponent(soilConditions);
        }
        
        // Show loading state
        function showLoading() {
            const contentArea = document.querySelector('.content-area');
            contentArea.innerHTML = `
                <div class="loading-state">
                    <i class="fas fa-spinner fa-spin"></i>
                    <h4>AI পরামর্শ তৈরি হচ্ছে...</h4>
                    <p>আপনার এলাকার তথ্য অনুযায়ী ফসলের পরামর্শ তৈরি করা হচ্ছে। অনুগ্রহ করে অপেক্ষা করুন।</p>
                </div>
            `;
        }
        
        // Handle form submission
        document.getElementById('profileUpdateForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const location = document.querySelector('input[name="location"]').value;
            const soilConditions = document.querySelector('select[name="soilConditions"]').value;
            
            if (!location || !soilConditions) {
                alert('অনুগ্রহ করে সব প্রয়োজনীয় তথ্য পূরণ করুন।');
                return;
            }
            
            // For now, just get AI suggestions directly
            // In a real app, you'd save the profile first
            getAISuggestions();
        });
    </script>
</body>
</html>
