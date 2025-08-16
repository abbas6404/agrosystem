<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<jsp:include page="/WEB-INF/includes/admin_header.jsp">
    <jsp:param name="pageTitle" value="কৃষক ব্যবস্থাপনা" />
    <jsp:param name="pageIcon" value="fas fa-users" />
    <jsp:param name="activePage" value="farmers" />
</jsp:include>

<style>
.error-message {
    background-color: #fee;
    border: 1px solid #fcc;
    color: #c33;
    padding: 15px;
    margin: 20px;
    border-radius: 5px;
    text-align: center;
}



.empty-state {
    text-align: center;
    padding: 60px 20px;
    color: #666;
}

.empty-state i {
    font-size: 48px;
    margin-bottom: 20px;
    color: #ccc;
}

.empty-state h3 {
    margin-bottom: 10px;
    color: #333;
}

.empty-state p {
    margin-bottom: 20px;
}

.loading-state {
    text-align: center;
    padding: 40px 20px;
    color: #666;
}

.loading-state i {
    font-size: 24px;
    margin-bottom: 15px;
    color: #007bff;
    animation: spin 1s linear infinite;
}

@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

.stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
    margin-bottom: 30px;
}

.stat-card {
    background: white;
    border-radius: 10px;
    padding: 20px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    display: flex;
    align-items: center;
    gap: 15px;
}

.stat-icon {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    width: 50px;
    height: 50px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 20px;
}

.stat-content h4 {
    margin: 0 0 5px 0;
    color: #666;
    font-size: 14px;
}

.stat-number {
    margin: 0;
    font-size: 24px;
    font-weight: bold;
    color: #333;
}

.search-filter-form {
    background: white;
    border-radius: 10px;
    padding: 20px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    margin-bottom: 20px;
}

.form-row {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 15px;
    margin-bottom: 15px;
}

.input-group label {
    display: block;
    margin-bottom: 5px;
    font-weight: 500;
    color: #333;
}

.search-input, .filter-select {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 14px;
}

.form-actions {
    display: flex;
    gap: 10px;
    justify-content: flex-end;
}

.btn-primary, .btn-secondary {
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 14px;
    display: inline-flex;
    align-items: center;
    gap: 8px;
}

.btn-primary {
    background: #007bff;
    color: white;
}

.btn-secondary {
    background: #6c757d;
    color: white;
}

