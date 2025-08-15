<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<jsp:include page="/WEB-INF/includes/admin_header.jsp">
    <jsp:param name="pageTitle" value="রিপোর্ট ও বিশ্লেষণ" />
    <jsp:param name="pageIcon" value="fas fa-chart-bar" />
    <jsp:param name="activePage" value="reports" />
</jsp:include>

<div class="reports-container">
    <!-- Page Actions -->
    <div class="page-actions">
        <button type="button" id="generateReportBtn" class="btn-primary">
            <i class="fas fa-file-alt"></i> রিপোর্ট তৈরি করুন
        </button>
        <button type="button" id="exportDataBtn" class="btn-secondary">
            <i class="fas fa-download"></i> ডেটা রপ্তানি করুন
        </button>
        <button type="button" id="scheduleReportBtn" class="btn-secondary">
            <i class="fas fa-clock"></i> সময়সূচী রিপোর্ট
        </button>
    </div>

    <!-- Report Statistics Overview -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-users"></i>
            </div>
            <div class="stat-content">
                <h4>মোট কৃষক</h4>
                <p class="stat-number">${totalFarmers}</p>
                <small class="stat-change positive">+${newFarmersThisMonth} এই মাসে</small>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-leaf"></i>
            </div>
            <div class="stat-content">
                <h4>মোট ফসল</h4>
                <p class="stat-number">${totalCrops}</p>
                <small class="stat-change positive">+${newCropsThisMonth} এই মাসে</small>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-map-marker-alt"></i>
            </div>
            <div class="stat-content">
                <h4>কভারেজ এলাকা</h4>
                <p class="stat-number">${totalLandArea} একর</p>
                <small class="stat-change positive">+${newLandArea} এই মাসে</small>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-chart-line"></i>
            </div>
            <div class="stat-content">
                <h4>বৃদ্ধির হার</h4>
                <p class="stat-number">${growthRate}%</p>
                <small class="stat-change positive">গত মাসের তুলনায়</small>
            </div>
        </div>
    </div>

    <!-- Report Generation Form -->
    <div class="content-area">
        <h3><i class="fas fa-cogs"></i> রিপোর্ট তৈরি করুন</h3>
        <form id="reportForm" class="report-form" method="post" action="${pageContext.request.contextPath}/admin/reports">
            <input type="hidden" name="action" value="generate">
            <div class="form-row">
                <div class="input-group">
                    <label>রিপোর্টের ধরন <span class="required">*</span></label>
                    <select name="reportType" id="reportType" required>
                        <option value="">রিপোর্টের ধরন নির্বাচন করুন</option>
                        <option value="farmer_summary">কৃষক সারসংক্ষেপ</option>
                        <option value="crop_analysis">ফসল বিশ্লেষণ</option>
                        <option value="location_distribution">অবস্থান বণ্টন</option>
                        <option value="growth_trends">বৃদ্ধির প্রবণতা</option>
                        <option value="seasonal_analysis">মৌসুমি বিশ্লেষণ</option>
                        <option value="performance_metrics">কর্মক্ষমতা মেট্রিক</option>
                    </select>
                </div>
                <div class="input-group">
                    <label>সময়কাল</label>
                    <select name="timePeriod" id="timePeriod">
                        <option value="7">গত ৭ দিন</option>
                        <option value="30" selected>গত ৩০ দিন</option>
                        <option value="90">গত ৩ মাস</option>
                        <option value="365">গত ১ বছর</option>
                        <option value="custom">কাস্টম</option>
                    </select>
                </div>
            </div>
            
            <div class="form-row" id="customDateRange" style="display: none;">
                <div class="input-group">
                    <label>শুরুর তারিখ</label>
                    <input type="date" name="startDate" id="startDate">
                </div>
                <div class="input-group">
                    <label>শেষের তারিখ</label>
                    <input type="date" name="endDate" id="endDate">
                </div>
            </div>
            
            <div class="form-row">
                <div class="input-group">
                    <label>ফিল্টার</label>
                    <select name="filterBy" id="filterBy">
                        <option value="">কোন ফিল্টার নেই</option>
                        <option value="location">অবস্থান অনুযায়ী</option>
                        <option value="crop_type">ফসলের ধরন অনুযায়ী</option>
                        <option value="land_size">জমির আকার অনুযায়ী</option>
                        <option value="registration_date">নিবন্ধনের তারিখ অনুযায়ী</option>
                    </select>
                </div>
                <div class="input-group">
                    <label>ফিল্টার মান</label>
                    <input type="text" name="filterValue" id="filterValue" placeholder="ফিল্টার মান লিখুন...">
                </div>
            </div>
            
            <div class="form-row">
                <div class="input-group">
                    <label>ফরম্যাট</label>
                    <select name="outputFormat">
                        <option value="html">HTML</option>
                        <option value="pdf">PDF</option>
                        <option value="excel">Excel</option>
                        <option value="csv">CSV</option>
                    </select>
                </div>
                <div class="input-group">
                    <label>সাজানোর ক্রম</label>
                    <select name="sortOrder">
                        <option value="asc">আরোহী ক্রম</option>
                        <option value="desc">অবরোহী ক্রম</option>
                    </select>
                </div>
            </div>
            
            <div class="form-actions">
                <button type="submit" class="btn-primary">
                    <i class="fas fa-chart-bar"></i> রিপোর্ট তৈরি করুন
                </button>
                <button type="button" class="btn-secondary" onclick="resetReportForm()">
                    <i class="fas fa-undo"></i> ফর্ম রিসেট করুন
                </button>
            </div>
        </form>
    </div>

    <!-- Quick Reports -->
    <div class="content-area" style="margin-bottom: 30px;">
        <h3><i class="fas fa-bolt"></i> দ্রুত রিপোর্ট</h3>
        <div class="quick-reports-grid">
            <div class="quick-report-card">
                <div class="report-icon">
                    <i class="fas fa-users"></i>
                </div>
                <div class="report-content">
                    <h4>কৃষক নিবন্ধন</h4>
                    <p>নতুন কৃষক নিবন্ধনের পরিসংখ্যান</p>
                </div>
                <button type="button" class="btn-primary" onclick="generateQuickReport('farmer_summary')">
                    <i class="fas fa-play"></i> চালু করুন
                </button>
            </div>
            
            <div class="quick-report-card">
                <div class="report-icon">
                    <i class="fas fa-leaf"></i>
                </div>
                <div class="report-content">
                    <h4>ফসল বণ্টন</h4>
                    <p>বিভিন্ন ফসলের চাষের পরিসংখ্যান</p>
                </div>
                <button type="button" class="btn-primary" onclick="generateQuickReport('crop_analysis')">
                    <i class="fas fa-play"></i> চালু করুন
                </button>
            </div>
            
            <div class="quick-report-card">
                <div class="report-icon">
                    <i class="fas fa-map-marked-alt"></i>
                </div>
                <div class="report-content">
                    <h4>এলাকাভিত্তিক বিশ্লেষণ</h4>
                    <p>বিভিন্ন এলাকার কৃষি পরিস্থিতি</p>
                </div>
                <button type="button" class="btn-primary" onclick="generateQuickReport('location_distribution')">
                    <i class="fas fa-play"></i> চালু করুন
                </button>
            </div>
            
            <div class="quick-report-card">
                <div class="report-icon">
                    <i class="fas fa-chart-line"></i>
                </div>
                <div class="report-content">
                    <h4>বৃদ্ধির প্রবণতা</h4>
                    <p>সময়ের সাথে বৃদ্ধির হার</p>
                </div>
                <button type="button" class="btn-primary" onclick="generateQuickReport('growth_trends')">
                    <i class="fas fa-play"></i> চালু করুন
                </button>
            </div>
        </div>
    </div>

    <!-- Report Results -->
    <div class="content-area" id="reportResults" 
         <c:if test="${showReport == true}">style="display: block;"</c:if>
         <c:if test="${showReport != true}">style="display: none;"</c:if>>
        <h3><i class="fas fa-chart-bar"></i> রিপোর্ট ফলাফল</h3>
        
        <div class="report-header">
            <div class="report-info">
                <h4 id="reportTitle">
                    <c:choose>
                        <c:when test="${reportData != null and reportData.title != null}">${reportData.title}</c:when>
                        <c:otherwise>রিপোর্টের শিরোনাম</c:otherwise>
                    </c:choose>
                </h4>
                <p id="reportDescription">
                    <c:choose>
                        <c:when test="${reportData != null and reportData.description != null}">${reportData.description}</c:when>
                        <c:otherwise>রিপোর্টের বিবরণ</c:otherwise>
                    </c:choose>
                </p>
                <small id="reportGenerated">উৎপাদনের সময়: <span id="generationTime">
                    <c:if test="${showReport == true}">
                        <jsp:useBean id="now" class="java.util.Date"/>
                        ${now}
                    </c:if>
                </span></small>
            </div>
            <div class="report-actions">
                <button type="button" id="printReportBtn" class="btn-secondary">
                    <i class="fas fa-print"></i> প্রিন্ট করুন
                </button>
                <button type="button" id="downloadReportBtn" class="btn-primary">
                    <i class="fas fa-download"></i> ডাউনলোড করুন
                </button>
            </div>
        </div>
        
        <div class="report-content" id="reportContent">
            <c:if test="${showReport == true and reportData != null}">
                <c:choose>
                    <c:when test="${reportData.error != null}">
                        <div class="error-message">${reportData.error}</div>
                    </c:when>
                    <c:otherwise>
                        <c:choose>
                            <c:when test="${reportData.reportType == 'farmer_summary'}">
                                <div class="report-section">
                                    <h4>সারসংক্ষেপ</h4>
                                    <div class="summary-stats">
                                        <div class="stat-item"><strong>মোট কৃষক:</strong> ${reportData.totalFarmers}</div>
                                        <div class="stat-item"><strong>নতুন কৃষক (এই মাসে):</strong> ${reportData.newFarmersThisMonth}</div>
                                        <div class="stat-item"><strong>সক্রিয় কৃষক:</strong> ${reportData.activeFarmers}</div>
                                    </div>
                                    
                                    <c:if test="${not empty reportData.farmersByLocation}">
                                        <h4>অবস্থান অনুযায়ী কৃষক</h4>
                                        <table class="report-table">
                                            <thead>
                                                <tr>
                                                    <th>অবস্থান</th>
                                                    <th>কৃষক সংখ্যা</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="item" items="${reportData.farmersByLocation}">
                                                    <tr>
                                                        <td>${item.location}</td>
                                                        <td>${item.count}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </c:if>
                                </div>
                            </c:when>
                            
                            <c:when test="${reportData.reportType == 'crop_analysis'}">
                                <div class="report-section">
                                    <h4>সারসংক্ষেপ</h4>
                                    <div class="summary-stats">
                                        <div class="stat-item"><strong>মোট ফসল:</strong> ${reportData.totalCrops}</div>
                                        <div class="stat-item"><strong>নতুন ফসল (এই মাসে):</strong> ${reportData.newCropsThisMonth}</div>
                                    </div>
                                    
                                    <c:if test="${not empty reportData.cropsByType}">
                                        <h4>ধরন অনুযায়ী ফসল</h4>
                                        <table class="report-table">
                                            <thead>
                                                <tr>
                                                    <th>ধরন</th>
                                                    <th>সংখ্যা</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="item" items="${reportData.cropsByType}">
                                                    <tr>
                                                        <td>${item.type}</td>
                                                        <td>${item.count}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </c:if>
                                </div>
                            </c:when>
                            
                            <c:when test="${reportData.reportType == 'location_distribution'}">
                                <div class="report-section">
                                    <c:if test="${not empty reportData.locationDistribution}">
                                        <h4>অবস্থান বণ্টন</h4>
                                        <table class="report-table">
                                            <thead>
                                                <tr>
                                                    <th>অবস্থান</th>
                                                    <th>কৃষক সংখ্যা</th>
                                                    <th>মোট জমি (একর)</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="item" items="${reportData.locationDistribution}">
                                                    <tr>
                                                        <td>${item.location}</td>
                                                        <td>${item.farmerCount}</td>
                                                        <td>${item.totalLand}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </c:if>
                                </div>
                            </c:when>
                            
                            <c:when test="${reportData.reportType == 'growth_trends'}">
                                <div class="report-section">
                                    <h4>বৃদ্ধির হার</h4>
                                    <div class="summary-stats">
                                        <div class="stat-item"><strong>বর্তমান বৃদ্ধির হার:</strong> ${reportData.growthRate}%</div>
                                    </div>
                                    
                                    <c:if test="${not empty reportData.growthTrends}">
                                        <h4>সময়ের সাথে বৃদ্ধি</h4>
                                        <table class="report-table">
                                            <thead>
                                                <tr>
                                                    <th>তারিখ</th>
                                                    <th>নতুন কৃষক</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="item" items="${reportData.growthTrends}">
                                                    <tr>
                                                        <td>${item.date}</td>
                                                        <td>${item.newFarmers}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </c:if>
                                </div>
                            </c:when>
                            
                            <c:when test="${reportData.reportType == 'seasonal_analysis'}">
                                <div class="report-section">
                                    <c:if test="${not empty reportData.seasonalData}">
                                        <h4>মৌসুমি বিশ্লেষণ</h4>
                                        <table class="report-table">
                                            <thead>
                                                <tr>
                                                    <th>মৌসুম</th>
                                                    <th>ফসল সংখ্যা</th>
                                                    <th>ধরন সংখ্যা</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="item" items="${reportData.seasonalData}">
                                                    <tr>
                                                        <td>${item.season}</td>
                                                        <td>${item.cropCount}</td>
                                                        <td>${item.typeCount}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </c:if>
                                </div>
                            </c:when>
                            
                            <c:when test="${reportData.reportType == 'performance_metrics'}">
                                <div class="report-section">
                                    <c:if test="${reportData.performanceMetrics != null}">
                                        <h4>কর্মক্ষমতা মেট্রিক</h4>
                                        <div class="summary-stats">
                                            <div class="stat-item"><strong>মোট কৃষক:</strong> ${reportData.performanceMetrics.totalFarmers}</div>
                                            <div class="stat-item"><strong>মোট অবস্থান:</strong> ${reportData.performanceMetrics.totalLocations}</div>
                                            <div class="stat-item"><strong>গড় জমির আকার:</strong> ${reportData.performanceMetrics.avgLandSize} একর</div>
                                            <div class="stat-item"><strong>মোট জমির আকার:</strong> ${reportData.performanceMetrics.totalLandArea} একর</div>
                                        </div>
                                    </c:if>
                                </div>
                            </c:when>
                            
                            <c:otherwise>
                                <div class="error-message">অজানা রিপোর্ট ধরন</div>
                            </c:otherwise>
                        </c:choose>
                    </c:otherwise>
                </c:choose>
            </c:if>
        </div>
    </div>

    <!-- Saved Reports -->
    <div class="content-area">
        <h3><i class="fas fa-save"></i> সংরক্ষিত রিপোর্ট</h3>
        
        <div class="table-container">
            <table class="styled-table" id="savedReportsTable">
                <thead>
                    <tr>
                        <th>রিপোর্টের নাম</th>
                        <th>ধরন</th>
                        <th>তৈরির তারিখ</th>
                        <th>ফরম্যাট</th>
                        <th>স্ট্যাটাস</th>
                        <th>পদক্ষেপ</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="savedReport" items="${savedReports}">
                        <tr>
                            <td>
                                <div class="report-name">
                                    <i class="fas fa-file-alt"></i>
                                    <span>${savedReport.name}</span>
                                </div>
                            </td>
                            <td>
                                <span class="report-type-badge">${savedReport.type}</span>
                            </td>
                            <td>
                                <span class="date-cell">${savedReport.createdAt}</span>
                            </td>
                            <td>
                                <span class="format-badge">${savedReport.format}</span>
                            </td>
                            <td>
                                <span class="status-badge status-${savedReport.status}">${savedReport.status}</span>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <a href="${pageContext.request.contextPath}/admin/reports/view?id=${savedReport.id}"
                                       class="action-btn btn-view" data-tooltip="দেখুন">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/reports/download?id=${savedReport.id}"
                                       class="action-btn btn-download" data-tooltip="ডাউনলোড করুন">
                                        <i class="fas fa-download"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/reports/delete?id=${savedReport.id}"
                                       class="action-btn btn-delete" data-tooltip="মুছুন"
                                       onclick="return confirm('আপনি কি নিশ্চিত যে আপনি এই রিপোর্টটি মুছতে চান?')">
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
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Handle custom date range toggle
    const timePeriod = document.getElementById('timePeriod');
    const customDateRange = document.getElementById('customDateRange');
    
    timePeriod.addEventListener('change', function() {
        if (this.value === 'custom') {
            customDateRange.style.display = 'flex';
        } else {
            customDateRange.style.display = 'none';
        }
    });
    
    // Handle report form submission
    const reportForm = document.getElementById('reportForm');
    reportForm.addEventListener('submit', function(e) {
        e.preventDefault();
        generateReport();
    });
    
    // Set default dates for custom range
    const today = new Date();
    const thirtyDaysAgo = new Date(today.getTime() - (30 * 24 * 60 * 60 * 1000));
    
    document.getElementById('startDate').value = thirtyDaysAgo.toISOString().split('T')[0];
    document.getElementById('endDate').value = today.toISOString().split('T')[0];
});

