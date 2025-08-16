<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<jsp:include page="/WEB-INF/includes/admin_header.jsp">
    <jsp:param name="pageTitle" value="ফসল ব্যবস্থাপনা" />
    <jsp:param name="pageIcon" value="fas fa-leaf" />
    <jsp:param name="activePage" value="crops" />
</jsp:include>

<style>
/* Enhanced Crop Management Design System */
:root {
    --primary-color: #2ecc71;
    --primary-dark: #27ae60;
    --secondary-color: #3498db;
    --accent-color: #f39c12;
    --danger-color: #e74c3c;
    --success-color: #27ae60;
    --warning-color: #f39c12;
    --text-primary: #2c3e50;
    --text-secondary: #7f8c8d;
    --bg-light: #f8f9fa;
    --border-color: #e9ecef;
    --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    --shadow-hover: 0 8px 15px rgba(0, 0, 0, 0.15);
    --border-radius: 16px;
    --transition: all 0.3s ease;
}

/* Enhanced Page Header */
.page-header {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 40px;
    border-radius: var(--border-radius);
    margin-bottom: 30px;
    text-align: center;
    position: relative;
    overflow: hidden;
    box-shadow: 0 20px 40px rgba(0,0,0,0.1);
}

.page-header::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="rgba(255,255,255,0.1)"/><circle cx="75" cy="75" r="1" fill="rgba(255,255,255,0.1)"/><circle cx="50" cy="10" r="0.5" fill="rgba(255,255,255,0.1)"/><circle cx="10" cy="60" r="0.5" fill="rgba(255,255,255,0.1)"/><circle cx="90" cy="40" r="0.5" fill="rgba(255,255,255,0.1)"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
    opacity: 0.3;
}

.page-header h1 {
    margin: 0 0 15px 0;
    font-size: 2.8rem;
    font-weight: 700;
    position: relative;
    z-index: 1;
}

.page-header p {
    margin: 0;
    font-size: 1.2rem;
    opacity: 0.9;
    position: relative;
    z-index: 1;
}

/* Enhanced Statistics Cards */
.stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 25px;
    margin-bottom: 40px;
}

.stat-card {
    background: white;
    border-radius: var(--border-radius);
    padding: 30px;
    box-shadow: var(--shadow);
    border: 1px solid rgba(255,255,255,0.2);
    transition: all 0.3s ease;
    position: relative;
    overflow: hidden;
}

.stat-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 4px;
    background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
    transform: scaleX(0);
    transition: transform 0.3s ease;
}

.stat-card:hover::before {
    transform: scaleX(1);
}

.stat-card:hover {
    transform: translateY(-10px);
    box-shadow: 0 20px 50px rgba(0,0,0,0.15);
}

.stat-header {
    display: flex;
    align-items: center;
    gap: 20px;
    margin-bottom: 20px;
}

.stat-icon {
    width: 60px;
    height: 60px;
    border-radius: 15px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 24px;
    color: white;
}

