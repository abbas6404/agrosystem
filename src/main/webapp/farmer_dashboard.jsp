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
    <% User user = (User) session.getAttribute("loggedInUser"); 
       if (user == null || !"FARMER".equals(user.getUserType())) { 
           response.sendRedirect(request.getContextPath() + "/login.jsp"); 
           return; 
       } %>
    
    <div class="dashboard-container">
        <!-- Include Farmer Sidebar -->
        <jsp:include page="includes/farmer-sidebar.jsp">
            <jsp:param name="active" value="dashboard"/>
        </jsp:include>
        
        <main class="main-content">
            <!-- Include Header -->
            <jsp:include page="includes/header.jsp">
                <jsp:param name="pageTitle" value="কৃষকের ড্যাশবোর্ড"/>
                <jsp:param name="userName" value="<%= user.getName() %>"/>
            </jsp:include>
            
            <!-- Dashboard Cards -->
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
            
            <!-- Content Area -->
            <div class="content-area">
                <!-- Include Alerts -->
                <jsp:include page="includes/alerts.jsp"/>
                
                <h3><i class="fas fa-bullhorn"></i> অ্যাডমিন থেকে নোটিশ</h3>
                <c:choose>
                    <c:when test="${not empty noticeList}">
                        <div class="notice-list">
                            <c:forEach var="notice" items="${noticeList}">
                                <div class="notice-item">
                                    <h4>${notice.getTitle()}</h4>
                                    <p>${notice.getContent()}</p>
                                    <small>প্রকাশিত: ${notice.getCreatedAt()}</small>
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