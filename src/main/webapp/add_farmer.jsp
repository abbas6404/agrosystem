<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<jsp:include page="/WEB-INF/includes/admin_header.jsp">
    <jsp:param name="pageTitle" value="নতুন কৃষক যোগ করুন" />
    <jsp:param name="pageIcon" value="fas fa-user-plus" />
    <jsp:param name="activePage" value="farmers" />
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
.farmer-form {
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

.btn-primary, .btn-secondary {
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

/* Form Validation */
.input-error {
    border-color: var(--danger-color) !important;
    box-shadow: 0 0 0 3px rgba(231, 76, 60, 0.1) !important;
}

.error-message {
    color: var(--danger-color);
    font-size: 0.85rem;
    margin-top: 5px;
    display: none;
}

.error-message.show {
    display: block;
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
    
    .form-actions {
        flex-direction: column;
        align-items: stretch;
    }
    
    .btn-primary, .btn-secondary {
        width: 100%;
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
    <h1><i class="fas fa-user-plus"></i> নতুন কৃষক যোগ করুন</h1>
    <p>আপনার কৃষি ব্যবস্থায় নতুন কৃষক নিবন্ধন করুন</p>
</div>

<!-- Add Farmer Form -->
<div class="content-area">
    <h3><i class="fas fa-user-edit"></i> কৃষকের তথ্য</h3>
    
    <form action="${pageContext.request.contextPath}/admin/farmers/add" method="post" class="farmer-form" id="addFarmerForm">
        <input type="hidden" name="action" value="add">
        
        <div class="form-row">
            <div class="input-group">
                <label>কৃষকের নাম <span class="required">*</span></label>
                <input type="text" name="farmerName" id="farmerName" required 
                       placeholder="কৃষকের পূর্ণ নাম লিখুন">
                <div class="error-message" id="farmerNameError">কৃষকের নাম প্রয়োজন</div>
            </div>
            <div class="input-group">
                <label>ফোন নম্বর <span class="required">*</span></label>
                <input type="tel" name="phoneNumber" id="phoneNumber" required 
                       placeholder="০১৭১১-১২৩৪৫৬">
                <div class="error-message" id="phoneNumberError">সঠিক ফোন নম্বর প্রয়োজন</div>
            </div>
        </div>
        
        <div class="form-row">
            <div class="input-group">
                <label>পাসওয়ার্ড <span class="required">*</span></label>
                <input type="password" name="password" id="password" required 
                       placeholder="নূন্যতম ৬ অক্ষর">
                <div class="error-message" id="passwordError">পাসওয়ার্ড প্রয়োজন</div>
            </div>
            <div class="input-group">
                <label>পাসওয়ার্ড নিশ্চিত করুন <span class="required">*</span></label>
                <input type="password" name="confirmPassword" id="confirmPassword" required 
                       placeholder="পাসওয়ার্ড আবার লিখুন">
                <div class="error-message" id="confirmPasswordError">পাসওয়ার্ড মিলছে না</div>
            </div>
        </div>
        
        <div class="form-row">
            <div class="input-group">
                <label>এলাকা <span class="required">*</span></label>
                <input type="text" name="location" id="location" required 
                       placeholder="যেমন: আশুলিয়া, সাভার, ঢাকা">
                <div class="error-message" id="locationError">এলাকা প্রয়োজন</div>
            </div>
            <div class="input-group">
                <label>জমির আকার (একর) <span class="required">*</span></label>
                <input type="number" name="landSize" id="landSize" required 
                       placeholder="যেমন: ২.৫" step="0.1" min="0.1">
                <div class="error-message" id="landSizeError">জমির আকার প্রয়োজন</div>
            </div>
        </div>
        
        <div class="form-row">
            <div class="input-group">
                <label>মাটির ধরণ</label>
                <select name="soilType" id="soilType">
                    <option value="">মাটির ধরণ নির্বাচন করুন</option>
                    <option value="দোআঁশ">দোআঁশ (Loamy)</option>
                    <option value="বেলে">বেলে (Sandy)</option>
                    <option value="এঁটেল">এঁটেল (Clayey)</option>
                    <option value="পাথুরে">পাথুরে (Rocky)</option>
                    <option value="জৈব">জৈব (Organic)</option>
                </select>
            </div>
            <div class="input-group">
                <label>মাটির অবস্থা</label>
                <textarea name="soilConditions" id="soilConditions" rows="3" 
                          placeholder="মাটির বিশেষ বৈশিষ্ট্য, pH মান, বা অন্যান্য গুরুত্বপূর্ণ তথ্য লিখুন"></textarea>
            </div>
        </div>
        
        <div class="form-row">
            <div class="input-group">
                <label>জলবায়ু</label>
                <select name="climate" id="climate">
                    <option value="">জলবায়ু নির্বাচন করুন</option>
                    <option value="উষ্ণ">উষ্ণ (Warm)</option>
                    <option value="মাঝারি">মাঝারি (Moderate)</option>
                    <option value="শীতল">শীতল (Cool)</option>
                    <option value="আর্দ্র">আর্দ্র (Humid)</option>
                    <option value="শুষ্ক">শুষ্ক (Dry)</option>
                </select>
            </div>
            <div class="input-group">
                <label>সেচ ব্যবস্থা</label>
                <select name="irrigation" id="irrigation">
                    <option value="">সেচ ব্যবস্থা নির্বাচন করুন</option>
                    <option value="নলকূপ">নলকূপ (Tube Well)</option>
                    <option value="পুকুর">পুকুর (Pond)</option>
                    <option value="নদী">নদী (River)</option>
                    <option value="বৃষ্টি">বৃষ্টি (Rain-fed)</option>
                    <option value="ড্রিপ">ড্রিপ সেচ (Drip Irrigation)</option>
                </select>
            </div>
        </div>
        
        <div class="form-actions">
            <button type="submit" class="btn-primary" id="submitBtn">
                <i class="fas fa-save"></i> কৃষক যোগ করুন
            </button>
            <a href="${pageContext.request.contextPath}/admin/farmers" class="btn-secondary">
                <i class="fas fa-times"></i> বাতিল করুন
            </a>
        </div>
    </form>
</div>

<!-- Form Preview -->
<div class="content-area">
    <h3><i class="fas fa-eye"></i> ফর্ম প্রিভিউ</h3>
    <div id="formPreview" style="background: var(--bg-light); padding: 20px; border-radius: var(--border-radius);">
        <p style="text-align: center; color: var(--text-secondary);">ফর্ম পূরণ করুন প্রিভিউ দেখতে</p>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/admin_footer.jsp" />

<script>
document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('addFarmerForm');
    const inputs = form.querySelectorAll('input, select, textarea');
    const preview = document.getElementById('formPreview');
    
    // Real-time form validation
    inputs.forEach(input => {
        input.addEventListener('blur', function() {
            validateField(this);
        });
        
        input.addEventListener('input', function() {
            clearFieldError(this);
            updatePreview();
        });
    });
    
    // Form submission
    form.addEventListener('submit', function(e) {
        if (!validateForm()) {
            e.preventDefault();
            return false;
        }
        
        // Show loading state
        const submitBtn = document.getElementById('submitBtn');
        submitBtn.classList.add('loading');
        submitBtn.disabled = true;
        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> যোগ করা হচ্ছে...';
    });
    
    // Field validation
    function validateField(field) {
        const value = field.value.trim();
        const fieldName = field.name;
        let isValid = true;
        let errorMessage = '';
        
        // Required field validation
        if (field.hasAttribute('required') && !value) {
            isValid = false;
            errorMessage = 'এই ক্ষেত্রটি প্রয়োজন';
        }
        
        // Specific field validations
        if (fieldName === 'phoneNumber' && value) {
            const phoneRegex = /^(\+?880|0)?1[3-9]\d{8}$/;
            if (!phoneRegex.test(value.replace(/[-\s]/g, ''))) {
                isValid = false;
                errorMessage = 'সঠিক ফোন নম্বর লিখুন';
            }
        }
        
        if (fieldName === 'password' && value) {
            if (value.length < 6) {
                isValid = false;
                errorMessage = 'পাসওয়ার্ড কমপক্ষে ৬ অক্ষর হতে হবে';
            }
        }
        
        if (fieldName === 'confirmPassword' && value) {
            const password = document.getElementById('password').value;
            if (value !== password) {
                isValid = false;
                errorMessage = 'পাসওয়ার্ড মিলছে না';
            }
        }
        
        if (fieldName === 'landSize' && value) {
            const size = parseFloat(value);
            if (isNaN(size) || size <= 0) {
                isValid = false;
                errorMessage = 'সঠিক জমির আকার লিখুন';
            }
        }
        
        // Show/hide error
        if (!isValid) {
            showFieldError(field, errorMessage);
        } else {
            clearFieldError(field);
        }
        
        return isValid;
    }
    
    // Show field error
    function showFieldError(field, message) {
        field.classList.add('input-error');
        const errorDiv = field.parentNode.querySelector('.error-message');
        if (errorDiv) {
            errorDiv.textContent = message;
            errorDiv.classList.add('show');
        }
    }
    
    // Clear field error
    function clearFieldError(field) {
        field.classList.remove('input-error');
        const errorDiv = field.parentNode.querySelector('.error-message');
        if (errorDiv) {
            errorDiv.classList.remove('show');
        }
    }
    
    // Validate entire form
    function validateForm() {
        let isValid = true;
        inputs.forEach(input => {
            if (!validateField(input)) {
                isValid = false;
            }
        });
        return isValid;
    }
    
    // Update preview
    function updatePreview() {
        const formData = new FormData(form);
        let previewHTML = '<div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px;">';
        
        for (let [key, value] of formData.entries()) {
            if (value && key !== 'action') {
                const label = getFieldLabel(key);
                previewHTML += `
                    <div style="background: white; padding: 15px; border-radius: 8px; border: 1px solid var(--border-color);">
                        <strong style="color: var(--text-primary);">${label}:</strong><br>
                        <span style="color: var(--text-secondary);">${value}</span>
                    </div>
                `;
            }
        }
        
        previewHTML += '</div>';
        
        if (previewHTML === '<div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px;"></div>') {
            preview.innerHTML = '<p style="text-align: center; color: var(--text-secondary);">ফর্ম পূরণ করুন প্রিভিউ দেখতে</p>';
        } else {
            preview.innerHTML = previewHTML;
        }
    }
    
    // Get field label
    function getFieldLabel(fieldName) {
        const labels = {
            'farmerName': 'কৃষকের নাম',
            'phoneNumber': 'ফোন নম্বর',
            'password': 'পাসওয়ার্ড',
            'confirmPassword': 'পাসওয়ার্ড নিশ্চিত করুন',
            'location': 'এলাকা',
            'landSize': 'জমির আকার',
            'soilType': 'মাটির ধরণ',
            'soilConditions': 'মাটির অবস্থা',
            'climate': 'জলবায়ু',
            'irrigation': 'সেচ ব্যবস্থা'
        };
        return labels[fieldName] || fieldName;
    }
    
    // Initialize preview
    updatePreview();
});
</script>
