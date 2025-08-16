<%@page import="com.mycompany.agrosystem.model.User"%>
<%@page import="com.mycompany.agrosystem.model.Admin"%>
<%@page import="java.util.*"%>
<%@page session="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/includes/admin_header.jsp">
    <jsp:param name="pageTitle" value="পাসওয়ার্ড পরিবর্তন" />
    <jsp:param name="pageIcon" value="fas fa-key" />
    <jsp:param name="activePage" value="password" />
</jsp:include>

<style>
    .password-change-container {
        max-width: 600px;
        margin: 0 auto;
        padding: 30px;
        background: white;
        border-radius: 15px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.1);
    }
    
    .password-change-header {
        text-align: center;
        margin-bottom: 30px;
        padding-bottom: 20px;
        border-bottom: 2px solid #e9ecef;
    }
    
    .password-change-header h3 {
        color: #2c3e50;
        margin-bottom: 10px;
        font-size: 1.8rem;
    }
    
    .password-change-header p {
        color: #7f8c8d;
        font-size: 1rem;
    }
    
    .form-group {
        margin-bottom: 25px;
    }
    
    .form-group label {
        display: block;
        margin-bottom: 8px;
        font-weight: 600;
        color: #2c3e50;
        font-size: 1rem;
    }
    
    .form-group input {
        width: 100%;
        padding: 15px;
        border: 2px solid #e9ecef;
        border-radius: 10px;
        font-size: 1rem;
        transition: all 0.3s ease;
        box-sizing: border-box;
    }
    
    .form-group input:focus {
        outline: none;
        border-color: #3498db;
        box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
    }
    
    .password-requirements {
        background: #f8f9fa;
        border: 1px solid #e9ecef;
        border-radius: 10px;
        padding: 20px;
        margin: 25px 0;
    }
    
    .password-requirements h4 {
        color: #2c3e50;
        margin-bottom: 15px;
        font-size: 1.1rem;
    }
    
    .requirement-item {
        display: flex;
        align-items: center;
        margin-bottom: 10px;
        font-size: 0.95rem;
        color: #555;
    }
    
    .requirement-item i {
        margin-right: 10px;
        width: 20px;
        text-align: center;
    }
    
    .requirement-item.valid {
        color: #27ae60;
    }
    
    .requirement-item.invalid {
        color: #e74c3c;
    }
    
    .submit-btn {
        width: 100%;
        padding: 15px;
        background: linear-gradient(135deg, #3498db, #2980b9);
        color: white;
        border: none;
        border-radius: 10px;
        font-size: 1.1rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        margin-top: 20px;
    }
    
    .submit-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(52, 152, 219, 0.4);
    }
    
    .submit-btn:disabled {
        background: #bdc3c7;
        cursor: not-allowed;
        transform: none;
        box-shadow: none;
    }
    
    .message {
        padding: 15px;
        border-radius: 10px;
        margin-bottom: 20px;
        font-weight: 500;
    }
    
    .success-message {
        background: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
    }
    
    .error-message {
        background: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
    }
    
    .loading {
        opacity: 0.6;
        pointer-events: none;
    }
    
    .loading .submit-btn {
        background: #95a5a6;
    }
    
    @media (max-width: 768px) {
        .password-change-container {
            margin: 20px;
            padding: 20px;
        }
        
        .password-change-header h3 {
            font-size: 1.5rem;
        }
    }
</style>

