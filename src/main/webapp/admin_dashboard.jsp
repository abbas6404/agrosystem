<%@page import="com.mycompany.agrosystem.model.User"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="bn">
<head>
    <title>অ্যাডমিন ড্যাশবোর্ড</title>
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
            <jsp:param name="active" value="dashboard"/>
        </jsp:include>
        
        <main class="main-content">
            <!-- Include Header -->
            <jsp:include page="includes/header.jsp">
                <jsp:param name="pageTitle" value="অ্যাডমিন ড্যাশবোর্ড"/>
                <jsp:param name="userName" value="<%= user.getName() %>"/>
            </jsp:include>
            
            <!-- Dashboard Cards -->
            <div class="dashboard-cards">
                <div class="card">
                    <div class="card-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="card-info">
                        <h4>মোট কৃষক</h4>
                        <p>${farmerCount} জন</p>
                    </div>
                </div>
                <div class="card">
                    <div class="card-icon">
                        <i class="fas fa-leaf"></i>
                    </div>
                    <div class="card-info">
                        <h4>মোট ফসল</h4>
                        <p>${cropCount} টি</p>
                    </div>
                </div>
                <div class="card">
                    <div class="card-icon">
                        <i class="fas fa-server"></i>
                    </div>
                    <div class="card-info">
                        <h4>সিস্টেম স্ট্যাটাস</h4>
                        <p style="color: #27ae60;">অনলাইন</p>
                    </div>
                </div>
            </div>
            
            <!-- Notice Board Section -->
            <div class="content-area" style="margin-bottom: 30px;">
                <h3><i class="fas fa-bullhorn"></i> নোটিশ বোর্ড</h3>
                <form action="${pageContext.request.contextPath}/admin/notices" method="post">
                    <div class="input-group">
                        <label>শিরোনাম</label>
                        <input type="text" name="title" required>
                    </div>
                    <div class="input-group">
                        <label>বিস্তারিত</label>
                        <textarea name="content" rows="3" required></textarea>
                    </div>
                    <button type="submit">নোটিশ প্রকাশ করুন</button>
                </form>
            </div>
            
            <!-- Farmers List Section -->
            <div class="content-area">
                <h3><i class="fas fa-users"></i> নিবন্ধিত সকল কৃষক</h3>
                <div class="table-container">
                    <table class="styled-table">
                        <thead>
                            <tr>
                                <th>নাম</th>
                                <th>ফোন</th>
                                <th>এলাকা</th>
                                <th>পদক্ষেপ</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="farmer" items="${allFarmers}">
                                <tr>
                                    <td>${farmer.getName()}</td>
                                    <td>${farmer.getPhoneNumber()}</td>
                                    <td>${farmer.getLocation()}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/editFarmer?id=${farmer.getId()}" class="action-btn btn-edit">সম্পাদনা</a>
                                        <a href="${pageContext.request.contextPath}/admin/deleteFarmer?id=${farmer.getId()}" class="action-btn btn-delete" onclick="return confirm('নিশ্চিত?')">মুছুন</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
</body>
</html>