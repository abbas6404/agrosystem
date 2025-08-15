<%@page import="com.mycompany.agrosystem.model.User"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="bn">
<head>
    <title>কৃষকের ড্যাশবোর্ড</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <% 
        User user = (User) session.getAttribute("loggedInUser"); 
        if (user == null || !"FARMER".equals(user.getUserType())) { 
            response.sendRedirect(request.getContextPath() + "/login.jsp"); 
            return; 
        } 
    %>
    <div class="dashboard-container">
        <aside class="sidebar">
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
            </nav>
        </aside>
        <main class="main-content">
            <header class="main-header">
                <div class="header-title">
                    <h2>কৃষকের ড্যাশবোর্ড</h2>
                    <p>স্বাগতম, <%= user.getName() %>!</p>
                </div>
                <div class="header-actions">
                    <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                        <i class="fas fa-sign-out-alt"></i> লগ আউট
                    </a>
                </div>
            </header>
            <div class="dashboard-cards">
                <div class="card">
                    <div class="card-icon">
                        <i class="fas fa-seedling"></i>
                    </div>
                    <div class="card-info">
                        <h4>আমার ফসল</h4>
                        <p>${myCropsCount} টি</p>
                    </div>
                </div>
                <div class="card">
                    <div class="card-icon">
                        <i class="fas fa-bullhorn"></i>
                    </div>
                    <div class="card-info">
                        <h4>নতুন নোটিশ</h4>
                        <p>${noticeList.size()} টি</p>
                    </div>
                </div>
                <div class="card">
                    <div class="card-icon">
                        <i class="fas fa-cloud-sun"></i>
                    </div>
                    <div class="card-info">
                        <h4>আবহাওয়া</h4>
                        <p><a href="${pageContext.request.contextPath}/weather" style="text-decoration:none; color: var(--dark-color);">পূর্বাভাস দেখুন</a></p>
                    </div>
                </div>
            </div>
            <div class="content-area">
                <% if (session.getAttribute("message") != null) { %>
                    <p class="alert alert-success"><%= session.getAttribute("message") %></p>
                    <% session.removeAttribute("message"); %>
                <% } %>
                <% if (session.getAttribute("errorMessage") != null) { %>
                    <p class="alert alert-danger"><%= session.getAttribute("errorMessage") %></p>
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
                                                                         <small>প্রকাশিত: ${notice.getCreatedAt() != null ? notice.getCreatedAt().toLocalDateTime().toLocalDate().toString() : 'N/A'}</small>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <p>এই মুহূর্তে কোনো নতুন নোটিশ নেই।</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
    </div>
</body>
</html>