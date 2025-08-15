<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<jsp:include page="/WEB-INF/includes/admin_header.jsp">
    <jsp:param name="pageTitle" value="নোটিশ ব্যবস্থাপনা" />
    <jsp:param name="pageIcon" value="fas fa-bullhorn" />
    <jsp:param name="activePage" value="notices" />
</jsp:include>

<div class="notice-management-container">
    <!-- Page Actions -->
    <div class="page-actions">
        <a href="${pageContext.request.contextPath}/admin/notices/add" class="btn-primary">
            <i class="fas fa-plus"></i> নতুন নোটিশ যোগ করুন
        </a>
        <a href="${pageContext.request.contextPath}/admin/notices/templates" class="btn-secondary">
            <i class="fas fa-file-alt"></i> নোটিশ টেমপ্লেট
        </a>
    </div>

    <!-- Notice Statistics -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-bullhorn"></i>
            </div>
            <div class="stat-content">
                <h4>মোট নোটিশ</h4>
                <p class="stat-number">${noticeCount}</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-eye"></i>
            </div>
            <div class="stat-content">
                <h4>আজ দেখা হয়েছে</h4>
                <p class="stat-number">${todayViews != null ? todayViews : '0'}</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-calendar"></i>
            </div>
            <div class="stat-content">
                <h4>এই মাসে প্রকাশিত</h4>
                <p class="stat-number">${monthlyNotices != null ? monthlyNotices : '0'}</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-star"></i>
            </div>
            <div class="stat-content">
                <h4>গুরুত্বপূর্ণ</h4>
                <p class="stat-number">${importantNotices != null ? importantNotices : '0'}</p>
            </div>
        </div>
    </div>

    <!-- Quick Notice Form -->
    <div class="content-area">
        <h3><i class="fas fa-plus-circle"></i> দ্রুত নোটিশ প্রকাশ</h3>
        <form action="${pageContext.request.contextPath}/admin/notices" method="post" class="quick-notice-form">
            <c:if test="${editNotice != null}">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="noticeId" value="${editNotice.id}">
            </c:if>
            <c:if test="${editNotice == null}">
                <input type="hidden" name="action" value="add">
            </c:if>
            
            <div class="form-row">
                <div class="input-group">
                    <label>শিরোনাম <span class="required">*</span></label>
                    <input type="text" name="title" required 
                           placeholder="নোটিশের শিরোনাম লিখুন"
                           value="${editNotice != null ? editNotice.title : ''}">
                </div>
                <div class="input-group">
                    <label>ধরন</label>
                    <select name="noticeType">
                        <option value="general" ${editNotice != null && editNotice.type == 'general' ? 'selected' : ''}>সাধারণ</option>
                        <option value="important" ${editNotice != null && editNotice.type == 'important' ? 'selected' : ''}>গুরুত্বপূর্ণ</option>
                        <option value="urgent" ${editNotice != null && editNotice.type == 'urgent' ? 'selected' : ''}>জরুরি</option>
                        <option value="announcement" ${editNotice != null && editNotice.type == 'announcement' ? 'selected' : ''}>ঘোষণা</option>
                        <option value="warning" ${editNotice != null && editNotice.type == 'warning' ? 'selected' : ''}>সতর্কতা</option>
                    </select>
                </div>
            </div>
            <div class="form-row">
                <div class="input-group">
                    <label>বিস্তারিত <span class="required">*</span></label>
                    <textarea name="content" rows="4" required placeholder="নোটিশের বিস্তারিত লিখুন">${editNotice != null ? editNotice.content : ''}</textarea>
                </div>
            </div>
            <div class="form-row">
                <div class="input-group">
                    <label>টার্গেট গ্রুপ</label>
                    <select name="targetGroup">
                        <option value="all" ${editNotice != null && editNotice.targetGroup == 'all' ? 'selected' : ''}>সব কৃষক</option>
                        <option value="rice" ${editNotice != null && editNotice.targetGroup == 'rice' ? 'selected' : ''}>ধান চাষকারী</option>
                        <option value="wheat" ${editNotice != null && editNotice.targetGroup == 'wheat' ? 'selected' : ''}>গম চাষকারী</option>
                        <option value="vegetables" ${editNotice != null && editNotice.targetGroup == 'vegetables' ? 'selected' : ''}>সবজি চাষকারী</option>
                        <option value="fruits" ${editNotice != null && editNotice.targetGroup == 'fruits' ? 'selected' : ''}>ফল চাষকারী</option>
                    </select>
                </div>
                <div class="input-group">
                    <label>মেয়াদ</label>
                    <select name="expiry">
                        <option value="1" ${editNotice != null && editNotice.expiry == 1 ? 'selected' : ''}>১ দিন</option>
                        <option value="3" ${editNotice != null && editNotice.expiry == 3 ? 'selected' : ''}>৩ দিন</option>
                        <option value="7" ${editNotice != null && editNotice.expiry == 7 ? 'selected' : ''}>১ সপ্তাহ</option>
                        <option value="30" ${editNotice != null && editNotice.expiry == 30 ? 'selected' : ''}>১ মাস</option>
                        <option value="0" ${editNotice != null && editNotice.expiry == 0 ? 'selected' : ''}>অসীমিত</option>
                    </select>
                </div>
            </div>
            <div class="form-actions">
                <button type="submit" class="btn-primary">
                    <i class="fas fa-paper-plane"></i> 
                    <c:choose>
                        <c:when test="${editNotice != null}">নোটিশ আপডেট করুন</c:when>
                        <c:otherwise>নোটিশ প্রকাশ করুন</c:otherwise>
                    </c:choose>
                </button>
                <c:if test="${editNotice != null}">
                    <a href="${pageContext.request.contextPath}/admin/notices" class="btn-secondary">
                        <i class="fas fa-times"></i> বাতিল করুন
                    </a>
                </c:if>
                <c:if test="${editNotice == null}">
                    <button type="button" class="btn-secondary" onclick="clearForm()">
                        <i class="fas fa-undo"></i> ফর্ম পরিষ্কার করুন
                    </button>
                </c:if>
            </div>
        </form>
    </div>

    <!-- Search and Filter -->
    <div class="content-area">
        <h3><i class="fas fa-search"></i> অনুসন্ধান ও ফিল্টার</h3>
        <div class="search-filter-form">
            <div class="form-row">
                <div class="input-group">
                    <label>শিরোনাম দিয়ে অনুসন্ধান</label>
                    <input type="text" id="noticeTitleSearch" placeholder="নোটিশের শিরোনাম লিখুন..." class="search-input">
                </div>
                <div class="input-group">
                    <label>ধরন</label>
                    <select id="noticeTypeFilter" class="filter-select">
                        <option value="">সব ধরন</option>
                        <option value="general">সাধারণ</option>
                        <option value="important">গুরুত্বপূর্ণ</option>
                        <option value="urgent">জরুরি</option>
                        <option value="announcement">ঘোষণা</option>
                        <option value="warning">সতর্কতা</option>
                    </select>
                </div>
                <div class="input-group">
                    <label>তারিখ</label>
                    <select id="dateFilter" class="filter-select">
                        <option value="">সব তারিখ</option>
                        <option value="today">আজ</option>
                        <option value="week">এই সপ্তাহ</option>
                        <option value="month">এই মাস</option>
                        <option value="year">এই বছর</option>
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

    <!-- Notices List -->
    <div class="content-area">
        <h3><i class="fas fa-list"></i> প্রকাশিত নোটিশসমূহ</h3>
        
        <c:if test="${empty notices}">
            <div class="empty-state">
                <i class="fas fa-bullhorn"></i>
                <h3>কোন নোটিশ নেই</h3>
                <p>এখনও কোন নোটিশ প্রকাশ করা হয়নি। প্রথম নোটিশ যোগ করুন।</p>
            </div>
        </c:if>
        
        <c:if test="${notices != null && not empty notices}">
            <div class="table-container">
                <table class="styled-table" id="noticesTable">
                    <thead>
                        <tr>
                            <th>শিরোনাম</th>
                            <th>ধরন</th>
                            <th>টার্গেট গ্রুপ</th>
                            <th>প্রকাশের তারিখ</th>
                            <th>মেয়াদ</th>
                            <th>স্ট্যাটাস</th>
                            <th>পদক্ষেপ</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="notice" items="${notices}">
                            <tr class="notice-row notice-${notice.type != null ? notice.type : 'general'}">
                                <td>
                                    <div class="notice-info">
                                        <div class="notice-title">
                                            <i class="fas fa-bullhorn"></i>
                                            <span>${notice.title != null ? notice.title : 'No Title'}</span>
                                            <c:if test="${notice.type == 'important' || notice.type == 'urgent'}">
                                                <i class="fas fa-star important-star" title="গুরুত্বপূর্ণ"></i>
                                            </c:if>
                                        </div>
                                        <div class="notice-preview">
                                            <c:choose>
                                                <c:when test="${notice.content != null && notice.content.length() > 100}">
                                                    ${notice.content.substring(0, 100)}...
                                                </c:when>
                                                <c:when test="${notice.content != null}">
                                                    ${notice.content}
                                                </c:when>
                                                <c:otherwise>
                                                    কোন বিবরণ নেই
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <span class="notice-type-badge notice-type-${notice.type != null ? notice.type : 'general'}">
                                        ${notice.type != null ? notice.type : 'সাধারণ'}
                                    </span>
                                </td>
                                <td>
                                    <span class="target-group">${notice.targetGroup != null ? notice.targetGroup : 'সব কৃষক'}</span>
                                </td>
                                <td>
                                    <span class="date-cell">
                                        <c:choose>
                                            <c:when test="${notice.createdAt != null}">
                                                ${notice.createdAt.toLocalDateTime().toLocalDate().toString()}
                                            </c:when>
                                            <c:otherwise>N/A</c:otherwise>
                                        </c:choose>
                                    </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${notice.expiry == 0}">
                                            <span class="expiry unlimited">অসীমিত</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="expiry">${notice.expiry != null ? notice.expiry : 30} দিন</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${notice.isExpired()}">
                                            <span class="status-badge status-expired">মেয়াদ শেষ</span>
                                        </c:when>
                                        <c:when test="${notice.isActive()}">
                                            <span class="status-badge status-active">সক্রিয়</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-inactive">নিষ্ক্রিয়</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <a href="${pageContext.request.contextPath}/admin/notices/view/${notice.id}" 
                                           class="action-btn btn-view" data-tooltip="দেখুন">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/notices/edit/${notice.id}" 
                                           class="action-btn btn-edit" data-tooltip="সম্পাদনা করুন">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/notices/delete/${notice.id}" 
                                           class="action-btn btn-delete" data-tooltip="মুছুন"
                                           onclick="return confirm('আপনি কি নিশ্চিত যে আপনি এই নোটিশটি মুছতে চান?')">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
    </div>
