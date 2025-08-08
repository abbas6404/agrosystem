<%@page import="com.mycompany.agrosystem.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="bn">
<head>
    <title>ফসল ব্যবস্থাপনা</title>
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
            <jsp:param name="active" value="crops"/>
        </jsp:include>
        
        <main class="main-content">
            <!-- Include Header -->
            <jsp:include page="includes/header.jsp">
                <jsp:param name="pageTitle" value="ফসল ব্যবস্থাপনা"/>
                <jsp:param name="userName" value="<%= user.getName() %>"/>
            </jsp:include>
            
            <!-- Include Alerts -->
            <jsp:include page="includes/alerts.jsp"/>
            
            <!-- Add New Crop Section -->
            <div class="content-area" style="margin-bottom: 30px;">
                <h3><i class="fas fa-plus-circle"></i> নতুন ফসল যোগ করুন</h3>
                <form action="${pageContext.request.contextPath}/admin/crops" method="post">
                    <input type="hidden" name="action" value="add">
                    <div class="input-group">
                        <label>ফসলের নাম</label>
                        <input type="text" name="cropName" required>
                    </div>
                    <div class="input-group">
                        <label>বিবরণ</label>
                        <textarea name="description" rows="2"></textarea>
                    </div>
                    <button type="submit">যোগ করুন</button>
                </form>
            </div>
            
            <!-- Existing Crops Section -->
            <div class="content-area">
                <h3><i class="fas fa-list"></i> বিদ্যমান ফসলের তালিকা</h3>
                <table class="styled-table">
                    <thead>
                        <tr>
                            <th>নাম</th>
                            <th>বিবরণ</th>
                            <th>পদক্ষেপ</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="crop" items="${cropList}">
                            <tr>
                                <td>${crop.getName()}</td>
                                <td>${crop.getDescription()}</td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/admin/crops" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="cropId" value="${crop.getId()}">
                                        <button type="submit" class="action-btn btn-delete" onclick="return confirm('নিশ্চিত?')">মুছুন</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
</body>
</html>