.table-container {
    background: white;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.styled-table {
    width: 100%;
    border-collapse: collapse;
}

.styled-table th {
    background: #f8f9fa;
    padding: 15px;
    text-align: left;
    font-weight: 600;
    color: #333;
    border-bottom: 1px solid #dee2e6;
}

.styled-table td {
    padding: 15px;
    border-bottom: 1px solid #dee2e6;
    vertical-align: middle;
}

.styled-table tbody tr:hover {
    background-color: #f8f9fa;
}

.user-info-cell, .phone-cell, .location-cell {
    display: flex;
    align-items: center;
    gap: 10px;
}

.user-info-cell i, .phone-cell i, .location-cell i {
    color: #666;
    width: 16px;
}

.user-details {
    display: flex;
    flex-direction: column;
}

.user-name {
    font-weight: 500;
    color: #333;
}

.user-id {
    color: #666;
    font-size: 12px;
}

.crops-cell {
    display: flex;
    flex-wrap: wrap;
    gap: 5px;
}

.crop-tag {
    background: #e9ecef;
    color: #495057;
    padding: 2px 8px;
    border-radius: 12px;
    font-size: 12px;
}

.no-crops {
    color: #999;
    font-style: italic;
}

.status-badge {
    padding: 4px 12px;
    border-radius: 12px;
    font-size: 12px;
    font-weight: 500;
}

.status-active {
    background: #d4edda;
    color: #155724;
}

.action-buttons {
    display: flex;
    gap: 5px;
}

.action-btn {
    width: 32px;
    height: 32px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    text-decoration: none;
    color: white;
    font-size: 12px;
}

.btn-view { background: #17a2b8; }
.btn-edit { background: #ffc107; }
.btn-crops { background: #28a745; }
.btn-delete { background: #dc3545; }

.bulk-actions {
    background: white;
    border-radius: 10px;
    padding: 15px 20px;
    margin-top: 20px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.selected-count {
    font-weight: 500;
    color: #333;
}

.bulk-buttons {
    display: flex;
    gap: 10px;
}

.btn-danger {
    background: #dc3545;
    color: white;
    border: none;
    padding: 8px 16px;
    border-radius: 5px;
    cursor: pointer;
    font-size: 14px;
}

.btn-danger:disabled {
    background: #6c757d;
    cursor: not-allowed;
}

.pagination-container {
    background: white;
    border-radius: 10px;
    padding: 20px;
    margin-top: 20px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.pagination-controls {
    display: flex;
    gap: 5px;
}

.page-btn {
    padding: 8px 12px;
    border: 1px solid #dee2e6;
    border-radius: 5px;
    text-decoration: none;
    color: #007bff;
    background: white;
}

.page-btn.active {
    background: #007bff;
    color: white;
    border-color: #007bff;
}

.page-btn:hover:not(.active) {
    background: #f8f9fa;
}
</style>

<!-- Error Display -->
<c:if test="${not empty error}">
    <div class="error-message" style="background-color: #fee; border: 1px solid #fcc; color: #c33; padding: 15px; margin: 20px; border-radius: 5px; text-align: center;">
        <i class="fas fa-exclamation-triangle"></i>
        <strong>Error:</strong> ${error}
    </div>
</c:if>



<!-- Page Actions -->
<div class="page-actions">
    <a href="${pageContext.request.contextPath}/admin/farmers/add" class="btn-primary">
        <i class="fas fa-user-plus"></i> নতুন কৃষক যোগ করুন
    </a>
    <a href="${pageContext.request.contextPath}/admin/farmers/export" class="btn-secondary">
        <i class="fas fa-download"></i> রিপোর্ট ডাউনলোড করুন
    </a>
</div>

<!-- Farmer Statistics -->
<div class="stats-grid" style="margin-bottom: 30px;">
    <div class="stat-card">
        <div class="stat-icon">
            <i class="fas fa-users"></i>
        </div>
        <div class="stat-content">
            <h4>মোট কৃষক</h4>
            <p class="stat-number">${farmerCount}</p>
        </div>
    </div>
    <div class="stat-card">
        <div class="stat-icon">
            <i class="fas fa-user-plus"></i>
        </div>
        <div class="stat-content">
            <h4>এই মাসে যোগ হয়েছে</h4>
            <p class="stat-number">${monthlyFarmerCount != null ? monthlyFarmerCount : '0'}</p>
        </div>
    </div>
    <div class="stat-card">
        <div class="stat-icon">
            <i class="fas fa-map-marker-alt"></i>
        </div>
        <div class="stat-content">
            <h4>সক্রিয় এলাকা</h4>
            <p class="stat-number">${activeLocations != null ? activeLocations : '0'}</p>
        </div>
    </div>
    <div class="stat-card">
        <div class="stat-icon">
            <i class="fas fa-leaf"></i>
        </div>
        <div class="stat-content">
            <h4>ফসল চাষকারী</h4>
            <p class="stat-number">${activeFarmers != null ? activeFarmers : '0'}</p>
        </div>
    </div>
</div>

<!-- Search and Filter -->
<div class="content-area" style="margin-bottom: 30px;">
    <h3><i class="fas fa-search"></i> অনুসন্ধান ও ফিল্টার</h3>
    <div class="search-filter-form">
        <div class="form-row">
            <div class="input-group">
                <label>নাম দিয়ে অনুসন্ধান</label>
                <input type="text" id="farmerNameSearch" placeholder="কৃষকের নাম লিখুন..." class="search-input">
            </div>
            <div class="input-group">
                <label>ফোন নম্বর</label>
                <input type="text" id="phoneSearch" placeholder="ফোন নম্বর লিখুন..." class="search-input">
            </div>
            <div class="input-group">
                <label>এলাকা</label>
                <select id="locationFilter" class="filter-select">
                    <option value="">সব এলাকা</option>
                    <c:forEach var="location" items="${locations}">
                        <option value="${location}">${location}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="form-row">
            <div class="input-group">
                <label>জমির আকার</label>
                <select id="landSizeFilter" class="filter-select">
                    <option value="">সব আকার</option>
                    <option value="0-1">১ একরের কম</option>
                    <option value="1-5">১-৫ একর</option>
                    <option value="5-10">৫-১০ একর</option>
                    <option value="10+">১০ একরের বেশি</option>
                </select>
            </div>
            <div class="input-group">
                <label>নিবন্ধনের তারিখ</label>
                <select id="dateFilter" class="filter-select">
                    <option value="">সব তারিখ</option>
                    <option value="today">আজ</option>
                    <option value="week">এই সপ্তাহ</option>
                    <option value="month">এই মাস</option>
                    <option value="year">এই বছর</option>
                </select>
            </div>
            <div class="input-group">
                <label>স্ট্যাটাস</label>
                <select id="statusFilter" class="filter-select">
                    <option value="">সব স্ট্যাটাস</option>
                    <option value="active">সক্রিয়</option>
                    <option value="inactive">নিষ্ক্রিয়</option>
                </select>
            </div>
        </div>
        <div class="form-actions">
            <button type="button" id="searchBtn" class="btn-primary">
                <i class="fas fa-search"></i> অনুসন্ধান করুন
            </button>
            <button type="button" id="resetBtn" class="btn-secondary">
                <i class="fas fa-undo"></i> রিসেট করুন
            </button>
        </div>
    </div>
</div>

<!-- Farmers List -->
<div class="content-area">
    <h3><i class="fas fa-list"></i> কৃষকদের তালিকা</h3>
    
    <div class="table-container">
        <table class="styled-table" id="farmersTable">
            <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="selectAll" class="select-checkbox">
                    </th>
                    <th>নাম</th>
                    <th>ফোন</th>
                    <th>এলাকা</th>
                    <th>জমির আকার</th>
                    <th>ফসল</th>
                    <th>নিবন্ধনের তারিখ</th>
                    <th>স্ট্যাটাস</th>
                    <th>পদক্ষেপ</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty allFarmers}">
                        <tr>
                            <td colspan="9">
                                <div class="empty-state">
                                    <i class="fas fa-users"></i>
                                    <h3>কোন কৃষক পাওয়া যায়নি</h3>
                                    <p>এখনও কোন কৃষক নিবন্ধন করেনি। প্রথম কৃষক যোগ করতে নিচের বোতামে ক্লিক করুন।</p>
                                    <a href="${pageContext.request.contextPath}/admin/farmers/add" class="btn-primary">
                                        <i class="fas fa-user-plus"></i> প্রথম কৃষক যোগ করুন
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="farmer" items="${allFarmers}">
                            <tr>
                                <td>
                                    <input type="checkbox" class="farmer-checkbox" value="${farmer.getId()}">
                                </td>
                                <td>
                                    <div class="user-info-cell">
                                        <i class="fas fa-user-circle"></i>
                                        <div class="user-details">
                                            <span class="user-name">${farmer.getName()}</span>
                                            <small class="user-id">ID: ${farmer.getId()}</small>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="phone-cell">
                                        <i class="fas fa-phone"></i>
                                        <span>${farmer.getPhoneNumber()}</span>
                                    </div>
                                </td>
                                <td>
                                    <div class="location-cell">
                                        <i class="fas fa-map-marker-alt"></i>
                                        <span>${farmer.getLocation()}</span>
                                    </div>
                                </td>
                                <td>
                                    <span class="land-size">${farmer.getLandSizeAcres()} একর</span>
                                </td>
                                <td>
                                    <div class="crops-cell">
                                        <c:forEach var="crop" items="${farmer.getCrops()}" varStatus="status">
                                            <span class="crop-tag">${crop.getName()}</span>
                                            <c:if test="${!status.last}">, </c:if>
                                        </c:forEach>
                                        <c:if test="${empty farmer.getCrops()}">
                                            <span class="no-crops">কোন ফসল নেই</span>
                                        </c:if>
                                    </div>
                                </td>
                                <td>
                                    <span class="date-cell">${farmer.getCreatedAt() != null ? farmer.getCreatedAt().toLocalDate().toString() : 'N/A'}</span>
                                </td>
                                <td>
                                    <span class="status-badge status-active">সক্রিয়</span>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <a href="${pageContext.request.contextPath}/admin/farmers/view?id=${farmer.getId()}" 
                                           class="action-btn btn-view" data-tooltip="দেখুন">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/farmers/edit?id=${farmer.getId()}" 
                                           class="action-btn btn-edit" data-tooltip="সম্পাদনা করুন">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/farmers/crops?id=${farmer.getId()}" 
                                           class="action-btn btn-crops" data-tooltip="ফসল ব্যবস্থাপনা">
                                            <i class="fas fa-leaf"></i>
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
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
    
    <!-- Bulk Actions -->
    <c:if test="${not empty allFarmers}">
        <div class="bulk-actions">
            <span class="selected-count">০ টি নির্বাচিত</span>
            <div class="bulk-buttons">
                <button type="button" id="bulkEdit" class="btn-secondary" disabled>
                    <i class="fas fa-edit"></i> একসাথে সম্পাদনা
                </button>
                <button type="button" id="bulkDelete" class="btn-danger" disabled>
                    <i class="fas fa-trash"></i> একসাথে মুছুন
                </button>
                <button type="button" id="bulkExport" class="btn-secondary" disabled>
                    <i class="fas fa-download"></i> নির্বাচিত রপ্তানি
                </button>
            </div>
        </div>
    </c:if>
</div>

<!-- Pagination -->
<c:if test="${not empty allFarmers and totalPages > 1}">
    <div class="pagination-container">
        <div class="pagination-info">
            <span>মোট ${totalPages} পৃষ্ঠার মধ্যে ${currentPage} নম্বর পৃষ্ঠা দেখানো হচ্ছে</span>
        </div>
        <div class="pagination-controls">
            <c:if test="${currentPage > 1}">
                <a href="?page=${currentPage - 1}" class="page-btn">
                    <i class="fas fa-chevron-left"></i> আগের
                </a>
            </c:if>
            
            <c:forEach var="pageNum" begin="1" end="${totalPages}">
                <c:choose>
                    <c:when test="${pageNum == currentPage}">
                        <span class="page-btn active">${pageNum}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="?page=${pageNum}" class="page-btn">${pageNum}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            
            <c:if test="${currentPage < totalPages}">
                <a href="?page=${currentPage + 1}" class="page-btn">
                    পরের <i class="fas fa-chevron-right"></i>
                </a>
            </c:if>
        </div>
    </div>
</c:if>

<!-- JavaScript for Search, Filter, and Bulk Actions -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    // Check if there are any farmers
    const farmersTable = document.getElementById('farmersTable');
    const tableRows = farmersTable.querySelectorAll('tbody tr');
    
    if (tableRows.length === 0) {
        console.log('No farmers found in table');
        return;
    }
    
    // Search and filter functionality
    const searchBtn = document.getElementById('searchBtn');
    const resetBtn = document.getElementById('resetBtn');
    const farmerNameSearch = document.getElementById('farmerNameSearch');
    const phoneSearch = document.getElementById('phoneSearch');
    const locationFilter = document.getElementById('locationFilter');
    const landSizeFilter = document.getElementById('landSizeFilter');
    const dateFilter = document.getElementById('dateFilter');
    const statusFilter = document.getElementById('statusFilter');
    
    // Search and filter function
    function filterFarmers() {
        const nameSearch = farmerNameSearch.value.toLowerCase();
        const phoneSearchValue = phoneSearch.value.toLowerCase();
        const locationValue = locationFilter.value;
        const landSizeValue = landSizeFilter.value;
        const dateValue = dateFilter.value;
        const statusValue = statusFilter.value;
        
        let visibleCount = 0;
        
        tableRows.forEach(row => {
            // Skip the empty state row if it exists
            if (row.querySelector('.empty-state')) {
                row.style.display = 'none';
                return;
            }
            
            let showRow = true;
            
            // Name search
            const nameCell = row.querySelector('.user-name');
            if (nameCell && nameSearch && !nameCell.textContent.toLowerCase().includes(nameSearch)) {
                showRow = false;
            }
            
            // Phone search
            const phoneCell = row.querySelector('.phone-cell span');
            if (phoneCell && phoneSearchValue && !phoneCell.textContent.toLowerCase().includes(phoneSearchValue)) {
                showRow = false;
            }
            
            // Location filter
            const locationCell = row.querySelector('.location-cell span');
            if (locationCell && locationValue && locationCell.textContent !== locationValue) {
                showRow = false;
            }
            
            // Land size filter
            const landSizeCell = row.querySelector('.land-size');
            if (landSizeCell && landSizeValue) {
                const landSizeText = landSizeCell.textContent;
                const landSize = parseFloat(landSizeText);
                if (landSizeValue === '0-1' && landSize >= 1) showRow = false;
                else if (landSizeValue === '1-5' && (landSize < 1 || landSize >= 5)) showRow = false;
                else if (landSizeValue === '5-10' && (landSize < 5 || landSize >= 10)) showRow = false;
                else if (landSizeValue === '10+' && landSize < 10) showRow = false;
            }
            
            // Date filter
            const dateCell = row.querySelector('.date-cell');
            if (dateCell && dateValue) {
                const dateText = dateCell.textContent;
                if (dateText === 'N/A') {
                    showRow = false;
                } else {
                    const rowDate = new Date(dateText);
                    const today = new Date();
                    const diffTime = Math.abs(today - rowDate);
                    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
                    
                    if (dateValue === 'today' && diffDays > 1) showRow = false;
                    else if (dateValue === 'week' && diffDays > 7) showRow = false;
                    else if (dateValue === 'month' && diffDays > 30) showRow = false;
                    else if (dateValue === 'year' && diffDays > 365) showRow = false;
                }
            }
            
            // Status filter (all are active for now)
            if (statusValue && statusValue !== 'active') {
                showRow = false;
            }
            
            row.style.display = showRow ? '' : 'none';
            if (showRow) visibleCount++;
        });
        
        // Show no results message if no rows are visible
        const noResultsRow = document.querySelector('.no-results-row');
        if (visibleCount === 0) {
            if (!noResultsRow) {
                const tbody = farmersTable.querySelector('tbody');
                const newRow = document.createElement('tr');
                newRow.className = 'no-results-row';
                newRow.innerHTML = `
                    <td colspan="9">
                        <div class="empty-state">
                            <i class="fas fa-search"></i>
                            <h3>কোন ফলাফল পাওয়া যায়নি</h3>
                            <p>আপনার অনুসন্ধানের সাথে মিলে এমন কোন কৃষক পাওয়া যায়নি। অনুসন্ধানের শর্ত পরিবর্তন করে আবার চেষ্টা করুন।</p>
                        </div>
                    </td>
                `;
                tbody.appendChild(newRow);
            }
        } else {
            if (noResultsRow) {
                noResultsRow.remove();
            }
        }
        
        updateSelectedCount();
    }
    
    // Event listeners
    if (searchBtn) searchBtn.addEventListener('click', filterFarmers);
    if (resetBtn) resetBtn.addEventListener('click', function() {
        farmerNameSearch.value = '';
        phoneSearch.value = '';
        locationFilter.value = '';
        landSizeFilter.value = '';
        dateFilter.value = '';
        statusFilter.value = '';
        filterFarmers();
    });
    
    // Real-time search
    if (farmerNameSearch) farmerNameSearch.addEventListener('input', filterFarmers);
    if (phoneSearch) phoneSearch.addEventListener('input', filterFarmers);
    if (locationFilter) locationFilter.addEventListener('change', filterFarmers);
    if (landSizeFilter) landSizeFilter.addEventListener('change', filterFarmers);
    if (dateFilter) dateFilter.addEventListener('change', filterFarmers);
    if (statusFilter) statusFilter.addEventListener('change', filterFarmers);
    
    // Bulk selection functionality
    const selectAllCheckbox = document.getElementById('selectAll');
    const farmerCheckboxes = document.querySelectorAll('.farmer-checkbox');
    const bulkEditBtn = document.getElementById('bulkEdit');
    const bulkDeleteBtn = document.getElementById('bulkDelete');
    const bulkExportBtn = document.getElementById('bulkExport');
    
    if (selectAllCheckbox && farmerCheckboxes.length > 0) {
        // Select all functionality
        selectAllCheckbox.addEventListener('change', function() {
            farmerCheckboxes.forEach(checkbox => {
                checkbox.checked = this.checked;
            });
            updateSelectedCount();
        });
        
        // Individual checkbox functionality
        farmerCheckboxes.forEach(checkbox => {
            checkbox.addEventListener('change', function() {
                updateSelectedCount();
                // Update select all checkbox
                const checkedCount = document.querySelectorAll('.farmer-checkbox:checked').length;
                const totalCount = farmerCheckboxes.length;
                selectAllCheckbox.checked = checkedCount === totalCount;
                selectAllCheckbox.indeterminate = checkedCount > 0 && checkedCount < totalCount;
            });
        });
    }
    
    // Update selected count and button states
    function updateSelectedCount() {
        const selectedCount = document.querySelectorAll('.farmer-checkbox:checked').length;
        const selectedCountSpan = document.querySelector('.selected-count');
        if (selectedCountSpan) {
            selectedCountSpan.textContent = selectedCount + ' টি নির্বাচিত';
        }
        
        const hasSelection = selectedCount > 0;
        if (bulkEditBtn) bulkEditBtn.disabled = !hasSelection;
        if (bulkDeleteBtn) bulkDeleteBtn.disabled = !hasSelection;
        if (bulkExportBtn) bulkExportBtn.disabled = !hasSelection;
    }
    
    // Bulk actions
    if (bulkEditBtn) {
        bulkEditBtn.addEventListener('click', function() {
            const selectedIds = Array.from(document.querySelectorAll('.farmer-checkbox:checked'))
                .map(checkbox => checkbox.value);
            if (selectedIds.length > 0) {
                alert('বেছে নেওয়া কৃষকদের সম্পাদনা করুন: ' + selectedIds.join(', '));
            }
        });
    }
    
    if (bulkDeleteBtn) {
        bulkDeleteBtn.addEventListener('click', function() {
            const selectedIds = Array.from(document.querySelectorAll('.farmer-checkbox:checked'))
                .map(checkbox => checkbox.value);
            if (selectedIds.length > 0) {
                if (confirm('আপনি কি নিশ্চিত যে আপনি ' + selectedIds.length + ' জন কৃষককে মুছতে চান?')) {
                    alert('বেছে নেওয়া কৃষকদের মুছে ফেলা হয়েছে: ' + selectedIds.join(', '));
                }
            }
        });
    }
    
    if (bulkExportBtn) {
        bulkExportBtn.addEventListener('click', function() {
            const selectedIds = Array.from(document.querySelectorAll('.farmer-checkbox:checked'))
                .map(checkbox => checkbox.value);
            if (selectedIds.length > 0) {
                alert('বেছে নেওয়া কৃষকদের রপ্তানি করা হয়েছে: ' + selectedIds.join(', '));
            }
        });
    }
    
    // Initialize
    updateSelectedCount();
    
    console.log('Admin farmers page JavaScript initialized successfully');
});
</script>

<jsp:include page="/WEB-INF/includes/admin_footer.jsp" />
