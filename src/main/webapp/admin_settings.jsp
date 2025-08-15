<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<jsp:include page="/WEB-INF/includes/admin_header.jsp">
    <jsp:param name="pageTitle" value="সেটিংস" />
    <jsp:param name="pageIcon" value="fas fa-cog" />
    <jsp:param name="activePage" value="settings" />
</jsp:include>

<div class="settings-container">
    <!-- Success/Error Messages -->
    <c:if test="${not empty success}">
        <div class="alert alert-success">
            <i class="fas fa-check-circle"></i> ${success}
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-error">
            <i class="fas fa-exclamation-circle"></i> ${error}
        </div>
    </c:if>

    <!-- Settings Navigation -->
    <div class="settings-nav">
        <div class="nav-tabs">
            <button class="nav-tab active" data-tab="general">
                <i class="fas fa-cog"></i> সাধারণ সেটিংস
            </button>
            <button class="nav-tab" data-tab="users">
                <i class="fas fa-users"></i> ব্যবহারকারী ব্যবস্থাপনা
            </button>
            <button class="nav-tab" data-tab="system">
                <i class="fas fa-server"></i> সিস্টেম সেটিংস
            </button>
            <button class="nav-tab" data-tab="notifications">
                <i class="fas fa-bell"></i> বিজ্ঞপ্তি সেটিংস
            </button>
            <button class="nav-tab" data-tab="backup">
                <i class="fas fa-database"></i> ব্যাকআপ ও পুনরুদ্ধার
            </button>
        </div>
    </div>

    <!-- Settings Content -->
    <div class="settings-content">
        
        <!-- General Settings -->
        <div class="settings-panel active" id="general">
            <h3><i class="fas fa-cog"></i> সাধারণ সেটিংস</h3>
            
            <form class="settings-form" method="post" action="${pageContext.request.contextPath}/admin/settings">
                <input type="hidden" name="action" value="updateGeneral">
                
                <div class="form-section">
                    <h4><i class="fas fa-info-circle"></i> সাইট তথ্য</h4>
                    <div class="form-row">
                        <div class="input-group">
                            <label>সাইটের নাম</label>
                            <input type="text" name="siteName" value="${settings != null ? settings.siteName : ''}" required>
                        </div>
                        <div class="input-group">
                            <label>সাইটের বিবরণ</label>
                            <textarea name="siteDescription" rows="3">${settings != null ? settings.siteDescription : ''}</textarea>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="input-group">
                            <label>ইমেইল ঠিকানা</label>
                            <input type="email" name="contactEmail" value="${settings != null ? settings.contactEmail : ''}">
                        </div>
                        <div class="input-group">
                            <label>ফোন নম্বর</label>
                            <input type="tel" name="contactPhone" value="${settings != null ? settings.contactPhone : ''}">
                        </div>
                    </div>
                </div>
                
                <div class="form-section">
                    <h4><i class="fas fa-clock"></i> সময় ও তারিখ</h4>
                    <div class="form-row">
                        <div class="input-group">
                            <label>সময় অঞ্চল</label>
                            <select name="timezone">
                                <option value="Asia/Dhaka" ${settings != null and settings.timezone == 'Asia/Dhaka' ? 'selected' : ''}>বাংলাদেশ সময় (GMT+6)</option>
                                <option value="UTC" ${settings != null and settings.timezone == 'UTC' ? 'selected' : ''}>UTC</option>
                            </select>
                        </div>
                        <div class="input-group">
                            <label>তারিখ ফরম্যাট</label>
                            <select name="dateFormat">
                                <option value="dd/MM/yyyy" ${settings != null and settings.dateFormat == 'dd/MM/yyyy' ? 'selected' : ''}>dd/MM/yyyy</option>
                                <option value="MM/dd/yyyy" ${settings != null and settings.dateFormat == 'MM/dd/yyyy' ? 'selected' : ''}>MM/dd/yyyy</option>
                                <option value="yyyy-MM-dd" ${settings != null and settings.dateFormat == 'yyyy-MM-dd' ? 'selected' : ''}>yyyy-MM-dd</option>
                            </select>
                        </div>
                    </div>
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn-primary">
                        <i class="fas fa-save"></i> সেটিংস সংরক্ষণ করুন
                    </button>
                    <button type="button" class="btn-secondary" onclick="resetForm('general')">
                        <i class="fas fa-undo"></i> রিসেট করুন
                    </button>
                </div>
            </form>
        </div>
        
        <!-- User Management Settings -->
        <div class="settings-panel" id="users">
            <h3><i class="fas fa-users"></i> ব্যবহারকারী ব্যবস্থাপনা</h3>
            
            <form class="settings-form" method="post" action="${pageContext.request.contextPath}/admin/settings">
                <input type="hidden" name="action" value="updateUsers">
                
                <div class="form-section">
                    <h4>নিবন্ধন সেটিংস</h4>
                    <div class="form-row">
                        <div class="input-group">
                            <label>নতুন নিবন্ধন অনুমতি</label>
                            <select name="allowRegistration">
                                <option value="true" ${settings != null and settings.allowRegistration ? 'selected' : ''}>অনুমতি দিন</option>
                                <option value="false" ${settings != null and not settings.allowRegistration ? 'selected' : ''}>অনুমতি দিন না</option>
                            </select>
                        </div>
                        <div class="input-group">
                            <label>ইমেইল যাচাইকরণ</label>
                            <select name="emailVerification">
                                <option value="true" ${settings != null and settings.emailVerification ? 'selected' : ''}>প্রয়োজন</option>
                                <option value="false" ${settings != null and not settings.emailVerification ? 'selected' : ''}>প্রয়োজন নেই</option>
                            </select>
                        </div>
                    </div>
                </div>
                
                <div class="form-section">
                    <h4>পাসওয়ার্ড সেটিংস</h4>
                    <div class="form-row">
                        <div class="input-group">
                            <label>নূন্যতম পাসওয়ার্ড দৈর্ঘ্য</label>
                            <input type="number" name="minPasswordLength" value="${settings != null ? settings.minPasswordLength : ''}" min="6" max="20">
                        </div>
                        <div class="input-group">
                            <label>সেশন টাইমআউট (মিনিট)</label>
                            <input type="number" name="sessionTimeout" value="${settings != null ? settings.sessionTimeout : ''}" min="15" max="480">
                        </div>
                    </div>
                </div>
                
                <div class="form-section">
                    <h4>ব্যবহারকারী ভূমিকা</h4>
                    <div class="form-row">
                        <div class="input-group">
                            <label>ডিফল্ট ব্যবহারকারী ভূমিকা</label>
                            <select name="defaultUserRole">
                                <option value="FARMER" ${settings != null and settings.defaultUserRole == 'FARMER' ? 'selected' : ''}>কৃষক</option>
                                <option value="ADMIN" ${settings != null and settings.defaultUserRole == 'ADMIN' ? 'selected' : ''}>অ্যাডমিন</option>
                            </select>
                        </div>
                    </div>
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn-primary">
                        <i class="fas fa-save"></i> সেটিংস সংরক্ষণ করুন
                    </button>
                    <button type="button" class="btn-secondary" onclick="resetForm('users')">
                        <i class="fas fa-undo"></i> রিসেট করুন
                    </button>
                </div>
            </form>
        </div>
        
        <!-- System Settings -->
        <div class="settings-panel" id="system">
            <h3><i class="fas fa-server"></i> সিস্টেম সেটিংস</h3>
            
            <form class="settings-form" method="post" action="${pageContext.request.contextPath}/admin/settings">
                <input type="hidden" name="action" value="updateSystem">
                
                <div class="form-section">
                    <h4>ডেটাবেস সেটিংস</h4>
                    <div class="form-row">
                        <div class="input-group">
                            <label>কানেকশন পুল সাইজ</label>
                            <input type="number" name="dbPoolSize" value="${settings != null ? settings.dbPoolSize : ''}" min="5" max="50">
                        </div>
                        <div class="input-group">
                            <label>কানেকশন টাইমআউট (সেকেন্ড)</label>
                            <input type="number" name="dbTimeout" value="${settings != null ? settings.dbTimeout : ''}" min="5" max="60">
                        </div>
                    </div>
                </div>
                
                <div class="form-section">
                    <h4>ফাইল আপলোড সেটিংস</h4>
                    <div class="form-row">
                        <div class="input-group">
                            <label>সর্বোচ্চ ফাইল সাইজ (MB)</label>
                            <input type="number" name="maxFileSize" value="${settings != null ? settings.maxFileSize : ''}" min="1" max="100">
                        </div>
                        <div class="input-group">
                            <label>অনুমোদিত ফাইল ধরন</label>
                            <input type="text" name="allowedFileTypes" value="${settings != null ? settings.allowedFileTypes : ''}" placeholder="jpg,jpeg,png,pdf,doc,docx">
                        </div>
                    </div>
                </div>
                
                <div class="form-section">
                    <h4>লগিং সেটিংস</h4>
                    <div class="form-row">
                        <div class="input-group">
                            <label>লগ লেভেল</label>
                            <select name="logLevel">
                                <option value="INFO" ${settings != null and settings.logLevel == 'INFO' ? 'selected' : ''}>INFO</option>
                                <option value="DEBUG" ${settings != null and settings.logLevel == 'DEBUG' ? 'selected' : ''}>DEBUG</option>
                                <option value="WARNING" ${settings != null and settings.logLevel == 'WARNING' ? 'selected' : ''}>WARNING</option>
                                <option value="ERROR" ${settings != null and settings.logLevel == 'ERROR' ? 'selected' : ''}>ERROR</option>
                            </select>
                        </div>
                        <div class="input-group">
                            <label>লগ রিটেনশন (দিন)</label>
                            <input type="number" name="logRetention" value="${settings != null ? settings.logRetention : ''}" min="1" max="365">
                        </div>
                    </div>
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn-primary">
                        <i class="fas fa-save"></i> সেটিংস সংরক্ষণ করুন
                    </button>
                    <button type="button" class="btn-secondary" onclick="resetForm('system')">
                        <i class="fas fa-undo"></i> রিসেট করুন
                    </button>
                </div>
            </form>
        </div>
        
        <!-- Notification Settings -->
        <div class="settings-panel" id="notifications">
            <h3><i class="fas fa-bell"></i> বিজ্ঞপ্তি ব্যবস্থাপনা</h3>
            
            <!-- Notification Overview -->
            <div class="notification-overview">
                <div class="overview-card">
                    <div class="overview-icon">
                        <i class="fas fa-envelope"></i>
                    </div>
                    <div class="overview-content">
                        <h4>ইমেইল বিজ্ঞপ্তি</h4>
                        <p>ইমেইল মাধ্যমে বিজ্ঞপ্তি পাঠানোর সেটিংস</p>
                        <div class="status-indicator ${settings != null and settings.emailNotifications ? 'active' : 'inactive'}">
                            <span class="status-dot"></span>
                            <span class="status-text">${settings != null and settings.emailNotifications ? 'সক্রিয়' : 'নিষ্ক্রিয়'}</span>
                        </div>
                    </div>
                </div>
                
                <div class="overview-card">
                    <div class="overview-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="overview-content">
                        <h4>ব্যবহারকারী বিজ্ঞপ্তি</h4>
                        <p>নতুন ব্যবহারকারী নিবন্ধন সম্পর্কিত বিজ্ঞপ্তি</p>
                        <div class="status-indicator ${settings != null and settings.notifyNewUsers ? 'active' : 'inactive'}">
                            <span class="status-dot"></span>
                            <span class="status-text">${settings != null and settings.notifyNewUsers ? 'সক্রিয়' : 'নিষ্ক্রিয়'}</span>
                        </div>
                    </div>
                </div>
                
                <div class="overview-card">
                    <div class="overview-icon">
                        <i class="fas fa-leaf"></i>
                    </div>
                    <div class="overview-content">
                        <h4>ফসল আপডেট</h4>
                        <p>ফসল সম্পর্কিত আপডেট বিজ্ঞপ্তি</p>
                        <div class="status-indicator ${settings != null and settings.notifyCropUpdates ? 'active' : 'inactive'}">
                            <span class="status-dot"></span>
                            <span class="status-text">${settings != null and settings.notifyCropUpdates ? 'সক্রিয়' : 'নিষ্ক্রিয়'}</span>
                        </div>
                    </div>
                </div>
                
                <div class="overview-card">
                    <div class="overview-icon">
                        <i class="fas fa-exclamation-triangle"></i>
                    </div>
                    <div class="overview-content">
                        <h4>সিস্টেম সতর্কতা</h4>
                        <p>সিস্টেম সতর্কতা ও ত্রুটি বিজ্ঞপ্তি</p>
                        <div class="status-indicator ${settings != null and settings.notifySystemAlerts ? 'active' : 'inactive'}">
                            <span class="status-dot"></span>
                            <span class="status-text">${settings != null and settings.notifySystemAlerts ? 'সক্রিয়' : 'নিষ্ক্রিয়'}</span>
                        </div>
                    </div>
                </div>
            </div>
            
            <form class="settings-form" method="post" action="${pageContext.request.contextPath}/admin/settings">
                <input type="hidden" name="action" value="updateNotifications">
                
                <!-- Email Configuration -->
                <div class="form-section email-config">
                    <div class="section-header">
                        <div class="section-icon">
                            <i class="fas fa-envelope"></i>
                        </div>
                        <div class="section-title">
                            <h4>ইমেইল কনফিগারেশন</h4>
                            <p>ইমেইল বিজ্ঞপ্তি পাঠানোর জন্য SMTP সেটিংস</p>
                        </div>
                        <div class="section-toggle">
                            <label class="toggle-switch">
                                <input type="checkbox" name="emailNotifications" ${settings != null and settings.emailNotifications ? 'checked' : ''}>
                                <span class="toggle-slider"></span>
                            </label>
                        </div>
                    </div>
                    
                    <div class="config-grid">
                        <div class="config-item">
                            <label>SMTP সার্ভার</label>
                            <input type="text" name="smtpServer" value="${settings != null ? settings.smtpServer : ''}" placeholder="smtp.gmail.com">
                            <small>ইমেইল সার্ভারের SMTP ঠিকানা</small>
                        </div>
                        
                        <div class="config-item">
                            <label>SMTP পোর্ট</label>
                            <input type="number" name="smtpPort" value="${settings != null ? settings.smtpPort : ''}" placeholder="587" min="1" max="65535">
                            <small>SMTP সার্ভারের পোর্ট নম্বর</small>
                        </div>
                        
                        <div class="config-item">
                            <label>SMTP ব্যবহারকারী নাম</label>
                            <input type="text" name="smtpUsername" value="${settings != null ? settings.smtpUsername : ''}" placeholder="your-email@gmail.com">
                            <small>ইমেইল অ্যাকাউন্টের ব্যবহারকারী নাম</small>
                        </div>
                        
                        <div class="config-item">
                            <label>SMTP পাসওয়ার্ড</label>
                            <div class="password-input">
                                <input type="password" name="smtpPassword" value="${settings != null ? settings.smtpPassword : ''}" placeholder="আপনার পাসওয়ার্ড">
                                <button type="button" class="toggle-password" onclick="togglePassword(this)">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                            <small>ইমেইল অ্যাকাউন্টের পাসওয়ার্ড</small>
                        </div>
                    </div>
                </div>
                
                <!-- Notification Types -->
                <div class="form-section notification-types">
                    <div class="section-header">
                        <div class="section-icon">
                            <i class="fas fa-bell"></i>
                        </div>
                        <div class="section-title">
                            <h4>বিজ্ঞপ্তির ধরন</h4>
                            <p>কোন ধরনের বিজ্ঞপ্তি পাঠাতে হবে তা নির্বাচন করুন</p>
                        </div>
                    </div>
                    
                    <div class="notification-grid">
                        <div class="notification-item">
                            <div class="notification-icon">
                                <i class="fas fa-user-plus"></i>
                            </div>
                            <div class="notification-content">
                                <h5>নতুন ব্যবহারকারী নিবন্ধন</h5>
                                <p>নতুন কৃষক বা ব্যবহারকারী নিবন্ধন করলে বিজ্ঞপ্তি পাঠানো হবে</p>
                            </div>
                            <div class="notification-toggle">
                                <label class="toggle-switch">
                                    <input type="checkbox" name="notifyNewUsers" ${settings != null and settings.notifyNewUsers ? 'checked' : ''}>
                                    <span class="toggle-slider"></span>
                                </label>
                            </div>
                        </div>
                        
                        <div class="notification-item">
                            <div class="notification-icon">
                                <i class="fas fa-leaf"></i>
                            </div>
                            <div class="notification-content">
                                <h5>ফসল আপডেট</h5>
                                <p>ফসল সম্পর্কিত কোন আপডেট হলে বিজ্ঞপ্তি পাঠানো হবে</p>
                            </div>
                            <div class="notification-toggle">
                                <label class="toggle-switch">
                                    <input type="checkbox" name="notifyCropUpdates" ${settings != null and settings.notifyCropUpdates ? 'checked' : ''}>
                                    <span class="toggle-slider"></span>
                                </label>
                            </div>
                        </div>
                        
                        <div class="notification-item">
                            <div class="notification-icon">
                                <i class="fas fa-exclamation-circle"></i>
                            </div>
                            <div class="notification-content">
                                <h5>সিস্টেম সতর্কতা</h5>
                                <p>সিস্টেমে কোন ত্রুটি বা সতর্কতা দেখা দিলে বিজ্ঞপ্তি পাঠানো হবে</p>
                            </div>
                            <div class="notification-toggle">
                                <label class="toggle-switch">
                                    <input type="checkbox" name="notifySystemAlerts" ${settings != null and settings.notifySystemAlerts ? 'checked' : ''}>
                                    <span class="toggle-slider"></span>
                                </label>
                            </div>
                        </div>
                        
                        <div class="notification-item">
                            <div class="notification-icon">
                                <i class="fas fa-chart-bar"></i>
                            </div>
                            <div class="notification-content">
                                <h5>রিপোর্ট বিজ্ঞপ্তি</h5>
                                <p>নতুন রিপোর্ট তৈরি হলে বিজ্ঞপ্তি পাঠানো হবে</p>
                            </div>
                            <div class="notification-toggle">
                                <label class="toggle-switch">
                                    <input type="checkbox" name="notifyReports" ${settings != null and settings.notifyReports ? 'checked' : ''}>
                                    <span class="toggle-slider"></span>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Notification Schedule -->
                <div class="form-section notification-schedule">
                    <div class="section-header">
                        <div class="section-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="section-title">
                            <h4>বিজ্ঞপ্তি সময়সূচী</h4>
                            <p>বিজ্ঞপ্তি পাঠানোর সময়সূচী নির্ধারণ করুন</p>
                        </div>
                    </div>
                    
                    <div class="schedule-grid">
                        <div class="schedule-item">
                            <label>বিজ্ঞপ্তি ফ্রিকোয়েন্সি</label>
                            <select name="notificationFrequency" class="modern-select">
                                <option value="immediate">তাৎক্ষণিক</option>
                                <option value="daily">দৈনিক</option>
                                <option value="weekly">সাপ্তাহিক</option>
                                <option value="monthly">মাসিক</option>
                            </select>
                        </div>
                        
                        <div class="schedule-item">
                            <label>বিজ্ঞপ্তি সময়</label>
                            <input type="time" name="notificationTime" class="modern-input" value="09:00">
                        </div>
                        
                        <div class="schedule-item">
                            <label>বিজ্ঞপ্তি দিন</label>
                            <div class="day-selector">
                                <label class="day-checkbox">
                                    <input type="checkbox" name="notificationDays" value="sunday" checked>
                                    <span>রবি</span>
                                </label>
                                <label class="day-checkbox">
                                    <input type="checkbox" name="notificationDays" value="monday" checked>
                                    <span>সোম</span>
                                </label>
                                <label class="day-checkbox">
                                    <input type="checkbox" name="notificationDays" value="tuesday" checked>
                                    <span>মঙ্গল</span>
                                </label>
                                <label class="day-checkbox">
                                    <input type="checkbox" name="notificationDays" value="wednesday" checked>
                                    <span>বুধ</span>
                                </label>
                                <label class="day-checkbox">
                                    <input type="checkbox" name="notificationDays" value="thursday" checked>
                                    <span>বৃহস্পতি</span>
                                </label>
                                <label class="day-checkbox">
                                    <input type="checkbox" name="notificationDays" value="friday" checked>
                                    <span>শুক্র</span>
                                </label>
                                <label class="day-checkbox">
                                    <input type="checkbox" name="notificationDays" value="saturday" checked>
                                    <span>শনি</span>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Test Notification -->
                <div class="form-section">
                    <div class="section-header">
                        <div class="section-icon">
                            <i class="fas fa-paper-plane"></i>
                        </div>
                        <div class="section-title">
                            <h4>টেস্ট বিজ্ঞপ্তি</h4>
                            <p>বিজ্ঞপ্তি সেটিংস পরীক্ষা করুন</p>
                        </div>
                    </div>
                    
                    <button type="button" class="btn-test" onclick="testNotification()">
                        <i class="fas fa-paper-plane"></i> টেস্ট বিজ্ঞপ্তি পাঠান
                    </button>
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn-primary">
                        <i class="fas fa-save"></i> বিজ্ঞপ্তি সেটিংস সংরক্ষণ করুন
                    </button>
                    <button type="button" class="btn-secondary" onclick="resetForm('notifications')">
                        <i class="fas fa-undo"></i> রিসেট করুন
                    </button>
                </div>
            </form>
        </div>
        
        <!-- Backup & Restore Settings -->
        <div class="settings-panel" id="backup">
            <h3><i class="fas fa-database"></i> ব্যাকআপ ও পুনরুদ্ধার</h3>
            
            <form class="settings-form" method="post" action="${pageContext.request.contextPath}/admin/settings">
                <input type="hidden" name="action" value="updateBackupSchedule">
                
                <div class="form-section">
                    <h4>ব্যাকআপ সময়সূচী</h4>
                    <div class="form-row">
                        <div class="input-group">
                            <label>ব্যাকআপ ফ্রিকোয়েন্সি</label>
                            <select name="backupFrequency">
                                <option value="daily" ${settings != null and settings.backupFrequency == 'daily' ? 'selected' : ''}>দৈনিক</option>
                                <option value="weekly" ${settings != null and settings.backupFrequency == 'weekly' ? 'selected' : ''}>সাপ্তাহিক</option>
                                <option value="monthly" ${settings != null and settings.backupFrequency == 'monthly' ? 'selected' : ''}>মাসিক</option>
                            </select>
                        </div>
                        <div class="input-group">
                            <label>ব্যাকআপ সময়</label>
                            <input type="time" name="backupTime" value="${settings != null ? settings.backupTime : ''}">
                        </div>
                    </div>
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn-primary">
                        <i class="fas fa-save"></i> সময়সূচী সংরক্ষণ করুন
                    </button>
                    <button type="button" class="btn-secondary" onclick="resetForm('backup')">
                        <i class="fas fa-undo"></i> রিসেট করুন
                    </button>
                </div>
            </form>
            
            <div class="form-section">
                <h4>ম্যানুয়াল ব্যাকআপ</h4>
                <div class="backup-actions">
                    <button type="button" class="btn-primary" onclick="createBackup()">
                        <i class="fas fa-download"></i> ব্যাকআপ তৈরি করুন
                    </button>
                    <button type="button" class="btn-secondary" onclick="scheduleBackup()">
                        <i class="fas fa-clock"></i> সময়সূচী ব্যাকআপ
                    </button>
                </div>
            </div>
            
            <div class="form-section">
                <h4>ব্যাকআপ ইতিহাস</h4>
                <div class="backup-history">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>ফাইল নাম</th>
                                <th>আকার</th>
                                <th>তারিখ</th>
                                <th>অবস্থা</th>
                                <th>কর্ম</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="backup" items="${backupHistory}">
                                <tr>
                                    <td>${backup.filename}</td>
                                    <td>${backup.size}</td>
                                    <td>${backup.createdAt}</td>
                                    <td>
                                        <span class="status-badge ${backup.status}">${backup.status}</span>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <button type="button" class="btn-small" onclick="downloadBackup('${backup.filename}')">
                                                <i class="fas fa-download"></i>
                                            </button>
                                            <button type="button" class="btn-small btn-danger" onclick="deleteBackup('${backup.filename}')">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Tab navigation
    const tabs = document.querySelectorAll('.nav-tab');
    const panels = document.querySelectorAll('.settings-panel');
    
    // Initially hide all panels except the first one
    panels.forEach((panel, index) => {
        if (index === 0) {
            panel.classList.add('active');
        } else {
            panel.classList.remove('active');
        }
    });
    
    tabs.forEach(tab => {
        tab.addEventListener('click', function() {
            const targetTab = this.dataset.tab;
            
            // Remove active class from all tabs and panels
            tabs.forEach(t => t.classList.remove('active'));
            panels.forEach(p => p.classList.remove('active'));
            
            // Add active class to clicked tab and corresponding panel
            this.classList.add('active');
            const targetPanel = document.getElementById(targetTab);
            if (targetPanel) {
                targetPanel.classList.add('active');
            }
        });
    });
    
    // Initialize toggle switches
    const toggleSwitches = document.querySelectorAll('.toggle-switch input');
    toggleSwitches.forEach(toggle => {
        toggle.addEventListener('change', function() {
            const toggleSwitch = this.closest('.toggle-switch');
            if (this.checked) {
                toggleSwitch.classList.add('active');
                toggleSwitch.style.backgroundColor = '#3498db';
            } else {
                toggleSwitch.classList.remove('active');
                toggleSwitch.style.backgroundColor = '#e0e0e0';
            }
        });
        
        // Set initial state
        if (toggle.checked) {
            const toggleSwitch = toggle.closest('.toggle-switch');
            toggleSwitch.classList.add('active');
            toggleSwitch.style.backgroundColor = '#3498db';
        }
    });
    
    // Initialize day checkboxes
    const dayCheckboxes = document.querySelectorAll('.day-checkbox input');
    dayCheckboxes.forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            const dayCheckbox = this.closest('.day-checkbox');
            if (this.checked) {
                dayCheckbox.classList.add('active');
            } else {
                dayCheckbox.classList.remove('active');
            }
        });
        
        // Set initial state
        if (checkbox.checked) {
            const dayCheckbox = checkbox.closest('.day-checkbox');
            dayCheckbox.classList.add('active');
        }
    });
});

