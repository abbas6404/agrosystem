<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mycompany.agrosystem.model.User" %>
<%@ page import="com.mycompany.agrosystem.model.Farmer" %>
<%@ page import="java.util.*" %>
<%@ page session="true" %>

<%
    User user = (User) session.getAttribute("loggedInUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="bn">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>পাসওয়ার্ড পরিবর্তন - AgroSystem</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #10b981;
            --secondary-color: #3b82f6;
            --accent-color: #f59e0b;
            --success-color: #10b981;
            --danger-color: #ef4444;
            --warning-color: #f59e0b;
            --gray-50: #f9fafb;
            --gray-100: #f3f4f6;
            --gray-200: #e5e7eb;
            --gray-300: #d1d5db;
            --gray-400: #9ca3af;
            --gray-500: #6b7280;
            --gray-600: #4b5563;
            --gray-700: #374151;
            --gray-800: #1f2937;
            --gray-900: #111827;
            --gradient-primary: linear-gradient(135deg, #10b981 0%, #059669 100%);
            --gradient-secondary: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
            --gradient-accent: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
            --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            --border-radius: 8px;
            --border-radius-lg: 12px;
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: var(--gray-50);
            color: var(--gray-800);
            line-height: 1.6;
        }

        .dashboard-container {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Styles */
        .sidebar {
            width: 280px;
            background: white;
            box-shadow: var(--shadow-lg);
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            z-index: 1000;
            transition: var(--transition);
        }

        .sidebar-header {
            padding: 30px 25px;
            border-bottom: 1px solid var(--gray-200);
            text-align: center;
        }

        .sidebar-header h3 {
            color: var(--primary-color);
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .sidebar-header p {
            color: var(--gray-600);
            font-size: 0.9rem;
        }

        .nav-menu {
            padding: 20px 0;
        }

        .nav-item {
            display: flex;
            align-items: center;
            padding: 15px 25px;
            color: var(--gray-700);
            text-decoration: none;
            transition: var(--transition);
            border-left: 3px solid transparent;
        }

        .nav-item:hover {
            background: var(--gray-50);
            color: var(--primary-color);
            border-left-color: var(--primary-color);
        }

        .nav-item.active {
            background: var(--gray-50);
            color: var(--primary-color);
            border-left-color: var(--primary-color);
        }

        .nav-item i {
            width: 20px;
            margin-right: 15px;
            font-size: 1.1rem;
        }

        .mobile-menu-toggle {
            display: none;
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 1001;
            background: var(--primary-color);
            color: white;
            border: none;
            padding: 10px;
            border-radius: var(--border-radius);
            cursor: pointer;
            font-size: 1.2rem;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 30px;
            transition: var(--transition);
        }

        .main-header {
            background: white;
            padding: 25px 30px;
            border-radius: var(--border-radius-lg);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: var(--shadow-md);
        }

        .header-title h2 {
            color: var(--gray-800);
            margin: 0 0 10px 0;
            font-size: 2rem;
            font-weight: 700;
        }

        .header-title p {
            color: var(--gray-600);
            margin: 0;
            font-size: 1.1rem;
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .btn-primary {
            background: var(--gradient-primary);
            color: white;
            padding: 12px 24px;
            border-radius: var(--border-radius);
            text-decoration: none;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: var(--transition);
            box-shadow: var(--shadow-md);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        /* Password Change Form */
        .password-change-container {
            background: white;
            border-radius: var(--border-radius-lg);
            box-shadow: var(--shadow-md);
            overflow: hidden;
        }

        .form-header {
            background: var(--gradient-primary);
            color: white;
            padding: 30px;
            text-align: center;
        }

        .form-header i {
            font-size: 3rem;
            margin-bottom: 15px;
            display: block;
        }

        .form-header h3 {
            font-size: 1.8rem;
            margin-bottom: 10px;
            font-weight: 700;
        }

        .form-header p {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        .form-content {
            padding: 40px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--gray-700);
            font-size: 1rem;
        }

        .form-group input {
            width: 100%;
            padding: 15px;
            border: 2px solid var(--gray-200);
            border-radius: var(--border-radius);
            font-size: 1rem;
            transition: var(--transition);
            background: var(--gray-50);
        }

        .form-group input:focus {
            outline: none;
            border-color: var(--primary-color);
            background: white;
            box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.1);
        }

        .form-group input.error {
            border-color: var(--danger-color);
            background: #fef2f2;
        }

        .form-group input.success {
            border-color: var(--success-color);
            background: #f0fdf4;
        }

        .error-message {
            color: var(--danger-color);
            font-size: 0.9rem;
            margin-top: 5px;
            display: none;
        }

        .success-message {
            color: var(--success-color);
            font-size: 0.9rem;
            margin-top: 5px;
            display: none;
        }

        .password-requirements {
            background: var(--gray-50);
            border: 1px solid var(--gray-200);
            border-radius: var(--border-radius);
            padding: 20px;
            margin-bottom: 25px;
        }

        .password-requirements h4 {
            color: var(--gray-700);
            margin-bottom: 15px;
            font-size: 1.1rem;
        }

        .requirement-list {
            list-style: none;
        }

        .requirement-list li {
            display: flex;
            align-items: center;
            margin-bottom: 8px;
            font-size: 0.9rem;
            color: var(--gray-600);
        }

        .requirement-list li i {
            margin-right: 10px;
            width: 16px;
            text-align: center;
        }

        .requirement-list li.valid i {
            color: var(--success-color);
        }

        .requirement-list li.invalid i {
            color: var(--danger-color);
        }

        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: flex-end;
            margin-top: 30px;
        }

        .btn-secondary {
            background: var(--gray-200);
            color: var(--gray-700);
            padding: 12px 24px;
            border: none;
            border-radius: var(--border-radius);
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
        }

        .btn-secondary:hover {
            background: var(--gray-300);
        }

        .btn-submit {
            background: var(--gradient-primary);
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: var(--border-radius);
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: var(--shadow-md);
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .btn-submit:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }

        /* Alert Messages */
        .alert {
            padding: 15px 20px;
            border-radius: var(--border-radius);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .alert-success {
            background: #d1fae5;
            color: #065f46;
            border: 1px solid #a7f3d0;
        }

        .alert-danger {
            background: #fee2e2;
            color: #991b1b;
            border: 1px solid #fca5a5;
        }

        .alert i {
            font-size: 1.2rem;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .mobile-menu-toggle {
                display: block;
            }

            .sidebar {
                transform: translateX(-100%);
            }

            .sidebar.open {
                transform: translateX(0);
            }

            .main-content {
                margin-left: 0;
                padding: 20px;
            }

            .form-content {
                padding: 25px;
            }

            .form-actions {
                flex-direction: column;
            }

            .btn-submit, .btn-secondary {
                width: 100%;
                text-align: center;
            }
        }

        /* Loading State */
        .loading {
            opacity: 0.6;
            pointer-events: none;
        }

        .spinner {
            display: inline-block;
            width: 16px;
            height: 16px;
            border: 2px solid #ffffff;
            border-radius: 50%;
            border-top-color: transparent;
            animation: spin 1s ease-in-out infinite;
            margin-right: 8px;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <!-- Mobile Menu Toggle -->
        <button class="mobile-menu-toggle" onclick="toggleSidebar()">
            <i class="fas fa-bars"></i>
        </button>

        <!-- Sidebar -->
        <aside class="sidebar" id="sidebar">
            <div class="sidebar-header">
                <h3><i class="fas fa-leaf"></i> AgroSystem</h3>
                <p>কৃষি ব্যবস্থাপনা সিস্টেম</p>
            </div>
            <nav class="nav-menu">
                <a href="${pageContext.request.contextPath}/farmerDashboard" class="nav-item">
                    <i class="fas fa-tachometer-alt"></i> ড্যাশবোর্ড
                </a>
                <a href="${pageContext.request.contextPath}/myCrops" class="nav-item">
                    <i class="fas fa-seedling"></i> আমার ফসল
                </a>
                <a href="${pageContext.request.contextPath}/getSuggestion" class="nav-item">
                    <i class="fas fa-lightbulb"></i> AI পরামর্শ
                </a>
                <a href="${pageContext.request.contextPath}/weather" class="nav-item">
                    <i class="fas fa-cloud-sun"></i> আবহাওয়া
                </a>
                <a href="${pageContext.request.contextPath}/disease_detection.jsp" class="nav-item">
                    <i class="fas fa-stethoscope"></i> রোগ শনাক্তকরণ
                </a>
                <a href="${pageContext.request.contextPath}/profile.jsp" class="nav-item">
                    <i class="fas fa-user"></i> প্রোফাইল
                </a>
                <a href="${pageContext.request.contextPath}/change_password.jsp" class="nav-item active">
                    <i class="fas fa-key"></i> পাসওয়ার্ড পরিবর্তন
                </a>
                <a href="${pageContext.request.contextPath}/logout" class="nav-item">
                    <i class="fas fa-sign-out-alt"></i> লগ আউট
                </a>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <div class="main-header">
                <div class="header-title">
                    <h2><i class="fas fa-key"></i> পাসওয়ার্ড পরিবর্তন</h2>
                    <p>আপনার অ্যাকাউন্টের নিরাপত্তা বাড়ান</p>
                </div>
                <div class="header-actions">
                    <a href="${pageContext.request.contextPath}/profile.jsp" class="btn-primary">
                        <i class="fas fa-user"></i> প্রোফাইল
                    </a>
                </div>
            </div>

            <!-- Alert Messages -->
            <% if (request.getAttribute("successMessage") != null) { %>
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i>
                    <%= request.getAttribute("successMessage") %>
                </div>
            <% } %>
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle"></i>
                    <%= request.getAttribute("errorMessage") %>
                </div>
            <% } %>

            <!-- Password Change Form -->
            <div class="password-change-container">
                <div class="form-header">
                    <i class="fas fa-shield-alt"></i>
                    <h3>নিরাপদ পাসওয়ার্ড সেট করুন</h3>
                    <p>আপনার অ্যাকাউন্ট সুরক্ষিত রাখতে শক্তিশালী পাসওয়ার্ড ব্যবহার করুন</p>
                </div>
                
                <div class="form-content">
                    <form id="passwordChangeForm" action="${pageContext.request.contextPath}/changePassword" method="post" onsubmit="return validateForm()">
                        <div class="form-group">
                            <label for="currentPassword">বর্তমান পাসওয়ার্ড</label>
                            <input type="password" id="currentPassword" name="currentPassword" required>
                            <div class="error-message" id="currentPasswordError"></div>
                        </div>

                        <div class="form-group">
                            <label for="newPassword">নতুন পাসওয়ার্ড</label>
                            <input type="password" id="newPassword" name="newPassword" required>
                            <div class="error-message" id="newPasswordError"></div>
                        </div>

                        <div class="form-group">
                            <label for="confirmPassword">নতুন পাসওয়ার্ড নিশ্চিত করুন</label>
                            <input type="password" id="confirmPassword" name="confirmPassword" required>
                            <div class="error-message" id="confirmPasswordError"></div>
                        </div>

                        <!-- Password Requirements -->
                        <div class="password-requirements">
                            <h4><i class="fas fa-info-circle"></i> পাসওয়ার্ডের প্রয়োজনীয়তা</h4>
                            <ul class="requirement-list">
                                <li id="lengthReq">
                                    <i class="fas fa-circle"></i>
                                    কমপক্ষে ৮টি অক্ষর
                                </li>
                                <li id="uppercaseReq">
                                    <i class="fas fa-circle"></i>
                                    কমপক্ষে একটি বড় হাতের অক্ষর
                                </li>
                                <li id="lowercaseReq">
                                    <i class="fas fa-circle"></i>
                                    কমপক্ষে একটি ছোট হাতের অক্ষর
                                </li>
                                <li id="numberReq">
                                    <i class="fas fa-circle"></i>
                                    কমপক্ষে একটি সংখ্যা
                                </li>
                                <li id="specialReq">
                                    <i class="fas fa-circle"></i>
                                    কমপক্ষে একটি বিশেষ অক্ষর (!@#$%^&*)
                                </li>
                            </ul>
                        </div>

                        <div class="form-actions">
                            <a href="${pageContext.request.contextPath}/profile.jsp" class="btn-secondary">
                                <i class="fas fa-arrow-left"></i> ফিরে যান
                            </a>
                            <button type="submit" class="btn-submit" id="submitBtn">
                                <span class="spinner" style="display: none;"></span>
                                <i class="fas fa-save"></i> পাসওয়ার্ড পরিবর্তন করুন
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </main>
    </div>

    <script>
        // Toggle sidebar on mobile
        function toggleSidebar() {
            const sidebar = document.querySelector('.sidebar');
            sidebar.classList.toggle('open');
        }

        // Close sidebar when clicking outside on mobile
        document.addEventListener('click', function(event) {
            const sidebar = document.querySelector('.sidebar');
            const mobileToggle = document.querySelector('.mobile-menu-toggle');
            
            if (window.innerWidth <= 768) {
                if (!sidebar.contains(event.target) && !mobileToggle.contains(event.target)) {
                    sidebar.classList.remove('open');
                }
            }
        });

        // Password validation
        const newPasswordInput = document.getElementById('newPassword');
        const confirmPasswordInput = document.getElementById('confirmPassword');
        const currentPasswordInput = document.getElementById('currentPassword');

        function validatePassword(password) {
            const requirements = {
                length: password.length >= 8,
                uppercase: /[A-Z]/.test(password),
                lowercase: /[a-z]/.test(password),
                number: /[0-9]/.test(password),
                special: /[!@#$%^&*]/.test(password)
            };

            // Update requirement indicators
            document.getElementById('lengthReq').className = requirements.length ? 'valid' : 'invalid';
            document.getElementById('lengthReq').innerHTML = `<i class="fas fa-${requirements.length ? 'check' : 'times'}"></i> কমপক্ষে ৮টি অক্ষর`;
            
            document.getElementById('uppercaseReq').className = requirements.uppercase ? 'valid' : 'invalid';
            document.getElementById('uppercaseReq').innerHTML = `<i class="fas fa-${requirements.uppercase ? 'check' : 'times'}"></i> কমপক্ষে একটি বড় হাতের অক্ষর`;
            
            document.getElementById('lowercaseReq').className = requirements.lowercase ? 'valid' : 'invalid';
            document.getElementById('lowercaseReq').innerHTML = `<i class="fas fa-${requirements.lowercase ? 'check' : 'times'}"></i> কমপক্ষে একটি ছোট হাতের অক্ষর`;
            
            document.getElementById('numberReq').className = requirements.number ? 'valid' : 'invalid';
            document.getElementById('numberReq').innerHTML = `<i class="fas fa-${requirements.number ? 'check' : 'times'}"></i> কমপক্ষে একটি সংখ্যা`;
            
            document.getElementById('specialReq').className = requirements.special ? 'valid' : 'invalid';
            document.getElementById('specialReq').innerHTML = `<i class="fas fa-${requirements.special ? 'check' : 'times'}"></i> কমপক্ষে একটি বিশেষ অক্ষর (!@#$%^&*)`;

            return Object.values(requirements).every(req => req);
        }

        function validateForm() {
            let isValid = true;
            
            // Clear previous errors
            document.querySelectorAll('.error-message').forEach(el => el.style.display = 'none');
            document.querySelectorAll('input').forEach(el => {
                el.classList.remove('error', 'success');
            });

            // Validate current password
            if (!currentPasswordInput.value.trim()) {
                showError(currentPasswordInput, 'বর্তমান পাসওয়ার্ড প্রয়োজন');
                isValid = false;
            }

            // Validate new password
            if (!newPasswordInput.value.trim()) {
                showError(newPasswordInput, 'নতুন পাসওয়ার্ড প্রয়োজন');
                isValid = false;
            } else if (!validatePassword(newPasswordInput.value)) {
                showError(newPasswordInput, 'পাসওয়ার্ড প্রয়োজনীয়তা পূরণ করে না');
                isValid = false;
            } else {
                showSuccess(newPasswordInput);
            }

            // Validate confirm password
            if (!confirmPasswordInput.value.trim()) {
                showError(confirmPasswordInput, 'পাসওয়ার্ড নিশ্চিতকরণ প্রয়োজন');
                isValid = false;
            } else if (newPasswordInput.value !== confirmPasswordInput.value) {
                showError(confirmPasswordInput, 'পাসওয়ার্ড মিলছে না');
                isValid = false;
            } else {
                showSuccess(confirmPasswordInput);
            }

            if (isValid) {
                // Show loading state
                const submitBtn = document.getElementById('submitBtn');
                const spinner = submitBtn.querySelector('.spinner');
                submitBtn.disabled = true;
                submitBtn.classList.add('loading');
                spinner.style.display = 'inline-block';
            }

            return isValid;
        }

        function showError(input, message) {
            const errorDiv = input.parentNode.querySelector('.error-message');
            errorDiv.textContent = message;
            errorDiv.style.display = 'block';
            input.classList.add('error');
            input.classList.remove('success');
        }

        function showSuccess(input) {
            const errorDiv = input.parentNode.querySelector('.error-message');
            errorDiv.style.display = 'none';
            input.classList.remove('error');
            input.classList.add('success');
        }

        // Real-time password validation
        newPasswordInput.addEventListener('input', function() {
            if (this.value.trim()) {
                validatePassword(this.value);
                if (validatePassword(this.value)) {
                    showSuccess(this);
                } else {
                    this.classList.remove('success');
                }
            } else {
                this.classList.remove('error', 'success');
            }
        });

        confirmPasswordInput.addEventListener('input', function() {
            if (this.value.trim()) {
                if (this.value === newPasswordInput.value) {
                    showSuccess(this);
                } else {
                    showError(this, 'পাসওয়ার্ড মিলছে না');
                }
            } else {
                this.classList.remove('error', 'success');
            }
        });

        // Initialize page
        document.addEventListener('DOMContentLoaded', function() {
            // Add animation to form
            const form = document.querySelector('.password-change-container');
            form.style.opacity = '0';
            form.style.transform = 'translateY(20px)';
            
            setTimeout(() => {
                form.style.transition = 'all 0.6s ease';
                form.style.opacity = '1';
                form.style.transform = 'translateY(0)';
            }, 100);
        });
    </script>
</body>
</html>