</div>

<!-- Notice View Modal (if viewing a notice) -->
<c:if test="${viewNotice != null}">
    <div class="modal-overlay" id="noticeViewModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3><i class="fas fa-bullhorn"></i> নোটিশের বিবরণ</h3>
                <button class="modal-close" onclick="closeNoticeViewModal()">&times;</button>
            </div>
            <div class="modal-body">
                <div class="notice-details">
                    <div class="detail-row">
                        <label>শিরোনাম:</label>
                        <span>${viewNotice.title != null ? viewNotice.title : 'No Title'}</span>
                    </div>
                    <div class="detail-row">
                        <label>ধরন:</label>
                        <span class="notice-type-badge notice-type-${viewNotice.type != null ? viewNotice.type : 'general'}">
                            ${viewNotice.type != null ? viewNotice.type : 'সাধারণ'}
                        </span>
                    </div>
                    <div class="detail-row">
                        <label>টার্গেট গ্রুপ:</label>
                        <span>${viewNotice.targetGroup != null ? viewNotice.targetGroup : 'সব কৃষক'}</span>
                    </div>
                    <div class="detail-row">
                        <label>বিস্তারিত:</label>
                        <span>${viewNotice.content != null ? viewNotice.content : 'কোন বিবরণ নেই'}</span>
                    </div>
                    <div class="detail-row">
                        <label>মেয়াদ:</label>
                        <span>
                            <c:choose>
                                <c:when test="${viewNotice.expiry == 0}">অসীমিত</c:when>
                                <c:otherwise>${viewNotice.expiry != null ? viewNotice.expiry : 30} দিন</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <div class="detail-row">
                        <label>প্রকাশের তারিখ:</label>
                        <span>
                            <c:choose>
                                <c:when test="${viewNotice.createdAt != null}">
                                    ${viewNotice.createdAt.toLocalDateTime().toLocalDate().toString()}
                                </c:when>
                                <c:otherwise>N/A</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <div class="detail-row">
                        <label>স্ট্যাটাস:</label>
                        <span>
                            <c:choose>
                                <c:when test="${viewNotice.isExpired()}">
                                    <span class="status-badge status-expired">মেয়াদ শেষ</span>
                                </c:when>
                                <c:when test="${viewNotice.isActive()}">
                                    <span class="status-badge status-active">সক্রিয়</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-badge status-inactive">নিষ্ক্রিয়</span>
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <a href="${pageContext.request.contextPath}/admin/notices/edit/${viewNotice.id}" class="btn-primary">
                    <i class="fas fa-edit"></i> সম্পাদনা করুন
                </a>
                <button class="btn-secondary" onclick="closeNoticeViewModal()">বন্ধ করুন</button>
            </div>
        </div>
    </div>