// Form reset function
function resetForm(panelId) {
    const panel = document.getElementById(panelId);
    if (panel) {
        const form = panel.querySelector('form');
        if (form) {
            form.reset();
        }
    }
}

// Toggle password visibility
function togglePassword(button) {
    const input = button.previousElementSibling;
    const icon = button.querySelector('i');
    
    if (input.type === 'password') {
        input.type = 'text';
        icon.classList.remove('fa-eye');
        icon.classList.add('fa-eye-slash');
    } else {
        input.type = 'password';
        icon.classList.remove('fa-eye-slash');
        icon.classList.add('fa-eye');
    }
}

// Create backup function
function createBackup() {
    fetch('${pageContext.request.contextPath}/admin/settings/backup', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        }
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            showNotification('ব্যাকআপ সফলভাবে তৈরি হয়েছে!', 'success');
            // Refresh the page to show the new backup
            setTimeout(() => {
                location.reload();
            }, 1000);
        } else {
            showNotification('ব্যাকআপ তৈরি করতে ব্যর্থ হয়েছে: ' + data.message, 'error');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        showNotification('ব্যাকআপ তৈরি করতে ব্যর্থ হয়েছে!', 'error');
    });
}

// Schedule backup function
function scheduleBackup() {
    showNotification('সময়সূচী ব্যাকআপ বৈশিষ্ট্য শীঘ্রই আসবে!', 'info');
}

