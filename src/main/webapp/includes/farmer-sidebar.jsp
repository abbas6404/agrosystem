<%@page contentType="text/html" pageEncoding="UTF-8"%>
<aside class="sidebar">
    <div class="sidebar-header">
        <h3><i class="fas fa-tractor"></i> এগ্রো সিস্টেম</h3>
    </div>
    <nav class="sidebar-nav">
        <a href="${pageContext.request.contextPath}/farmerDashboard" class="nav-item ${param.active == 'dashboard' ? 'active' : ''}">
            <i class="fas fa-tachometer-alt"></i> ড্যাশবোর্ড
        </a>
        <a href="${pageContext.request.contextPath}/myCrops" class="nav-item ${param.active == 'myCrops' ? 'active' : ''}">
            <i class="fas fa-leaf"></i> আমার ফসল
        </a>
        <a href="${pageContext.request.contextPath}/getSuggestion" class="nav-item ${param.active == 'suggestion' ? 'active' : ''}">
            <i class="fas fa-lightbulb"></i> AI পরামর্শ
        </a>
        <a href="${pageContext.request.contextPath}/weather" class="nav-item ${param.active == 'weather' ? 'active' : ''}">
            <i class="fas fa-cloud-sun"></i> আবহাওয়া
        </a>
        <a href="${pageContext.request.contextPath}/disease_detection.jsp" class="nav-item ${param.active == 'disease' ? 'active' : ''}">
            <i class="fas fa-stethoscope"></i> রোগ শনাক্তকরণ
        </a>
    </nav>
</aside>
