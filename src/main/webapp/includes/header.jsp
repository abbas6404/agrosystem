<%@page import="com.mycompany.agrosystem.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<header class="main-header">
    <div class="header-title">
        <h2>${param.pageTitle}</h2>
        <p>স্বাগতম, ${param.userName}!</p>
    </div>
    <div class="header-actions">
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i> লগ আউট
        </a>
    </div>
</header>
