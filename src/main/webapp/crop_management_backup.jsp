<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<jsp:include page="/WEB-INF/includes/admin_header.jsp">
    <jsp:param name="pageTitle" value="ফসল ব্যবস্থাপনা" />
    <jsp:param name="pageIcon" value="fas fa-leaf" />
    <jsp:param name="activePage" value="crops" />
</jsp:include>

<style>
/* Modern Design System */
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
    --border-radius: 12px;
    --transition: all 0.3s ease;
}

/* Alert System */
.alert {
    padding: 16px 20px;
    border-radius: var(--border-radius);
    margin: 20px 0;
    display: flex;
    align-items: center;
    gap: 12px;
    font-weight: 500;
    animation: slideIn 0.3s ease;
}

.alert-success {
    background: linear-gradient(135deg, #d4edda, #c3e6cb);
    color: #155724;
    border-left: 4px solid var(--success-color);
}

.alert-error {
    background: linear-gradient(135deg, #f8d7da, #f5c6cb);
    color: #721c24;
    border-left: 4px solid var(--danger-color);
}

@keyframes slideIn {
    from { transform: translateY(-20px); opacity: 0; }
    to { transform: translateY(0); opacity: 1; }
}

/* Page Header */
.page-header {
    background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
    color: white;
    padding: 30px;
    border-radius: var(--border-radius);
    margin-bottom: 30px;
    text-align: center;
    box-shadow: var(--shadow);
}

.page-header h1 {
    margin: 0 0 10px 0;
    font-size: 2.5rem;
    font-weight: 700;
}

.page-header p {
    margin: 0;
    font-size: 1.1rem;
    opacity: 0.9;
}

/* Content Areas */
.content-area {
    background: white;
    border-radius: var(--border-radius);
    padding: 30px;
    margin-bottom: 30px;
    box-shadow: var(--shadow);
    transition: var(--transition);
}

.content-area:hover {
    box-shadow: var(--shadow-hover);
}

.content-area h3 {
    color: var(--text-primary);
    margin: 0 0 25px 0;
    font-size: 1.5rem;
    font-weight: 600;
    display: flex;
    align-items: center;
    gap: 12px;
}

.content-area h3 i {
    color: var(--primary-color);
    font-size: 1.3rem;
}

/* Form Styling */
.crop-form {
    background: var(--bg-light);
    padding: 25px;
    border-radius: var(--border-radius);
    border: 2px solid var(--border-color);
}

.form-row {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
    margin-bottom: 20px;
}

.input-group {
    display: flex;
    flex-direction: column;
}

.input-group label {
    font-weight: 600;
    color: var(--text-primary);
    margin-bottom: 8px;
    font-size: 0.95rem;
}

.required {
    color: var(--danger-color);
    font-weight: 700;
}

.input-group input,
.input-group select,
.input-group textarea {
    padding: 12px 16px;
    border: 2px solid var(--border-color);
    border-radius: 8px;
    font-size: 1rem;
    transition: var(--transition);
    background: white;
}

.input-group input:focus,
.input-group select:focus,
.input-group textarea:focus {
    outline: none;
    border-color: var(--primary-color);
    box-shadow: 0 0 0 3px rgba(46, 204, 113, 0.1);
}

.input-group textarea {
    resize: vertical;
    min-height: 100px;
}

/* Button System */
.form-actions {
    display: flex;
    gap: 15px;
    justify-content: flex-end;
    margin-top: 25px;
}

.btn-primary, .btn-secondary, .btn-danger {
    padding: 12px 24px;
    border: none;
    border-radius: 8px;
    font-size: 1rem;
    font-weight: 600;
    cursor: pointer;
    transition: var(--transition);
    display: inline-flex;
    align-items: center;
    gap: 8px;
    text-decoration: none;
    min-width: 120px;
    justify-content: center;
}

.btn-primary {
    background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
    color: white;
}

.btn-primary:hover {
    transform: translateY(-2px);
    box-shadow: var(--shadow-hover);
}

.btn-secondary {
    background: linear-gradient(135deg, var(--secondary-color), #2980b9);
    color: white;
}

.btn-secondary:hover {
    transform: translateY(-2px);
    box-shadow: var(--shadow-hover);
}

.btn-danger {
    background: linear-gradient(135deg, var(--danger-color), #c0392b);
    color: white;
}

.btn-danger:hover {
    transform: translateY(-2px);
    box-shadow: var(--shadow-hover);
}

/* Table Controls */
.table-controls {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 25px;
    flex-wrap: wrap;
    gap: 20px;
}

.search-box {
    position: relative;
    flex: 1;
    max-width: 400px;
}

.search-input {
    width: 100%;
    padding: 12px 16px 12px 45px;
    border: 2px solid var(--border-color);
    border-radius: 25px;
    font-size: 1rem;
    transition: var(--transition);
}

.search-input:focus {
    outline: none;
    border-color: var(--primary-color);
    box-shadow: 0 0 0 3px rgba(46, 204, 113, 0.1);
}

.search-icon {
    position: absolute;
    left: 16px;
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
    padding: 10px 16px;
    border: 2px solid var(--border-color);
    border-radius: 8px;
    font-size: 0.95rem;
    background: white;
    transition: var(--transition);
    min-width: 140px;
}

.filter-select:focus {
    outline: none;
    border-color: var(--primary-color);
}

/* Table Styling */
.table-container {
    background: white;
    border-radius: var(--border-radius);
    overflow: hidden;
    box-shadow: var(--shadow);
    border: 1px solid var(--border-color);
}

.styled-table {
    width: 100%;
    border-collapse: collapse;
}

.styled-table th {
    background: linear-gradient(135deg, #f8f9fa, #e9ecef);
    padding: 18px 20px;
    text-align: left;
    font-weight: 600;
    color: var(--text-primary);
    border-bottom: 2px solid var(--border-color);
    font-size: 0.95rem;
}

.styled-table td {
    padding: 18px 20px;
    border-bottom: 1px solid var(--border-color);
    vertical-align: middle;
}

.styled-table tbody tr {
    transition: var(--transition);
}

.styled-table tbody tr:hover {
    background: linear-gradient(135deg, #f8f9fa, #e9ecef);
    transform: scale(1.01);
}

/* Crop Info Styling */
.crop-info {
    display: flex;
    align-items: center;
    gap: 12px;
}

.crop-icon {
    color: var(--primary-color);
    font-size: 1.2rem;
    background: rgba(46, 204, 113, 0.1);
    padding: 8px;
    border-radius: 50%;
}

.crop-name {
    font-weight: 600;
    color: var(--text-primary);
}

.crop-type-badge, .season-badge {
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 0.85rem;
    font-weight: 500;
    text-align: center;
    display: inline-block;
    min-width: 80px;
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
    line-height: 1.4;
    max-width: 200px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

/* Action Buttons */
.action-buttons {
    display: flex;
    gap: 8px;
    justify-content: center;
}

.action-btn {
    width: 36px;
    height: 36px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    text-decoration: none;
    color: white;
    font-size: 0.9rem;
    transition: var(--transition);
    border: none;
    cursor: pointer;
}

.action-btn:hover {
    transform: scale(1.1);
    box-shadow: var(--shadow);
}

.btn-view { background: linear-gradient(135deg, var(--secondary-color), #2980b9); }
.btn-edit { background: linear-gradient(135deg, var(--accent-color), #e67e22); }
.btn-delete { background: linear-gradient(135deg, var(--danger-color), #c0392b); }

/* Statistics Grid */
.stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 25px;
    margin-top: 25px;
}

.stat-card {
    background: linear-gradient(135deg, white, var(--bg-light));
    border-radius: var(--border-radius);
    padding: 25px;
    box-shadow: var(--shadow);
    transition: var(--transition);
    border: 1px solid var(--border-color);
    text-align: center;
}

.stat-card:hover {
    transform: translateY(-5px);
    box-shadow: var(--shadow-hover);
}

.stat-icon {
    background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
    color: white;
    width: 60px;
    height: 60px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.5rem;
    margin: 0 auto 20px auto;
}

.stat-content h4 {
    margin: 0 0 10px 0;
    color: var(--text-secondary);
    font-size: 1rem;
    font-weight: 500;
}

.stat-number {
    margin: 0;
    font-size: 2.5rem;
    font-weight: 700;
    color: var(--text-primary);
}

/* Empty State */
.empty-state {
    text-align: center;
    padding: 60px 20px;
    color: var(--text-secondary);
}

.empty-state i {
    font-size: 4rem;
    margin-bottom: 20px;
    color: var(--border-color);
}

.empty-state h3 {
    margin-bottom: 10px;
    color: var(--text-primary);
    font-size: 1.3rem;
}

.empty-state p {
    margin-bottom: 20px;
    font-size: 1rem;
}

.empty-state small {
    display: block;
    font-size: 0.9rem;
    opacity: 0.7;
}

/* Modal Styling */
.modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000;
    backdrop-filter: blur(5px);
}

.modal-content {
    background: white;
    border-radius: var(--border-radius);
    box-shadow: var(--shadow-hover);
    max-width: 500px;
    width: 90%;
    max-height: 90vh;
    overflow-y: auto;
    animation: modalSlideIn 0.3s ease;
}

@keyframes modalSlideIn {
    from { transform: scale(0.9); opacity: 0; }
    to { transform: scale(1); opacity: 1; }
}

.modal-header {
    padding: 25px 30px 20px;
    border-bottom: 1px solid var(--border-color);
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.modal-header h3 {
    margin: 0;
    color: var(--text-primary);
    font-size: 1.3rem;
    display: flex;
    align-items: center;
    gap: 10px;
}

.modal-close {
    background: none;
    border: none;
    font-size: 1.5rem;
    color: var(--text-secondary);
    cursor: pointer;
    padding: 5px;
    border-radius: 50%;
    transition: var(--transition);
}

.modal-close:hover {
    background: var(--bg-light);
    color: var(--text-primary);
}

.modal-body {
    padding: 25px 30px;
}

.modal-footer {
    padding: 20px 30px 25px;
    border-top: 1px solid var(--border-color);
    display: flex;
    gap: 15px;
    justify-content: flex-end;
}

/* Crop Details */
.crop-details {
    display: flex;
    flex-direction: column;
    gap: 15px;
}

.detail-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 12px 0;
    border-bottom: 1px solid var(--border-color);
}

.detail-row:last-child {
    border-bottom: none;
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

/* Warning Text */
.warning-text {
    color: var(--danger-color);
    font-weight: 600;
    text-align: center;
    margin: 15px 0;
    padding: 10px;
    background: rgba(231, 76, 60, 0.1);
    border-radius: 6px;
}

/* Responsive Design */
@media (max-width: 768px) {
    .page-header {
        padding: 20px;
        margin-bottom: 20px;
    }
    
    .page-header h1 {
        font-size: 2rem;
    }
    
    .content-area {
        padding: 20px;
        margin-bottom: 20px;
    }
    
    .form-row {
        grid-template-columns: 1fr;
        gap: 15px;
    }
    
    .table-controls {
        flex-direction: column;
        align-items: stretch;
    }
    
    .search-box {
        max-width: none;
    }
    
    .filter-controls {
        justify-content: center;
    }
    
    .stats-grid {
        grid-template-columns: 1fr;
        gap: 20px;
    }
    
    .modal-content {
        width: 95%;
        margin: 20px;
    }
    
    .modal-header,
    .modal-body,
    .modal-footer {
        padding: 20px;
    }
}

/* Loading States */
.loading {
    opacity: 0.6;
    pointer-events: none;
}

.loading::after {
    content: '';
    position: absolute;
    top: 50%;
    left: 50%;
    width: 20px;
    height: 20px;
    margin: -10px 0 0 -10px;
    border: 2px solid var(--primary-color);
    border-top: 2px solid transparent;
    border-radius: 50%;
    animation: spin 1s linear infinite;
}

@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}
</style>

<!-- Success/Error Messages -->
<c:if test="${param.success != null}">
    <div class="alert alert-success">
        <i class="fas fa-check-circle"></i> ${param.success}
    </div>
</c:if>
<c:if test="${param.error != null}">
    <div class="alert alert-error">
        <i class="fas fa-exclamation-circle"></i> ${param.error}
    </div>
</c:if>
<c:if test="${error != null}">
    <div class="alert alert-error">
        <i class="fas fa-exclamation-circle"></i> ${error}
    </div>
</c:if>

<!-- Page Header -->
<div class="page-header">
    <h1><i class="fas fa-leaf"></i> ফসল ব্যবস্থাপনা</h1>
    <p>আপনার কৃষি ব্যবস্থায় ফসল যোগ করুন, সম্পাদনা করুন এবং পরিচালনা করুন</p>
</div>

<!-- Add/Edit Crop Form -->
<div class="content-area">
    <h3>
        <i class="fas fa-plus-circle"></i> 
        <c:choose>
            <c:when test="${editCrop != null}">ফসল সম্পাদনা করুন</c:when>
            <c:otherwise>নতুন ফসল যোগ করুন</c:otherwise>
        </c:choose>
    </h3>
    
    <form action="${pageContext.request.contextPath}/admin/crops" method="post" class="crop-form">
        <c:if test="${editCrop != null}">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="cropId" value="${editCrop.id}">
        </c:if>
        <c:if test="${editCrop == null}">
            <input type="hidden" name="action" value="add">
        </c:if>
        
        <div class="form-row">
            <div class="input-group">
                <label>ফসলের নাম <span class="required">*</span></label>
                <input type="text" name="cropName" required 
                       placeholder="যেমন: ধান, গম, ভুট্টা"
                       value="${editCrop != null ? editCrop.name : ''}">
            </div>
            <div class="input-group">
                <label>ফসলের ধরন</label>
                <select name="cropType">
                    <option value="">ফসলের ধরন নির্বাচন করুন</option>
                    <option value="ধান" ${editCrop != null && editCrop.type == 'ধান' ? 'selected' : ''}>ধান</option>
                    <option value="গম" ${editCrop != null && editCrop.type == 'গম' ? 'selected' : ''}>গম</option>
                    <option value="ভুট্টা" ${editCrop != null && editCrop.type == 'ভুট্টা' ? 'selected' : ''}>ভুট্টা</option>
                    <option value="ডাল" ${editCrop != null && editCrop.type == 'ডাল' ? 'selected' : ''}>ডাল</option>
                    <option value="সবজি" ${editCrop != null && editCrop.type == 'সবজি' ? 'selected' : ''}>সবজি</option>
                    <option value="ফল" ${editCrop != null && editCrop.type == 'ফল' ? 'selected' : ''}>ফল</option>
                    <option value="অন্যান্য" ${editCrop != null && editCrop.type == 'অন্যান্য' ? 'selected' : ''}>অন্যান্য</option>
                </select>
            </div>
        </div>
        <div class="form-row">
            <div class="input-group">
                <label>উৎপাদন মৌসুম</label>
                <select name="season">
                    <option value="">মৌসুম নির্বাচন করুন</option>
                    <option value="রবি" ${editCrop != null && editCrop.season == 'রবি' ? 'selected' : ''}>রবি (শীতকালীন)</option>
                    <option value="খরিফ" ${editCrop != null && editCrop.season == 'খরিফ' ? 'selected' : ''}>খরিফ (বর্ষাকালীন)</option>
                    <option value="জায়েদ" ${editCrop != null && editCrop.season == 'জায়েদ' ? 'selected' : ''}>জায়েদ (গ্রীষ্মকালীন)</option>
                    <option value="সারা বছর" ${editCrop != null && editCrop.season == 'সারা বছর' ? 'selected' : ''}>সারা বছর</option>
                </select>
            </div>
            <div class="input-group">
                <label>বিবরণ</label>
                <textarea name="description" rows="3" 
                          placeholder="ফসলের বিশেষ বৈশিষ্ট্য, চাষ পদ্ধতি, বা অন্যান্য গুরুত্বপূর্ণ তথ্য লিখুন">${editCrop != null ? editCrop.description : ''}</textarea>
            </div>
        </div>
        <div class="form-actions">
            <button type="submit" class="btn-primary">
                <i class="fas fa-save"></i> 
                <c:choose>
                    <c:when test="${editCrop != null}">আপডেট করুন</c:when>
                    <c:otherwise>ফসল যোগ করুন</c:otherwise>
                </c:choose>
            </button>
            <c:if test="${editCrop != null}">
                <a href="${pageContext.request.contextPath}/admin/crops" class="btn-secondary">
                    <i class="fas fa-times"></i> বাতিল করুন
                </a>
            </c:if>
        </div>
    </form>
</div>

<!-- Crop Statistics -->
<div class="content-area">
    <h3><i class="fas fa-chart-pie"></i> ফসল পরিসংখ্যান</h3>
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-leaf"></i>
            </div>
            <div class="stat-content">
                <h4>মোট ফসল</h4>
                <p class="stat-number">${cropCount != null ? cropCount : '0'}</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-users"></i>
            </div>
            <div class="stat-content">
                <h4>ফসল চাষকারী কৃষক</h4>
                <p class="stat-number">${farmerCropCount != null ? farmerCropCount : '0'}</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-calendar"></i>
            </div>
            <div class="stat-content">
                <h4>এই মাসে যোগ করা</h4>
                <p class="stat-number">${monthlyCropCount != null ? monthlyCropCount : '0'}</p>
            </div>
        </div>
    </div>
</div>

<!-- Existing Crops -->
<div class="content-area">
    <h3><i class="fas fa-list"></i> বিদ্যমান ফসলের তালিকা</h3>
    
    <!-- Search and Filter -->
    <div class="table-controls">
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
        </div>
    </div>
    
    <div class="table-container">
        <table class="styled-table" id="cropsTable">
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
                                        <i class="fas fa-leaf crop-icon"></i>
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
                            <td colspan="6" class="no-data">
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

<!-- Crop View Modal (if viewing a crop) -->
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

<!-- Delete Confirmation Modal -->
<div id="deleteModal" class="modal-overlay" style="display: none;">
    <div class="modal-content">
        <div class="modal-header">
            <h3><i class="fas fa-exclamation-triangle"></i> ফসল মুছুন</h3>
        </div>
        <div class="modal-body">
            <p>আপনি কি নিশ্চিত যে আপনি "<span id="cropNameToDelete"></span>" ফসলটি মুছতে চান?</p>
            <p class="warning-text">এই কাজটি অপরিবর্তনীয়!</p>
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
// Show crop view modal if viewing a crop
document.addEventListener('DOMContentLoaded', function() {
    const cropViewModal = document.getElementById('cropViewModal');
    if (cropViewModal) {
        cropViewModal.style.display = 'flex';
    }
    
    // Initialize tooltips
    initializeTooltips();
    
    // Initialize search and filter
    initializeSearchAndFilter();
});

// Close crop view modal
function closeCropViewModal() {
    const modal = document.getElementById('cropViewModal');
    if (modal) {
        modal.style.display = 'none';
    }
}

// Delete crop confirmation
function deleteCrop(cropId, cropName) {
    document.getElementById('cropNameToDelete').textContent = cropName;
    document.getElementById('cropIdToDelete').value = cropId;
    document.getElementById('deleteModal').style.display = 'flex';
}

// Close delete modal
function closeDeleteModal() {
    document.getElementById('deleteModal').style.display = 'none';
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
                background: #333;
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
    const table = document.getElementById('cropsTable');
    
    if (!table) return;
    
    const rows = table.getElementsByTagName('tbody')[0].getElementsByTagName('tr');

    function filterTable() {
        const searchTerm = searchInput.value.toLowerCase();
        const selectedType = typeFilter.value.toLowerCase();
        const selectedSeason = seasonFilter.value.toLowerCase();

        let visibleCount = 0;

        for (let i = 0; i < rows.length; i++) {
            const row = rows[i];
            
            // Skip empty state rows
            if (row.querySelector('.empty-state')) {
                row.style.display = 'none';
                continue;
            }
            
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
        }

        // Show no results message if no rows are visible
        showNoResultsMessage(visibleCount === 0);
    }

    function showNoResultsMessage(show) {
        let noResultsRow = document.querySelector('.no-results-row');
        
        if (show && !noResultsRow) {
            const tbody = table.getElementsByTagName('tbody')[0];
            noResultsRow = document.createElement('tr');
            noResultsRow.className = 'no-results-row';
            noResultsRow.innerHTML = `
                <td colspan="6">
                    <div class="empty-state">
                        <i class="fas fa-search"></i>
                        <h3>কোন ফলাফল পাওয়া যায়নি</h3>
                        <p>আপনার অনুসন্ধানের সাথে মিলে এমন কোন ফসল পাওয়া যায়নি</p>
                        <small>অনুসন্ধানের শর্ত পরিবর্তন করে আবার চেষ্টা করুন</small>
                    </div>
                </td>
            `;
            tbody.appendChild(noResultsRow);
        } else if (!show && noResultsRow) {
            noResultsRow.remove();
        }
    }

    // Event listeners
    if (searchInput) searchInput.addEventListener('input', filterTable);
    if (typeFilter) typeFilter.addEventListener('change', filterTable);
    if (seasonFilter) seasonFilter.addEventListener('change', filterTable);
}

// Close modals when clicking outside
window.addEventListener('click', function(event) {
    const cropViewModal = document.getElementById('cropViewModal');
    const deleteModal = document.getElementById('deleteModal');
    
    if (event.target === cropViewModal) {
        cropViewModal.style.display = 'none';
    }
    if (event.target === deleteModal) {
        deleteModal.style.display = 'none';
    }
});

// Form validation and enhancement
document.addEventListener('DOMContentLoaded', function() {
    const cropForm = document.querySelector('.crop-form');
    if (cropForm) {
        cropForm.addEventListener('submit', function(e) {
            const cropName = this.querySelector('input[name="cropName"]');
            if (cropName && cropName.value.trim() === '') {
                e.preventDefault();
                cropName.focus();
                cropName.style.borderColor = 'var(--danger-color)';
                setTimeout(() => {
                    cropName.style.borderColor = '';
                }, 3000);
            }
        });
    }
});

// Add loading states to buttons
document.addEventListener('DOMContentLoaded', function() {
    const submitButtons = document.querySelectorAll('button[type="submit"]');
    submitButtons.forEach(button => {
        button.addEventListener('click', function() {
            this.classList.add('loading');
            this.disabled = true;
        });
    });
});
</script>