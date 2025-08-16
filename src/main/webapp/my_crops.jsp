<%@page import="com.mycompany.agrosystem.model.User"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="bn">
<head>
    <title>আমার ফসল - এগ্রো সিস্টেম</title>
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
            box-shadow: var(--shadow-md);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border: 1px solid var(--gray-200);
        }

        .main-header h2 {
            color: var(--gray-800);
            font-size: 2rem;
            margin: 0;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .main-header h2 i {
            color: var(--primary-color);
        }

        .header-actions {
            display: flex;
            gap: 15px;
        }

        .btn-primary {
            background: var(--gradient-primary);
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

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .btn-secondary {
            background: white;
            color: var(--gray-700);
            border: 2px solid var(--gray-300);
            padding: 12px 24px;
            border-radius: var(--border-radius);
            text-decoration: none;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: var(--transition);
        }

        .btn-secondary:hover {
            background: var(--gray-100);
            border-color: var(--gray-400);
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
            font-size: 2.5rem;
            margin-bottom: 15px;
            font-weight: 800;
            position: relative;
            z-index: 1;
        }

        .welcome-section p {
            font-size: 1.2rem;
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

        /* Content Area */
        .content-area {
            background: white;
            padding: 30px;
            border-radius: var(--border-radius-lg);
            box-shadow: var(--shadow-md);
            border: 1px solid var(--gray-200);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: var(--gray-500);
        }

        .empty-state i {
            font-size: 4rem;
            margin-bottom: 20px;
            display: block;
            opacity: 0.5;
            color: var(--gray-400);
        }

        .empty-state h3 {
            color: var(--gray-600);
            font-size: 1.5rem;
            margin-bottom: 15px;
            font-weight: 600;
        }

        .empty-state p {
            color: var(--gray-500);
            font-size: 1.1rem;
            margin-bottom: 30px;
            line-height: 1.6;
        }

        .empty-state .action-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }

        /* Crops Table */
        .crops-table-container {
            overflow-x: auto;
            border-radius: var(--border-radius);
            border: 1px solid var(--gray-200);
            box-shadow: var(--shadow-sm);
        }

        .crops-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }

        .crops-table thead {
            background: var(--gradient-primary);
            color: white;
        }

        .crops-table th {
            padding: 18px 20px;
            text-align: left;
            font-weight: 600;
            font-size: 1rem;
            border: none;
        }

        .crops-table tbody tr {
            border-bottom: 1px solid var(--gray-200);
            transition: var(--transition);
        }

        .crops-table tbody tr:hover {
            background: var(--gray-50);
            transform: scale(1.01);
        }

        .crops-table td {
            padding: 18px 20px;
            color: var(--gray-700);
            font-size: 1rem;
        }

        .crops-table tbody tr:last-child {
            border-bottom: none;
        }

        /* Crop Status Badge */
        .status-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-suggested {
            background: var(--info-color);
            color: white;
        }

        .status-growing {
            background: var(--success-color);
            color: white;
        }

        .status-harvested {
            background: var(--warning-color);
            color: white;
        }

        .status-failed {
            background: var(--danger-color);
            color: white;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .btn-sm {
            padding: 8px 16px;
            font-size: 0.9rem;
            border-radius: var(--border-radius);
            text-decoration: none;
            font-weight: 500;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-edit {
            background: var(--info-color);
            color: white;
        }

        .btn-edit:hover {
            background: #2563eb;
            transform: translateY(-1px);
        }

        .btn-delete {
            background: var(--danger-color);
            color: white;
        }

        .btn-delete:hover {
            background: #dc2626;
            transform: translateY(-1px);
        }

        .btn-view {
            background: var(--success-color);
            color: white;
        }

        .btn-view:hover {
            background: #059669;
            transform: translateY(-1px);
        }

        /* Search and Filter */
        .search-filter-section {
            background: var(--gray-50);
            padding: 25px;
            border-radius: var(--border-radius);
            margin-bottom: 25px;
            border: 1px solid var(--gray-200);
        }

        .search-filter-section h3 {
            color: var(--gray-800);
            font-size: 1.3rem;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .search-filter-section h3 i {
            color: var(--primary-color);
        }

        .search-filter-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            align-items: end;
        }

        .search-group {
            display: flex;
            flex-direction: column;
        }

        .search-group label {
            font-weight: 600;
            color: var(--gray-700);
            margin-bottom: 8px;
            font-size: 0.95rem;
        }

        .search-group input,
        .search-group select {
            padding: 12px 16px;
            border: 2px solid var(--gray-300);
            border-radius: var(--border-radius);
            font-size: 1rem;
            transition: var(--transition);
            background: white;
        }

        .search-group input:focus,
        .search-group select:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.1);
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
            .main-header {
                flex-direction: column;
                gap: 20px;
                text-align: center;
            }
            .welcome-section h1 {
                font-size: 2rem;
            }
            .welcome-stats {
                grid-template-columns: repeat(2, 1fr);
            }
            .search-filter-row {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 480px) {
            .welcome-stats {
                grid-template-columns: 1fr;
            }
            .welcome-section {
                padding: 30px 20px;
            }
            .welcome-section h1 {
                font-size: 1.8rem;
            }
            .action-buttons {
                flex-direction: column;
            }
            .btn-sm {
                width: 100%;
                justify-content: center;
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

        /* Animations */
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
                <a href="${pageContext.request.contextPath}/farmerDashboard" class="nav-item">
                    <i class="fas fa-tachometer-alt"></i> ড্যাশবোর্ড
                </a>
                <a href="${pageContext.request.contextPath}/myCrops" class="nav-item active">
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
                <h2><i class="fas fa-leaf"></i> আমার ফসল ব্যবস্থাপনা</h2>
                <div class="header-actions">
                    <a href="${pageContext.request.contextPath}/getSuggestion" class="btn-primary">
                        <i class="fas fa-plus"></i> নতুন ফসল যোগ করুন
                    </a>
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
                <h1><i class="fas fa-seedling"></i> আমার ফসল</h1>
                <p>আপনার নির্বাচিত ফসলগুলির তালিকা এবং ব্যবস্থাপনা</p>
                
                <div class="welcome-stats">
                    <div class="stat-item">
                        <span class="stat-number">${myCropsList != null ? myCropsList.size() : '0'}</span>
                        <span class="stat-label">মোট ফসল</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-number">${myCropsList != null ? myCropsList.stream().filter(crop -> "growing".equals(crop.getStatus())).count() : '0'}</span>
                        <span class="stat-label">বর্ধমান ফসল</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-number">${myCropsList != null ? myCropsList.stream().filter(crop -> "harvested".equals(crop.getStatus())).count() : '0'}</span>
                        <span class="stat-label">সংগৃহীত ফসল</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-number">${myCropsList != null ? myCropsList.stream().filter(crop -> "suggested".equals(crop.getStatus())).count() : '0'}</span>
                        <span class="stat-label">পরামর্শকৃত ফসল</span>
                    </div>
                </div>
            </div>

            <!-- Search and Filter Section -->
            <div class="search-filter-section">
                <h3><i class="fas fa-search"></i> অনুসন্ধান এবং ফিল্টার</h3>
                <div class="search-filter-row">
                    <div class="search-group">
                        <label>ফসলের নাম অনুসন্ধান</label>
                        <input type="text" id="searchInput" placeholder="ফসলের নাম লিখুন..." onkeyup="filterCrops()">
                    </div>
                    <div class="search-group">
                        <label>অবস্থা অনুযায়ী ফিল্টার</label>
                        <select id="statusFilter" onchange="filterCrops()">
                            <option value="">সব অবস্থা</option>
                            <option value="suggested">পরামর্শকৃত</option>
                            <option value="growing">বর্ধমান</option>
                            <option value="harvested">সংগৃহীত</option>
                            <option value="failed">ব্যর্থ</option>
                        </select>
                    </div>
                    <div class="search-group">
                        <label>&nbsp;</label>
                        <button onclick="resetFilters()" class="btn-secondary" style="margin: 0;">
                            <i class="fas fa-refresh"></i> ফিল্টার রিসেট করুন
                        </button>
                    </div>
                </div>
            </div>

            <!-- Content Area -->
            <div class="content-area">
                <c:choose>
                    <c:when test="${not empty myCropsList}">
                        <div class="crops-table-container">
                            <table class="crops-table" id="cropsTable">
                                <thead>
                                    <tr>
                                        <th>ফসলের নাম</th>
                                        <th>বিবরণ</th>
                                        <th>অবস্থা</th>
                                        <th>যোগ করার তারিখ</th>
                                        <th>কর্ম</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="crop" items="${myCropsList}">
                                        <tr class="crop-row" data-name="${crop.getName().toLowerCase()}" data-status="${crop.getStatus() != null ? crop.getStatus() : 'suggested'}">
                                            <td>
                                                <strong>${crop.getName()}</strong>
                                            </td>
                                            <td>${crop.getDescription() != null ? crop.getDescription() : 'কোনো বিবরণ নেই'}</td>
                                            <td>
                                                <span class="status-badge status-${crop.getStatus() != null ? crop.getStatus() : 'suggested'}">
                                                    ${crop.getStatus() != null ? crop.getStatus() : 'suggested'}
                                                </span>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${crop.getCreatedAt() != null}">
                                                        ${crop.getCreatedAt().toLocalDateTime().toLocalDate().toString()}
                                                    </c:when>
                                                    <c:otherwise>
                                                        আজ
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="action-buttons">
                                                    <a href="#" class="btn-sm btn-view" onclick="viewCrop('${crop.getName()}')">
                                                        <i class="fas fa-eye"></i> দেখুন
                                                    </a>
                                                    <a href="#" class="btn-sm btn-edit" onclick="editCrop('${crop.getName()}')">
                                                        <i class="fas fa-edit"></i> সম্পাদনা
                                                    </a>
                                                    <a href="#" class="btn-sm btn-delete" onclick="deleteCrop('${crop.getName()}')">
                                                        <i class="fas fa-trash"></i> মুছুন
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="fas fa-seedling"></i>
                            <h3>কোনো ফসল নেই</h3>
                            <p>আপনি এখনো কোনো ফসল আপনার তালিকায় যোগ করেননি।<br>AI পরামর্শ থেকে আপনার পছন্দের ফসল যোগ করুন এবং আপনার কৃষি ব্যবস্থাপনা শুরু করুন।</p>
                            <div class="action-buttons">
                                <a href="${pageContext.request.contextPath}/getSuggestion" class="btn-primary">
                                    <i class="fas fa-lightbulb"></i> AI পরামর্শ নিন
                                </a>
                                <a href="${pageContext.request.contextPath}/farmerDashboard" class="btn-secondary">
                                    <i class="fas fa-arrow-left"></i> ড্যাশবোর্ডে ফিরে যান
                                </a>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
    </div>

    <script>
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

        // Filter crops based on search and status
        function filterCrops() {
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            const statusFilter = document.getElementById('statusFilter').value;
            const cropRows = document.querySelectorAll('.crop-row');

            cropRows.forEach(row => {
                const cropName = row.dataset.name;
                const cropStatus = row.dataset.status;
                
                const matchesSearch = cropName.includes(searchTerm);
                const matchesStatus = !statusFilter || cropStatus === statusFilter;
                
                if (matchesSearch && matchesStatus) {
                    row.style.display = '';
                    row.style.animation = 'slideInRight 0.3s ease-out';
                } else {
                    row.style.display = 'none';
                }
            });
        }

        // Reset all filters
        function resetFilters() {
            document.getElementById('searchInput').value = '';
            document.getElementById('statusFilter').value = '';
            
            const cropRows = document.querySelectorAll('.crop-row');
            cropRows.forEach(row => {
                row.style.display = '';
                row.style.animation = 'slideInRight 0.3s ease-out';
            });
        }

        // View crop details
        function viewCrop(cropName) {
            alert(`ফসলের বিবরণ দেখানো হচ্ছে: ${cropName}\n\nএই বৈশিষ্ট্যটি শীঘ্রই আসবে!`);
        }

        // Edit crop
        function editCrop(cropName) {
            alert(`ফসল সম্পাদনা করা হচ্ছে: ${cropName}\n\nএই বৈশিষ্ট্যটি শীঘ্রই আসবে!`);
        }

        // Delete crop
        function deleteCrop(cropName) {
            if (confirm(`আপনি কি নিশ্চিত যে আপনি "${cropName}" ফসলটি মুছতে চান?`)) {
                alert(`ফসল মুছে ফেলা হয়েছে: ${cropName}\n\nএই বৈশিষ্ট্যটি শীঘ্রই আসবে!`);
            }
        }

        // Initialize page
        document.addEventListener('DOMContentLoaded', function() {
            // Add animation to table rows
            const cropRows = document.querySelectorAll('.crop-row');
            cropRows.forEach((row, index) => {
                row.style.animation = `fadeInUp 0.6s ease-out ${index * 0.1}s both`;
            });
        });
    </script>
</body>
</html>