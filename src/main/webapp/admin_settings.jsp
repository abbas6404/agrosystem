<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<jsp:include page="/WEB-INF/includes/admin_header.jsp">
    <jsp:param name="pageTitle" value="সেটিংস" />
    <jsp:param name="pageIcon" value="fas fa-cog" />
    <jsp:param name="activePage" value="settings" />
</jsp:include>

<div class="settings-container">
    <!-- Welcome Section -->
    <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 30px; border-radius: 16px; margin-bottom: 30px; text-align: center; box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);">
        <h1 style="font-size: 2.5rem; margin-bottom: 10px; font-weight: 700;"><i class="fas fa-cog"></i> সিস্টেম সেটিংস</h1>
        <p style="font-size: 1.1rem; opacity: 0.9; margin-bottom: 20px;">আপনার এগ্রো সিস্টেমের সমস্ত কনফিগারেশন এখানে পরিচালনা করুন</p>
        
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin-top: 25px;">
            <div style="background: rgba(255, 255, 255, 0.1); padding: 20px; border-radius: 12px; border: 1px solid rgba(255, 255, 255, 0.2);">
                <span style="font-size: 2rem; font-weight: 700; display: block; margin-bottom: 5px;">${settings != null ? '5' : '0'}</span>
                <span style="font-size: 0.9rem; opacity: 0.8;">সক্রিয় সেটিংস</span>
            </div>
            <div style="background: rgba(255, 255, 255, 0.1); padding: 20px; border-radius: 12px; border: 1px solid rgba(255, 255, 255, 0.2);">
                <span style="font-size: 2rem; font-weight: 700; display: block; margin-bottom: 5px;">${settings != null ? '3' : '0'}</span>
                <span style="font-size: 0.9rem; opacity: 0.8;">সক্রিয় বিজ্ঞপ্তি</span>
            </div>
            <div style="background: rgba(255, 255, 255, 0.1); padding: 20px; border-radius: 12px; border: 1px solid rgba(255, 255, 255, 0.2);">
                <span style="font-size: 2rem; font-weight: 700; display: block; margin-bottom: 5px;">${settings != null ? '2' : '0'}</span>
                <span style="font-size: 0.9rem; opacity: 0.8;">ব্যাকআপ সময়সূচী</span>
            </div>
            <div style="background: rgba(255, 255, 255, 0.1); padding: 20px; border-radius: 12px; border: 1px solid rgba(255, 255, 255, 0.2);">
                <span style="font-size: 2rem; font-weight: 700; display: block; margin-bottom: 5px;">${settings != null ? '100%' : '0%'}</span>
                <span style="font-size: 0.9rem; opacity: 0.8;">সিস্টেম স্বাস্থ্য</span>
            </div>
        </div>
    </div>

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
    <div style="background: white; border-radius: 16px; padding: 20px; margin-bottom: 30px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1); border: 1px solid #e5e7eb;">
        <div style="display: flex; gap: 10px; flex-wrap: wrap;">
            <button class="nav-tab active" data-tab="general" style="background: #4f46e5; border: 2px solid #4f46e5; color: white; padding: 12px 20px; border-radius: 12px; cursor: pointer; font-weight: 600; display: flex; align-items: center; gap: 10px; min-width: 160px; justify-content: center;">
                <i class="fas fa-cog"></i> সাধারণ সেটিংস
            </button>
            <button class="nav-tab" data-tab="users" style="background: #f3f4f6; border: 2px solid transparent; color: #4b5563; padding: 12px 20px; border-radius: 12px; cursor: pointer; font-weight: 600; display: flex; align-items: center; gap: 10px; min-width: 160px; justify-content: center;">
                <i class="fas fa-users"></i> ব্যবহারকারী ব্যবস্থাপনা
            </button>
            <button class="nav-tab" data-tab="system" style="background: #f3f4f6; border: 2px solid transparent; color: #4b5563; padding: 12px 20px; border-radius: 12px; cursor: pointer; font-weight: 600; display: flex; align-items: center; gap: 10px; min-width: 160px; justify-content: center;">
                <i class="fas fa-server"></i> সিস্টেম সেটিংস
            </button>
            <button class="nav-tab" data-tab="notifications" style="background: #f3f4f6; border: 2px solid transparent; color: #4b5563; padding: 12px 20px; border-radius: 12px; cursor: pointer; font-weight: 600; display: flex; align-items: center; gap: 10px; min-width: 160px; justify-content: center;">
                <i class="fas fa-bell"></i> বিজ্ঞপ্তি সেটিংস
            </button>
            <button class="nav-tab" data-tab="backup" style="background: #f3f4f6; border: 2px solid transparent; color: #4b5563; padding: 12px 20px; border-radius: 12px; cursor: pointer; font-weight: 600; display: flex; align-items: center; gap: 10px; min-width: 160px; justify-content: center;">
                <i class="fas fa-database"></i> ব্যাকআপ ও পুনরুদ্ধার
            </button>
        </div>
    </div>

    <!-- Settings Content -->
    <div style="background: white; border-radius: 16px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1); border: 1px solid #e5e7eb; overflow: hidden;">
        
        <!-- General Settings -->
        <div class="settings-panel active" id="general" style="display: block; padding: 30px;">
            <h3 style="color: #1f2937; font-size: 1.8rem; margin-bottom: 25px; display: flex; align-items: center; gap: 15px; padding-bottom: 15px; border-bottom: 2px solid #e5e7eb;"><i class="fas fa-cog" style="color: #4f46e5;"></i> সাধারণ সেটিংস</h3>
            
            <form class="settings-form" method="post" action="${pageContext.request.contextPath}/admin/settings">
                <input type="hidden" name="action" value="updateGeneral">
                
                <div style="background: #f9fafb; padding: 25px; border-radius: 12px; margin-bottom: 25px; border: 1px solid #e5e7eb;">
                    <h4 style="color: #374151; font-size: 1.3rem; margin-bottom: 20px; display: flex; align-items: center; gap: 10px;"><i class="fas fa-info-circle" style="color: #4f46e5;"></i> সাইট তথ্য</h4>
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px; margin-bottom: 20px;">
                        <div style="display: flex; flex-direction: column;">
                            <label style="font-weight: 600; color: #374151; margin-bottom: 8px; font-size: 0.95rem;">সাইটের নাম</label>
                            <input type="text" name="siteName" value="${settings != null ? settings.siteName : 'এগ্রো সিস্টেম'}" required style="padding: 12px 16px; border: 2px solid #d1d5db; border-radius: 12px; font-size: 1rem; background: white;">
                        </div>
                        <div style="display: flex; flex-direction: column;">
                            <label style="font-weight: 600; color: #374151; margin-bottom: 8px; font-size: 0.95rem;">সাইটের বিবরণ</label>
                            <textarea name="siteDescription" rows="3" style="padding: 12px 16px; border: 2px solid #d1d5db; border-radius: 12px; font-size: 1rem; background: white; resize: vertical; min-height: 100px;">${settings != null ? settings.siteDescription : 'কৃষি ব্যবস্থাপনা সিস্টেম'}</textarea>
                        </div>
                    </div>
                    
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px; margin-bottom: 20px;">
                        <div style="display: flex; flex-direction: column;">
                            <label style="font-weight: 600; color: #374151; margin-bottom: 8px; font-size: 0.95rem;">ইমেইল ঠিকানা</label>
                            <input type="email" name="contactEmail" value="${settings != null ? settings.contactEmail : 'admin@agrosystem.com'}" style="padding: 12px 16px; border: 2px solid #d1d5db; border-radius: 12px; font-size: 1rem; background: white;">
                        </div>
                        <div style="display: flex; flex-direction: column;">
                            <label style="font-weight: 600; color: #374151; margin-bottom: 8px; font-size: 0.95rem;">ফোন নম্বর</label>
                            <input type="tel" name="contactPhone" value="${settings != null ? settings.contactPhone : '+880 1234-567890'}" style="padding: 12px 16px; border: 2px solid #d1d5db; border-radius: 12px; font-size: 1rem; background: white;">
                        </div>
                    </div>
                </div>
                
                <div class="form-section">
                    <h4><i class="fas fa-clock"></i> সময় ও তারিখ</h4>
                    <div class="form-row">
                        <div class="input-group">
                            <label>সময় অঞ্চল</label>
                            <select name="timezone">
                                <option value="Asia/Dhaka" ${settings != null and settings.timezone == 'Asia/Dhaka' ? 'selected' : 'selected'}>বাংলাদেশ সময় (GMT+6)</option>
                                <option value="UTC" ${settings != null and settings.timezone == 'UTC' ? 'selected' : ''}>UTC</option>
                            </select>
                        </div>
                        <div class="input-group">
                            <label>তারিখ ফরম্যাট</label>
                            <select name="dateFormat">
                                <option value="dd/MM/yyyy" ${settings != null and settings.dateFormat == 'dd/MM/yyyy' ? 'selected' : 'selected'}>dd/MM/yyyy</option>
                                <option value="MM/dd/yyyy" ${settings != null and settings.dateFormat == 'MM/dd/yyyy' ? 'selected' : ''}>MM/dd/yyyy</option>
                                <option value="yyyy-MM-dd" ${settings != null and settings.dateFormat == 'yyyy-MM-dd' ? 'selected' : ''}>yyyy-MM-dd</option>
                            </select>
                        </div>
                    </div>
                </div>
                
                <div style="display: flex; gap: 15px; margin-top: 30px; padding-top: 25px; border-top: 2px solid #e5e7eb; flex-wrap: wrap;">
                    <button type="submit" style="padding: 12px 24px; border: none; border-radius: 12px; font-weight: 600; font-size: 1rem; cursor: pointer; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; display: flex; align-items: center; gap: 10px; min-width: 160px; justify-content: center;">
                        <i class="fas fa-save"></i> সেটিংস সংরক্ষণ করুন
                    </button>
                    <button type="button" onclick="resetForm('general')" style="padding: 12px 24px; border: 2px solid #d1d5db; border-radius: 12px; font-weight: 600; font-size: 1rem; cursor: pointer; background: white; color: #374151; display: flex; align-items: center; gap: 10px; min-width: 160px; justify-content: center;">
                        <i class="fas fa-undo"></i> রিসেট করুন
                    </button>
                </div>
            </form>
        </div>
        
        <!-- User Management Settings -->
        <div class="settings-panel" id="users" style="display: none; padding: 30px;">
            <h3 style="color: #1f2937; font-size: 1.8rem; margin-bottom: 25px; display: flex; align-items: center; gap: 15px; padding-bottom: 15px; border-bottom: 2px solid #e5e7eb;"><i class="fas fa-users" style="color: #4f46e5;"></i> ব্যবহারকারী ব্যবস্থাপনা</h3>
            
            <form class="settings-form" method="post" action="${pageContext.request.contextPath}/admin/settings">
                <input type="hidden" name="action" value="updateUsers">
                
                <div class="form-section">
                    <h4><i class="fas fa-user-plus"></i> নিবন্ধন সেটিংস</h4>
                    <div class="form-row">
                        <div class="input-group">
                            <label>নতুন নিবন্ধন অনুমতি</label>
                            <select name="allowRegistration">
                                <option value="true" ${settings != null and settings.allowRegistration ? 'selected' : 'selected'}>অনুমতি দিন</option>
                                <option value="false" ${settings != null and not settings.allowRegistration ? 'selected' : ''}>অনুমতি দিন না</option>
                            </select>
                        </div>
                        <div class="input-group">
                            <label>ইমেইল যাচাইকরণ</label>
                            <select name="emailVerification">
                                <option value="true" ${settings != null and settings.emailVerification ? 'selected' : 'selected'}>প্রয়োজন</option>
                                <option value="false" ${settings != null and not settings.emailVerification ? 'selected' : ''}>প্রয়োজন নেই</option>
                            </select>
                        </div>
                    </div>
                </div>
                
                <div class="form-section">
                    <h4><i class="fas fa-lock"></i> পাসওয়ার্ড সেটিংস</h4>
                    <div class="form-row">
                        <div class="input-group">
                            <label>নূন্যতম পাসওয়ার্ড দৈর্ঘ্য</label>
                            <input type="number" name="minPasswordLength" value="${settings != null ? settings.minPasswordLength : '8'}" min="6" max="20">
                        </div>
                        <div class="input-group">
                            <label>সেশন টাইমআউট (মিনিট)</label>
                            <input type="number" name="sessionTimeout" value="${settings != null ? settings.sessionTimeout : '30'}" min="15" max="480">
                        </div>
                    </div>
                </div>
                
                <div class="form-section">
                    <h4><i class="fas fa-user-tag"></i> ব্যবহারকারী ভূমিকা</h4>
                    <div class="form-row">
                        <div class="input-group">
                            <label>ডিফল্ট ব্যবহারকারী ভূমিকা</label>
                            <select name="defaultUserRole">
                                <option value="FARMER" ${settings != null and settings.defaultUserRole == 'FARMER' ? 'selected' : 'selected'}>কৃষক</option>
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
        <div class="settings-panel" id="system" style="display: none; padding: 30px;">
            <h3 style="color: #1f2937; font-size: 1.8rem; margin-bottom: 25px; display: flex; align-items: center; gap: 15px; padding-bottom: 15px; border-bottom: 2px solid #e5e7eb;"><i class="fas fa-server" style="color: #4f46e5;"></i> সিস্টেম সেটিংস</h3>
            
            <form class="settings-form" method="post" action="${pageContext.request.contextPath}/admin/settings">
                <input type="hidden" name="action" value="updateSystem">
                
                <div class="form-section">
                    <h4><i class="fas fa-database"></i> ডেটাবেস সেটিংস</h4>
                    <div class="form-row">
                        <div class="input-group">
                            <label>কানেকশন পুল সাইজ</label>
                            <input type="number" name="dbPoolSize" value="${settings != null ? settings.dbPoolSize : '10'}" min="5" max="50">
                        </div>
                        <div class="input-group">
                            <label>কানেকশন টাইমআউট (সেকেন্ড)</label>
                            <input type="number" name="dbTimeout" value="${settings != null ? settings.dbTimeout : '30'}" min="5" max="60">
                        </div>
                    </div>
                </div>
                
                <div class="form-section">
                    <h4><i class="fas fa-upload"></i> ফাইল আপলোড সেটিংস</h4>
                    <div class="form-row">
                        <div class="input-group">
                            <label>সর্বোচ্চ ফাইল সাইজ (MB)</label>
                            <input type="number" name="maxFileSize" value="${settings != null ? settings.maxFileSize : '10'}" min="1" max="100">
                        </div>
                        <div class="input-group">
                            <label>অনুমোদিত ফাইল ধরন</label>
                            <input type="text" name="allowedFileTypes" value="${settings != null ? settings.allowedFileTypes : 'jpg,jpeg,png,pdf,doc,docx'}" placeholder="jpg,jpeg,png,pdf,doc,docx">
                        </div>
                    </div>
                </div>
                
                <div class="form-section">
                    <h4><i class="fas fa-file-alt"></i> লগিং সেটিংস</h4>
                    <div class="form-row">
                        <div class="input-group">
                            <label>লগ লেভেল</label>
                            <select name="logLevel">
                                <option value="INFO" ${settings != null and settings.logLevel == 'INFO' ? 'selected' : 'selected'}>INFO</option>
                                <option value="DEBUG" ${settings != null and settings.logLevel == 'DEBUG' ? 'selected' : ''}>DEBUG</option>
                                <option value="WARNING" ${settings != null and settings.logLevel == 'WARNING' ? 'selected' : ''}>WARNING</option>
                                <option value="ERROR" ${settings != null and settings.logLevel == 'ERROR' ? 'selected' : ''}>ERROR</option>
                            </select>
                        </div>
                        <div class="input-group">
                            <label>লগ রিটেনশন (দিন)</label>
                            <input type="number" name="logRetention" value="${settings != null ? settings.logRetention : '30'}" min="1" max="365">
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
        <div class="settings-panel" id="notifications" style="display: none; padding: 30px;">
            <h3 style="color: #1f2937; font-size: 1.8rem; margin-bottom: 25px; display: flex; align-items: center; gap: 15px; padding-bottom: 15px; border-bottom: 2px solid #e5e7eb;"><i class="fas fa-bell" style="color: #4f46e5;"></i> বিজ্ঞপ্তি ব্যবস্থাপনা</h3>
            
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
                <div class="form-section">
                    <h4><i class="fas fa-envelope"></i> ইমেইল কনফিগারেশন</h4>
                    <div class="form-row">
                        <div class="input-group">
                            <label>ইমেইল বিজ্ঞপ্তি সক্রিয় করুন</label>
                            <label class="toggle-switch">
                                <input type="checkbox" name="emailNotifications" ${settings != null and settings.emailNotifications ? 'checked' : ''}>
                                <span class="toggle-slider"></span>
                            </label>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="input-group">
                            <label>SMTP সার্ভার</label>
                            <input type="text" name="smtpServer" value="${settings != null ? settings.smtpServer : 'smtp.gmail.com'}" placeholder="smtp.gmail.com">
                        </div>
                        <div class="input-group">
                            <label>SMTP পোর্ট</label>
                            <input type="number" name="smtpPort" value="${settings != null ? settings.smtpPort : '587'}" placeholder="587" min="1" max="65535">
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="input-group">
                            <label>SMTP ব্যবহারকারী নাম</label>
                            <input type="text" name="smtpUsername" value="${settings != null ? settings.smtpUsername : ''}" placeholder="your-email@gmail.com">
                        </div>
                        <div class="input-group">
                            <label>SMTP পাসওয়ার্ড</label>
                            <input type="password" name="smtpPassword" value="${settings != null ? settings.smtpPassword : ''}" placeholder="আপনার পাসওয়ার্ড">
                        </div>
                    </div>
                </div>
                
                <!-- Notification Types -->
                <div class="form-section">
                    <h4><i class="fas fa-bell"></i> বিজ্ঞপ্তির ধরন</h4>
                    <div class="form-row">
                        <div class="input-group">
                            <label>নতুন ব্যবহারকারী নিবন্ধন</label>
                            <label class="toggle-switch">
                                <input type="checkbox" name="notifyNewUsers" ${settings != null and settings.notifyNewUsers ? 'checked' : 'checked'}>
                                <span class="toggle-slider"></span>
                            </label>
                        </div>
                        <div class="input-group">
                            <label>ফসল আপডেট</label>
                            <label class="toggle-switch">
                                <input type="checkbox" name="notifyCropUpdates" ${settings != null and settings.notifyCropUpdates ? 'checked' : 'checked'}>
                                <span class="toggle-slider"></span>
                            </label>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="input-group">
                            <label>সিস্টেম সতর্কতা</label>
                            <label class="toggle-switch">
                                <input type="checkbox" name="notifySystemAlerts" ${settings != null and settings.notifySystemAlerts ? 'checked' : 'checked'}>
                                <span class="toggle-slider"></span>
                            </label>
                        </div>
                        <div class="input-group">
                            <label>রিপোর্ট বিজ্ঞপ্তি</label>
                            <label class="toggle-switch">
                                <input type="checkbox" name="notifyReports" ${settings != null and settings.notifyReports ? 'checked' : 'checked'}>
                                <span class="toggle-slider"></span>
                            </label>
                        </div>
                    </div>
                </div>
                
                <!-- Test Notification -->
                <div class="form-section">
                    <h4><i class="fas fa-paper-plane"></i> টেস্ট বিজ্ঞপ্তি</h4>
                    <p>বিজ্ঞপ্তি সেটিংস পরীক্ষা করুন</p>
                    <button type="button" class="btn-primary" onclick="testNotification()">
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
        <div class="settings-panel" id="backup" style="display: none; padding: 30px;">
            <h3 style="color: #1f2937; font-size: 1.8rem; margin-bottom: 25px; display: flex; align-items: center; gap: 15px; padding-bottom: 15px; border-bottom: 2px solid #e5e7eb;"><i class="fas fa-database" style="color: #4f46e5;"></i> ব্যাকআপ ও পুনরুদ্ধার</h3>
            
            <form class="settings-form" method="post" action="${pageContext.request.contextPath}/admin/settings">
                <input type="hidden" name="action" value="updateBackupSchedule">
                
                <div class="form-section">
                    <h4><i class="fas fa-clock"></i> ব্যাকআপ সময়সূচী</h4>
                    <div class="form-row">
                        <div class="input-group">
                            <label>ব্যাকআপ ফ্রিকোয়েন্সি</label>
                            <select name="backupFrequency">
                                <option value="daily" ${settings != null and settings.backupFrequency == 'daily' ? 'selected' : 'selected'}>দৈনিক</option>
                                <option value="weekly" ${settings != null and settings.backupFrequency == 'weekly' ? 'selected' : ''}>সাপ্তাহিক</option>
                                <option value="monthly" ${settings != null and settings.backupFrequency == 'monthly' ? 'selected' : ''}>মাসিক</option>
                            </select>
                        </div>
                        <div class="input-group">
                            <label>ব্যাকআপ সময়</label>
                            <input type="time" name="backupTime" value="${settings != null ? settings.backupTime : '02:00'}">
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
                <h4><i class="fas fa-download"></i> ম্যানুয়াল ব্যাকআপ</h4>
                <div class="form-actions">
                    <button type="button" class="btn-primary" onclick="createBackup()">
                        <i class="fas fa-download"></i> ব্যাকআপ তৈরি করুন
                    </button>
                    <button type="button" class="btn-secondary" onclick="scheduleBackup()">
                        <i class="fas fa-clock"></i> সময়সূচী ব্যাকআপ
                    </button>
                </div>
            </div>
            
            <div class="form-section">
                <h4><i class="fas fa-history"></i> ব্যাকআপ ইতিহাস</h4>
                <div class="backup-history">
                    <p>ব্যাকআপ ইতিহাস শীঘ্রই দেখানো হবে...</p>
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
            panel.style.display = 'block';
        } else {
            panel.style.display = 'none';
        }
    });
    
    tabs.forEach(tab => {
        tab.addEventListener('click', function() {
            const targetTab = this.dataset.tab;
            
            // Remove active class from all tabs and hide all panels
            tabs.forEach(t => {
                t.classList.remove('active');
                t.style.background = '#f3f4f6';
                t.style.color = '#4b5563';
                t.style.borderColor = 'transparent';
            });
            panels.forEach(p => p.style.display = 'none');
            
            // Add active class to clicked tab and show corresponding panel
            this.classList.add('active');
            this.style.background = '#4f46e5';
            this.style.color = 'white';
            this.style.borderColor = '#4f46e5';
            
            const targetPanel = document.getElementById(targetTab);
            if (targetPanel) {
                targetPanel.style.display = 'block';
            }
        });
    });
});

// Form reset function
function resetForm(panelId) {
    const panel = document.getElementById(panelId);
    if (panel) {
        const form = panel.querySelector('form');
        if (form) {
            form.reset();
            alert('ফর্ম রিসেট করা হয়েছে');
        }
    }
}

// Create backup function
function createBackup() {
    alert('ব্যাকআপ বৈশিষ্ট্য শীঘ্রই আসবে!');
}

// Schedule backup function
function scheduleBackup() {
    alert('সময়সূচী ব্যাকআপ বৈশিষ্ট্য শীঘ্রই আসবে!');
}

// Test notification function
function testNotification() {
    alert('টেস্ট বিজ্ঞপ্তি বৈশিষ্ট্য শীঘ্রই আসবে!');
}
</script>

<jsp:include page="/WEB-INF/includes/admin_footer.jsp" />