// Download backup function
function downloadBackup(filename) {
    window.open('${pageContext.request.contextPath}/admin/settings/download/' + filename, '_blank');
}

// Delete backup function
function deleteBackup(filename) {
    if (confirm('আপনি কি নিশ্চিত যে আপনি এই ব্যাকআপ ফাইলটি মুছে ফেলতে চান?')) {
        fetch('${pageContext.request.contextPath}/admin/settings/delete/' + filename, {
            method: 'DELETE'
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                showNotification('ব্যাকআপ ফাইল সফলভাবে মুছে ফেলা হয়েছে!', 'success');
                // Refresh the page to update the backup list
                setTimeout(() => {
                    location.reload();
                }, 1000);
            } else {
                showNotification('ব্যাকআপ ফাইল মুছতে ব্যর্থ হয়েছে: ' + data.message, 'error');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            showNotification('ব্যাকআপ ফাইল মুছতে ব্যর্থ হয়েছে!', 'error');
        });
    }
}

// Test notification function
function testNotification() {
    const button = event.target.closest('.btn-test');
    const originalText = button.innerHTML;
    
    // Show loading state
    button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> পাঠানো হচ্ছে...';
    button.disabled = true;
    
    fetch('${pageContext.request.contextPath}/admin/settings/test-notification', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        }
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            showNotification('টেস্ট বিজ্ঞপ্তি সফলভাবে পাঠানো হয়েছে!', 'success');
        } else {
            showNotification('টেস্ট বিজ্ঞপ্তি পাঠাতে ব্যর্থ হয়েছে: ' + data.message, 'error');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        showNotification('টেস্ট বিজ্ঞপ্তি পাঠাতে ব্যর্থ হয়েছে!', 'error');
    })
    .finally(() => {
        // Restore button state
        button.innerHTML = originalText;
        button.disabled = false;
    });
}

