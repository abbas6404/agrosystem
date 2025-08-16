<%@page import="org.json.JSONObject"%>
<%@page import="com.mycompany.agrosystem.model.User"%>
<%@page import="com.mycompany.agrosystem.model.Farmer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page session="true"%>
<!DOCTYPE html>
<html lang="bn">
<head>
    <title>রোগ শনাক্তকরণ - এগ্রো সিস্টেম</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary-color: #10b981;
            --secondary-color: #3b82f6;
            --danger-color: #ef4444;
            --warning-color: #f59e0b;
            --success-color: #22c55e;
            --gradient-primary: linear-gradient(135deg, #10b981 0%, #059669 100%);
            --gradient-danger: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
            --gradient-warning: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
            --border-radius: 12px;
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            --shadow-lg: 0 10px 25px rgba(0, 0, 0, 0.15);
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f9fafb;
        }

        .dashboard-container {
            display: flex;
            min-height: 100vh;
        }

        .sidebar {
            width: 280px;
            background: white;
            box-shadow: var(--shadow-md);
            border-right: 1px solid #e5e7eb;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
        }

        .sidebar-header {
            background: var(--gradient-primary);
            color: white;
            padding: 25px 20px;
            text-align: center;
        }

        .sidebar-header h3 {
            margin: 0;
            font-size: 1.5rem;
            font-weight: 700;
        }

        .sidebar-nav {
            padding: 20px 0;
        }

        .nav-item {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px 25px;
            color: #4b5563;
            text-decoration: none;
            transition: all 0.3s;
            border-left: 4px solid transparent;
        }

        .nav-item:hover {
            background: #f3f4f6;
            color: var(--primary-color);
            border-left-color: var(--primary-color);
        }

        .nav-item.active {
            background: var(--primary-color);
            color: white;
            border-left-color: white;
        }

        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 20px;
        }

        .main-header {
            background: white;
            padding: 25px 30px;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-md);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .main-header h2 {
            color: #1f2937;
            font-size: 2rem;
            margin: 0;
            font-weight: 700;
        }

        .welcome-section {
            background: var(--gradient-danger);
            color: white;
            padding: 40px 30px;
            border-radius: var(--border-radius);
            margin-bottom: 30px;
            text-align: center;
            box-shadow: var(--shadow-md);
        }

        .welcome-section h1 {
            font-size: 3rem;
            margin-bottom: 15px;
            font-weight: 800;
        }

        .welcome-section p {
            font-size: 1.3rem;
            opacity: 0.9;
            margin-bottom: 25px;
        }

        .disease-features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }

        .disease-feature {
            background: rgba(255, 255, 255, 0.15);
            padding: 25px;
            border-radius: var(--border-radius);
            border: 1px solid rgba(255, 255, 255, 0.2);
            text-align: center;
        }

        .disease-feature i {
            font-size: 2.5rem;
            margin-bottom: 15px;
            display: block;
        }

        .disease-feature h3 {
            font-size: 1.2rem;
            margin-bottom: 10px;
            font-weight: 600;
        }

        .content-area {
            background: white;
            padding: 30px;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-md);
            margin-bottom: 30px;
        }

        .content-area h3 {
            color: #1f2937;
            font-size: 1.8rem;
            margin-bottom: 25px;
        }

        .btn-primary {
            background: var(--gradient-primary);
            color: white;
            padding: 12px 24px;
            border-radius: var(--border-radius);
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .btn-secondary {
            background: white;
            color: #374151;
            border: 2px solid #d1d5db;
            padding: 12px 24px;
            border-radius: var(--border-radius);
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s;
        }

        .btn-secondary:hover {
            background: #f3f4f6;
            border-color: #9ca3af;
        }

        .logout-btn {
            background: var(--secondary-color);
            color: white;
            padding: 12px 24px;
            border-radius: var(--border-radius);
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s;
        }

        .logout-btn:hover {
            background: #1d4ed8;
            transform: translateY(-2px);
        }

        .upload-section {
            text-align: center;
            padding: 40px;
            border: 2px dashed #d1d5db;
            border-radius: var(--border-radius);
            background: #f9fafb;
            margin-bottom: 30px;
            transition: all 0.3s ease;
        }

        .upload-section:hover {
            border-color: var(--primary-color);
            background: #f0f9ff;
        }

        .upload-section.dragover {
            border-color: var(--primary-color);
            background: #f0f9ff;
            transform: scale(1.02);
        }

        .upload-icon {
            font-size: 4rem;
            color: var(--primary-color);
            margin-bottom: 20px;
        }

        .upload-text h4 {
            color: #374151;
            margin-bottom: 10px;
            font-size: 1.5rem;
        }

        .upload-text p {
            color: #6b7280;
            margin-bottom: 20px;
            font-size: 1rem;
        }

        .file-input {
            display: none;
        }

        .upload-btn {
            background: var(--gradient-primary);
            color: white;
            padding: 15px 30px;
            border: none;
            border-radius: var(--border-radius);
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }

        .upload-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .result-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-top: 30px;
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .image-preview {
            background: white;
            padding: 25px;
            border-radius: var(--border-radius);
            border: 1px solid #e5e7eb;
            box-shadow: var(--shadow-md);
        }

        .image-preview h4 {
            color: #1f2937;
            margin-bottom: 20px;
            font-size: 1.3rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .image-preview h4 i {
            color: var(--primary-color);
        }

        .uploaded-image {
            width: 100%;
            max-height: 300px;
            object-fit: cover;
            border-radius: var(--border-radius);
            border: 2px solid #e5e7eb;
        }

        .analysis-details {
            background: white;
            padding: 25px;
            border-radius: var(--border-radius);
            border: 1px solid #e5e7eb;
            box-shadow: var(--shadow-md);
        }

        .analysis-details h4 {
            color: #1f2937;
            margin-bottom: 20px;
            font-size: 1.3rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .analysis-details h4 i {
            color: var(--danger-color);
        }

        .disease-info {
            background: #fef2f2;
            border: 1px solid #fecaca;
            border-radius: var(--border-radius);
            padding: 20px;
            margin-bottom: 20px;
        }

        .disease-info h5 {
            color: var(--danger-color);
            margin-bottom: 15px;
            font-size: 1.2rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .disease-info h5 i {
            font-size: 1.1rem;
        }

        .info-item {
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid #fecaca;
        }

        .info-item:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .info-label {
            font-weight: 600;
            color: #374151;
            margin-bottom: 8px;
            display: block;
        }

        .info-value {
            color: #6b7280;
            line-height: 1.6;
        }

        .treatment-section {
            background: #f0f9ff;
            border: 1px solid #bae6fd;
            border-radius: var(--border-radius);
            padding: 20px;
        }

        .treatment-section h5 {
            color: var(--secondary-color);
            margin-bottom: 15px;
            font-size: 1.2rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .treatment-section h5 i {
            font-size: 1.1rem;
        }

        .loading-state {
            text-align: center;
            padding: 60px 40px;
            color: #6b7280;
        }

        .loading-state i {
            font-size: 4rem;
            margin-bottom: 20px;
            display: block;
            color: var(--primary-color);
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.5; }
        }

        .loading-state h4 {
            color: #374151;
            margin-bottom: 15px;
            font-size: 1.3rem;
        }

        .loading-state p {
            color: #6b7280;
            font-size: 1rem;
            line-height: 1.5;
        }

        .error-message {
            background: #fee2e2;
            color: #991b1b;
            padding: 20px;
            border-radius: var(--border-radius);
            border: 1px solid #fecaca;
            margin-bottom: 20px;
            text-align: center;
        }

        .error-message i {
            font-size: 1.5rem;
            margin-bottom: 10px;
            display: block;
        }

        .success-message {
            background: #d1fae5;
            color: #065f46;
            padding: 20px;
            border-radius: var(--border-radius);
            border: 1px solid #a7f3d0;
            margin-bottom: 20px;
            text-align: center;
        }

        .success-message i {
            font-size: 1.5rem;
            margin-bottom: 10px;
            display: block;
        }

        .instructions {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: var(--border-radius);
            padding: 25px;
            margin-bottom: 30px;
        }

        .instructions h4 {
            color: #1e293b;
            margin-bottom: 20px;
            font-size: 1.3rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .instructions h4 i {
            color: var(--warning-color);
        }

        .instruction-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .instruction-list li {
            padding: 10px 0;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            align-items: flex-start;
            gap: 12px;
        }

        .instruction-list li:last-child {
            border-bottom: none;
        }

        .instruction-list i {
            color: var(--warning-color);
            margin-top: 2px;
            min-width: 16px;
        }

        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
                transition: transform 0.3s;
            }
            .sidebar.open {
                transform: translateX(0);
            }
            .main-content {
                margin-left: 0;
            }
            .welcome-section h1 {
                font-size: 2rem;
            }
            .disease-features {
                grid-template-columns: 1fr;
            }
            .result-container {
                grid-template-columns: 1fr;
                gap: 20px;
            }
            .upload-section {
                padding: 30px 20px;
            }
            .upload-icon {
                font-size: 3rem;
            }
        }
    </style>
</head>
<body>
    <% 
        User user = (User) session.getAttribute("loggedInUser"); 
        if (user == null || !"FARMER".equals(user.getUserType())) { 
            response.sendRedirect(request.getContextPath() + "/login.jsp"); 
            return; 
        } 
        Farmer farmer = (Farmer) user;
    %>
    
    <div class="dashboard-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="sidebar-header">
                <h3><i class="fas fa-tractor"></i> এগ্রো সিস্টেম</h3>
            </div>
            <nav class="sidebar-nav">
                <a href="${pageContext.request.contextPath}/farmerDashboard" class="nav-item">
                    <i class="fas fa-tachometer-alt"></i> ড্যাশবোর্ড
                </a>
                <a href="${pageContext.request.contextPath}/myCrops" class="nav-item">
                    <i class="fas fa-leaf"></i> আমার ফসল
                </a>
                <a href="${pageContext.request.contextPath}/getSuggestion" class="nav-item">
                    <i class="fas fa-lightbulb"></i> AI পরামর্শ
                </a>
                <a href="${pageContext.request.contextPath}/weather" class="nav-item">
                    <i class="fas fa-cloud-sun"></i> আবহাওয়া
                </a>
                <a href="${pageContext.request.contextPath}/disease_detection.jsp" class="nav-item active">
                    <i class="fas fa-stethoscope"></i> রোগ শনাক্তকরণ
                </a>
                <a href="${pageContext.request.contextPath}/profile.jsp" class="nav-item">
                    <i class="fas fa-user"></i> প্রোফাইল
                </a>
                <a href="${pageContext.request.contextPath}/change_password.jsp" class="nav-item">
                    <i class="fas fa-key"></i> পাসওয়ার্ড পরিবর্তন
                </a>
                <a href="${pageContext.request.contextPath}/logout" class="nav-item">
                    <i class="fas fa-sign-out-alt"></i> লগ আউট
                </a>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <!-- Header -->
            <header class="main-header">
                <h2><i class="fas fa-stethoscope"></i> রোগ শনাক্তকরণ</h2>
                <div>
                    <a href="${pageContext.request.contextPath}/farmerDashboard" class="btn-secondary">
                        <i class="fas fa-arrow-left"></i> ড্যাশবোর্ডে ফিরে যান
                    </a>
                    <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                        <i class="fas fa-sign-out-alt"></i> লগ আউট
                    </a>
                </div>
            </header>

            <!-- Welcome Section -->
            <div class="welcome-section">
                <h1><i class="fas fa-stethoscope"></i> রোগ শনাক্তকরণ</h1>
                <p>AI প্রযুক্তি ব্যবহার করে আপনার ফসলের রোগ ও পোকামাকড় শনাক্ত করুন</p>
                
                <div class="disease-features">
                    <div class="disease-feature">
                        <i class="fas fa-camera"></i>
                        <h3>ছবি আপলোড</h3>
                        <p>রোগাক্রান্ত পাতার ছবি তুলে আপলোড করুন</p>
                    </div>
                    <div class="disease-feature">
                        <i class="fas fa-brain"></i>
                        <h3>AI বিশ্লেষণ</h3>
                        <p>আর্টিফিশিয়াল ইন্টেলিজেন্স দিয়ে রোগ শনাক্ত করুন</p>
                    </div>
                    <div class="disease-feature">
                        <i class="fas fa-pills"></i>
                        <h3>চিকিৎসা পরামর্শ</h3>
                        <p>রোগের সঠিক চিকিৎসা ও প্রতিকার জানুন</p>
                    </div>
                </div>
            </div>

            <!-- Content Area -->
            <div class="content-area">
                <h3><i class="fas fa-stethoscope"></i> রোগ শনাক্তকরণ</h3>
                
                <!-- Instructions -->
                <div class="instructions">
                    <h4><i class="fas fa-info-circle"></i> কিভাবে ব্যবহার করবেন</h4>
                    <ul class="instruction-list">
                        <li>
                            <i class="fas fa-check-circle"></i>
                            <span>রোগাক্রান্ত পাতার স্পষ্ট ছবি তুলুন (উপরের দিক থেকে)</span>
                        </li>
                        <li>
                            <i class="fas fa-check-circle"></i>
                            <span>ছবিতে পাতা সম্পূর্ণভাবে দেখা যাবে এমনভাবে তুলুন</span>
                        </li>
                        <li>
                            <i class="fas fa-check-circle"></i>
                            <span>ভাল আলোতে ছবি তুলুন যাতে রোগের লক্ষণ স্পষ্ট দেখা যায়</span>
                        </li>
                        <li>
                            <i class="fas fa-check-circle"></i>
                            <span>ছবি আপলোড করার পর AI স্বয়ংক্রিয়ভাবে বিশ্লেষণ করবে</span>
                        </li>
                    </ul>
                </div>

                <!-- Upload Section -->
                <div class="upload-section" id="uploadSection">
                    <div class="upload-icon">
                        <i class="fas fa-cloud-upload-alt"></i>
                    </div>
                    <div class="upload-text">
                        <h4>ছবি আপলোড করুন</h4>
                        <p>রোগাক্রান্ত পাতার ছবি এখানে আপলোড করুন। ছবি আপলোড করার পর স্বয়ংক্রিয়ভাবে AI বিশ্লেষণ শুরু হবে।</p>
                        <button class="upload-btn" onclick="document.getElementById('cropImage').click();">
                            <i class="fas fa-upload"></i>
                            ছবি নির্বাচন করুন
                        </button>
                    </div>
                    <input type="file" id="cropImage" name="cropImage" accept="image/*" class="file-input" onchange="handleFileUpload(this)">
                </div>

                <!-- Loading State -->
                <div class="loading-state" id="loadingState" style="display: none;">
                    <i class="fas fa-spinner fa-spin"></i>
                    <h4>ছবি বিশ্লেষণ হচ্ছে...</h4>
                    <p>AI আপনার ছবি বিশ্লেষণ করে রোগ শনাক্ত করছে। অনুগ্রহ করে অপেক্ষা করুন।</p>
                </div>

                <!-- Error Message -->
                <% if (request.getAttribute("errorMessage") != null) { %>
                    <div class="error-message">
                        <i class="fas fa-exclamation-triangle"></i>
                        <%= request.getAttribute("errorMessage") %>
                    </div>
                <% } %>

                <!-- Success Message -->
                <% if (request.getAttribute("analysisResult") != null) { %>
                    <div class="success-message">
                        <i class="fas fa-check-circle"></i>
                        <strong>সফল!</strong> আপনার ছবি সফলভাবে বিশ্লেষণ করা হয়েছে।
                    </div>
                <% } %>

                <!-- Results -->
                <% if (request.getAttribute("analysisResult") != null) { %>
                    <div class="result-container">
                        <div class="image-preview">
                            <h4><i class="fas fa-image"></i> আপনার আপলোড করা ছবি</h4>
                            <img src="${uploadedImage}" alt="Crop Leaf" class="uploaded-image">
                        </div>
                        
                        <div class="analysis-details">
                            <h4><i class="fas fa-vial"></i> AI বিশ্লেষণ ফলাফল</h4>
                            
                            <% try { 
                                JSONObject result = new JSONObject((String)request.getAttribute("analysisResult")); 
                            %>
                                <div class="disease-info">
                                    <h5><i class="fas fa-bug"></i> রোগের তথ্য</h5>
                                    
                                    <div class="info-item">
                                        <span class="info-label">রোগের নাম:</span>
                                        <div class="info-value">
                                            <%= result.optString("রোগের_নাম", "শনাক্ত করা যায়নি") %>
                                        </div>
                                    </div>
                                    
                                    <div class="info-item">
                                        <span class="info-label">রোগের বিবরণ:</span>
                                        <div class="info-value">
                                            <%= result.optString("বিবরণ", "বিবরণ পাওয়া যায়নি") %>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="treatment-section">
                                    <h5><i class="fas fa-pills"></i> চিকিৎসা ও প্রতিকার</h5>
                                    <div class="info-value">
                                        <%= result.optString("প্রতিকার", "প্রতিকার সম্পর্কিত তথ্য পাওয়া যায়নি") %>
                                    </div>
                                </div>
                                
                            <% } catch (Exception e) { %>
                                <div class="error-message">
                                    <i class="fas fa-exclamation-triangle"></i>
                                    ফলাফল দেখাতে সমস্যা হয়েছে। অনুগ্রহ করে আবার চেষ্টা করুন।
                                </div>
                            <% } %>
                        </div>
                    </div>
                <% } %>
            </div>
        </main>
    </div>

    <script>
        // Simple mobile menu toggle
        function toggleSidebar() {
            const sidebar = document.querySelector('.sidebar');
            sidebar.classList.toggle('open');
        }

        // Handle file upload
        function handleFileUpload(input) {
            if (input.files && input.files[0]) {
                const file = input.files[0];
                
                // Show loading state
                document.getElementById('uploadSection').style.display = 'none';
                document.getElementById('loadingState').style.display = 'block';
                
                // Submit form automatically
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'diseaseDetection';
                form.enctype = 'multipart/form-data';
                
                const fileInput = document.createElement('input');
                fileInput.type = 'file';
                fileInput.name = 'cropImage';
                fileInput.files = input.files;
                
                form.appendChild(fileInput);
                document.body.appendChild(form);
                form.submit();
            }
        }

        // Drag and drop functionality
        const uploadSection = document.getElementById('uploadSection');
        
        uploadSection.addEventListener('dragover', (e) => {
            e.preventDefault();
            uploadSection.classList.add('dragover');
        });
        
        uploadSection.addEventListener('dragleave', () => {
            uploadSection.classList.remove('dragover');
        });
        
        uploadSection.addEventListener('drop', (e) => {
            e.preventDefault();
            uploadSection.classList.remove('dragover');
            
            const files = e.dataTransfer.files;
            if (files.length > 0) {
                document.getElementById('cropImage').files = files;
                handleFileUpload(document.getElementById('cropImage'));
            }
        });
    </script>
</body>
</html>