function resetReportForm() {
    document.getElementById('reportForm').reset();
    document.getElementById('customDateRange').style.display = 'none';
    document.getElementById('reportResults').style.display = 'none';
}

function generateReport() {
    const formData = new FormData(document.getElementById('reportForm'));
    const reportType = formData.get('reportType');
    
    if (!reportType) {
        alert('অনুগ্রহ করে রিপোর্টের ধরন নির্বাচন করুন');
        return;
    }
    
    // Show loading state
    document.getElementById('reportResults').style.display = 'block';
    document.getElementById('reportContent').innerHTML = '<div class="loading">রিপোর্ট তৈরি হচ্ছে...</div>';
    
    // Submit the form
    document.getElementById('reportForm').submit();
}

function generateQuickReport(reportType) {
    // Set form values for quick report
    document.getElementById('reportType').value = reportType;
    document.getElementById('timePeriod').value = '30';
    
    // Generate report
    generateReport();
}

// Handle print functionality
document.getElementById('printReportBtn').addEventListener('click', function() {
    window.print();
});

// Handle download functionality
document.getElementById('downloadReportBtn').addEventListener('click', function() {
    const reportContent = document.getElementById('reportContent').innerHTML;
    const blob = new Blob([reportContent], { type: 'text/html' });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'report.html';
    a.click();
    window.URL.revokeObjectURL(url);
});
</script>