// Enhanced form validation for notification section
function validateNotificationForm() {
    const emailNotifications = document.querySelector('input[name="emailNotifications"]');
    const smtpServer = document.querySelector('input[name="smtpServer"]');
    const smtpPort = document.querySelector('input[name="smtpPort"]');
    const smtpUsername = document.querySelector('input[name="smtpUsername"]');
    const smtpPassword = document.querySelector('input[name="smtpPassword"]');
    
    if (emailNotifications && emailNotifications.checked) {
        if (!smtpServer.value.trim()) {
            showNotification('SMTP সার্ভার প্রয়োজন!', 'error');
            return false;
        }
        if (!smtpPort.value.trim()) {
            showNotification('SMTP পোর্ট প্রয়োজন!', 'error');
            return false;
        }
        if (!smtpUsername.value.trim()) {
            showNotification('SMTP ব্যবহারকারী নাম প্রয়োজন!', 'error');
            return false;
        }
        if (!smtpPassword.value.trim()) {
            showNotification('SMTP পাসওয়ার্ড প্রয়োজন!', 'error');
            return false;
        }
    }
    
    return true;
}

// Generic notification function
function showNotification(message, type = 'info') {
    const notification = document.createElement('div');
    notification.className = `alert alert-${type}`;
    notification.innerHTML = `
        <i class="fas fa-${type === 'success' ? 'check-circle' : type === 'error' ? 'exclamation-circle' : 'info-circle'}"></i>
        ${message}
    `;
    
    // Insert at the top of the container
    const container = document.querySelector('.settings-container');
    container.insertBefore(notification, container.firstChild);
    
    // Auto remove after 5 seconds
    setTimeout(() => {
        if (notification.parentNode) {
            notification.parentNode.removeChild(notification);
        }
    }, 5000);
}
</script>

<jsp:include page="/WEB-INF/includes/admin_footer.jsp" />
