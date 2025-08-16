<%@page import="com.mycompany.agrosystem.model.User"%>
<%@page import="com.mycompany.agrosystem.model.Farmer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page session="true"%>
<!DOCTYPE html>
<html lang="bn">
<head>
    <title>প্রোফাইল - এগ্রো সিস্টেম</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary-color: #10b981;
            --secondary-color: #3b82f6;
            --danger-color: #ef4444;
            --warning-color: #f59e0b;
            --success-color: #22c55e;
            --gradient-primary: linear-gradient(135deg, #10b981 0%, #059669 100%);
            --gradient-secondary: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
            --gradient-warning: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
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
            background: var(--gradient-secondary);
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

        .profile-features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }

        .profile-feature {
            background: rgba(255, 255, 255, 0.15);
            padding: 25px;
            border-radius: var(--border-radius);
            border: 1px solid rgba(255, 255, 255, 0.2);
            text-align: center;
        }

        .profile-feature i {
            font-size: 2.5rem;
            margin-bottom: 15px;
            display: block;
        }

        .profile-feature h3 {
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
            border: none;
            cursor: pointer;
            font-size: 1rem;
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
            cursor: pointer;
            font-size: 1rem;
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

        .profile-form {
            max-width: 800px;
            margin: 0 auto;
        }

        .form-section {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: var(--border-radius);
            padding: 25px;
            margin-bottom: 25px;
        }

        .form-section h4 {
            color: #1e293b;
            margin-bottom: 20px;
            font-size: 1.3rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-section h4 i {
            color: var(--primary-color);
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #374151;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #d1d5db;
            border-radius: var(--border-radius);
            font-size: 1rem;
            transition: all 0.3s;
            box-sizing: border-box;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.1);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }

        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 30px;
            padding-top: 25px;
            border-top: 1px solid #e5e7eb;
        }

        .profile-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 25px;
            border-radius: var(--border-radius);
            border: 1px solid #e5e7eb;
            box-shadow: var(--shadow-md);
            text-align: center;
            transition: all 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }

        .stat-card i {
            font-size: 2.5rem;
            color: var(--primary-color);
            margin-bottom: 15px;
        }

        .stat-card h4 {
            color: #1f2937;
            margin-bottom: 10px;
            font-size: 1.2rem;
        }

        .stat-card p {
            color: #6b7280;
            font-size: 1.5rem;
            font-weight: 700;
            margin: 0;
        }

        .success-message {
            background: #d1fae5;
            color: #065f46;
            padding: 20px;
            border-radius: var(--border-radius);
            border: 1px solid #a7f3d0;
            margin-bottom: 20px;
            text-align: center;
            animation: fadeInUp 0.6s ease-out;
        }

        .success-message i {
            font-size: 1.5rem;
            margin-bottom: 10px;
            display: block;
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

        .error-message i {
            font-size: 1.5rem;
            margin-bottom: 10px;
            display: block;
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
            .profile-features {
                grid-template-columns: 1fr;
            }
            .form-row {
                grid-template-columns: 1fr;
                gap: 15px;
            }
            .form-actions {
                flex-direction: column;
                align-items: center;
            }
            .profile-stats {
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
                <a href="${pageContext.request.contextPath}/weather" class="nav-item">
                    <i class="fas fa-cloud-sun"></i> আবহাওয়া
                </a>
                <a href="${pageContext.request.contextPath}/disease_detection.jsp" class="nav-item">
                    <i class="fas fa-stethoscope"></i> রোগ শনাক্তকরণ
                </a>
                <a href="${pageContext.request.contextPath}/profile.jsp" class="nav-item active">
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
                <h2><i class="fas fa-user"></i> প্রোফাইল</h2>
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
                <h1><i class="fas fa-user"></i> প্রোফাইল</h1>
                <p>আপনার ব্যক্তিগত তথ্য এবং কৃষি খামারের বিবরণ আপডেট করুন</p>
                
                <div class="profile-features">
                    <div class="profile-feature">
                        <i class="fas fa-user-edit"></i>
                        <h3>তথ্য আপডেট</h3>
                        <p>ব্যক্তিগত তথ্য এবং যোগাযোগের বিবরণ পরিবর্তন করুন</p>
                    </div>
                    <div class="profile-feature">
                        <i class="fas fa-map-marker-alt"></i>
                        <h3>খামারের অবস্থান</h3>
                        <p>খামারের ঠিকানা এবং অবস্থান আপডেট করুন</p>
                    </div>
                    <div class="profile-feature">
                        <i class="fas fa-cog"></i>
                        <h3>সেটিংস</h3>
                        <p>অ্যাপ্লিকেশনের সেটিংস এবং পছন্দসমূহ পরিবর্তন করুন</p>
                    </div>
                </div>
            </div>

            <!-- Profile Statistics -->
            <div class="profile-stats">
                <div class="stat-card">
                    <i class="fas fa-leaf"></i>
                    <h4>মোট ফসল</h4>
                    <p>12</p>
                </div>
                <div class="stat-card">
                    <i class="fas fa-calendar-alt"></i>
                    <h4>সদস্যপদ</h4>
                    <p>2 বছর</p>
                </div>
                <div class="stat-card">
                    <i class="fas fa-chart-line"></i>
                    <h4>উৎপাদন</h4>
                    <p>85%</p>
                </div>
                <div class="stat-card">
                    <i class="fas fa-star"></i>
                    <h4>রেটিং</h4>
                    <p>4.8</p>
                </div>
            </div>

            <!-- Content Area -->
            <div class="content-area">
                <h3><i class="fas fa-user-edit"></i> প্রোফাইল আপডেট</h3>
                
                <!-- Success/Error Messages -->
                <% if (request.getAttribute("successMessage") != null) { %>
                    <div class="success-message">
                        <i class="fas fa-check-circle"></i>
                        <%= request.getAttribute("successMessage") %>
                    </div>
                <% } %>
                
                <% if (request.getAttribute("errorMessage") != null) { %>
                    <div class="error-message">
                        <i class="fas fa-exclamation-triangle"></i>
                        <%= request.getAttribute("errorMessage") %>
                    </div>
                <% } %>

                <!-- Profile Form -->
                <form class="profile-form" method="post" action="${pageContext.request.contextPath}/updateProfile">
                    <!-- Personal Information -->
                    <div class="form-section">
                        <h4><i class="fas fa-user"></i> ব্যক্তিগত তথ্য</h4>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="firstName">নামের প্রথম অংশ</label>
                                <input type="text" id="firstName" name="firstName" value="<%= farmer.getFirstName() != null ? farmer.getFirstName() : "" %>" required>
                            </div>
                            <div class="form-group">
                                <label for="lastName">নামের শেষ অংশ</label>
                                <input type="text" id="lastName" name="lastName" value="<%= farmer.getLastName() != null ? farmer.getLastName() : "" %>" required>
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="email">ইমেইল</label>
                                <input type="email" id="email" name="email" value="<%= farmer.getEmail() != null ? farmer.getEmail() : "" %>" required>
                            </div>
                            <div class="form-group">
                                <label for="phone">ফোন নম্বর</label>
                                <input type="tel" id="phone" name="phone" value="<%= farmer.getPhone() != null ? farmer.getPhone() : "" %>" required>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="dateOfBirth">জন্ম তারিখ</label>
                            <input type="date" id="dateOfBirth" name="dateOfBirth" value="<%= farmer.getDateOfBirth() != null ? farmer.getDateOfBirth() : "" %>">
                        </div>
                    </div>

                    <!-- Farm Information -->
                    <div class="form-section">
                        <h4><i class="fas fa-tractor"></i> খামারের তথ্য</h4>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="farmName">খামারের নাম</label>
                                <input type="text" id="farmName" name="farmName" value="<%= farmer.getFarmName() != null ? farmer.getFarmName() : "" %>">
                            </div>
                            <div class="form-group">
                                <label for="farmSize">খামারের আকার (একর)</label>
                                <input type="number" id="farmSize" name="farmSize" value="<%= farmer.getFarmSize() != null ? farmer.getFarmSize() : "" %>" min="0" step="0.1">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="location">খামারের অবস্থান</label>
                            <input type="text" id="location" name="location" value="<%= farmer.getLocation() != null ? farmer.getLocation() : "" %>" placeholder="গ্রাম, উপজেলা, জেলা">
                        </div>
                        
                        <div class="form-group">
                            <label for="soilConditions">মাটির ধরন</label>
                            <select id="soilConditions" name="soilConditions">
                                <option value="">মাটির ধরন নির্বাচন করুন</option>
                                <option value="clay" <%= "clay".equals(farmer.getSoilConditions()) ? "selected" : "" %>>কাদামাটি</option>
                                <option value="loamy" <%= "loamy".equals(farmer.getSoilConditions()) ? "selected" : "" %>>দোআঁশ মাটি</option>
                                <option value="sandy" <%= "sandy".equals(farmer.getSoilConditions()) ? "selected" : "" %>>বালু মাটি</option>
                                <option value="black" <%= "black".equals(farmer.getSoilConditions()) ? "selected" : "" %>>কালো মাটি</option>
                                <option value="red" <%= "red".equals(farmer.getSoilConditions()) ? "selected" : "" %>>লাল মাটি</option>
                            </select>
                        </div>
                    </div>

                    <!-- Additional Information -->
                    <div class="form-section">
                        <h4><i class="fas fa-info-circle"></i> অতিরিক্ত তথ্য</h4>
                        
                        <div class="form-group">
                            <label for="experience">কৃষি অভিজ্ঞতা (বছর)</label>
                            <input type="number" id="experience" name="experience" value="<%= farmer.getExperience() != null ? farmer.getExperience() : "" %>" min="0" max="50">
                        </div>
                        
                        <div class="form-group">
                            <label for="specialization">বিশেষজ্ঞতা</label>
                            <textarea id="specialization" name="specialization" placeholder="আপনার কৃষি বিশেষজ্ঞতা সম্পর্কে লিখুন..."><%= farmer.getSpecialization() != null ? farmer.getSpecialization() : "" %></textarea>
                        </div>
                        
                        <div class="form-group">
                            <label for="goals">কৃষি লক্ষ্য</label>
                            <textarea id="specialization" name="goals" placeholder="আপনার কৃষি লক্ষ্য এবং পরিকল্পনা লিখুন..."><%= farmer.getGoals() != null ? farmer.getGoals() : "" %></textarea>
                        </div>
                    </div>

                    <!-- Form Actions -->
                    <div class="form-actions">
                        <button type="submit" class="btn-primary">
                            <i class="fas fa-save"></i>
                            প্রোফাইল আপডেট করুন
                        </button>
                        <button type="reset" class="btn-secondary">
                            <i class="fas fa-undo"></i>
                            পুনরায় সেট করুন
                        </button>
                    </div>
                </form>
            </div>
        </main>
    </div>

    <script>
        // Simple mobile menu toggle
        function toggleSidebar() {
            const sidebar = document.querySelector('.sidebar');
            sidebar.classList.toggle('open');
        }

        // Form validation
        document.querySelector('.profile-form').addEventListener('submit', function(e) {
            const requiredFields = this.querySelectorAll('[required]');
            let isValid = true;
            
            requiredFields.forEach(field => {
                if (!field.value.trim()) {
                    field.style.borderColor = 'var(--danger-color)';
                    isValid = false;
                } else {
                    field.style.borderColor = '#d1d5db';
                }
            });
            
            if (!isValid) {
                e.preventDefault();
                alert('অনুগ্রহ করে সব প্রয়োজনীয় ক্ষেত্র পূরণ করুন।');
            }
        });

        // Real-time form validation
        document.querySelectorAll('input, select, textarea').forEach(field => {
            field.addEventListener('blur', function() {
                if (this.hasAttribute('required') && !this.value.trim()) {
                    this.style.borderColor = 'var(--danger-color)';
                } else {
                    this.style.borderColor = '#d1d5db';
                }
            });
        });
    </script>
</body>
</html>