<style>
.report-form {
    background: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.form-row {
    display: flex;
    gap: 20px;
    margin-bottom: 15px;
}

.input-group {
    flex: 1;
}

.input-group label {
    display: block;
    margin-bottom: 5px;
    font-weight: 500;
    color: #333;
}

.input-group input,
.input-group select {
    width: 100%;
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
}

.required {
    color: #e74c3c;
}

.form-actions {
    display: flex;
    gap: 10px;
    margin-top: 20px;
}

.quick-reports-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
    margin-top: 20px;
}

.quick-report-card {
    background: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    display: flex;
    align-items: center;
    gap: 15px;
}

.report-icon {
    width: 50px;
    height: 50px;
    background: #3498db;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 20px;
}

.report-content {
    flex: 1;
}

.report-content h4 {
    margin: 0 0 5px 0;
    color: #333;
}

.report-content p {
    margin: 0;
    color: #666;
    font-size: 14px;
}

.report-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    padding-bottom: 15px;
    border-bottom: 1px solid #eee;
}

.report-info h4 {
    margin: 0 0 5px 0;
    color: #333;
}

.report-info p {
    margin: 0 0 5px 0;
    color: #666;
}

.report-info small {
    color: #999;
}

.report-actions {
    display: flex;
    gap: 10px;
}