</c:if>

<!-- Notice Templates -->
<div class="content-area">
    <h3><i class="fas fa-file-alt"></i> নোটিশ টেমপ্লেট</h3>
    <div class="templates-grid">
        <div class="template-card">
            <div class="template-header">
                <i class="fas fa-exclamation-triangle"></i>
                <h4>জরুরি সতর্কতা</h4>
            </div>
            <div class="template-content">
                <p>আবহাওয়া সতর্কতা, রোগ সতর্কতা, বা জরুরি পরিস্থিতি সম্পর্কিত নোটিশের জন্য</p>
            </div>
            <button type="button" class="btn-primary" onclick="useTemplate('urgent')">
                <i class="fas fa-plus"></i> ব্যবহার করুন
            </button>
        </div>
        
        <div class="template-card">
            <div class="template-header">
                <i class="fas fa-calendar-alt"></i>
                <h4>মৌসুমি নির্দেশনা</h4>
            </div>
            <div class="template-content">
                <p>চাষের মৌসুম, রোপণ সময়, বা কৃষি নির্দেশনার জন্য</p>
            </div>
            <button type="button" class="btn-primary" onclick="useTemplate('seasonal')">
                <i class="fas fa-plus"></i> ব্যবহার করুন
            </button>
        </div>
        
        <div class="template-card">
            <div class="template-header">
                <i class="fas fa-graduation-cap"></i>
                <h4>কৃষি শিক্ষা</h4>
            </div>
            <div class="template-content">
                <p>নতুন কৃষি প্রযুক্তি, প্রশিক্ষণ, বা শিক্ষামূলক তথ্যের জন্য</p>
            </div>
            <button type="button" class="btn-primary" onclick="useTemplate('educational')">
                <i class="fas fa-plus"></i> ব্যবহার করুন
            </button>
        </div>
        
        <div class="template-card">
            <div class="template-header">
                <i class="fas fa-handshake"></i>
                <h4>সহযোগিতা</h4>
            </div>
            <div class="template-content">
                <p>সরকারি সহায়তা, বাজার তথ্য, বা সহযোগিতামূলক কর্মসূচির জন্য</p>
            </div>
            <button type="button" class="btn-primary" onclick="useTemplate('cooperation')">
                <i class="fas fa-plus"></i> ব্যবহার করুন
            </button>
        </div>
    </div>