.stat-icon.total { background: linear-gradient(135deg, #667eea, #764ba2); }
.stat-icon.monthly { background: linear-gradient(135deg, #f093fb, #f5576c); }
.stat-icon.active { background: linear-gradient(135deg, #4facfe, #00f2fe); }
.stat-icon.types { background: linear-gradient(135deg, #43e97b, #38f9d7); }

.stat-content h4 {
    margin: 0 0 8px 0;
    color: var(--text-secondary);
    font-size: 1rem;
    font-weight: 500;
}

.stat-number {
    font-size: 2.5rem;
    font-weight: 700;
    margin: 0;
    background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

/* Quick Actions Section */
.quick-actions-section {
    background: white;
    border-radius: var(--border-radius);
    padding: 30px;
    margin-bottom: 30px;
    box-shadow: var(--shadow);
}

.quick-actions-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 20px;
    margin-top: 25px;
}

.quick-action-card {
    background: linear-gradient(135deg, #f8f9fa, #e9ecef);
    border-radius: 15px;
    padding: 25px;
    text-align: center;
    transition: all 0.3s ease;
    border: 2px solid transparent;
    cursor: pointer;
    text-decoration: none;
    color: var(--dark-color);
}

.quick-action-card:hover {
    transform: translateY(-5px);
    background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
    color: white;
    border-color: var(--primary-color);
    box-shadow: 0 15px 35px rgba(39, 174, 96, 0.3);
}

.quick-action-card i {
    font-size: 2.5rem;
    margin-bottom: 15px;
    display: block;
    transition: all 0.3s ease;
}

.quick-action-card:hover i {
    transform: scale(1.1);
}

.quick-action-card h4 {
    margin: 0;
    font-size: 1.1rem;
    font-weight: 600;
}

/* Enhanced Search and Filter */
.search-filter-section {
    background: white;
    border-radius: var(--border-radius);
    padding: 30px;
    margin-bottom: 30px;
    box-shadow: var(--shadow);
}

.search-filter-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 25px;
    flex-wrap: wrap;
    gap: 20px;
}

.search-filter-header h3 {
    margin: 0;
    color: var(--text-primary);
    font-size: 1.4rem;
    font-weight: 600;
    display: flex;
    align-items: center;
    gap: 12px;
}

.search-filter-header h3 i {
    color: var(--primary-color);
    font-size: 1.2rem;
}

.search-filter-controls {
    display: flex;
    gap: 20px;
    flex-wrap: wrap;
    align-items: center;
}

.search-box {
    position: relative;
    min-width: 300px;
}

.search-input {
    width: 100%;
    padding: 15px 20px 15px 50px;
    border: 2px solid var(--border-color);
    border-radius: 25px;
    font-size: 1rem;
    transition: all 0.3s ease;
    background: white;
}

.search-input:focus {
    outline: none;
    border-color: var(--primary-color);
    box-shadow: 0 0 0 4px rgba(46, 204, 113, 0.1);
    transform: translateY(-2px);
}

.search-icon {
    position: absolute;
    left: 20px;
    top: 50%;
    transform: translateY(-50%);
    color: var(--text-secondary);
    font-size: 1.1rem;
}

.filter-controls {
    display: flex;
    gap: 15px;
    flex-wrap: wrap;
}

.filter-select {
    padding: 12px 20px;
    border: 2px solid var(--border-color);
    border-radius: 12px;
    font-size: 0.95rem;
    background: white;
    transition: all 0.3s ease;
    min-width: 150px;
    cursor: pointer;
}

.filter-select:focus {
    outline: none;
    border-color: var(--primary-color);
    box-shadow: 0 0 0 3px rgba(46, 204, 113, 0.1);
}

/* Enhanced Table */
.crops-table-section {
    background: white;
    border-radius: var(--border-radius);
    padding: 30px;
    box-shadow: var(--shadow);
    overflow: hidden;
}

.table-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 25px;
}

.table-header h3 {
    margin: 0;
    color: var(--text-primary);
    font-size: 1.4rem;
    font-weight: 600;
    display: flex;
    align-items: center;
    gap: 12px;
}

.table-header h3 i {
    color: var(--primary-color);
    font-size: 1.2rem;
}

.enhanced-table {
    width: 100%;
    border-collapse: collapse;
    background: white;
    border-radius: var(--border-radius);
    overflow: hidden;
    box-shadow: 0 5px 15px rgba(0,0,0,0.08);
}

.enhanced-table thead th {
    background: linear-gradient(135deg, var(--dark-color), #34495e);
    color: white;
    font-weight: 600;
    padding: 20px;
    text-align: left;
    border: none;
    font-size: 0.95rem;
}

.enhanced-table tbody td {
    padding: 20px;
    border-bottom: 1px solid #f1f3f4;
    transition: background-color 0.3s ease;
}

.enhanced-table tbody tr:hover {
    background-color: #f8f9fa;
    transform: scale(1.01);
}

.crop-info {
    display: flex;
    align-items: center;
    gap: 15px;
}

.crop-icon {
    width: 50px;
    height: 50px;
    background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 1.2rem;
}

.crop-name {
    font-weight: 600;
    color: var(--text-primary);
    font-size: 1.1rem;
}

.crop-type-badge, .season-badge {
    padding: 8px 16px;
    border-radius: 20px;
    font-size: 0.9rem;
    font-weight: 500;
    text-align: center;
    display: inline-block;
    min-width: 100px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.crop-type-badge {
    background: linear-gradient(135deg, #e3f2fd, #bbdefb);
    color: #1565c0;
}

.season-badge {
    background: linear-gradient(135deg, #fff3e0, #ffe0b2);
    color: #ef6c00;
}

.crop-description {
    color: var(--text-secondary);
    font-size: 0.9rem;
    line-height: 1.5;
    max-width: 250px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

/* Enhanced Action Buttons */
.action-buttons {
    display: flex;
    gap: 10px;
    justify-content: center;
}

.action-btn {
    width: 40px;
    height: 40px;
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    text-decoration: none;
    color: white;
    font-size: 1rem;
    transition: all 0.3s ease;
    border: none;
    cursor: pointer;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.action-btn:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 20px rgba(0,0,0,0.2);
}

.btn-view { background: linear-gradient(135deg, var(--secondary-color), #2980b9); }
.btn-edit { background: linear-gradient(135deg, var(--accent-color), #e67e22); }
.btn-delete { background: linear-gradient(135deg, var(--danger-color), #c0392b); }

/* Empty State */
.empty-state {
    text-align: center;
    padding: 60px 20px;
    color: var(--text-secondary);
}

.empty-state i {
    font-size: 4rem;
    color: var(--primary-color);
    margin-bottom: 20px;
    opacity: 0.6;
}

.empty-state h3 {
    margin: 0 0 10px 0;
    color: var(--text-primary);
    font-weight: 600;
}

.empty-state p {
    margin: 0 0 15px 0;
    font-size: 1.1rem;
}

.empty-state small {
    color: var(--text-secondary);
    font-size: 0.9rem;
}

/* Enhanced Modal */
.modal-overlay {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.6);
    backdrop-filter: blur(5px);
    z-index: 1000;
    align-items: center;
    justify-content: center;
}

.modal-content {
    background: white;
    border-radius: var(--border-radius);
    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
    max-width: 500px;
    width: 90%;
    max-height: 90vh;
    overflow-y: auto;
    animation: modalSlideIn 0.3s ease-out;
}

@keyframes modalSlideIn {
    from {
        opacity: 0;
        transform: translateY(-50px) scale(0.9);
    }
    to {
        opacity: 1;
        transform: translateY(0) scale(1);
    }
}

.modal-header {
    background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
    color: white;
    padding: 25px;
    border-radius: var(--border-radius) var(--border-radius) 0 0;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.modal-header h3 {
    margin: 0;
    font-size: 1.3rem;
    font-weight: 600;
}

.modal-close {
    background: rgba(255, 255, 255, 0.2);
    border: none;
    color: white;
    font-size: 24px;
    cursor: pointer;
    width: 35px;
    height: 35px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.3s ease;
}

.modal-close:hover {
    background: rgba(255, 255, 255, 0.3);
    transform: scale(1.1);
}

.modal-body {
    padding: 25px;
}

.crop-details {
    display: flex;
    flex-direction: column;
    gap: 20px;
}

.detail-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px;
    background: var(--bg-light);
    border-radius: 10px;
    border-left: 4px solid var(--primary-color);
}

.detail-row label {
    font-weight: 600;
    color: var(--text-primary);
    min-width: 120px;
}

.detail-row span {
    color: var(--text-secondary);
    text-align: right;
    flex: 1;
}

.modal-footer {
    padding: 25px;
    border-top: 1px solid var(--border-color);
    display: flex;
    gap: 15px;
    justify-content: flex-end;
}

/* Responsive Design */
@media (max-width: 768px) {
    .page-header {
        padding: 30px 20px;
    }
    
    .page-header h1 {
        font-size: 2.2rem;
    }
    
    .stats-grid {
        grid-template-columns: 1fr;
        gap: 20px;
    }
    
    .quick-actions-grid {
        grid-template-columns: 1fr;
    }
    
    .search-filter-controls {
        flex-direction: column;
        align-items: stretch;
    }
    
    .search-box {
        min-width: 100%;
    }
    
    .filter-controls {
        justify-content: center;
    }
    
    .table-header {
        flex-direction: column;
        gap: 15px;
        align-items: flex-start;
    }
    
    .enhanced-table {
        font-size: 0.9rem;
    }
    
    .enhanced-table thead th,
    .enhanced-table tbody td {
        padding: 15px 10px;
    }
    
    .action-buttons {
        flex-direction: column;
        gap: 5px;
    }
    
    .action-btn {
        width: 35px;
        height: 35px;
    }
}

/* Loading Animation */
.loading-shimmer {
    background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
    background-size: 200% 100%;
    animation: shimmer 1.5s infinite;
}

@keyframes shimmer {
    0% { background-position: -200% 0; }
    100% { background-position: 200% 0; }
}
</style>

<!-- Enhanced Page Header -->
<div class="page-header">
    <h1><i class="fas fa-seedling"></i> ফসল ব্যবস্থাপনা</h1>
    <p>আপনার কৃষি ব্যবস্থায় ফসলের তথ্য দেখুন, যোগ করুন এবং ব্যবস্থাপনা করুন</p>
</div>

<!-- Enhanced Statistics Cards -->
<div class="stats-grid">
    <div class="stat-card">
        <div class="stat-header">
            <div class="stat-icon total">
                <i class="fas fa-leaf"></i>
            </div>
            <div class="stat-content">
                <h4>মোট ফসল</h4>
                <p class="stat-number">${cropCount != null ? cropCount : '0'}</p>
            </div>
        </div>
    </div>
    
    <div class="stat-card">
        <div class="stat-header">
            <div class="stat-icon monthly">
                <i class="fas fa-calendar-plus"></i>
            </div>
            <div class="stat-content">
                <h4>এই মাসে যোগ করা</h4>
                <p class="stat-number">${monthlyCropCount != null ? monthlyCropCount : '0'}</p>
            </div>
        </div>
    </div>
    
    <div class="stat-card">
        <div class="stat-header">
            <div class="stat-icon active">
                <i class="fas fa-check-circle"></i>
            </div>
            <div class="stat-content">
                <h4>সক্রিয় ফসল</h4>
                <p class="stat-number">${activeCropCount != null ? activeCropCount : '0'}</p>
            </div>
        </div>
    </div>
    
    <div class="stat-card">
        <div class="stat-header">
            <div class="stat-icon types">
                <i class="fas fa-tags"></i>
            </div>
            <div class="stat-content">
                <h4>ফসলের ধরন</h4>
                <p class="stat-number">${cropTypeCount != null ? cropTypeCount : '0'}</p>
            </div>
        </div>
    </div>
</div>

<!-- Quick Actions Section -->
<div class="quick-actions-section">
    <h3><i class="fas fa-bolt"></i> দ্রুত পদক্ষেপ</h3>
    <div class="quick-actions-grid">
        <a href="${pageContext.request.contextPath}/admin/crops/add" class="quick-action-card">
            <i class="fas fa-plus-circle"></i>
            <h4>নতুন ফসল যোগ করুন</h4>
        </a>
        <a href="${pageContext.request.contextPath}/admin/crops/import" class="quick-action-card">
            <i class="fas fa-file-import"></i>
            <h4>ফাইল থেকে আমদানি</h4>
        </a>
        <a href="${pageContext.request.contextPath}/admin/crops/export" class="quick-action-card">
            <i class="fas fa-file-export"></i>
            <h4>ফাইল হিসেবে রপ্তানি</h4>
        </a>
        <a href="${pageContext.request.contextPath}/admin/crops/analytics" class="quick-action-card">
            <i class="fas fa-chart-pie"></i>
            <h4>ফসল বিশ্লেষণ</h4>
        </a>
    </div>
</div>

<!-- Enhanced Search and Filter -->
<div class="search-filter-section">
    <div class="search-filter-header">
        <h3><i class="fas fa-search"></i> ফসল অনুসন্ধান ও ফিল্টার</h3>
        <div class="search-filter-controls">
            <div class="search-box">
                <input type="text" id="cropSearch" placeholder="ফসলের নাম দিয়ে অনুসন্ধান করুন..." class="search-input">
                <i class="fas fa-search search-icon"></i>
            </div>
            <div class="filter-controls">
                <select id="cropTypeFilter" class="filter-select">
                    <option value="">সব ধরন</option>
                    <option value="ধান">ধান</option>
                    <option value="গম">গম</option>
                    <option value="ভুট্টা">ভুট্টা</option>
                    <option value="ডাল">ডাল</option>
                    <option value="সবজি">সবজি</option>
                    <option value="ফল">ফল</option>
                    <option value="অন্যান্য">অন্যান্য</option>
                </select>
                <select id="seasonFilter" class="filter-select">
                    <option value="">সব মৌসুম</option>
                    <option value="রবি">রবি</option>
                    <option value="খরিফ">খরিফ</option>
                    <option value="জায়েদ">জায়েদ</option>
                    <option value="সারা বছর">সারা বছর</option>
                </select>
                <button id="clearFilters" class="btn-secondary" style="padding: 12px 20px; border-radius: 12px;">
                    <i class="fas fa-times"></i> ফিল্টার মুছুন
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Enhanced Crops Table -->
<div class="crops-table-section">
    <div class="table-header">
        <h3><i class="fas fa-list"></i> বিদ্যমান ফসলের তালিকা</h3>
        <div style="display: flex; gap: 15px; align-items: center;">
            <span style="color: var(--text-secondary); font-size: 0.9rem;">
                মোট: <strong>${cropCount != null ? cropCount : '0'}</strong> টি ফসল
            </span>
        </div>
    </div>
    
    <div class="table-container">
        <table class="enhanced-table" id="cropsTable">
            <thead>
                <tr>
                    <th>ফসলের নাম</th>
                    <th>ধরন</th>
                    <th>মৌসুম</th>
                    <th>বিবরণ</th>
                    <th>যোগ করার তারিখ</th>
                    <th>পদক্ষেপ</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${cropList != null && !cropList.isEmpty()}">
                        <c:forEach var="crop" items="${cropList}">
                            <tr>
                                <td>
                                    <div class="crop-info">
                                        <div class="crop-icon">
                                            <i class="fas fa-leaf"></i>
                                        </div>
                                        <span class="crop-name">${crop.name}</span>
                                    </div>
                                </td>
                                <td>
                                    <span class="crop-type-badge">${crop.type != null ? crop.type : 'নির্ধারিত নয়'}</span>
                                </td>
                                <td>
                                    <span class="season-badge">${crop.season != null ? crop.season : 'নির্ধারিত নয়'}</span>
                                </td>
                                <td>
                                    <div class="crop-description" title="${crop.description != null ? crop.description : 'কোন বিবরণ নেই'}">
                                        ${crop.description != null ? crop.description : 'কোন বিবরণ নেই'}
                                    </div>
                                </td>
                                <td>${crop.createdAt != null ? crop.createdAt.toLocalDate().toString() : 'N/A'}</td>
                                <td>
                                    <div class="action-buttons">
                                        <a href="${pageContext.request.contextPath}/admin/crops/edit/${crop.id}" 
                                           class="action-btn btn-edit" data-tooltip="সম্পাদনা করুন">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/crops/view/${crop.id}" 
                                           class="action-btn btn-view" data-tooltip="দেখুন">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <button type="button" class="action-btn btn-delete" 
                                                onclick="deleteCrop(${crop.id}, '${crop.name}')"                   
                                                data-tooltip="মুছুন">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="6">
                                <div class="empty-state">
                                    <i class="fas fa-leaf"></i>
                                    <h3>কোন ফসল পাওয়া যায়নি</h3>
                                    <p>এখনও কোন ফসল যোগ করা হয়নি</p>
                                    <small>উপরে নতুন ফসল যোগ করে শুরু করুন</small>
                                </div>
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>

<!-- Enhanced Crop View Modal -->
<c:if test="${viewCrop != null}">
    <div class="modal-overlay" id="cropViewModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3><i class="fas fa-leaf"></i> ফসলের বিবরণ</h3>
                <button class="modal-close" onclick="closeCropViewModal()">&times;</button>
            </div>
            <div class="modal-body">
                <div class="crop-details">
                    <div class="detail-row">
                        <label>নাম:</label>
                        <span>${viewCrop.name}</span>
                    </div>
                    <div class="detail-row">
                        <label>ধরন:</label>
                        <span>${viewCrop.type != null ? viewCrop.type : 'নির্ধারিত নয়'}</span>
                    </div>
                    <div class="detail-row">
                        <label>মৌসুম:</label>
                        <span>${viewCrop.season != null ? viewCrop.season : 'নির্ধারিত নয়'}</span>
                    </div>
                    <div class="detail-row">
                        <label>বিবরণ:</label>
                        <span>${viewCrop.description != null ? viewCrop.description : 'কোন বিবরণ নেই'}</span>
                    </div>
                    <div class="detail-row">
                        <label>যোগ করার তারিখ:</label>
                        <span>${viewCrop.createdAt != null ? viewCrop.createdAt.toLocalDate().toString() : 'N/A'}</span>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <a href="${pageContext.request.contextPath}/admin/crops/edit/${viewCrop.id}" class="btn-primary">
                    <i class="fas fa-edit"></i> সম্পাদনা করুন
                </a>
                <button class="btn-secondary" onclick="closeCropViewModal()">বন্ধ করুন</button>
            </div>
        </div>
    </div>
</c:if>

<!-- Enhanced Delete Confirmation Modal -->
<div id="deleteModal" class="modal-overlay" style="display: none;">
    <div class="modal-content">
        <div class="modal-header">
            <h3><i class="fas fa-exclamation-triangle"></i> ফসল মুছুন</h3>
        </div>
        <div class="modal-body">
            <p>আপনি কি নিশ্চিত যে আপনি "<span id="cropNameToDelete"></span>" ফসলটি মুছতে চান?</p>
            <p style="color: var(--warning-color); font-weight: 600; margin-top: 15px;">
                <i class="fas fa-exclamation-triangle"></i> এই কাজটি অপরিবর্তনীয়!
            </p>
        </div>
        <div class="modal-footer">
            <form id="deleteForm" action="${pageContext.request.contextPath}/admin/crops" method="post">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="cropId" id="cropIdToDelete">
                <button type="submit" class="btn-danger">
                    <i class="fas fa-trash"></i> মুছুন
                </button>
                <button type="button" class="btn-secondary" onclick="closeDeleteModal()">
                    <i class="fas fa-times"></i> বাতিল করুন
                </button>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/admin_footer.jsp" />

<script>
// Enhanced Crop Management JavaScript
document.addEventListener('DOMContentLoaded', function() {
    // Show crop view modal if viewing a crop
    const cropViewModal = document.getElementById('cropViewModal');
    if (cropViewModal) {
        cropViewModal.style.display = 'flex';
    }
    
    // Initialize tooltips
    initializeTooltips();
    
    // Initialize search and filter
    initializeSearchAndFilter();
    
    // Add loading animations
    addLoadingAnimations();
});

// Close crop view modal
function closeCropViewModal() {
    const modal = document.getElementById('cropViewModal');
    if (modal) {
        modal.style.display = 'none';
    }
}

// Initialize tooltips
function initializeTooltips() {
    const tooltipElements = document.querySelectorAll('[data-tooltip]');
    tooltipElements.forEach(element => {
        element.addEventListener('mouseenter', function(e) {
            const tooltip = document.createElement('div');
            tooltip.className = 'tooltip';
            tooltip.textContent = this.getAttribute('data-tooltip');
            tooltip.style.cssText = `
                position: absolute;
                background: rgba(0,0,0,0.8);
                color: white;
                padding: 8px 12px;
                border-radius: 6px;
                font-size: 12px;
                z-index: 1000;
                pointer-events: none;
                white-space: nowrap;
            `;
            document.body.appendChild(tooltip);
            
            const rect = this.getBoundingClientRect();
            tooltip.style.left = rect.left + (rect.width / 2) - (tooltip.offsetWidth / 2) + 'px';
            tooltip.style.top = rect.top - tooltip.offsetHeight - 10 + 'px';
            
            this.tooltip = tooltip;
        });
        
        element.addEventListener('mouseleave', function() {
            if (this.tooltip) {
                this.tooltip.remove();
                this.tooltip = null;
            }
        });
    });
}

// Initialize search and filter functionality
function initializeSearchAndFilter() {
    const searchInput = document.getElementById('cropSearch');
    const typeFilter = document.getElementById('cropTypeFilter');
    const seasonFilter = document.getElementById('seasonFilter');
    const clearFiltersBtn = document.getElementById('clearFilters');
    const table = document.getElementById('cropsTable');
    
    if (!table) return;
    
    function filterTable() {
        const searchTerm = searchInput.value.toLowerCase();
        const selectedType = typeFilter.value.toLowerCase();
        const selectedSeason = seasonFilter.value.toLowerCase();
        
        const rows = table.querySelectorAll('tbody tr');
        let visibleCount = 0;
        
        rows.forEach(row => {
            const name = row.cells[0].textContent.toLowerCase();
            const type = row.cells[1].textContent.toLowerCase();
            const season = row.cells[2].textContent.toLowerCase();
            
            const matchesSearch = name.includes(searchTerm);
            const matchesType = !selectedType || type.includes(selectedType);
            const matchesSeason = !selectedSeason || season.includes(selectedSeason);
            
            if (matchesSearch && matchesType && matchesSeason) {
                row.style.display = '';
                visibleCount++;
            } else {
                row.style.display = 'none';
            }
        });
        
        // Update visible count
        const countElement = document.querySelector('.table-header span strong');
        if (countElement) {
            countElement.textContent = visibleCount;
        }
    }
    
    // Add event listeners
    searchInput.addEventListener('input', filterTable);
    typeFilter.addEventListener('change', filterTable);
    seasonFilter.addEventListener('change', filterTable);
    
    // Clear filters
    clearFiltersBtn.addEventListener('click', function() {
        searchInput.value = '';
        typeFilter.value = '';
        seasonFilter.value = '';
        filterTable();
    });
}

// Add loading animations
function addLoadingAnimations() {
    const cards = document.querySelectorAll('.stat-card');
    cards.forEach((card, index) => {
        setTimeout(() => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(20px)';
            card.style.transition = 'all 0.6s ease';
            
            setTimeout(() => {
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            }, 100);
        }, index * 100);
    });
    
    const quickActionCards = document.querySelectorAll('.quick-action-card');
    quickActionCards.forEach((card, index) => {
        setTimeout(() => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(20px)';
            card.style.transition = 'all 0.6s ease';
            
            setTimeout(() => {
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            }, 100);
        }, (index * 100) + 400);
    });
}

// Delete crop function
function deleteCrop(cropId, cropName) {
    document.getElementById('cropNameToDelete').textContent = cropName;
    document.getElementById('cropIdToDelete').value = cropId;
    document.getElementById('deleteModal').style.display = 'flex';
}

// Close delete modal
function closeDeleteModal() {
    document.getElementById('deleteModal').style.display = 'none';
}

// Close modal when clicking outside
document.addEventListener('click', function(e) {
    if (e.target.classList.contains('modal-overlay')) {
        e.target.style.display = 'none';
    }
});

// Add hover effects to table rows
document.addEventListener('DOMContentLoaded', function() {
    const tableRows = document.querySelectorAll('.enhanced-table tbody tr');
    tableRows.forEach(row => {
        row.addEventListener('mouseenter', function() {
            this.style.backgroundColor = '#f8f9fa';
        });
        
        row.addEventListener('mouseleave', function() {
            this.style.backgroundColor = '';
        });
    });
});
</script>