.report-section {
    margin-bottom: 30px;
}

.report-section h4 {
    color: #333;
    border-bottom: 2px solid #3498db;
    padding-bottom: 5px;
    margin-bottom: 15px;
}

.summary-stats {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 15px;
    margin-bottom: 20px;
}

.stat-item {
    background: #f8f9fa;
    padding: 15px;
    border-radius: 6px;
    border-left: 4px solid #3498db;
}

.report-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 15px;
}

.report-table th,
.report-table td {
    padding: 12px;
    text-align: left;
    border-bottom: 1px solid #eee;
}

.report-table th {
    background: #f8f9fa;
    font-weight: 600;
    color: #333;
}

.report-table tr:hover {
    background: #f8f9fa;
}

.loading {
    text-align: center;
    padding: 40px;
    color: #666;
}

.error-message {
    background: #fee;
    color: #c33;
    padding: 15px;
    border-radius: 4px;
    border-left: 4px solid #c33;
}

.report-type-badge,
.format-badge {
    background: #3498db;
    color: white;
    padding: 4px 8px;
    border-radius: 12px;
    font-size: 12px;
}

.status-badge {
    padding: 4px 8px;
    border-radius: 12px;
    font-size: 12px;
}

.status-completed {
    background: #27ae60;
    color: white;
}

.status-pending {
    background: #f39c12;
    color: white;
}

.status-failed {
    background: #e74c3c;
    color: white;
}

.action-buttons {
    display: flex;
    gap: 5px;
}

.action-btn {
    padding: 6px 8px;
    border-radius: 4px;
    text-decoration: none;
    color: white;
    font-size: 12px;
}

.btn-view {
    background: #3498db;
}

.btn-download {
    background: #27ae60;
}

.btn-delete {
    background: #e74c3c;
}

.report-name {
    display: flex;
    align-items: center;
    gap: 8px;
}

.report-name i {
    color: #3498db;
}

@media print {
    .page-actions,
    .form-actions,
    .report-actions {
        display: none;
    }
}
</style>

<jsp:include page="/WEB-INF/includes/admin_footer.jsp" />