</div>

<script>
// Show notice view modal if viewing a notice
document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('noticeViewModal').style.display = 'flex';
});

// Close notice view modal
function closeNoticeViewModal() {
    document.getElementById('noticeViewModal').style.display = 'none';
}

function clearForm() {
    document.querySelector('.quick-notice-form').reset();
}

function useTemplate(templateType) {
    const templates = {
        urgent: {
            title: 'জরুরি সতর্কতা',
            content: 'আপনার এলাকায় জরুরি পরিস্থিতি দেখা দিয়েছে। দয়া করে সতর্কতা অবলম্বন করুন।',
            type: 'urgent',
            targetGroup: 'all',
            expiry: '1'
        },
        seasonal: {
            title: 'মৌসুমি কৃষি নির্দেশনা',
            content: 'বর্তমান মৌসুমে চাষের জন্য গুরুত্বপূর্ণ নির্দেশনা।',
            type: 'important',
            targetGroup: 'all',
            expiry: '7'
        },
        educational: {
            title: 'কৃষি শিক্ষা',
            content: 'নতুন কৃষি প্রযুক্তি ও পদ্ধতি সম্পর্কে জানুন।',
            type: 'general',
            targetGroup: 'all',
            expiry: '30'
        },
        cooperation: {
            title: 'সরকারি সহায়তা',
            content: 'কৃষকদের জন্য উপলব্ধ সরকারি সহায়তা ও সুবিধা।',
            type: 'announcement',
            targetGroup: 'all',
            expiry: '30'
        }
    };
    
    const template = templates[templateType];
    if (template) {
        document.querySelector('input[name="title"]').value = template.title;
        document.querySelector('textarea[name="content"]').value = template.content;
        document.querySelector('select[name="noticeType"]').value = template.type;
        document.querySelector('select[name="targetGroup"]').value = template.targetGroup;
        document.querySelector('select[name="expiry"]').value = template.expiry;
        
        // Scroll to form
        document.querySelector('.quick-notice-form').scrollIntoView({ behavior: 'smooth' });
    }
}