<div class="password-change-container">
    <div class="password-change-header">
        <h3><i class="fas fa-key"></i> পাসওয়ার্ড পরিবর্তন করুন</h3>
        <p>আপনার অ্যাকাউন্টের নিরাপত্তার জন্য নিয়মিত পাসওয়ার্ড পরিবর্তন করুন</p>
    </div>
    
    <!-- Success/Error Messages -->
    <% if (request.getAttribute("successMessage") != null) { %>
        <div class="message success-message">
            <i class="fas fa-check-circle"></i> <%= request.getAttribute("successMessage") %>
        </div>
    <% } %>
    
    <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="message error-message">
            <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("errorMessage") %>
        </div>
    <% } %>
    
    <form id="passwordChangeForm" action="${pageContext.request.contextPath}/changePassword" method="post">
        <div class="form-group">
            <label for="currentPassword">
                <i class="fas fa-lock"></i> বর্তমান পাসওয়ার্ড
            </label>
            <input type="password" id="currentPassword" name="currentPassword" required 
                   placeholder="আপনার বর্তমান পাসওয়ার্ড লিখুন">
        </div>
        
        <div class="form-group">
            <label for="newPassword">
                <i class="fas fa-key"></i> নতুন পাসওয়ার্ড
            </label>
            <input type="password" id="newPassword" name="newPassword" required 
                   placeholder="নতুন পাসওয়ার্ড লিখুন">
        </div>
        
        <div class="form-group">
            <label for="confirmPassword">
                <i class="fas fa-check-circle"></i> পাসওয়ার্ড নিশ্চিত করুন
            </label>
            <input type="password" id="confirmPassword" name="confirmPassword" required 
                   placeholder="নতুন পাসওয়ার্ড আবার লিখুন">
        </div>
        
        <!-- Password Requirements -->
        <div class="password-requirements">
            <h4><i class="fas fa-shield-alt"></i> পাসওয়ার্ডের প্রয়োজনীয়তা</h4>
            <div class="requirement-item" id="length-req">
                <i class="fas fa-circle" id="length-icon"></i>
                <span>কমপক্ষে ৮টি অক্ষর</span>
            </div>
            <div class="requirement-item" id="uppercase-req">
                <i class="fas fa-circle" id="uppercase-icon"></i>
                <span>একটি বড় হাতের অক্ষর (A-Z)</span>
            </div>
            <div class="requirement-item" id="lowercase-req">
                <i class="fas fa-circle" id="lowercase-icon"></i>
                <span>একটি ছোট হাতের অক্ষর (a-z)</span>
            </div>
            <div class="requirement-item" id="number-req">
                <i class="fas fa-circle" id="number-icon"></i>
                <span>একটি সংখ্যা (0-9)</span>
            </div>
            <div class="requirement-item" id="special-req">
                <i class="fas fa-circle" id="special-icon"></i>
                <span>একটি বিশেষ অক্ষর (!@#$%^&*)</span>
            </div>
        </div>
        
        <button type="submit" class="submit-btn" id="submitBtn">
            <i class="fas fa-save"></i> পাসওয়ার্ড পরিবর্তন করুন
        </button>
    </form>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('passwordChangeForm');
    const newPassword = document.getElementById('newPassword');
    const confirmPassword = document.getElementById('confirmPassword');
    const submitBtn = document.getElementById('submitBtn');
    
    // Password validation
    function validatePassword(password) {
        const requirements = {
            length: password.length >= 8,
            uppercase: /[A-Z]/.test(password),
            lowercase: /[a-z]/.test(password),
            number: /[0-9]/.test(password),
            special: /[!@#$%^&*]/.test(password)
        };
        
        // Update requirement indicators
        updateRequirement('length', requirements.length);
        updateRequirement('uppercase', requirements.uppercase);
        updateRequirement('lowercase', requirements.lowercase);
        updateRequirement('number', requirements.number);
        updateRequirement('special', requirements.special);
        
        return Object.values(requirements).every(req => req);
    }
    
    function updateRequirement(type, isValid) {
        const req = document.getElementById(type + '-req');
        const icon = document.getElementById(type + '-icon');
        
        if (isValid) {
            req.classList.add('valid');
            req.classList.remove('invalid');
            icon.className = 'fas fa-check-circle';
            icon.style.color = '#27ae60';
        } else {
            req.classList.add('invalid');
            req.classList.remove('valid');
            icon.className = 'fas fa-times-circle';
            icon.style.color = '#e74c3c';
        }
    }
    
    // Real-time password validation
    newPassword.addEventListener('input', function() {
        validatePassword(this.value);
    });
    
    // Confirm password validation
    function validateConfirmPassword() {
        if (newPassword.value === confirmPassword.value) {
            confirmPassword.style.borderColor = '#27ae60';
            return true;
        } else {
            confirmPassword.style.borderColor = '#e74c3c';
            return false;
        }
    }
    
    confirmPassword.addEventListener('input', validateConfirmPassword);
    
    // Form submission
    form.addEventListener('submit', function(e) {
        e.preventDefault();
        
        // Validate form
        if (!validatePassword(newPassword.value)) {
            showError('দয়া করে একটি শক্তিশালী পাসওয়ার্ড ব্যবহার করুন');
            return;
        }
        
        if (newPassword.value !== confirmPassword.value) {
            showError('নতুন পাসওয়ার্ড এবং নিশ্চিতকরণ মিলছে না');
            return;
        }
        
        // Show loading state
        form.classList.add('loading');
        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> পরিবর্তন হচ্ছে...';
        submitBtn.disabled = true;
        
        // Submit form
        form.submit();
    });
    
    function showError(message) {
        // Remove existing messages
        const existingMessages = document.querySelectorAll('.message');
        existingMessages.forEach(msg => msg.remove());
        
        // Create error message
        const errorDiv = document.createElement('div');
        errorDiv.className = 'message error-message';
        errorDiv.innerHTML = '<i class="fas fa-exclamation-circle"></i> ' + message;
        
        // Insert before form
        form.parentNode.insertBefore(errorDiv, form);
        
        // Auto-remove after 5 seconds
        setTimeout(() => {
            errorDiv.remove();
        }, 5000);
    }
    
    // Initialize validation
    validatePassword('');
});
</script>

<jsp:include page="/WEB-INF/includes/admin_footer.jsp" />
