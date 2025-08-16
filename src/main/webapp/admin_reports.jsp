<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<jsp:include page="WEB-INF/includes/admin_header.jsp">
    <jsp:param name="pageTitle" value="রিপোর্ট ও বিশ্লেষণ" />
    <jsp:param name="activePage" value="reports" />
    <jsp:param name="pageIcon" value="fas fa-chart-bar" />
</jsp:include>

<div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 20px; text-align: center; margin: 20px; border-radius: 16px;">
    <h1 style="font-size: 28px; margin-bottom: 10px;"><i class="fas fa-chart-bar"></i> রিপোর্ট ও বিশ্লেষণ</h1>
    <p style="opacity: 0.9;">কৃষি সিস্টেমের পরিসংখ্যান ও বিশ্লেষণ</p>
</div>
    
<div style="max-width: 1400px; margin: 0 auto; padding: 20px;">
    <a href="${pageContext.request.contextPath}/admin/dashboard" style="display: inline-block; background: rgba(102, 126, 234, 0.2); color: white; padding: 10px 20px; text-decoration: none; border-radius: 8px; margin-bottom: 20px;">
        <i class="fas fa-arrow-left"></i> ড্যাশবোর্ডে ফিরে যান
    </a>

    <!-- Page Actions -->
        <div style="display: flex; gap: 15px; margin-bottom: 30px; flex-wrap: wrap;">
            <button type="button" id="generateReportBtn" style="padding: 12px 24px; border: none; border-radius: 12px; font-weight: 600; font-size: 14px; cursor: pointer; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; display: flex; align-items: center; gap: 8px;">
            <i class="fas fa-file-alt"></i> রিপোর্ট তৈরি করুন
        </button>
            <button type="button" id="exportDataBtn" style="padding: 12px 24px; border: 2px solid #e2e8f0; border-radius: 12px; font-weight: 600; font-size: 14px; cursor: pointer; background: white; color: #1e293b; display: flex; align-items: center; gap: 8px;">
            <i class="fas fa-download"></i> ডেটা রপ্তানি করুন
        </button>
            <button type="button" id="scheduleReportBtn" style="padding: 12px 24px; border: 2px solid #e2e8f0; border-radius: 12px; font-weight: 600; font-size: 14px; cursor: pointer; background: white; color: #1e293b; display: flex; align-items: center; gap: 8px;">
            <i class="fas fa-clock"></i> সময়সূচী রিপোর্ট
        </button>
    </div>

    <!-- Report Statistics Overview -->
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 20px; margin-bottom: 40px;">
            <div style="background: white; padding: 25px; border-radius: 16px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1); border: 1px solid #e2e8f0;">
                <div style="width: 60px; height: 60px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 16px; display: flex; align-items: center; justify-content: center; color: white; font-size: 24px; margin-bottom: 20px;">
                <i class="fas fa-users"></i>
            </div>
                <div>
                    <h4 style="margin: 0 0 10px 0; color: #64748b; font-size: 14px; font-weight: 500; text-transform: uppercase;">মোট কৃষক</h4>
                    <p style="font-size: 32px; font-weight: 700; color: #1e293b; margin: 0 0 8px 0;">${totalFarmers != null ? totalFarmers : 0}</p>
                    <small style="font-size: 12px; font-weight: 600; padding: 4px 12px; border-radius: 20px; background: #dcfce7; color: #166534;">+${newFarmersThisMonth != null ? newFarmersThisMonth : 0} এই মাসে</small>
            </div>
        </div>
            <div style="background: white; padding: 25px; border-radius: 16px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1); border: 1px solid #e2e8f0;">
                <div style="width: 60px; height: 60px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 16px; display: flex; align-items: center; justify-content: center; color: white; font-size: 24px; margin-bottom: 20px;">
                <i class="fas fa-leaf"></i>
            </div>
                <div>
                    <h4 style="margin: 0 0 10px 0; color: #64748b; font-size: 14px; font-weight: 500; text-transform: uppercase;">মোট ফসল</h4>
                    <p style="font-size: 32px; font-weight: 700; color: #1e293b; margin: 0 0 8px 0;">${totalCrops != null ? totalCrops : 0}</p>
                    <small style="font-size: 12px; font-weight: 600; padding: 4px 12px; border-radius: 20px; background: #dcfce7; color: #166534;">+${newCropsThisMonth != null ? newCropsThisMonth : 0} এই মাসে</small>
            </div>
        </div>
            <div style="background: white; padding: 25px; border-radius: 16px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1); border: 1px solid #e2e8f0;">
                <div style="width: 60px; height: 60px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 16px; display: flex; align-items: center; justify-content: center; color: white; font-size: 24px; margin-bottom: 20px;">
                <i class="fas fa-map-marker-alt"></i>
            </div>
                <div>
                    <h4 style="margin: 0 0 10px 0; color: #64748b; font-size: 14px; font-weight: 500; text-transform: uppercase;">কভারেজ এলাকা</h4>
                    <p style="font-size: 32px; font-weight: 700; color: #1e293b; margin: 0 0 8px 0;">${totalLandArea != null ? totalLandArea : '0.00'} একর</p>
                    <small style="font-size: 12px; font-weight: 600; padding: 4px 12px; border-radius: 20px; background: #dcfce7; color: #166534;">+${newLandArea != null ? newLandArea : '0.00'} এই মাসে</small>
            </div>
        </div>
            <div style="background: white; padding: 25px; border-radius: 16px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1); border: 1px solid #e2e8f0;">
                <div style="width: 60px; height: 60px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 16px; display: flex; align-items: center; justify-content: center; color: white; font-size: 24px; margin-bottom: 20px;">
                <i class="fas fa-chart-line"></i>
            </div>
                <div>
                    <h4 style="margin: 0 0 10px 0; color: #64748b; font-size: 14px; font-weight: 500; text-transform: uppercase;">বৃদ্ধির হার</h4>
                    <p style="font-size: 32px; font-weight: 700; color: #1e293b; margin: 0 0 8px 0;">${growthRate != null ? growthRate : '0.0'}%</p>
                    <small style="font-size: 12px; font-weight: 600; padding: 4px 12px; border-radius: 20px; background: #dcfce7; color: #166534;">গত মাসের তুলনায়</small>
            </div>
        </div>
    </div>

    <!-- Report Generation Form -->
        <div style="background: white; border-radius: 16px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1); margin-bottom: 30px; overflow: hidden;">
            <h3 style="margin: 0; padding: 25px 30px 20px; color: #1e293b; font-size: 20px; font-weight: 600; border-bottom: 1px solid #e2e8f0; display: flex; align-items: center; gap: 12px;">
                <i class="fas fa-cogs" style="color: #4f46e5;"></i> রিপোর্ট তৈরি করুন
            </h3>
            <form method="post" action="${pageContext.request.contextPath}/admin/reports" style="padding: 30px;">
            <input type="hidden" name="action" value="generate">
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; margin-bottom: 20px;">
                    <div>
                        <label style="display: block; margin-bottom: 8px; font-weight: 600; color: #1e293b; font-size: 14px;">রিপোর্টের ধরন <span style="color: #ef4444;">*</span></label>
                        <select name="reportType" required style="width: 100%; padding: 12px 16px; border: 2px solid #e2e8f0; border-radius: 12px; font-size: 14px; background: #f8fafc;">
                        <option value="">রিপোর্টের ধরন নির্বাচন করুন</option>
                        <option value="farmer_summary">কৃষক সারসংক্ষেপ</option>
                        <option value="crop_analysis">ফসল বিশ্লেষণ</option>
                        <option value="location_distribution">অবস্থান বণ্টন</option>
                        <option value="growth_trends">বৃদ্ধির প্রবণতা</option>
                        <option value="seasonal_analysis">মৌসুমি বিশ্লেষণ</option>
                        <option value="performance_metrics">কর্মক্ষমতা মেট্রিক</option>
                    </select>
                </div>
                    <div>
                        <label style="display: block; margin-bottom: 8px; font-weight: 600; color: #1e293b; font-size: 14px;">সময়কাল</label>
                        <select name="timePeriod" style="width: 100%; padding: 12px 16px; border: 2px solid #e2e8f0; border-radius: 12px; font-size: 14px; background: #f8fafc;">
                        <option value="7">গত ৭ দিন</option>
                        <option value="30" selected>গত ৩০ দিন</option>
                        <option value="90">গত ৩ মাস</option>
                        <option value="365">গত ১ বছর</option>
                        <option value="custom">কাস্টম</option>
                    </select>
                </div>
            </div>
            
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; margin-bottom: 20px;">
                    <div>
                        <label style="display: block; margin-bottom: 8px; font-weight: 600; color: #1e293b; font-size: 14px;">ফরম্যাট</label>
                        <select name="outputFormat" style="width: 100%; padding: 12px 16px; border: 2px solid #e2e8f0; border-radius: 12px; font-size: 14px; background: #f8fafc;">
                        <option value="html">HTML</option>
                        <option value="pdf">PDF</option>
                        <option value="excel">Excel</option>
                        <option value="csv">CSV</option>
                    </select>
                </div>
                    <div>
                        <label style="display: block; margin-bottom: 8px; font-weight: 600; color: #1e293b; font-size: 14px;">সাজানোর ক্রম</label>
                        <select name="sortOrder" style="width: 100%; padding: 12px 16px; border: 2px solid #e2e8f0; border-radius: 12px; font-size: 14px; background: #f8fafc;">
                        <option value="asc">আরোহী ক্রম</option>
                        <option value="desc">অবরোহী ক্রম</option>
                    </select>
                </div>
            </div>
            
                <div style="display: flex; gap: 15px; margin-top: 30px; flex-wrap: wrap;">
                    <button type="submit" style="padding: 12px 24px; border: none; border-radius: 12px; font-weight: 600; font-size: 14px; cursor: pointer; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; display: flex; align-items: center; gap: 8px;">
                    <i class="fas fa-chart-bar"></i> রিপোর্ট তৈরি করুন
                </button>
                    <button type="button" onclick="resetForm()" style="padding: 12px 24px; border: 2px solid #e2e8f0; border-radius: 12px; font-weight: 600; font-size: 14px; cursor: pointer; background: white; color: #1e293b; display: flex; align-items: center; gap: 8px;">
                    <i class="fas fa-undo"></i> ফর্ম রিসেট করুন
                </button>
            </div>
        </form>
    </div>

    <!-- Quick Reports -->
        <div style="background: white; border-radius: 16px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1); margin-bottom: 30px; overflow: hidden;">
            <h3 style="margin: 0; padding: 25px 30px 20px; color: #1e293b; font-size: 20px; font-weight: 600; border-bottom: 1px solid #e2e8f0; display: flex; align-items: center; gap: 12px;">
                <i class="fas fa-bolt" style="color: #4f46e5;"></i> দ্রুত রিপোর্ট
            </h3>
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px; padding: 30px;">
                <div style="background: white; padding: 25px; border-radius: 16px; border: 2px solid #e2e8f0; display: flex; align-items: center; gap: 20px; cursor: pointer;" onclick="generateQuickReport('farmer_summary')">
                    <div style="width: 60px; height: 60px; background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); border-radius: 16px; display: flex; align-items: center; justify-content: center; color: white; font-size: 24px;">
                    <i class="fas fa-users"></i>
                </div>
                    <div style="flex: 1;">
                        <h4 style="margin: 0 0 8px 0; color: #1e293b; font-size: 18px; font-weight: 600;">কৃষক নিবন্ধন</h4>
                        <p style="margin: 0; color: #64748b; font-size: 14px; line-height: 1.5;">নতুন কৃষক নিবন্ধনের পরিসংখ্যান</p>
                </div>
                    <button type="button" style="padding: 12px 24px; border: none; border-radius: 12px; font-weight: 600; font-size: 14px; cursor: pointer; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; display: flex; align-items: center; gap: 8px;">
                    <i class="fas fa-play"></i> চালু করুন
                </button>
            </div>
            
                <div style="background: white; padding: 25px; border-radius: 16px; border: 2px solid #e2e8f0; display: flex; align-items: center; gap: 20px; cursor: pointer;" onclick="generateQuickReport('crop_analysis')">
                    <div style="width: 60px; height: 60px; background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); border-radius: 16px; display: flex; align-items: center; justify-content: center; color: white; font-size: 24px;">
                    <i class="fas fa-leaf"></i>
                </div>
                    <div style="flex: 1;">
                        <h4 style="margin: 0 0 8px 0; color: #1e293b; font-size: 18px; font-weight: 600;">ফসল বণ্টন</h4>
                        <p style="margin: 0; color: #64748b; font-size: 14px; line-height: 1.5;">বিভিন্ন ফসলের চাষের পরিসংখ্যান</p>
                </div>
                    <button type="button" style="padding: 12px 24px; border: none; border-radius: 12px; font-weight: 600; font-size: 14px; cursor: pointer; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; display: flex; align-items: center; gap: 8px;">
                    <i class="fas fa-play"></i> চালু করুন
                </button>
            </div>
        </div>
    </div>

    <!-- Report Results -->
        <div id="reportResults" style="background: white; border-radius: 16px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1); margin-bottom: 30px; overflow: hidden; display: none;">
            <h3 style="margin: 0; padding: 25px 30px 20px; color: #1e293b; font-size: 20px; font-weight: 600; border-bottom: 1px solid #e2e8f0; display: flex; align-items: center; gap: 12px;">
                <i class="fas fa-chart-bar" style="color: #4f46e5;"></i> রিপোর্ট ফলাফল
            </h3>
            <div id="reportContent" style="padding: 30px; text-align: center; color: #64748b;">
                <i class="fas fa-chart-bar" style="font-size: 64px; margin-bottom: 20px; display: block; opacity: 0.3;"></i>
                <h3>রিপোর্ট তৈরি করুন</h3>
                <p>উপরে ফর্ম ব্যবহার করে আপনার প্রথম রিপোর্ট তৈরি করুন</p>
        </div>
    </div>
