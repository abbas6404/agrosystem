<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="bn">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>লগইন করুন - AgroSyst</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Enhanced Login Page Styling */
        .form-page-container {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            position: relative;
            overflow: hidden;
        }
        
        .form-page-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="rgba(255,255,255,0.1)"/><circle cx="75" cy="75" r="1" fill="rgba(255,255,255,0.1)"/><circle cx="50" cy="10" r="0.5" fill="rgba(255,255,255,0.1)"/><circle cx="10" cy="60" r="0.5" fill="rgba(255,255,255,0.1)"/><circle cx="90" cy="40" r="0.5" fill="rgba(255,255,255,0.1)"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
            opacity: 0.3;
        }
        
        .form-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            padding: 40px;
            width: 100%;
            max-width: 450px;
            position: relative;
            z-index: 1;
            border: 1px solid rgba(255, 255, 255, 0.2);
            animation: slideInUp 0.6s ease-out;
        }
        
        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .form-container h2 {
            color: var(--dark-color);
            margin-bottom: 10px;
            font-weight: 700;
            font-size: 2rem;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }
        
        .form-container h2 i {
            color: var(--primary-color);
            font-size: 1.8rem;
        }
        
        .form-container p {
            color: #666;
            margin-bottom: 30px;
            text-align: center;
            font-size: 1rem;
            line-height: 1.6;
        }
        
        /* Enhanced Input Groups */
        .input-group {
            position: relative;
            margin-bottom: 25px;
        }
        
        .input-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--dark-color);
            font-size: 0.95rem;
        }
        
        .input-group input {
            width: 100%;
            padding: 15px 15px 15px 50px;
            border: 2px solid #e1e8ed;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: white;
            box-sizing: border-box;
        }
        
        .input-group input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(39, 174, 96, 0.1);
            transform: translateY(-2px);
        }
        
        .input-group i {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
            font-size: 18px;
            transition: all 0.3s ease;
            z-index: 2;
        }
        
        .input-group input:focus + i {
            color: var(--primary-color);
            transform: translateY(-50%) scale(1.1);
        }
        

        
        /* Enhanced Button */
        .form-container button {
            width: 100%;
            padding: 16px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            position: relative;
            overflow: hidden;
            box-shadow: 0 8px 25px rgba(39, 174, 96, 0.3);
        }
        
        .form-container button:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 35px rgba(39, 174, 96, 0.4);
        }
        
        .form-container button:active {
            transform: translateY(-1px);
        }
        
        .form-container button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.6s;
        }
        
        .form-container button:hover::before {
            left: 100%;
        }
        
        /* Loading State */
        .btn-loading {
            pointer-events: none;
            background: linear-gradient(135deg, #95a5a6, #7f8c8d) !important;
        }
        
        .btn-loading::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 24px;
            height: 24px;
            margin: -12px 0 0 -12px;
            border: 3px solid transparent;
            border-top: 3px solid white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        /* Form Links */
        .form-link {
            margin-top: 25px;
            text-align: center;
            font-size: 14px;
            color: #666;
        }
        
        .form-link a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }
        
        .form-link a:hover {
            color: var(--secondary-color);
            text-decoration: underline;
        }
        
        .forgot-password-link {
            margin-top: 15px;
            text-align: center;
        }
        
        .forgot-password-link a {
            color: var(--warning-color);
            text-decoration: none;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 16px;
            border-radius: 20px;
            background: rgba(243, 156, 18, 0.1);
            transition: all 0.3s ease;
        }
        
        .forgot-password-link a:hover {
            background: rgba(243, 156, 18, 0.2);
            transform: translateY(-2px);
        }
        
        /* Alert Messages */
        .alert {
            padding: 15px 20px;
            border-radius: 12px;
            margin-bottom: 25px;
            border: 1px solid transparent;
            display: flex;
            align-items: center;
            gap: 12px;
            font-weight: 500;
            animation: slideInDown 0.5s ease-out;
        }
        
        @keyframes slideInDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .alert-success {
            background: linear-gradient(135deg, #d4edda, #c3e6cb);
            color: #155724;
            border-color: #c3e6cb;
        }
        
        .alert-danger {
            background: linear-gradient(135deg, #f8d7da, #f5c6cb);
            color: #721c24;
            border-color: #f5c6cb;
        }
        
        .alert i {
            font-size: 18px;
        }
        
        /* Input Error Styling */
        .input-error {
            color: var(--danger-color);
            font-size: 12px;
            margin-top: 8px;
            padding: 8px 12px;
            background: rgba(231, 76, 60, 0.1);
            border-radius: 8px;
            border-left: 3px solid var(--danger-color);
            animation: shake 0.5s ease-in-out;
        }
        
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }
        
        /* Responsive Design */
        @media (max-width: 480px) {
            .form-container {
                padding: 30px 20px;
                margin: 10px;
                border-radius: 15px;
            }
            
            .form-container h2 {
                font-size: 1.6rem;
            }
            
            .input-group input {
                padding: 14px 14px 14px 45px;
                font-size: 16px;
            }
            

            
            .form-container button {
                padding: 14px;
                font-size: 15px;
            }
        }
        
        /* Success Animation */
        .form-success {
            animation: successPulse 0.6s ease-out;
        }
        
        @keyframes successPulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.02); }
            100% { transform: scale(1); }
        }
    </style>