// Enhanced search and filter functionality
document.addEventListener('DOMContentLoaded', function() {
    const searchInput = document.getElementById('noticeTitleSearch');
    const typeFilter = document.getElementById('noticeTypeFilter');
    const dateFilter = document.getElementById('dateFilter');
    const searchBtn = document.getElementById('searchBtn');
    const resetBtn = document.getElementById('resetBtn');
    const noticesTable = document.getElementById('noticesTable');
    
    if (searchBtn) {
        searchBtn.addEventListener('click', function() {
            performSearch();
        });
    }
    
    if (resetBtn) {
        resetBtn.addEventListener('click', function() {
            resetFilters();
        });
    }
    
    // Real-time search as user types
    if (searchInput) {
        searchInput.addEventListener('input', function() {
            performSearch();
        });
    }
    
    // Filter on change
    if (typeFilter) {
        typeFilter.addEventListener('change', function() {
            performSearch();
        });
    }
    
    if (dateFilter) {
        dateFilter.addEventListener('change', function() {
            performSearch();
        });
    }
    
    function performSearch() {
        const searchTerm = searchInput ? searchInput.value.toLowerCase() : '';
        const selectedType = typeFilter ? typeFilter.value : '';
        const selectedDate = dateFilter ? dateFilter.value : '';
        
        const rows = noticesTable ? noticesTable.querySelectorAll('tbody tr') : [];
        
        rows.forEach(row => {
            let showRow = true;
            
            // Search by title
            if (searchTerm) {
                const title = row.querySelector('.notice-title span')?.textContent.toLowerCase() || '';
                const content = row.querySelector('.notice-preview')?.textContent.toLowerCase() || '';
                if (!title.includes(searchTerm) && !content.includes(searchTerm)) {
                    showRow = false;
                }
            }
            
            // Filter by type
            if (selectedType && showRow) {
                const type = row.querySelector('.notice-type-badge')?.textContent.toLowerCase() || '';
                if (type !== selectedType.toLowerCase()) {
                    showRow = false;
                }
            }
            
            // Filter by date (simplified implementation)
            if (selectedDate && showRow) {
                const dateCell = row.querySelector('.date-cell')?.textContent || '';
                // This is a simplified date filter - you can enhance it based on your needs
                if (selectedDate === 'today') {
                    const today = new Date().toISOString().split('T')[0];
                    if (!dateCell.includes(today)) {
                        showRow = false;
                    }
                }
            }
            
            row.style.display = showRow ? '' : 'none';
        });
        
        // Show/hide empty state
        const visibleRows = Array.from(rows).filter(row => row.style.display !== 'none');
        const emptyState = document.querySelector('.empty-state');
        if (emptyState) {
            if (visibleRows.length === 0 && (searchTerm || selectedType || selectedDate)) {
                emptyState.style.display = 'block';
                emptyState.innerHTML = `
                    <i class="fas fa-search"></i>
                    <h3>কোন ফলাফল পাওয়া যায়নি</h3>
                    <p>আপনার অনুসন্ধানের সাথে মিলে এমন কোন নোটিশ পাওয়া যায়নি।</p>
                `;
            } else if (visibleRows.length === 0) {
                emptyState.style.display = 'block';
                emptyState.innerHTML = `
                    <i class="fas fa-bullhorn"></i>
                    <h3>কোন নোটিশ নেই</h3>
                    <p>এখনও কোন নোটিশ প্রকাশ করা হয়নি। প্রথম নোটিশ যোগ করুন।</p>
                `;
            } else {
                emptyState.style.display = 'none';
            }
        }
    }
    
    function resetFilters() {
        if (searchInput) searchInput.value = '';
        if (typeFilter) typeFilter.value = '';
        if (dateFilter) dateFilter.value = '';
        performSearch();
    }
    
    // Enhanced table interactions
    if (noticesTable) {
        const rows = noticesTable.querySelectorAll('tbody tr');
        rows.forEach(row => {
            row.addEventListener('click', function(e) {
                // Don't trigger if clicking on action buttons
                if (e.target.closest('.action-buttons')) {
                    return;
                }
                
                // Add visual feedback
                rows.forEach(r => r.classList.remove('selected'));
                this.classList.add('selected');
            });
        });
    }
});

// Enhanced form validation
document.addEventListener('DOMContentLoaded', function() {
    const form = document.querySelector('.quick-notice-form');
    if (form) {
        form.addEventListener('submit', function(e) {
            const title = form.querySelector('input[name="title"]');
            const content = form.querySelector('textarea[name="content"]');
            
            if (!title.value.trim()) {
                e.preventDefault();
                alert('শিরোনাম প্রয়োজনীয়');
                title.focus();
                return false;
            }
            
            if (!content.value.trim()) {
                e.preventDefault();
                alert('বিস্তারিত প্রয়োজনীয়');
                content.focus();
                return false;
            }
        });
    }
});

// Enhanced modal functionality
function closeNoticeViewModal() {
    const modal = document.getElementById('noticeViewModal');
    if (modal) {
        modal.style.display = 'none';
        // Remove modal backdrop click handler
        modal.onclick = null;
    }
}

// Add modal backdrop click to close
document.addEventListener('DOMContentLoaded', function() {
    const modal = document.getElementById('noticeViewModal');
    if (modal) {
        modal.addEventListener('click', function(e) {
            if (e.target === modal) {
                closeNoticeViewModal();
            }
        });
    }
});
</script>

<jsp:include page="/WEB-INF/includes/admin_footer.jsp" />