</div>

<script>
        function resetForm() {
            document.querySelector('form').reset();
            document.getElementById('reportResults').style.display = 'none';
            alert('ফর্ম রিসেট করা হয়েছে');
        }
        
        function generateQuickReport(reportType) {
            const reportTypeSelect = document.querySelector('select[name="reportType"]');
            if (reportTypeSelect) {
                reportTypeSelect.value = reportType;
            }
            alert(reportType + ' রিপোর্টের জন্য ফর্ম সেট করা হয়েছে');
        }
        
        // Handle form submission
        document.querySelector('form').addEventListener('submit', function(e) {
            e.preventDefault();
            const reportType = this.querySelector('select[name="reportType"]').value;
    if (!reportType) {
        alert('অনুগ্রহ করে রিপোর্টের ধরন নির্বাচন করুন');
        return;
    }
    
    // Show loading state
            const reportResults = document.getElementById('reportResults');
            const reportContent = document.getElementById('reportContent');
            
            reportResults.style.display = 'block';
            reportContent.innerHTML = `
                <div style="text-align: center; padding: 60px 20px; color: #64748b;">
                    <div style="width: 40px; height: 40px; border: 3px solid #e2e8f0; border-top: 3px solid #4f46e5; border-radius: 50%; animation: spin 1s linear infinite; margin: 0 auto 20px;"></div>
                    <p>রিপোর্ট তৈরি হচ্ছে...</p>
                    <small>অনুগ্রহ করে অপেক্ষা করুন</small>
                </div>
            `;
    
    // Submit the form
            this.submit();
        });
        
        // Add CSS animation
        const style = document.createElement('style');
        style.textContent = `
            @keyframes spin {
                0% { transform: rotate(0deg); }
                100% { transform: rotate(360deg); }
            }
        `;
        document.head.appendChild(style);
</script>

<jsp:include page="WEB-INF/includes/admin_footer.jsp" />
