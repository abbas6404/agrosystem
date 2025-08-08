<%@page import="com.mycompany.agrosystem.model.User"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="bn">
<head>
    <title>আমার ফসল</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <% User user = (User) session.getAttribute("loggedInUser"); if (user == null || !"FARMER".equals(user.getUserType())) { response.sendRedirect(request.getContextPath() + "/login.jsp"); return; } %>
    <div class="dashboard-container">
        <aside class="sidebar"><div class="sidebar-header"><h3><i class="fas fa-tractor"></i> এগ্রো সিস্টেম</h3></div><nav class="sidebar-nav"><a href="${pageContext.request.contextPath}/farmerDashboard" class="nav-item"><i class="fas fa-tachometer-alt"></i> ড্যাশবোর্ড</a><a href="${pageContext.request.contextPath}/myCrops" class="nav-item active"><i class="fas fa-leaf"></i> আমার ফসল</a></nav></aside>
        <main class="main-content">
            <header class="main-header"><h2><i class="fas fa-leaf"></i> আমার নির্বাচিত ফসলের তালিকা</h2><div class="header-actions"><a href="${pageContext.request.contextPath}/logout" class="logout-btn"><i class="fas fa-sign-out-alt"></i> লগ আউট</a></div></header>
            <div class="content-area">
                <c:choose><c:when test="${not empty myCropsList}"><table class="styled-table"><thead><tr><th>ফসলের নাম</th><th>বিবরণ</th><th>অবস্থা</th></tr></thead><tbody><c:forEach var="crop" items="${myCropsList}"><tr><td>${crop.getName()}</td><td>${crop.getDescription()}</td><td>Suggested</td></tr></c:forEach></tbody></table></c:when><c:otherwise><p>আপনি এখনো কোনো ফসল আপনার তালিকায় যোগ করেননি। <a href="${pageContext.request.contextPath}/getSuggestion">AI পরামর্শ</a> থেকে আপনার পছন্দের ফসল যোগ করুন।</p></c:otherwise></c:choose>
            </div>
        </main>
    </div>
</body>
</html>