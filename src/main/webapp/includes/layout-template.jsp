<%@page import="com.mycompany.agrosystem.model.User"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="bn">
<head>
    <title>পৃষ্ঠার শিরোনাম</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <% 
    // Authentication check
    User user = (User) session.getAttribute("loggedInUser"); 
    if (user == null) { 
        response.sendRedirect(request.getContextPath() + "/login.jsp"); 
        return; 
    } 
    %>
    
    <div class="dashboard-container">
        <!-- Include Sidebar (Choose one) -->
        
        <!-- For Farmer Pages -->
        <jsp:include page="includes/farmer-sidebar.jsp">
            <jsp:param name="active" value="pageName"/>
        </jsp:include>
        
        <!-- For Admin Pages -->
        <!--
        <jsp:include page="includes/admin-sidebar.jsp">
            <jsp:param name="active" value="pageName"/>
        </jsp:include>
        -->
        
        <main class="main-content">
            <!-- Include Header -->
            <jsp:include page="includes/header.jsp">
                <jsp:param name="pageTitle" value="পৃষ্ঠার শিরোনাম"/>
                <jsp:param name="userName" value="<%= user.getName() %>"/>
            </jsp:include>
            
            <!-- Include Alerts for Messages -->
            <jsp:include page="includes/alerts.jsp"/>
            
            <!-- Your Page Content Goes Here -->
            <div class="content-area">
                <h3><i class="fas fa-icon"></i> আপনার বিষয়বস্তু</h3>
                <!-- Add your page content here -->
            </div>
        </main>
    </div>
</body>
</html>
