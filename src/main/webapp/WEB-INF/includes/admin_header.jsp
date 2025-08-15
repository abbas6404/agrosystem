<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="bn">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${param.pageTitle} - এগ্রো সিস্টেম অ্যাডমিন</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <% 
        // Check if user is logged in and is admin
        com.mycompany.agrosystem.model.User user = (com.mycompany.agrosystem.model.User) session.getAttribute("loggedInUser"); 
        if (user == null || !"ADMIN".equals(user.getUserType())) { 
            response.sendRedirect(request.getContextPath() + "/login.jsp"); 
            return; 
        } 
    %>
    <div class="dashboard-container">
        <aside class="sidebar">
            <div class="sidebar-header">
                <h3><i class="fas fa-tractor"></i> এগ্রো সিস্টেম</h3>
                <p class="sidebar-subtitle">অ্যাডমিন প্যানেল</p>
            </div>
            <nav class="sidebar-nav">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-item ${param.activePage == 'dashboard' ? 'active' : ''}">
                    <i class="fas fa-tachometer-alt"></i> ড্যাশবোর্ড
                </a>
                <a href="${pageContext.request.contextPath}/admin/farmers" class="nav-item ${param.activePage == 'farmers' ? 'active' : ''}">
                    <i class="fas fa-users"></i> কৃষক ব্যবস্থাপনা
                </a>
                <a href="${pageContext.request.contextPath}/admin/crops" class="nav-item ${param.activePage == 'crops' ? 'active' : ''}">
                    <i class="fas fa-leaf"></i> ফসল ব্যবস্থাপনা
                </a>
                <a href="${pageContext.request.contextPath}/admin/notices" class="nav-item ${param.activePage == 'notices' ? 'active' : ''}">
                    <i class="fas fa-bullhorn"></i> নোটিশ ব্যবস্থাপনা
                </a>
                <a href="${pageContext.request.contextPath}/admin/reports" class="nav-item ${param.activePage == 'reports' ? 'active' : ''}">
                    <i class="fas fa-chart-bar"></i> রিপোর্ট
                </a>
                <a href="${pageContext.request.contextPath}/admin/settings" class="nav-item ${param.activePage == 'settings' ? 'active' : ''}">
                    <i class="fas fa-cog"></i> সেটিংস
                </a>
            </nav>
            <div class="sidebar-footer">
                <div class="user-info">
                    <i class="fas fa-user-circle"></i>
                    <span><%= user.getName() %></span>
                </div>
            </div>
        </aside>
        <main class="main-content">
            <header class="main-header">
                <div class="header-title">
                    <h2><i class="${param.pageIcon}"></i> ${param.pageTitle}</h2>
                    <p>স্বাগতম, <%= user.getName() %>! | <%= new java.text.SimpleDateFormat("EEEE, MMMM d, yyyy", new java.util.Locale("bn")).format(new java.util.Date()) %></p>
                </div>
                <div class="header-actions">
                    <a href="${pageContext.request.contextPath}/admin/profile" class="header-btn">
                        <i class="fas fa-user"></i> প্রোফাইল
                    </a>
                    <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                        <i class="fas fa-sign-out-alt"></i> লগ আউট
                    </a>
                </div>
            </header>
