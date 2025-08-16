<%@page import="com.mycompany.agrosystem.model.User"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="bn">
<head>
    <title>কৃষকের ড্যাশবোর্ড - এগ্রো সিস্টেম</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary-color: #10b981;
            --primary-light: #34d399;
            --primary-dark: #059669;
            --secondary-color: #3b82f6;
            --accent-color: #f59e0b;
            --success-color: #10b981;
            --warning-color: #f59e0b;
            --danger-color: #ef4444;
            --info-color: #3b82f6;
            --gray-50: #f9fafb;
            --gray-100: #f3f4f6;
            --gray-200: #e5e7eb;
            --gray-300: #d1d5db;
            --gray-400: #9ca3af;
            --gray-500: #6b7280;
            --gray-600: #4b5563;
            --gray-700: #374151;
            --gray-800: #1f2937;
            --gray-900: #111827;
            --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            --gradient-primary: linear-gradient(135deg, #10b981 0%, #059669 100%);
            --gradient-secondary: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
            --gradient-accent: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
            --gradient-success: linear-gradient(135deg, #10b981 0%, #047857 100%);
            --border-radius: 12px;
            --border-radius-lg: 16px;
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .dashboard-container {
            display: flex;
            min-height: 100vh;
            background: var(--gray-50);
        }

        /* Sidebar Styles */
        .sidebar {
            width: 280px;
            background: white;
            box-shadow: var(--shadow-lg);
            border-right: 1px solid var(--gray-200);
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            z-index: 1000;
        }

        .sidebar-header {
            background: var(--gradient-primary);
            color: white;
            padding: 25px 20px;
            text-align: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .sidebar-header h3 {
            margin: 0;
            font-size: 1.5rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }

        .sidebar-header i {
            font-size: 2rem;
        }

        .sidebar-nav {
            padding: 20px 0;
        }

        .nav-item {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px 25px;
            color: var(--gray-600);
            text-decoration: none;
            transition: var(--transition);
            border-left: 4px solid transparent;
            font-weight: 500;
        }

        .nav-item:hover {
            background: var(--gray-50);
            color: var(--primary-color);
            border-left-color: var(--primary-color);
            transform: translateX(5px);
        }

        .nav-item.active {
            background: var(--primary-color);
            color: white;
            border-left-color: white;
        }

        .nav-item i {
            font-size: 1.2rem;
            width: 20px;
            text-align: center;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 20px;
        }

        /* Header */
        .main-header {
            background: white;
            padding: 25px 30px;
            border-radius: var(--border-radius-lg);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: var(--shadow-md);
        }

        .header-title h2 {
            color: var(--gray-800);
            margin: 0 0 10px 0;
            font-size: 2rem;
            font-weight: 700;
        }

        .header-title p {
            color: var(--gray-600);
            margin: 0;
            font-size: 1.1rem;
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .logout-btn {
            background: var(--gradient-secondary);
            color: white;
            padding: 12px 24px;
            border-radius: var(--border-radius);
            text-decoration: none;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: var(--transition);
            box-shadow: var(--shadow-md);
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        /* Welcome Section */
        .welcome-section {
            background: var(--gradient-primary);
            color: white;
            padding: 40px 30px;
            border-radius: var(--border-radius-lg);
            margin-bottom: 30px;
            text-align: center;
            box-shadow: var(--shadow-xl);
            position: relative;
            overflow: hidden;
        }

        .welcome-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="rgba(255,255,255,0.1)"/><circle cx="75" cy="75" r="1" fill="rgba(255,255,255,0.1)"/><circle cx="50" cy="10" r="0.5" fill="rgba(255,255,255,0.1)"/><circle cx="10" cy="60" r="0.5" fill="rgba(255,255,255,0.1)"/><circle cx="90" cy="40" r="0.5" fill="rgba(255,255,255,0.1)"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
            opacity: 0.3;
        }

        .welcome-section h1 {
            font-size: 3rem;
            margin-bottom: 15px;
            font-weight: 800;
            position: relative;
            z-index: 1;
        }

        .welcome-section p {
            font-size: 1.3rem;
            opacity: 0.9;
            margin-bottom: 25px;
            position: relative;
            z-index: 1;
        }

        .welcome-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 30px;
            position: relative;
            z-index: 1;
        }

        .stat-item {
            background: rgba(255, 255, 255, 0.15);
            padding: 25px;
            border-radius: var(--border-radius);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: var(--transition);
        }

        .stat-item:hover {
            transform: translateY(-5px);
            background: rgba(255, 255, 255, 0.2);
        }

        .stat-item .stat-number {
            font-size: 2.5rem;
            font-weight: 800;
            display: block;
            margin-bottom: 8px;
        }

        .stat-item .stat-label {
            font-size: 1rem;
            opacity: 0.9;
            font-weight: 600;
        }

        /* Dashboard Cards */
        .dashboard-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .card {
            background: white;
            padding: 30px;
            border-radius: var(--border-radius-lg);
            box-shadow: var(--shadow-md);
            border: 1px solid var(--gray-200);
            transition: var(--transition);
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--gradient-primary);
        }

        .card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-xl);
        }

        .card-icon {
            width: 70px;
            height: 70px;
            background: var(--gradient-primary);
            border-radius: var(--border-radius);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2rem;
            margin-bottom: 20px;
        }

        .card-info h4 {
            color: var(--gray-800);
            font-size: 1.3rem;
            margin-bottom: 10px;
            font-weight: 600;
        }

        .card-info p {
            color: var(--gray-600);
            font-size: 1.1rem;
            margin: 0;
        }

        .card-info a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
        }

        .card-info a:hover {
            text-decoration: underline;
        }

        /* Content Area */
        .content-area {
            background: white;
            padding: 30px;
            border-radius: var(--border-radius-lg);
            box-shadow: var(--shadow-md);
            border: 1px solid var(--gray-200);
        }

        .content-area h3 {
            color: var(--gray-800);
            font-size: 1.8rem;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 15px;
            padding-bottom: 15px;
            border-bottom: 2px solid var(--gray-200);
        }

        .content-area h3 i {
            color: var(--primary-color);
            font-size: 1.5rem;
        }

        /* Alerts */
        .alert {
            padding: 15px 20px;
            border-radius: var(--border-radius);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 12px;
            font-weight: 500;
            animation: slideInRight 0.3s ease-out;
        }

        .alert-success {
            background: #d1fae5;
            color: #065f46;
            border: 1px solid #a7f3d0;
        }

        .alert-danger {
            background: #fee2e2;
            color: #991b1b;
            border: 1px solid #fecaca;
        }

        /* Notice List */
        .notice-list {
            display: grid;
            gap: 20px;
        }

        .notice-item {
            background: var(--gray-50);
            padding: 25px;
            border-radius: var(--border-radius);
            border: 1px solid var(--gray-200);
            transition: var(--transition);
            position: relative;
        }

        .notice-item::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 4px;
            background: var(--gradient-primary);
            border-radius: 2px;
        }

        .notice-item:hover {
            transform: translateX(5px);
            box-shadow: var(--shadow-md);
            background: white;
        }

        .notice-item h4 {
            color: var(--gray-800);
            font-size: 1.2rem;
            margin-bottom: 10px;
            font-weight: 600;
        }

        .notice-item p {
            color: var(--gray-600);
            line-height: 1.6;
            margin-bottom: 15px;
        }

        .notice-item small {
            color: var(--gray-500);
            font-size: 0.9rem;
            font-weight: 500;
        }

        /* Quick Actions */
        .quick-actions {
            background: white;
            padding: 30px;
            border-radius: var(--border-radius-lg);
            box-shadow: var(--shadow-md);
            border: 1px solid var(--gray-200);
            margin-bottom: 30px;
        }

        .quick-actions h3 {
            color: var(--gray-800);
            font-size: 1.5rem;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .quick-actions h3 i {
            color: var(--primary-color);
        }

        .action-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }

        .action-btn {
            background: var(--gray-50);
            border: 2px solid var(--gray-200);
            padding: 20px;
            border-radius: var(--border-radius);
            text-decoration: none;
            color: var(--gray-700);
            text-align: center;
            transition: var(--transition);
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 12px;
        }

        .action-btn:hover {
            background: var(--primary-color);
            color: white;
            border-color: var(--primary-color);
            transform: translateY(-3px);
            box-shadow: var(--shadow-lg);
        }

        .action-btn i {
            font-size: 2rem;
        }

        .action-btn span {
            font-weight: 600;
            font-size: 1rem;
        }

        /* Animations */
        @keyframes slideInRight {
            from {
                opacity: 0;
                transform: translateX(20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .sidebar {
                width: 250px;
            }
            .main-content {
                margin-left: 250px;
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
                transition: var(--transition);
            }
            .sidebar.open {
                transform: translateX(0);
            }
            .main-content {
                margin-left: 0;
            }
            .welcome-section h1 {
                font-size: 2.5rem;
            }
            .dashboard-cards {
                grid-template-columns: 1fr;
            }
            .welcome-stats {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 480px) {
            .welcome-stats {
                grid-template-columns: 1fr;
            }
            .main-header {
                flex-direction: column;
                gap: 20px;
                text-align: center;
            }
            .welcome-section {
                padding: 30px 20px;
            }
            .welcome-section h1 {
                font-size: 2rem;
            }
        }

        /* Mobile Menu Toggle */
        .mobile-menu-toggle {
            display: none;
            background: var(--primary-color);
            color: white;
            border: none;
            padding: 12px;
            border-radius: var(--border-radius);
            font-size: 1.2rem;
            cursor: pointer;
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 1001;
        }

        @media (max-width: 768px) {
            .mobile-menu-toggle {
                display: block;
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
    %>
    
    <!-- Mobile Menu Toggle -->
    <button class="mobile-menu-toggle" onclick="toggleSidebar()">
        <i class="fas fa-bars"></i>
    </button>

    <div class="dashboard-container">
        <!-- Sidebar -->
        <aside class="sidebar" id="sidebar">
            <div class="sidebar-header">
                <h3><i class="fas fa-tractor"></i> এগ্রো সিস্টেম</h3>
            </div>
            <nav class="sidebar-nav">
                <a href="${pageContext.request.contextPath}/farmerDashboard" class="nav-item active">
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
                <div class="header-title">
                    <h2><i class="fas fa-tractor"></i> কৃষকের ড্যাশবোর্ড</h2>
                    <p>স্বাগতম, <%= user.getName() %>! আজকের তারিখ: <span id="currentDate"></span></p>
                </div>
                <div class="header-actions">
                    <a href="${pageContext.request.contextPath}/profile.jsp" class="btn-primary" style="margin-right: 15px;">
                        <i class="fas fa-user"></i> প্রোফাইল
                    </a>
                    <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                        <i class="fas fa-sign-out-alt"></i> লগ আউট
                    </a>
                </div>
            </header>

            <!-- Welcome Section -->
            <div class="welcome-section">
                <h1><i class="fas fa-seedling"></i> স্বাগতম, <%= user.getName() %>!</h1>
                <p>আপনার কৃষি ব্যবস্থাপনা সফলভাবে পরিচালনা করুন</p>
                
                <div class="welcome-stats">
                    <div class="stat-item">
                        <span class="stat-number">${myCropsCount != null ? myCropsCount : '0'}</span>
                        <span class="stat-label">সক্রিয় ফসল</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-number">${noticeList != null ? noticeList.size() : '0'}</span>
                        <span class="stat-label">নতুন নোটিশ</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-number">100%</span>
                        <span class="stat-label">সিস্টেম স্বাস্থ্য</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-number">24°C</span>
                        <span class="stat-label">বর্তমান তাপমাত্রা</span>
                    </div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="quick-actions">
                <h3><i class="fas fa-bolt"></i> দ্রুত কর্ম</h3>
                <div class="action-grid">
                    <a href="${pageContext.request.contextPath}/myCrops" class="action-btn">
                        <i class="fas fa-leaf"></i>
                        <span>ফসল যোগ করুন</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/getSuggestion" class="action-btn">
                        <i class="fas fa-lightbulb"></i>
                        <span>AI পরামর্শ নিন</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/weather" class="action-btn">
                        <i class="fas fa-cloud-sun"></i>
                        <span>আবহাওয়া দেখুন</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/disease_detection.jsp" class="action-btn">
                        <i class="fas fa-stethoscope"></i>
                        <span>রোগ শনাক্ত করুন</span>
                    </a>
                </div>
            </div>

            <!-- Dashboard Cards -->
            <div class="dashboard-cards">
                <div class="card" onclick="window.location.href='${pageContext.request.contextPath}/myCrops'">
                    <div class="card-icon">
                        <i class="fas fa-seedling"></i>
                    </div>
                    <div class="card-info">
                        <h4>আমার ফসল</h4>
                        <p><strong>${myCropsCount != null ? myCropsCount : '0'}</strong> টি সক্রিয় ফসল</p>
                    </div>
                </div>
                
                <div class="card" onclick="window.location.href='${pageContext.request.contextPath}/getSuggestion'">
                    <div class="card-icon" style="background: var(--gradient-secondary);">
                        <i class="fas fa-lightbulb"></i>
                    </div>
                    <div class="card-info">
                        <h4>AI পরামর্শ</h4>
                        <p>স্মার্ট কৃষি পরামর্শ পান</p>
                    </div>
                </div>
                
                <div class="card" onclick="window.location.href='${pageContext.request.contextPath}/weather'">
                    <div class="card-icon" style="background: var(--gradient-accent);">
                        <i class="fas fa-cloud-sun"></i>
                    </div>
                    <div class="card-info">
                        <h4>আবহাওয়া</h4>
                        <p>আজকের আবহাওয়া পূর্বাভাস</p>
                    </div>
                </div>
            </div>

            <!-- Content Area -->
            <div class="content-area">
                <!-- Success/Error Messages -->
                <% if (session.getAttribute("message") != null) { %>
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle"></i> <%= session.getAttribute("message") %>
                    </div>
                    <% session.removeAttribute("message"); %>
                <% } %>
                <% if (session.getAttribute("errorMessage") != null) { %>
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-circle"></i> <%= session.getAttribute("errorMessage") %>
                    </div>
                    <% session.removeAttribute("errorMessage"); %>
                <% } %>

                <h3><i class="fas fa-bullhorn"></i> অ্যাডমিন থেকে নোটিশ</h3>
                
                <c:choose>
                    <c:when test="${not empty noticeList}">
                        <div class="notice-list">
                            <c:forEach var="notice" items="${noticeList}">
                                <div class="notice-item">
                                    <h4>${notice.getTitle()}</h4>
                                    <p>${notice.getContent()}</p>
                                    <small>
                                        <i class="fas fa-calendar-alt"></i> 
                                        প্রকাশিত: ${notice.getCreatedAt() != null ? notice.getCreatedAt().toLocalDateTime().toLocalDate().toString() : 'N/A'}
                                    </small>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div style="text-align: center; padding: 40px; color: var(--gray-500);">
                            <i class="fas fa-bell-slash" style="font-size: 3rem; margin-bottom: 20px; display: block; opacity: 0.5;"></i>
                            <h4 style="margin-bottom: 10px; color: var(--gray-600);">কোনো নতুন নোটিশ নেই</h4>
                            <p>এই মুহূর্তে অ্যাডমিন থেকে কোনো নতুন নোটিশ প্রকাশিত হয়নি।</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
    </div>

    <script>
        // Set current date
        function setCurrentDate() {
            const now = new Date();
            const options = { 
                weekday: 'long', 
                year: 'numeric', 
                month: 'long', 
                day: 'numeric' 
            };
            const dateStr = now.toLocaleDateString('bn-BD', options);
            document.getElementById('currentDate').textContent = dateStr;
        }

        // Toggle sidebar on mobile
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            sidebar.classList.toggle('open');
        }

        // Close sidebar when clicking outside on mobile
        document.addEventListener('click', function(event) {
            const sidebar = document.getElementById('sidebar');
            const mobileToggle = document.querySelector('.mobile-menu-toggle');
            
            if (window.innerWidth <= 768) {
                if (!sidebar.contains(event.target) && !mobileToggle.contains(event.target)) {
                    sidebar.classList.remove('open');
                }
            }
        });

        // Initialize dashboard
        document.addEventListener('DOMContentLoaded', function() {
            setCurrentDate();
            
            // Add animation to cards
            const cards = document.querySelectorAll('.card');
            cards.forEach((card, index) => {
                card.style.animation = `fadeInUp 0.6s ease-out ${index * 0.1}s both`;
            });
            
            // Add hover effects to action buttons
            const actionBtns = document.querySelectorAll('.action-btn');
            actionBtns.forEach(btn => {
                btn.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-5px) scale(1.02)';
                });
                
                btn.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0) scale(1)';
                });
            });
        });

        // Auto-refresh date every minute
        setInterval(setCurrentDate, 60000);
    </script>
</body>
</html>