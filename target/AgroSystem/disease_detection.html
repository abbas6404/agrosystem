<%@page import="org.json.JSONObject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="bn">
<head>
    <title>রোগ শনাক্তকরণ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="dashboard-container">
        <aside class="sidebar"><div class="sidebar-header"><h3><i class="fas fa-tractor"></i> এগ্রো সিস্টেম</h3></div><nav class="sidebar-nav"><a href="${pageContext.request.contextPath}/farmerDashboard" class="nav-item"><i class="fas fa-tachometer-alt"></i> ড্যাশবোর্ড</a><a href="${pageContext.request.contextPath}/disease_detection.jsp" class="nav-item active"><i class="fas fa-stethoscope"></i> রোগ শনাক্তকরণ</a></nav></aside>
        <main class="main-content">
            <header class="main-header"><h2><i class="fas fa-stethoscope"></i> রোগ ও পোকামাকড় শনাক্তকরণ</h2><div class="header-actions"><a href="${pageContext.request.contextPath}/logout" class="logout-btn"><i class="fas fa-sign-out-alt"></i> লগ আউট</a></div></header>
            <div class="content-area">
                <form id="uploadForm" action="diseaseDetection" method="post" enctype="multipart/form-data"><label for="cropImage" class="upload-container"><i class="fas fa-cloud-upload-alt"></i><p>ছবি আপলোড করতে ক্লিক করুন</p></label><input type="file" id="cropImage" name="cropImage" accept="image/*" onchange="document.getElementById('uploadForm').submit();"></form>
                <% if (request.getAttribute("analysisResult") != null) { %><div class="result-container"><div class="image-preview"><h4>আপনার ছবি:</h4><img src="${uploadedImage}" alt="Crop Leaf"></div><div class="analysis-details"><h4><i class="fas fa-vial"></i> AI বিশ্লেষণ:</h4><% try { JSONObject result = new JSONObject((String)request.getAttribute("analysisResult")); %><p><strong>রোগের নাম:</strong> <%= result.optString("রোগের_নাম", "N/A") %></p><p><strong>বিবরণ:</strong> <%= result.optString("বিবরণ", "N/A") %></p><p><strong>প্রতিকার:</strong> <%= result.optString("প্রতিকার", "N/A") %></p><% } catch (Exception e) { %><p style="color:red;">ফলাফল দেখাতে সমস্যা হয়েছে।</p><% } %></div></div><% } %>
            </div>
        </main>
    </div>
</body>
</html>