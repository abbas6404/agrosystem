<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<jsp:include page="/WEB-INF/includes/admin_header.jsp">
    <jsp:param name="pageTitle" value="ফসল ব্যবস্থাপনা" />
    <jsp:param name="pageIcon" value="fas fa-leaf" />
    <jsp:param name="activePage" value="crops" />
</jsp:include>

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

<!-- Add/Edit Crop Form -->
<div class="content-area" style="margin-bottom: 30px;">
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
                       placeholder="ফসলের নাম লিখুন"
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
                    <option value="রবি" ${editCrop != null && editCrop.season == 'রবি' ? 'selected' : ''}>রবি</option>
                    <option value="খরিফ" ${editCrop != null && editCrop.season == 'খরিফ' ? 'selected' : ''}>খরিফ</option>
                    <option value="জায়েদ" ${editCrop != null && editCrop.season == 'জায়েদ' ? 'selected' : ''}>জায়েদ</option>
                    <option value="সারা বছর" ${editCrop != null && editCrop.season == 'সারা বছর' ? 'selected' : ''}>সারা বছর</option>
                </select>
            </div>
            <div class="input-group">
                <label>বিবরণ</label>
                <textarea name="description" rows="3" placeholder="ফসলের বিবরণ লিখুন">${editCrop != null ? editCrop.description : ''}</textarea>
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
                    <th>নাম</th>
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
                                    <div class="crop-description">
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
                                    <p>কোন ফসল পাওয়া যায়নি</p>
                                    <small>নতুন ফসল যোগ করে শুরু করুন</small>
                                </div>
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
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
    document.getElementById('cropViewModal').style.display = 'flex';
});

// Close crop view modal
function closeCropViewModal() {
    document.getElementById('cropViewModal').style.display = 'none';
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

// Search and filter functionality
document.addEventListener('DOMContentLoaded', function() {
    const searchInput = document.getElementById('cropSearch');
    const typeFilter = document.getElementById('cropTypeFilter');
    const seasonFilter = document.getElementById('seasonFilter');
    const table = document.getElementById('cropsTable');
    const rows = table.getElementsByTagName('tbody')[0].getElementsByTagName('tr');

    function filterTable() {
        const searchTerm = searchInput.value.toLowerCase();
        const selectedType = typeFilter.value.toLowerCase();
        const selectedSeason = seasonFilter.value.toLowerCase();

        for (let i = 0; i < rows.length; i++) {
            const row = rows[i];
            const name = row.cells[0].textContent.toLowerCase();
            const type = row.cells[1].textContent.toLowerCase();
            const season = row.cells[2].textContent.toLowerCase();

            const matchesSearch = name.includes(searchTerm);
            const matchesType = !selectedType || type.includes(selectedType);
            const matchesSeason = !selectedSeason || season.includes(selectedSeason);

            if (matchesSearch && matchesType && matchesSeason) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        }
    }

    searchInput.addEventListener('input', filterTable);
    typeFilter.addEventListener('change', filterTable);
    seasonFilter.addEventListener('change', filterTable);
});

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
</script>