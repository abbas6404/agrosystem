<%@page import="com.mycompany.agrosystem.model.User"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/includes/admin_header.jsp">
    <jsp:param name="pageTitle" value="ড্যাশবোর্ড" />
    <jsp:param name="pageIcon" value="fas fa-tachometer-alt" />
    <jsp:param name="activePage" value="dashboard" />
</jsp:include>

<!-- Dashboard Content -->
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
            <i class="fas fa-bullhorn"></i>
        </div>
        <div class="card-info">
            <h4>সক্রিয় নোটিশ</h4>
            <p>${noticeCount != null ? noticeCount : '0'} টি</p>
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

<!-- Quick Actions -->
<div class="content-area" style="margin-bottom: 30px;">
    <h3><i class="fas fa-bolt"></i> দ্রুত পদক্ষেপ</h3>
    <div class="quick-actions">
        <a href="${pageContext.request.contextPath}/admin/farmers/add" class="quick-action-btn">
            <i class="fas fa-user-plus"></i>
            <span>নতুন কৃষক যোগ করুন</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/crops/add" class="quick-action-btn">
            <i class="fas fa-leaf"></i>
            <span>নতুন ফসল যোগ করুন</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/notices/add" class="quick-action-btn">
            <i class="fas fa-bullhorn"></i>
            <span>নোটিশ প্রকাশ করুন</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/reports" class="quick-action-btn">
            <i class="fas fa-chart-bar"></i>
            <span>রিপোর্ট দেখুন</span>
        </a>
    </div>
</div>

<!-- Recent Activity Chart -->
<div class="content-area" style="margin-bottom: 30px;">
    <h3><i class="fas fa-chart-line"></i> সাম্প্রতিক কার্যক্রম</h3>
    <div class="chart-container">
        <canvas id="dashboardChart" width="400" height="200"></canvas>
    </div>
</div>

<!-- Notice Board -->
<div class="content-area" style="margin-bottom: 30px;">
    <h3><i class="fas fa-bullhorn"></i> নোটিশ বোর্ড</h3>
    <form action="${pageContext.request.contextPath}/admin/notices" method="post" class="notice-form">
        <div class="form-row">
            <div class="input-group">
                <label>শিরোনাম</label>
                <input type="text" name="title" required placeholder="নোটিশের শিরোনাম লিখুন">
            </div>
            <div class="input-group">
                <label>বিস্তারিত</label>
                <textarea name="content" rows="3" required placeholder="নোটিশের বিস্তারিত লিখুন"></textarea>
            </div>
        </div>
        <button type="submit" class="btn-primary">
            <i class="fas fa-paper-plane"></i> নোটিশ প্রকাশ করুন
        </button>
    </form>
</div>

<!-- Recent Farmers -->
<div class="content-area">
    <h3><i class="fas fa-users"></i> নিবন্ধিত সকল কৃষক</h3>
    <div class="table-container">
        <table class="styled-table">
            <thead>
                <tr>
                    <th>নাম</th>
                    <th>ফোন</th>
                    <th>এলাকা</th>
                    <th>জমির আকার</th>
                    <th>নিবন্ধনের তারিখ</th>
                    <th>পদক্ষেপ</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="farmer" items="${allFarmers}">
                    <tr>
                        <td>
                            <div class="user-info-cell">
                                <i class="fas fa-user-circle"></i>
                                <span>${farmer.getName()}</span>
                            </div>
                        </td>
                        <td>${farmer.getPhoneNumber()}</td>
                        <td>${farmer.getLocation()}</td>
                        <td>${farmer.getLandSizeAcres()} একর</td>
                        <td>${farmer.getCreatedAt() != null ? farmer.getCreatedAt().toLocalDate().toString() : 'N/A'}</td>
                        <td>
                            <div class="action-buttons">
                                <a href="${pageContext.request.contextPath}/admin/farmers/edit?id=${farmer.getId()}" 
                                   class="action-btn btn-edit" data-tooltip="সম্পাদনা করুন">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/farmers/view?id=${farmer.getId()}" 
                                   class="action-btn btn-view" data-tooltip="দেখুন">
                                    <i class="fas fa-eye"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/farmers/delete?id=${farmer.getId()}" 
                                   class="action-btn btn-delete" data-tooltip="মুছুন"
                                   onclick="return confirm('আপনি কি নিশ্চিত যে আপনি এই কৃষককে মুছতে চান?')">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/admin_footer.jsp" />