</head>
<body>
    <div class="form-page-container">
        <div class="form-container">
            <h2><i class="fas fa-seedling"></i> AgroSyst</h2>
            <p>আপনার ফোন নম্বর ও পাসওয়ার্ড দিয়ে প্রবেশ করুন</p>
            
            <!-- Success/Error Messages -->
            <% if (session.getAttribute("message") != null) { %>
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i>
                    <%= session.getAttribute("message") %>
                </div>
                <% session.removeAttribute("message"); %>
            <% } %>
            
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle"></i>
                    <%= request.getAttribute("errorMessage") %>
                </div>
            <% } %>
            
            <form action="${pageContext.request.contextPath}/login" method="post" id="loginForm">
                <div class="input-group">
                    <label for="phone">ফোন নম্বর</label>
                    <input type="tel" id="phone" name="phone" required 
                           placeholder="01742184298"
                           value="${cookie.rememberedPhone.value != null ? cookie.rememberedPhone.value : ''}"
                           autocomplete="tel">
                    <i class="fas fa-phone"></i>
                </div>
                
                <div class="input-group">
                    <label for="password">পাসওয়ার্ড</label>
                    <input type="password" id="password" name="password" required 
                           placeholder="আপনার পাসওয়ার্ড লিখুন"
                           autocomplete="current-password">
                    <i class="fas fa-lock"></i>
                </div>
                

                
                <button type="submit" id="loginBtn">
                    <i class="fas fa-sign-in-alt"></i> প্রবেশ করুন
                </button>
            </form>
            
            <p class="form-link">
                অ্যাকাউন্ট নেই? <a href="registration.jsp">নিবন্ধন করুন</a>
            </p>
            
            <!-- Forgot Password Link -->
            <div class="forgot-password-link">
                <a href="#" onclick="showForgotPassword()">
                    <i class="fas fa-key"></i> পাসওয়ার্ড ভুলে গেছেন?
                </a>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const loginForm = document.getElementById('loginForm');
            const loginBtn = document.getElementById('loginBtn');
            const phoneInput = document.getElementById('phone');
            const passwordInput = document.getElementById('password');
            // Clear any existing phone number to start fresh
            if (!phoneInput.value || phoneInput.value.includes('017-421-84298') || phoneInput.value.includes('01711-123456')) {
                phoneInput.value = '';
            }
            
            // Form submission with loading state
            loginForm.addEventListener('submit', function(e) {
                if (!validateForm()) {
                    e.preventDefault();
                    return false;
                }
                
                // Show loading state
                loginBtn.classList.add('btn-loading');
                loginBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> প্রবেশ করা হচ্ছে...';
                loginBtn.disabled = true;
                
                // Add success animation
                setTimeout(() => {
                    document.querySelector('.form-container').classList.add('form-success');
                }, 100);
            });
            
            // Phone number formatting - match database format (01742184298)
            phoneInput.addEventListener('input', function(e) {
                let value = e.target.value.replace(/\D/g, '');
                
                if (value.length > 0) {
                    // Remove country codes if present
                    if (value.startsWith('880')) {
                        value = value.substring(3);
                    } else if (value.startsWith('88')) {
                        value = value.substring(2);
                    }
                    
                    // Ensure proper Bangladesh mobile format (no hyphens)
                    if (value.length >= 11) {
                        // Format: 01742184298 (11 digits, no hyphens)
                        if (value.startsWith('0')) {
                            value = value.substring(0, 11); // Keep first 11 digits
                        } else {
                            value = '0' + value.substring(0, 10); // Add 0 and keep next 10
                        }
                    } else if (value.length >= 10) {
                        // Format: 0174218429 (10 digits, no hyphens)
                        if (value.startsWith('0')) {
                            value = value.substring(0, 10);
                        } else {
                            value = '0' + value.substring(0, 9);
                        }
                    }
                }
                
                e.target.value = value;
                
                // Validate after formatting
                validatePhone(this);
            });
            
            // Real-time validation
            phoneInput.addEventListener('blur', function() {
                validatePhone(this);
            });
            
            passwordInput.addEventListener('blur', function() {
                validatePassword(this);
            });
            
            // Validation functions
            function validateForm() {
                let isValid = true;
                
                if (!validatePhone(phoneInput)) {
                    isValid = false;
                }
                
                if (!validatePassword(passwordInput)) {
                    isValid = false;
                }
                
                return isValid;
            }
            
            function validatePhone(input) {
                const value = input.value.replace(/\D/g, '');
                const phoneRegex = /^01[3-9]\d{8}$/;
                
                if (value.length === 0) {
                    showError(input, 'ফোন নম্বর প্রয়োজন');
                    return false;
                } else if (value.length !== 11) {
                    showError(input, 'ফোন নম্বর ঠিক ১১ ডিজিট হতে হবে');
                    return false;
                } else if (!phoneRegex.test(value)) {
                    showError(input, 'সঠিক ফোন নম্বর লিখুন (যেমন: 01742184298)');
                    return false;
                } else {
                    clearError(input);
                    return true;
                }
            }
            
            function validatePassword(input) {
                const value = input.value;
                
                if (value.length === 0) {
                    showError(input, 'পাসওয়ার্ড প্রয়োজন');
                    return false;
                } else if (value.length < 6) {
                    showError(input, 'পাসওয়ার্ড কমপক্ষে ৬ অক্ষর হতে হবে');
                    return false;
                } else {
                    clearError(input);
                    return true;
                }
            }
            
            function showError(input, message) {
                clearError(input);
                input.style.borderColor = 'var(--danger-color)';
                input.style.boxShadow = '0 0 0 4px rgba(231, 76, 60, 0.1)';
                
                const errorDiv = document.createElement('div');
                errorDiv.className = 'input-error';
                errorDiv.textContent = message;
                
                input.parentNode.appendChild(errorDiv);
            }
            
            function clearError(input) {
                input.style.borderColor = '';
                input.style.boxShadow = '';
                
                const errorDiv = input.parentNode.querySelector('.input-error');
                if (errorDiv) {
                    errorDiv.remove();
                }
            }
            

            
            // Add input focus effects
            const inputs = document.querySelectorAll('.input-group input');
            inputs.forEach(input => {
                input.addEventListener('focus', function() {
                    this.parentNode.style.transform = 'scale(1.02)';
                });
                
                input.addEventListener('blur', function() {
                    this.parentNode.style.transform = 'scale(1)';
                });
            });
        });
        
        // Forgot password function
        function showForgotPassword() {
            const message = 'পাসওয়ার্ড রিসেট ফিচার শীঘ্রই আসছে!\n\nআপনার অ্যাডমিনের সাথে যোগাযোগ করুন।';
            
            // Create a custom modal instead of alert
            const modal = document.createElement('div');
            modal.style.cssText = `
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0,0,0,0.5);
                display: flex;
                align-items: center;
                justify-content: center;
                z-index: 1000;
                animation: fadeIn 0.3s ease-out;
            `;
            
            const modalContent = document.createElement('div');
            modalContent.style.cssText = `
                background: white;
                padding: 30px;
                border-radius: 15px;
                text-align: center;
                max-width: 400px;
                margin: 20px;
                box-shadow: 0 20px 60px rgba(0,0,0,0.3);
                animation: slideInUp 0.3s ease-out;
            `;
            
            modalContent.innerHTML = `
                <i class="fas fa-key" style="font-size: 3rem; color: var(--warning-color); margin-bottom: 20px;"></i>
                <h3 style="margin: 0 0 15px 0; color: var(--dark-color);">পাসওয়ার্ড রিসেট</h3>
                <p style="margin: 0 0 25px 0; color: #666; line-height: 1.6;">${message}</p>
                <button onclick="this.closest('.modal').remove()" style="
                    background: var(--primary-color);
                    color: white;
                    border: none;
                    padding: 12px 24px;
                    border-radius: 8px;
                    cursor: pointer;
                    font-weight: 600;
                    transition: all 0.3s ease;
                ">ঠিক আছে</button>
            `;
            
            modal.appendChild(modalContent);
            modal.className = 'modal';
            document.body.appendChild(modal);
            
            // Close modal on outside click
            modal.addEventListener('click', function(e) {
                if (e.target === modal) {
                    modal.remove();
                }
            });
        }
        
        // Add CSS animations
        const style = document.createElement('style');
        style.textContent = `
            @keyframes fadeIn {
                from { opacity: 0; }
                to { opacity: 1; }
            }
            
            @keyframes slideInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
        `;
        document.head.appendChild(style);
    </script>
</body>
</html>