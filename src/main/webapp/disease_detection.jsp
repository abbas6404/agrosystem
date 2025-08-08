<%@page import="org.json.JSONObject"%>
<%@page import="com.mycompany.agrosystem.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="bn">
<head>
    <title>রোগ শনাক্তকরণ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <% User user = (User) session.getAttribute("loggedInUser"); 
       if (user == null || !"FARMER".equals(user.getUserType())) { 
           response.sendRedirect(request.getContextPath() + "/login.jsp"); 
           return; 
       } %>
    
    <div class="dashboard-container">
        <!-- Include Farmer Sidebar -->
        <jsp:include page="includes/farmer-sidebar.jsp">
            <jsp:param name="active" value="disease"/>
        </jsp:include>
        
        <main class="main-content">
            <!-- Include Header -->
            <jsp:include page="includes/header.jsp">
                <jsp:param name="pageTitle" value="রোগ শনাক্তকরণ"/>
                <jsp:param name="userName" value="<%= user.getName() %>"/>
            </jsp:include>
            
            <!-- Include Alerts -->
            <jsp:include page="includes/alerts.jsp"/>
            
            <!-- Content Area -->
            <div class="content-area">
                <h3><i class="fas fa-upload"></i> ছবি আপলোড করুন</h3>
                <form id="uploadForm" action="diseaseDetection" method="post" enctype="multipart/form-data">
                    <label for="cropImage" class="upload-container">
                        <i class="fas fa-cloud-upload-alt"></i>
                        <p>ছবি আপলোড করতে ক্লিক করুন</p>
                    </label>
                    <input type="file" id="cropImage" name="cropImage" accept="image/*" onchange="document.getElementById('uploadForm').submit();">
                </form>
                
                <% if (request.getAttribute("analysisResult") != null) { %>
                    <div class="result-container">
                        <div class="image-preview">
                            <h4>আপনার ছবি:</h4>
                            <img src="${uploadedImage}" alt="Crop Leaf">
                        </div>
                        <div class="analysis-details">
                            <h4><i class="fas fa-vial"></i> AI বিশ্লেষণ:</h4>
                            <% try { 
                                JSONObject result = new JSONObject((String)request.getAttribute("analysisResult")); 
                            %>
                                <p><strong>রোগের নাম:</strong> <%= result.optString("রোগের_নাম", "N/A") %></p>
                                <p><strong>বিবরণ:</strong> <%= result.optString("বিবরণ", "N/A") %></p>
                                <p><strong>প্রতিকার:</strong> <%= result.optString("প্রতিকার", "N/A") %></p>
                            <% } catch (Exception e) { %>
                                <p style="color:red;">ফলাফল দেখাতে সমস্যা হয়েছে।</p>
                            <% } %>
                        </div>
                    </div>
                <% } %>
            </div>
        </main>
    </div>
</body>
</html>