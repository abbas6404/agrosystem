<%@page import="com.mycompany.agrosystem.model.Farmer"%>
<%@page import="com.mycompany.agrosystem.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="bn">
<head>
    <title>কৃষক প্রোফাইল সম্পাদনা</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <% User user = (User) session.getAttribute("loggedInUser"); 
       if (user == null || !"ADMIN".equals(user.getUserType())) { 
           response.sendRedirect(request.getContextPath() + "/login.jsp"); 
           return; 
       } %>
    
    <div class="dashboard-container">
        <!-- Include Admin Sidebar -->
        <jsp:include page="includes/admin-sidebar.jsp">
            <jsp:param name="active" value="farmers"/>
        </jsp:include>
        
        <main class="main-content">
            <!-- Include Header -->
            <jsp:include page="includes/header.jsp">
                <jsp:param name="pageTitle" value="কৃষক প্রোফাইল সম্পাদনা"/>
                <jsp:param name="userName" value="<%= user.getName() %>"/>
            </jsp:include>
            
            <!-- Include Alerts -->
            <jsp:include page="includes/alerts.jsp"/>
            
            <!-- Content Area -->
            <div class="content-area">
                <form action="${pageContext.request.contextPath}/admin/editFarmer" method="post">
                    <input type="hidden" name="id" value="${farmer.getId()}">
                    <div class="input-group">
                        <label>নাম</label>
                        <input type="text" name="name" value="${farmer.getName()}" required>
                    </div>
                    <div class="input-group">
                        <label>ফোন নম্বর</label>
                        <input type="text" name="phone" value="${farmer.getPhoneNumber()}" required>
                    </div>
                    <div class="input-group">
                        <label>এলাকা</label>
                        <input type="text" name="location" value="${farmer.getLocation()}" required>
                    </div>
                    <div class="input-group">
                        <label>জমির পরিমাণ (একরে)</label>
                        <input type="number" step="0.01" name="landSize" value="${farmer.getLandSizeAcres()}" required>
                    </div>
                    <div class="input-group">
                        <label>মাটির ধরণ</label>
                        <textarea name="soil" rows="3" required>${farmer.getSoilConditions()}</textarea>
                    </div>
                    <button type="submit">আপডেট করুন</button>
                    <a href="${pageContext.request.contextPath}/admin/dashboard" style="display: block; text-align: center; margin-top: 15px;">বাতিল করুন</a>
                </form>
            </div>
        </main>
    </div>
</body>
</html>
