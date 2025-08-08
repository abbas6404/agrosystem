<%@page contentType="text/html" pageEncoding="UTF-8"%>
<aside class="sidebar">
    <div class="sidebar-header">
        <h3><i class="fas fa-tractor"></i> এগ্রো সিস্টেম</h3>
    </div>
    <nav class="sidebar-nav">
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-item ${param.active == 'dashboard' ? 'active' : ''}">
            <i class="fas fa-tachometer-alt"></i> ড্যাশবোর্ড
        </a>
        <a href="${pageContext.request.contextPath}/admin/crops" class="nav-item ${param.active == 'crops' ? 'active' : ''}">
            <i class="fas fa-leaf"></i> ফসল পরিচালনা
        </a>
        <a href="${pageContext.request.contextPath}/admin/farmers" class="nav-item ${param.active == 'farmers' ? 'active' : ''}">
            <i class="fas fa-users"></i> কৃষক পরিচালনা
        </a>
        <a href="${pageContext.request.contextPath}/admin/notices" class="nav-item ${param.active == 'notices' ? 'active' : ''}">
            <i class="fas fa-bullhorn"></i> নোটিশ বোর্ড
        </a>
        <a href="${pageContext.request.contextPath}/admin/reports" class="nav-item ${param.active == 'reports' ? 'active' : ''}">
            <i class="fas fa-chart-bar"></i> রিপোর্ট
        </a>
    </nav>
</aside>
