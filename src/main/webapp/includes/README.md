# Modular Layout System

This directory contains reusable JSP components for the AgroSyst application.

## 📁 Files Structure

```
includes/
├── farmer-sidebar.jsp      # Farmer navigation sidebar
├── admin-sidebar.jsp       # Admin navigation sidebar  
├── header.jsp             # Common header with user info
├── alerts.jsp             # Success/error message display
├── layout-template.jsp    # Template for new pages
└── README.md             # This documentation
```

## 🚀 How to Use

### 1. Creating a New Farmer Page

```jsp
<%@page import="com.mycompany.agrosystem.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="bn">
<head>
    <title>Your Page Title</title>
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
            <jsp:param name="active" value="pageName"/>
        </jsp:include>
        
        <main class="main-content">
            <!-- Include Header -->
            <jsp:include page="includes/header.jsp">
                <jsp:param name="pageTitle" value="Your Page Title"/>
            </jsp:include>
            
            <!-- Include Alerts -->
            <jsp:include page="includes/alerts.jsp"/>
            
            <!-- Your Content -->
            <div class="content-area">
                <h3><i class="fas fa-icon"></i> Your Content</h3>
                <!-- Add your content here -->
            </div>
        </main>
    </div>
</body>
</html>
```

### 2. Creating a New Admin Page

```jsp
<!-- Same structure but use admin-sidebar.jsp -->
<jsp:include page="includes/admin-sidebar.jsp">
    <jsp:param name="active" value="pageName"/>
</jsp:include>
```

## 📋 Available Sidebar Options

### Farmer Sidebar Active Values:
- `dashboard` - Dashboard page
- `myCrops` - My Crops page  
- `suggestion` - AI Suggestions page
- `weather` - Weather page
- `disease` - Disease Detection page

### Admin Sidebar Active Values:
- `dashboard` - Dashboard page
- `crops` - Crop Management page
- `farmers` - Farmer Management page
- `notices` - Notice Board page
- `reports` - Reports page

## 🎨 Features

### ✅ Benefits:
- **Consistent Layout** - All pages have the same structure
- **Easy Maintenance** - Change sidebar once, affects all pages
- **Active Navigation** - Current page is highlighted
- **Reusable Components** - Header, alerts, and sidebars are modular
- **Clean Code** - Less duplication, more maintainable

### 🔧 How Active Navigation Works:
The sidebar automatically highlights the current page based on the `active` parameter:

```jsp
<jsp:include page="includes/farmer-sidebar.jsp">
    <jsp:param name="active" value="dashboard"/>
</jsp:include>
```

This will add the `active` class to the dashboard link in the sidebar.

## 📝 Notes

- Always include authentication checks
- Use the alerts component for success/error messages
- Keep page titles consistent with the header parameter
- The template file shows the complete structure for reference
