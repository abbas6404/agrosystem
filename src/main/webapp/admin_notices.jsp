<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<jsp:include page="/WEB-INF/includes/admin_header.jsp">
    <jsp:param name="pageTitle" value="নোটিশ ব্যবস্থাপনা" />
    <jsp:param name="pageIcon" value="fas fa-bullhorn" />
    <jsp:param name="activePage" value="notices" />
</jsp:include>

<style>
/* CSS Variables */
:root {
    --primary-color: #2ecc71;
    --primary-dark: #27ae60;
    --secondary-color: #3498db;
    --accent-color: #f39c12;
    --danger-color: #e74c3c;
    --success-color: #27ae60;
    --warning-color: #f39c12;
    --text-primary: #2c3e50;
    --text-secondary: #7f8c8d;
    --dark-color: #2c3e50;
    --bg-light: #f8f9fa;
    --border-color: #e9ecef;
    --shadow: 0 4px 6px rgba(0,0,0,0.1);
    --shadow-hover: 0 8px 15px rgba(0,0,0,0.15);
    --border-radius: 12px;
    --transition: all 0.3s ease;
}

/* Enhanced Notice Management Styling */
.notice-welcome {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 40px;
    border-radius: 20px;
    margin-bottom: 30px;
    text-align: center;
    position: relative;
    overflow: hidden;
    box-shadow: 0 20px 40px rgba(0,0,0,0.1);
}

.notice-welcome::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="rgba(255,255,255,0.1)"/><circle cx="75" cy="75" r="1" fill="rgba(255,255,255,0.1)"/><circle cx="50" cy="10" r="0.5" fill="rgba(255,255,255,0.1)"/><circle cx="10" cy="60" r="0.5" fill="rgba(255,255,255,0.1)"/><circle cx="90" cy="40" r="0.5" fill="rgba(255,255,255,0.1)"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
    opacity: 0.3;
}

.notice-welcome h1 {
    margin: 0 0 15px 0;
    font-size: 2.5rem;
    font-weight: 700;
    position: relative;
    z-index: 1;
}

.notice-welcome p {
    margin: 0;
    font-size: 1.2rem;
    opacity: 0.9;
    position: relative;
    z-index: 1;
}

/* Enhanced Page Actions */
.page-actions {
    background: white;
    padding: 25px;
    border-radius: 20px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.08);
    margin-bottom: 30px;
    display: flex;
    gap: 20px;
    flex-wrap: wrap;
    align-items: center;
}

.page-actions .btn-primary,
.page-actions .btn-secondary {
    padding: 15px 30px;
    border-radius: 12px;
    text-decoration: none;
    font-weight: 600;
    transition: all 0.3s ease;
    display: inline-flex;
    align-items: center;
    gap: 12px;
    font-size: 1rem;
    border: none;
    cursor: pointer;
}

.page-actions .btn-primary {
    background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
    color: white;
    box-shadow: 0 8px 25px rgba(39, 174, 96, 0.3);
}

.page-actions .btn-primary:hover {
    transform: translateY(-3px);
    box-shadow: 0 12px 35px rgba(39, 174, 96, 0.4);
}

.page-actions .btn-secondary {
    background: linear-gradient(135deg, #95a5a6, #7f8c8d);
    color: white;
    box-shadow: 0 8px 25px rgba(149, 165, 166, 0.3);
}

.page-actions .btn-secondary:hover {
    transform: translateY(-3px);
    box-shadow: 0 12px 35px rgba(149, 165, 166, 0.4);
}

/* Enhanced Stats Grid */
.stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 25px;
    margin-bottom: 40px;
}

.stat-card {
    background: white;
    border-radius: 20px;
    padding: 30px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.08);
    border: 1px solid rgba(255,255,255,0.2);
    transition: all 0.3s ease;
    position: relative;
    overflow: hidden;
}

.stat-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 4px;
    background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
    transform: scaleX(0);
    transition: transform 0.3s ease;
}

.stat-card:hover::before {
    transform: scaleX(1);
}

.stat-card:hover {
    transform: translateY(-10px);
    box-shadow: 0 20px 50px rgba(0,0,0,0.15);
}

.stat-icon {
    width: 70px;
    height: 70px;
    background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 28px;
    color: white;
    margin-bottom: 20px;
    box-shadow: 0 8px 25px rgba(39, 174, 96, 0.3);
    transition: all 0.3s ease;
}

.stat-card:hover .stat-icon {
    transform: scale(1.1);
    box-shadow: 0 12px 35px rgba(39, 174, 96, 0.4);
}

.stat-content h4 {
    margin: 0 0 15px 0;
    color: var(--dark-color);
    font-size: 1.1rem;
    font-weight: 600;
}

.stat-number {
    margin: 0;
    font-size: 2.5rem;
    font-weight: 700;
    background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

/* Enhanced Quick Notice Form */
.quick-notice-form {
    background: white;
    border-radius: 20px;
    padding: 30px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.08);
    margin-bottom: 30px;
    border: 1px solid rgba(255,255,255,0.2);
}

.quick-notice-form h3 {
    margin: 0 0 25px 0;
    color: var(--dark-color);
    font-size: 1.5rem;
    font-weight: 600;
    display: flex;
    align-items: center;
    gap: 12px;
}

.quick-notice-form h3 i {
    color: var(--primary-color);
    font-size: 1.3rem;
}

.form-row {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
    margin-bottom: 20px;
}

.input-group {
    display: flex;
    flex-direction: column;
}

.input-group label {
    font-weight: 600;
    color: var(--dark-color);
    margin-bottom: 8px;
    font-size: 0.95rem;
}

.required {
    color: var(--danger-color);
    font-weight: 700;
}

.input-group input,
.input-group select,
.input-group textarea {
    padding: 15px 18px;
    border: 2px solid #e9ecef;
    border-radius: 12px;
    font-size: 1rem;
    transition: all 0.3s ease;
    background: white;
}

.input-group input:focus,
.input-group select:focus,
.input-group textarea:focus {
    outline: none;
    border-color: var(--primary-color);
    box-shadow: 0 0 0 4px rgba(39, 174, 96, 0.1);
    transform: translateY(-2px);
}

.input-group textarea {
    resize: vertical;
    min-height: 120px;
}

/* Enhanced Form Actions */
.form-actions {
    display: flex;
    gap: 15px;
    margin-top: 25px;
    padding-top: 20px;
    border-top: 2px solid #eee;
    flex-wrap: wrap;
}

.form-actions .btn-primary,
.form-actions .btn-secondary {
    padding: 15px 30px;
    border-radius: 12px;
    font-weight: 600;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 10px;
    transition: all 0.3s ease;
    border: none;
    cursor: pointer;
    font-size: 1rem;
}

.form-actions .btn-primary {
    background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
    color: white;
    box-shadow: 0 8px 25px rgba(39, 174, 96, 0.3);
}

.form-actions .btn-primary:hover {
    transform: translateY(-3px);
    box-shadow: 0 12px 35px rgba(39, 174, 96, 0.4);
}

.form-actions .btn-secondary {
    background: linear-gradient(135deg, #95a5a6, #7f8c8d);
    color: white;
    box-shadow: 0 8px 25px rgba(149, 165, 166, 0.3);
}

.form-actions .btn-secondary:hover {
    transform: translateY(-3px);
    box-shadow: 0 12px 35px rgba(149, 165, 166, 0.4);
}

/* Live Preview Styling */
.live-preview {
    background: #f8f9fa;
    border-radius: 15px;
    padding: 25px;
    margin-top: 25px;
    border: 2px dashed #dee2e6;
    transition: all 0.3s ease;
}

.live-preview h4 {
    margin: 0 0 20px 0;
    color: var(--dark-color);
    font-size: 1.2rem;
    font-weight: 600;
    display: flex;
    align-items: center;
    gap: 10px;
}

.live-preview h4 i {
    color: var(--primary-color);
}

.preview-content {
    background: white;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.08);
    border: 1px solid #e9ecef;
}

.preview-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 15px;
    padding-bottom: 15px;
    border-bottom: 2px solid #f1f3f4;
}

.preview-header h3 {
    margin: 0;
    color: var(--dark-color);
    font-size: 1.3rem;
    font-weight: 600;
}

.preview-badge {
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 0.85rem;
    font-weight: 500;
    background: linear-gradient(135deg, #e3f2fd, #bbdefb);
    color: #1565c0;
}

.preview-badge.important {
    background: linear-gradient(135deg, #fff3e0, #ffe0b2);
    color: #ef6c00;
}

.preview-badge.urgent {
    background: linear-gradient(135deg, #ffebee, #ffcdd2);
    color: #c62828;
}

.preview-badge.announcement {
    background: linear-gradient(135deg, #e8f5e8, #c8e6c9);
    color: #2e7d32;
}

.preview-badge.warning {
    background: linear-gradient(135deg, #fff8e1, #ffecb3);
    color: #f57f17;
}

.preview-body {
    margin-bottom: 15px;
}

.preview-body p {
    margin: 0;
    color: var(--dark-color);
    line-height: 1.6;
    font-size: 1rem;
}

.preview-footer {
    padding-top: 15px;
    border-top: 1px solid #f1f3f4;
}

.preview-footer small {
    color: var(--text-secondary);
    font-size: 0.9rem;
}

/* Enhanced Table Styling */
.table-container {
    background: white;
    border-radius: 20px;
    overflow: hidden;
    box-shadow: 0 10px 30px rgba(0,0,0,0.08);
    border: 1px solid #e9ecef;
    transition: all 0.3s ease;
}

.table-container:hover {
    box-shadow: 0 15px 40px rgba(0,0,0,0.12);
}

/* Table Row Selection */
.styled-table tbody tr.selected {
    background: linear-gradient(135deg, #e3f2fd, #bbdefb) !important;
    border-left: 4px solid var(--primary-color);
}

.styled-table tbody tr.active-row {
    background: linear-gradient(135deg, #f3e5f5, #e1bee7) !important;
    border-left: 4px solid var(--accent-color);
}

/* Enhanced Action Buttons */
.action-buttons {
    display: flex;
    gap: 8px;
    justify-content: center;
    flex-wrap: wrap;
}

.action-btn {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    text-decoration: none;
    color: white;
    font-size: 0.9rem;
    transition: all 0.3s ease;
    border: none;
    cursor: pointer;
    position: relative;
    overflow: hidden;
}

.action-btn:hover {
    transform: scale(1.1);
    box-shadow: 0 5px 15px rgba(0,0,0,0.3);
}

.btn-view { 
    background: linear-gradient(135deg, var(--secondary-color), #2980b9); 
}

.btn-edit { 
    background: linear-gradient(135deg, var(--accent-color), #e67e22); 
}

.btn-delete { 
    background: linear-gradient(135deg, var(--danger-color), #c0392b); 
}

/* Enhanced Empty State */
.empty-state {
    text-align: center;
    padding: 60px 20px;
    color: var(--text-secondary);
}

.empty-state i {
    font-size: 4rem;
    color: var(--primary-color);
    margin-bottom: 20px;
    opacity: 0.6;
}

.empty-state h3 {
    margin: 0 0 15px 0;
    color: var(--text-primary);
    font-size: 1.5rem;
    font-weight: 600;
}

.empty-state p {
    margin: 0;
    font-size: 1.1rem;
    line-height: 1.6;
}

.empty-state small {
    display: block;
    margin-top: 15px;
    font-size: 0.9rem;
    opacity: 0.7;
}

/* Enhanced Search and Filter */
.search-filter-form {
    background: white;
    border-radius: 20px;
    padding: 30px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.08);
    margin-bottom: 30px;
    border: 1px solid #e9ecef;
}

.search-filter-form h3 {
    margin: 0 0 25px 0;
    color: var(--dark-color);
    font-size: 1.5rem;
    font-weight: 600;
    display: flex;
    align-items: center;
    gap: 12px;
}

.search-filter-form h3 i {
    color: var(--primary-color);
    font-size: 1.3rem;
}

.search-input,
.filter-select {
    padding: 15px 18px;
    border: 2px solid #e9ecef;
    border-radius: 12px;
    font-size: 1rem;
    transition: all 0.3s ease;
    background: white;
    width: 100%;
}

.search-input:focus,
.filter-select:focus {
    outline: none;
    border-color: var(--primary-color);
    box-shadow: 0 0 0 4px rgba(39, 174, 96, 0.1);
    transform: translateY(-2px);
}

/* Enhanced Template Cards */
.templates-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 25px;
    margin-top: 25px;
}

/* Content Area Styling */
.content-area {
    background: white;
    border-radius: 20px;
    padding: 30px;
    margin-bottom: 30px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.08);
    border: 1px solid #e9ecef;
    transition: all 0.3s ease;
}

.content-area:hover {
    box-shadow: 0 15px 40px rgba(0,0,0,0.12);
}

.content-area h3 {
    margin: 0 0 25px 0;
    color: var(--dark-color);
    font-size: 1.5rem;
    font-weight: 600;
    display: flex;
    align-items: center;
    gap: 12px;
}

.content-area h3 i {
    color: var(--primary-color);
    font-size: 1.3rem;
}

.template-card {
    background: white;
    border-radius: 20px;
    padding: 25px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.08);
    border: 1px solid #e9ecef;
    transition: all 0.3s ease;
    text-align: center;
}

.template-card:hover {
    transform: translateY(-10px);
    box-shadow: 0 20px 50px rgba(0,0,0,0.15);
}

.template-header {
    margin-bottom: 20px;
}

.template-header i {
    font-size: 2.5rem;
    color: var(--primary-color);
    margin-bottom: 15px;
    display: block;
}

.template-header h4 {
    margin: 0;
    color: var(--dark-color);
    font-size: 1.3rem;
    font-weight: 600;
}

.template-content {
    margin-bottom: 25px;
}

.template-content p {
    margin: 0;
    color: var(--text-secondary);
    line-height: 1.6;
    font-size: 1rem;
}

.template-card .btn-primary {
    width: 100%;
    justify-content: center;
}

/* Enhanced Button Styling */
.btn-primary,
.btn-secondary {
    padding: 15px 30px;
    border-radius: 12px;
    font-weight: 600;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 10px;
    transition: all 0.3s ease;
    border: none;
    cursor: pointer;
    font-size: 1rem;
    position: relative;
    overflow: hidden;
}

.btn-primary {
    background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
    color: white;
    box-shadow: 0 8px 25px rgba(39, 174, 96, 0.3);
}

.btn-primary:hover {
    transform: translateY(-3px);
    box-shadow: 0 12px 35px rgba(39, 174, 96, 0.4);
}

.btn-secondary {
    background: linear-gradient(135deg, #95a5a6, #7f8c8d);
    color: white;
    box-shadow: 0 8px 25px rgba(149, 165, 166, 0.3);
}

.btn-secondary:hover {
    transform: translateY(-3px);
    box-shadow: 0 12px 35px rgba(149, 165, 166, 0.4);
}

/* Button Loading States */
.btn-primary:disabled,
.btn-secondary:disabled {
    opacity: 0.7;
    cursor: not-allowed;
    transform: none;
}

/* Enhanced Input Styling */
.input-group input,
.input-group select,
.input-group textarea {
    padding: 15px 18px;
    border: 2px solid #e9ecef;
    border-radius: 12px;
    font-size: 1rem;
    transition: all 0.3s ease;
    background: white;
    width: 100%;
    box-sizing: border-box;
}

.input-group input:focus,
.input-group select:focus,
.input-group textarea:focus {
    outline: none;
    border-color: var(--primary-color);
    box-shadow: 0 0 0 4px rgba(39, 174, 96, 0.1);
    transform: translateY(-2px);
}

/* Enhanced Label Styling */
.input-group label {
    font-weight: 600;
    color: var(--dark-color);
    margin-bottom: 8px;
    font-size: 0.95rem;
    display: block;
}

.required {
    color: var(--danger-color);
    font-weight: 700;
}

.styled-table {
    width: 100%;
    border-collapse: collapse;
}

.styled-table th {
    background: linear-gradient(135deg, #f8f9fa, #e9ecef);
    padding: 20px;
    text-align: left;
    font-weight: 600;
    color: var(--dark-color);
    border-bottom: 2px solid #dee2e6;
    font-size: 0.95rem;
}

.styled-table td {
    padding: 20px;
    border-bottom: 1px solid #f1f3f4;
    vertical-align: middle;
}

.styled-table tbody tr {
    transition: all 0.3s ease;
}

.styled-table tbody tr:hover {
    background: linear-gradient(135deg, #f8f9fa, #e9ecef);
    transform: scale(1.01);
}

/* Notice Type Badges */
.notice-type-badge {
    padding: 8px 16px;
    border-radius: 25px;
    font-size: 0.85rem;
    font-weight: 500;
    text-align: center;
    display: inline-block;
    min-width: 100px;
}

.notice-type-general {
    background: linear-gradient(135deg, #e3f2fd, #bbdefb);
    color: #1565c0;
}

.notice-type-important {
    background: linear-gradient(135deg, #fff3e0, #ffe0b2);
    color: #ef6c00;
}

.notice-type-urgent {
    background: linear-gradient(135deg, #ffebee, #ffcdd2);
    color: #c62828;
}

.notice-type-announcement {
    background: linear-gradient(135deg, #e8f5e8, #c8e6c9);
    color: #2e7d32;
}

.notice-type-warning {
    background: linear-gradient(135deg, #fff8e1, #ffecb3);
    color: #f57f17;
}

/* Status Badges */
.status-badge {
    padding: 8px 16px;
    border-radius: 25px;
    font-size: 0.85rem;
    font-weight: 500;
    text-align: center;
    display: inline-block;
    min-width: 100px;
}

.status-active {
    background: linear-gradient(135deg, #e8f5e8, #c8e6c9);
    color: #2e7d32;
}

.status-expired {
    background: linear-gradient(135deg, #ffebee, #ffcdd2);
    color: #c62828;
}

.status-inactive {
    background: linear-gradient(135deg, #f5f5f5, #eeeeee);
    color: #616161;
}

/* Responsive Design */
@media (max-width: 768px) {
    .notice-welcome {
        padding: 30px 20px;
    }
    
    .notice-welcome h1 {
        font-size: 2rem;
    }
    
    .page-actions {
        flex-direction: column;
        align-items: stretch;
    }
    
    .page-actions .btn-primary,
    .page-actions .btn-secondary {
        width: 100%;
        justify-content: center;
    }
    
    .stats-grid {
        grid-template-columns: 1fr;
        gap: 20px;
    }
    
    .form-row {
        grid-template-columns: 1fr;
    }
    
    .form-actions {
        flex-direction: column;
        align-items: stretch;
    }
    
    .form-actions .btn-primary,
    .form-actions .btn-secondary {
        width: 100%;
        justify-content: center;
    }
    
    .templates-grid {
        grid-template-columns: 1fr;
        gap: 20px;
    }
    
    .table-container {
        overflow-x: auto;
    }
    
    .styled-table {
        min-width: 600px;
    }
    
    .action-buttons {
        flex-direction: column;
        gap: 5px;
    }
    
    .action-btn {
        width: 35px;
        height: 35px;
        font-size: 0.8rem;
    }
}

/* Additional Responsive Breakpoints */
@media (max-width: 480px) {
    .notice-welcome {
        padding: 20px 15px;
    }
    
    .notice-welcome h1 {
        font-size: 1.8rem;
    }
    
    .notice-welcome p {
        font-size: 1rem;
    }
    
    .content-area,
    .quick-notice-form,
    .search-filter-form {
        padding: 20px;
    }
    
    .form-actions {
        gap: 10px;
    }
    
    .btn-primary,
    .btn-secondary {
        padding: 12px 20px;
        font-size: 0.9rem;
    }
}

/* Animation Enhancements */
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

@keyframes slideInLeft {
    from {
        opacity: 0;
        transform: translateX(-30px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

@keyframes pulse {
    0%, 100% {
        transform: scale(1);
    }
    50% {
        transform: scale(1.05);
    }
}

/* Apply animations to key elements */
.notice-welcome {
    animation: fadeInUp 0.8s ease-out;
}

.stat-card {
    animation: slideInLeft 0.6s ease-out;
}

.stat-card:nth-child(1) { animation-delay: 0.1s; }
.stat-card:nth-child(2) { animation-delay: 0.2s; }
.stat-card:nth-child(3) { animation-delay: 0.3s; }
.stat-card:nth-child(4) { animation-delay: 0.4s; }

.quick-notice-form {
    animation: fadeInUp 0.8s ease-out 0.2s both;
}

.content-area {
    animation: fadeInUp 0.8s ease-out 0.4s both;
}

/* Hover animations */
.stat-card:hover .stat-icon {
    animation: pulse 1s infinite;
}

.btn-primary:hover,
.btn-secondary:hover {
    animation: pulse 0.6s ease-in-out;
}
</style>

<!-- Notice Welcome Section -->
<div class="notice-welcome">
    <h1><i class="fas fa-bullhorn"></i> নোটিশ ব্যবস্থাপনা</h1>
    <p>আপনার কৃষকদের জন্য গুরুত্বপূর্ণ নোটিশ এবং ঘোষণা প্রকাশ করুন</p>
</div>

<div class="notice-management-container">
    <!-- Page Actions -->
    <div class="page-actions">
        <a href="${pageContext.request.contextPath}/admin/notices/add" class="btn-primary">
            <i class="fas fa-plus"></i> নতুন নোটিশ যোগ করুন
        </a>
        <a href="${pageContext.request.contextPath}/admin/notices/templates" class="btn-secondary">
            <i class="fas fa-file-alt"></i> নোটিশ টেমপ্লেট
        </a>
        <a href="${pageContext.request.contextPath}/admin/notices/schedule" class="btn-secondary">
            <i class="fas fa-clock"></i> সময়সূচী
        </a>
        <a href="${pageContext.request.contextPath}/admin/notices/analytics" class="btn-secondary">
            <i class="fas fa-chart-line"></i> বিশ্লেষণ
        </a>
    </div>

    <!-- Notice Statistics -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-bullhorn"></i>
            </div>
            <div class="stat-content">
                <h4>মোট নোটিশ</h4>
                <p class="stat-number">${noticeCount}</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-eye"></i>
            </div>
            <div class="stat-content">
                <h4>আজ দেখা হয়েছে</h4>
                <p class="stat-number">${todayViews != null ? todayViews : '0'}</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-calendar"></i>
            </div>
            <div class="stat-content">
                <h4>এই মাসে প্রকাশিত</h4>
                <p class="stat-number">${monthlyNotices != null ? monthlyNotices : '0'}</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-star"></i>
            </div>
            <div class="stat-content">
                <h4>গুরুত্বপূর্ণ</h4>
                <p class="stat-number">${importantNotices != null ? importantNotices : '0'}</p>
            </div>
        </div>
    </div>

    <!-- Quick Notice Form -->
    <div class="quick-notice-form">
        <h3><i class="fas fa-plus-circle"></i> দ্রুত নোটিশ প্রকাশ</h3>
        <form action="${pageContext.request.contextPath}/admin/notices" method="post" id="quickNoticeForm" onsubmit="return validateAndSubmitForm(event)">


            <c:if test="${editNotice != null}">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="noticeId" value="${editNotice.id}">
            </c:if>
            <c:if test="${editNotice == null}">
                <input type="hidden" name="action" value="add">
            </c:if>
            
            <div class="form-row">
                <div class="input-group">
                    <label>শিরোনাম <span class="required">*</span></label>
                    <input type="text" name="title" id="noticeTitle" required 
                           placeholder="নোটিশের শিরোনাম লিখুন"
                           value="${editNotice != null ? editNotice.title : ''}">
                </div>
                <div class="input-group">
                    <label>ধরন</label>
                    <select name="noticeType" id="noticeType">
                        <option value="general" ${editNotice != null && editNotice.type == 'general' ? 'selected' : ''}>সাধারণ</option>
                        <option value="important" ${editNotice != null && editNotice.type == 'important' ? 'selected' : ''}>গুরুত্বপূর্ণ</option>
                        <option value="urgent" ${editNotice != null && editNotice.type == 'urgent' ? 'selected' : ''}>জরুরি</option>
                        <option value="announcement" ${editNotice != null && editNotice.type == 'announcement' ? 'selected' : ''}>ঘোষণা</option>
                        <option value="warning" ${editNotice != null && editNotice.type == 'warning' ? 'selected' : ''}>সতর্কতা</option>
                    </select>
                </div>
            </div>
            <div class="form-row">
                <div class="input-group">
                    <label>বিস্তারিত <span class="required">*</span></label>
                    <textarea name="content" id="noticeContent" rows="4" required placeholder="নোটিশের বিস্তারিত লিখুন">${editNotice != null ? editNotice.content : ''}</textarea>
                </div>
            </div>
            <div class="form-row">
                <div class="input-group">
                    <label>টার্গেট গ্রুপ</label>
                    <select name="targetGroup" id="targetGroup">
                        <option value="all" ${editNotice != null && editNotice.targetGroup == 'all' ? 'selected' : ''}>সব কৃষক</option>
                        <option value="rice" ${editNotice != null && editNotice.targetGroup == 'rice' ? 'selected' : ''}>ধান চাষকারী</option>
                        <option value="wheat" ${editNotice != null && editNotice.targetGroup == 'wheat' ? 'selected' : ''}>গম চাষকারী</option>
                        <option value="vegetables" ${editNotice != null && editNotice.targetGroup == 'vegetables' ? 'selected' : ''}>সবজি চাষকারী</option>
                        <option value="fruits" ${editNotice != null && editNotice.targetGroup == 'fruits' ? 'selected' : ''}>ফল চাষকারী</option>
                    </select>
                </div>
                <div class="input-group">
                    <label>মেয়াদ</label>
                    <select name="expiry">
                        <option value="1" ${editNotice != null && editNotice.expiry == 1 ? 'selected' : ''}>১ দিন</option>
                        <option value="3" ${editNotice != null && editNotice.expiry == 3 ? 'selected' : ''}>৩ দিন</option>
                        <option value="7" ${editNotice != null && editNotice.expiry == 7 ? 'selected' : ''}>১ সপ্তাহ</option>
                        <option value="30" ${editNotice != null && editNotice.expiry == 30 ? 'selected' : ''}>১ মাস</option>
                        <option value="0" ${editNotice != null && editNotice.expiry == 0 ? 'selected' : ''}>অসীমিত</option>
                    </select>
                </div>
            </div>
            <div class="form-actions">
                <button type="submit" class="btn-primary">
                    <i class="fas fa-paper-plane"></i> 
                    <c:choose>
                        <c:when test="${editNotice != null}">নোটিশ আপডেট করুন</c:when>
                        <c:otherwise>নোটিশ প্রকাশ করুন</c:otherwise>
                    </c:choose>
                </button>





                <c:if test="${editNotice != null}">
                    <a href="${pageContext.request.contextPath}/admin/notices" class="btn-secondary">
                        <i class="fas fa-times"></i> বাতিল করুন
                    </a>
                </c:if>
            </div>
        </form>
        

    </div>

    <!-- Search and Filter -->
    <div class="content-area">
        <h3><i class="fas fa-search"></i> অনুসন্ধান ও ফিল্টার</h3>
        <div class="search-filter-form">
            <div class="form-row">
                <div class="input-group">
                    <label>শিরোনাম দিয়ে অনুসন্ধান</label>
                    <input type="text" id="noticeTitleSearch" placeholder="নোটিশের শিরোনাম লিখুন..." class="search-input">
                </div>
                <div class="input-group">
                    <label>ধরন</label>
                    <select id="noticeTypeFilter" class="filter-select">
                        <option value="">সব ধরন</option>
                        <option value="general">সাধারণ</option>
                        <option value="important">গুরুত্বপূর্ণ</option>
                        <option value="urgent">জরুরি</option>
                        <option value="announcement">ঘোষণা</option>
                        <option value="warning">সতর্কতা</option>
                    </select>
                </div>
                <div class="input-group">
                    <label>তারিখ</label>
                    <select id="dateFilter" class="filter-select">
                        <option value="">সব তারিখ</option>
                        <option value="today">আজ</option>
                        <option value="week">এই সপ্তাহ</option>
                        <option value="month">এই মাস</option>
                        <option value="year">এই বছর</option>
                    </select>
                </div>
            </div>
            <div class="form-actions">
                <button type="button" id="searchBtn" class="btn-primary">
                    <i class="fas fa-search"></i> অনুসন্ধান করুন
                </button>
                <button type="button" id="resetBtn" class="btn-secondary">
                    <i class="fas fa-undo"></i> রিসেট করুন
                </button>
            </div>
        </div>
    </div>

    <!-- Notices List -->
    <div class="content-area">
        <h3><i class="fas fa-list"></i> প্রকাশিত নোটিশসমূহ</h3>
        
        <c:if test="${empty notices}">
            <div class="empty-state">
                <i class="fas fa-bullhorn"></i>
                <h3>কোন নোটিশ নেই</h3>
                <p>এখনও কোন নোটিশ প্রকাশ করা হয়নি। প্রথম নোটিশ যোগ করুন।</p>
            </div>
        </c:if>
        
        <c:if test="${notices != null && not empty notices}">
            <div class="table-container">
                <table class="styled-table" id="noticesTable">
                    <thead>
                        <tr>
                            <th>শিরোনাম</th>
                            <th>ধরন</th>
                            <th>টার্গেট গ্রুপ</th>
                            <th>প্রকাশের তারিখ</th>
                            <th>মেয়াদ</th>
                            <th>স্ট্যাটাস</th>
                            <th>পদক্ষেপ</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="notice" items="${notices}">
                            <tr class="notice-row notice-${notice.type != null ? notice.type : 'general'}">
                                <td>
                                    <div class="notice-info">
                                        <div class="notice-title">
                                            <i class="fas fa-bullhorn"></i>
                                            <span>${notice.title != null ? notice.title : 'No Title'}</span>
                                            <c:if test="${notice.type == 'important' || notice.type == 'urgent'}">
                                                <i class="fas fa-star important-star" title="গুরুত্বপূর্ণ"></i>
                                            </c:if>
                                        </div>
                                        <div class="notice-preview">
                                            <c:choose>
                                                <c:when test="${notice.content != null && notice.content.length() > 100}">
                                                    ${notice.content.substring(0, 100)}...
                                                </c:when>
                                                <c:when test="${notice.content != null}">
                                                    ${notice.content}
                                                </c:when>
                                                <c:otherwise>
                                                    কোন বিবরণ নেই
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <span class="notice-type-badge notice-type-${notice.type != null ? notice.type : 'general'}">
                                        ${notice.type != null ? notice.type : 'সাধারণ'}
                                    </span>
                                </td>
                                <td>
                                    <span class="target-group">${notice.targetGroup != null ? notice.targetGroup : 'সব কৃষক'}</span>
                                </td>
                                <td>
                                    <span class="date-cell">
                                        <c:choose>
                                            <c:when test="${notice.createdAt != null}">
                                                ${notice.createdAt.toLocalDateTime().toLocalDate().toString()}
                                            </c:when>
                                            <c:otherwise>N/A</c:otherwise>
                                        </c:choose>
                                    </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${notice.expiry == 0}">
                                            <span class="expiry unlimited">অসীমিত</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="expiry">${notice.expiry != null ? notice.expiry : 30} দিন</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${notice.isExpired()}">
                                            <span class="status-badge status-expired">মেয়াদ শেষ</span>
                                        </c:when>
                                        <c:when test="${notice.isActive()}">
                                            <span class="status-badge status-active">সক্রিয়</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-inactive">নিষ্ক্রিয়</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <a href="${pageContext.request.contextPath}/admin/notices/view/${notice.id}" 
                                           class="action-btn btn-view" data-tooltip="দেখুন">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/notices/edit/${notice.id}" 
                                           class="action-btn btn-edit" data-tooltip="সম্পাদনা করুন">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/notices/delete/${notice.id}" 
                                           class="action-btn btn-delete" data-tooltip="মুছুন"
                                           onclick="return confirm('আপনি কি নিশ্চিত যে আপনি এই নোটিশটি মুছতে চান?')">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
    </div>
</div>

<!-- Notice View Modal (if viewing a notice) -->
<c:if test="${viewNotice != null}">
    <div class="modal-overlay" id="noticeViewModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3><i class="fas fa-bullhorn"></i> নোটিশের বিবরণ</h3>
                <button class="modal-close" onclick="closeNoticeViewModal()">&times;</button>
            </div>
            <div class="modal-body">
                <div class="notice-details">
                    <div class="detail-row">
                        <label>শিরোনাম:</label>
                        <span>${viewNotice.title != null ? viewNotice.title : 'No Title'}</span>
                    </div>
                    <div class="detail-row">
                        <label>ধরন:</label>
                        <span class="notice-type-badge notice-type-${viewNotice.type != null ? viewNotice.type : 'general'}">
                            ${viewNotice.type != null ? viewNotice.type : 'সাধারণ'}
                        </span>
                    </div>
                    <div class="detail-row">
                        <label>টার্গেট গ্রুপ:</label>
                        <span>${viewNotice.targetGroup != null ? viewNotice.targetGroup : 'সব কৃষক'}</span>
                    </div>
                    <div class="detail-row">
                        <label>বিস্তারিত:</label>
                        <span>${viewNotice.content != null ? viewNotice.content : 'কোন বিবরণ নেই'}</span>
                    </div>
                    <div class="detail-row">
                        <label>মেয়াদ:</label>
                        <span>
                            <c:choose>
                                <c:when test="${viewNotice.expiry == 0}">অসীমিত</c:when>
                                <c:otherwise>${viewNotice.expiry != null ? viewNotice.expiry : 30} দিন</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <div class="detail-row">
                        <label>প্রকাশের তারিখ:</label>
                        <span>
                            <c:choose>
                                <c:when test="${viewNotice.createdAt != null}">
                                    ${viewNotice.createdAt.toLocalDateTime().toLocalDate().toString()}
                                </c:when>
                                <c:otherwise>N/A</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <div class="detail-row">
                        <label>স্ট্যাটাস:</label>
                        <span>
                            <c:choose>
                                <c:when test="${viewNotice.isExpired()}">
                                    <span class="status-badge status-expired">মেয়াদ শেষ</span>
                                </c:when>
                                <c:when test="${viewNotice.isActive()}">
                                    <span class="status-badge status-active">সক্রিয়</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-badge status-inactive">নিষ্ক্রিয়</span>
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <a href="${pageContext.request.contextPath}/admin/notices/edit/${viewNotice.id}" class="btn-primary">
                    <i class="fas fa-edit"></i> সম্পাদনা করুন
                </a>
                <button class="btn-secondary" onclick="closeNoticeViewModal()">বন্ধ করুন</button>
            </div>
        </div>
    </div>
</c:if>

<!-- Notice Templates -->
<div class="content-area">
    <h3><i class="fas fa-file-alt"></i> নোটিশ টেমপ্লেট</h3>
    <div class="templates-grid">
        <div class="template-card">
            <div class="template-header">
                <i class="fas fa-exclamation-triangle"></i>
                <h4>জরুরি সতর্কতা</h4>
            </div>
            <div class="template-content">
                <p>আবহাওয়া সতর্কতা, রোগ সতর্কতা, বা জরুরি পরিস্থিতি সম্পর্কিত নোটিশের জন্য</p>
            </div>
            <button type="button" class="btn-primary" onclick="useTemplate('urgent')">
                <i class="fas fa-plus"></i> ব্যবহার করুন
            </button>
        </div>
        
        <div class="template-card">
            <div class="template-header">
                <i class="fas fa-calendar-alt"></i>
                <h4>মৌসুমি নির্দেশনা</h4>
            </div>
            <div class="template-content">
                <p>চাষের মৌসুম, রোপণ সময়, বা কৃষি নির্দেশনার জন্য</p>
            </div>
            <button type="button" class="btn-primary" onclick="useTemplate('seasonal')">
                <i class="fas fa-plus"></i> ব্যবহার করুন
            </button>
        </div>
        
        <div class="template-card">
            <div class="template-header">
                <i class="fas fa-graduation-cap"></i>
                <h4>কৃষি শিক্ষা</h4>
            </div>
            <div class="template-content">
                <p>নতুন কৃষি প্রযুক্তি, প্রশিক্ষণ, বা শিক্ষামূলক তথ্যের জন্য</p>
            </div>
            <button type="button" class="btn-primary" onclick="useTemplate('educational')">
                <i class="fas fa-plus"></i> ব্যবহার করুন
            </button>
        </div>
        
        <div class="template-card">
            <div class="template-header">
                <i class="fas fa-handshake"></i>
                <h4>সহযোগিতা</h4>
            </div>
            <div class="template-content">
                <p>সরকারি সহায়তা, বাজার তথ্য, বা সহযোগিতামূলক কর্মসূচির জন্য</p>
            </div>
            <button type="button" class="btn-primary" onclick="useTemplate('cooperation')">
                <i class="fas fa-plus"></i> ব্যবহার করুন
            </button>
        </div>
    </div>
</div>

<script>
// Show notice view modal if viewing a notice
document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('noticeViewModal').style.display = 'flex';
});

// Close notice view modal
function closeNoticeViewModal() {
    document.getElementById('noticeViewModal').style.display = 'none';
}





// Live Preview Functionality - Disabled to fix JavaScript errors
function updateLivePreview() {
    // Function disabled to prevent JavaScript errors
    return;
}

function getTypeText(type) {
    const typeMap = {
        'general': 'সাধারণ',
        'important': 'গুরুত্বপূর্ণ',
        'urgent': 'জরুরি',
        'announcement': 'ঘোষণা',
        'warning': 'সতর্কতা'
    };
    return typeMap[type] || 'সাধারণ';
}

function getTargetGroupText(targetGroup) {
    const targetMap = {
        'all': 'সব কৃষক',
        'rice': 'ধান চাষকারী',
        'wheat': 'গম চাষকারী',
        'vegetables': 'সবজি চাষকারী',
        'fruits': 'ফল চাষকারী'
    };
    return targetMap[targetGroup] || 'সব কৃষক';
}

// Enhanced search and filter functionality
document.addEventListener('DOMContentLoaded', function() {
    // Initialize live preview
    const titleInput = document.getElementById('noticeTitle');
    const contentInput = document.getElementById('noticeContent');
    const typeSelect = document.getElementById('noticeType');
    const targetSelect = document.getElementById('targetGroup');
    
    if (titleInput) titleInput.addEventListener('input', updateLivePreview);
    if (contentInput) contentInput.addEventListener('input', updateLivePreview);
    if (typeSelect) typeSelect.addEventListener('change', updateLivePreview);
    if (targetSelect) targetSelect.addEventListener('change', updateLivePreview);
    
    // Enhanced search and filter functionality
    const searchInput = document.getElementById('noticeTitleSearch');
    const typeFilter = document.getElementById('noticeTypeFilter');
    const dateFilter = document.getElementById('dateFilter');
    const searchBtn = document.getElementById('searchBtn');
    const resetBtn = document.getElementById('resetBtn');
    const noticesTable = document.getElementById('noticesTable');
    
    if (searchBtn) {
        searchBtn.addEventListener('click', function() {
            performSearch();
        });
    }
    
    if (resetBtn) {
        resetBtn.addEventListener('click', function() {
            resetFilters();
        });
    }
    
    // Real-time search as user types
    if (searchInput) {
        searchInput.addEventListener('input', function() {
            performSearch();
        });
    }
    
    // Filter on change
    if (typeFilter) {
        typeFilter.addEventListener('change', function() {
            performSearch();
        });
    }
    
    if (dateFilter) {
        dateFilter.addEventListener('change', function() {
            performSearch();
        });
    }
    
    function performSearch() {
        const searchTerm = searchInput ? searchInput.value.toLowerCase() : '';
        const selectedType = typeFilter ? typeFilter.value : '';
        const selectedDate = dateFilter ? dateFilter.value : '';
        
        const rows = noticesTable ? noticesTable.querySelectorAll('tbody tr') : [];
        
        rows.forEach(row => {
            let showRow = true;
            
            // Search by title
            if (searchTerm) {
                const title = row.querySelector('.notice-title span')?.textContent.toLowerCase() || '';
                const content = row.querySelector('.notice-preview')?.textContent.toLowerCase() || '';
                if (!title.includes(searchTerm) && !content.includes(searchTerm)) {
                    showRow = false;
                }
            }
            
            // Filter by type
            if (selectedType && showRow) {
                const type = row.querySelector('.notice-type-badge')?.textContent.toLowerCase() || '';
                if (type !== selectedType.toLowerCase()) {
                    showRow = false;
                }
            }
            
            // Filter by date (simplified implementation)
            if (selectedDate && showRow) {
                const dateCell = row.querySelector('.date-cell')?.textContent || '';
                // This is a simplified date filter - you can enhance it based on your needs
                if (selectedDate === 'today') {
                    const today = new Date().toISOString().split('T')[0];
                    if (!dateCell.includes(today)) {
                        showRow = false;
                    }
                }
            }
            
            row.style.display = showRow ? '' : 'none';
        });
        
        // Show/hide empty state
        const visibleRows = Array.from(rows).filter(row => row.style.display !== 'none');
        const emptyState = document.querySelector('.empty-state');
        if (emptyState) {
            if (visibleRows.length === 0 && (searchTerm || selectedType || selectedDate)) {
                emptyState.style.display = 'block';
                emptyState.innerHTML = `
                    <i class="fas fa-search"></i>
                    <h3>কোন ফলাফল পাওয়া যায়নি</h3>
                    <p>আপনার অনুসন্ধানের সাথে মিলে এমন কোন নোটিশ পাওয়া যায়নি।</p>
                `;
            } else if (visibleRows.length === 0) {
                emptyState.style.display = 'block';
                emptyState.innerHTML = `
                    <i class="fas fa-bullhorn"></i>
                    <h3>কোন নোটিশ নেই</h3>
                    <p>এখনও কোন নোটিশ প্রকাশ করা হয়নি। প্রথম নোটিশ যোগ করুন।</p>
                `;
            } else {
                emptyState.style.display = 'none';
            }
        }
    }
    
    function resetFilters() {
        if (searchInput) searchInput.value = '';
        if (typeFilter) typeFilter.value = '';
        if (dateFilter) dateFilter.value = '';
        performSearch();
    }
    
    // Enhanced table interactions
    if (noticesTable) {
        const rows = noticesTable.querySelectorAll('tbody tr');
        rows.forEach(row => {
            row.addEventListener('click', function(e) {
                // Don't trigger if clicking on action buttons
                if (e.target.closest('.action-buttons')) {
                    return;
                }
                
                // Add visual feedback
                rows.forEach(r => r.classList.remove('selected'));
                this.classList.add('selected');
            });
        });
    }
});

// Enhanced form validation
document.addEventListener('DOMContentLoaded', function() {
    const form = document.querySelector('.quick-notice-form');
    if (form) {
        form.addEventListener('submit', function(e) {
            const title = form.querySelector('input[name="title"]');
            const content = form.querySelector('textarea[name="content"]');
            
            if (!title.value.trim()) {
                e.preventDefault();
                alert('শিরোনাম প্রয়োজনীয়');
                title.focus();
                return false;
            }
            
            if (!content.value.trim()) {
                e.preventDefault();
                alert('বিস্তারিত প্রয়োজনীয়');
                content.focus();
                return false;
            }
        });
    }
});

// Enhanced modal functionality
function closeNoticeViewModal() {
    const modal = document.getElementById('noticeViewModal');
    if (modal) {
        modal.style.display = 'none';
        // Remove modal backdrop click handler
        modal.onclick = null;
    }
}

// Add modal backdrop click to close
document.addEventListener('DOMContentLoaded', function() {
    const modal = document.getElementById('noticeViewModal');
    if (modal) {
        modal.addEventListener('click', function(e) {
            if (e.target === modal) {
                closeNoticeViewModal();
            }
        });
    }
    
    // Initialize live preview
    const titleInput = document.getElementById('noticeTitle');
    const contentInput = document.getElementById('noticeContent');
    const typeSelect = document.getElementById('noticeType');
    const targetSelect = document.getElementById('targetGroup');
    
    if (titleInput) titleInput.addEventListener('input', updateLivePreview);
    if (contentInput) contentInput.addEventListener('input', updateLivePreview);
    if (typeSelect) typeSelect.addEventListener('change', updateLivePreview);
    if (targetSelect) targetSelect.addEventListener('change', updateLivePreview);
    
    // Enhanced search functionality
    const searchBtn = document.getElementById('searchBtn');
    const resetBtn = document.getElementById('resetBtn');
    
    if (searchBtn) {
        searchBtn.addEventListener('click', function() {
            performSearch();
        });
    }
    
    if (resetBtn) {
        resetBtn.addEventListener('click', function() {
            resetSearch();
        });
    }
    
    // Add loading states to buttons
    const submitBtn = document.querySelector('button[type="submit"]');
    if (submitBtn) {
        submitBtn.addEventListener('click', function() {
            this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> প্রক্রিয়াকরণ হচ্ছে...';
            this.disabled = true;
        });
    }
});



function performSearch() {
    const titleSearch = document.getElementById('noticeTitleSearch').value;
    const typeFilter = document.getElementById('noticeTypeFilter').value;
    const dateFilter = document.getElementById('dateFilter').value;
    
    // Implement search logic here
    console.log('Searching for:', { titleSearch, typeFilter, dateFilter });
    
    // Show loading state
    const searchBtn = document.getElementById('searchBtn');
    searchBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> অনুসন্ধান হচ্ছে...';
    searchBtn.disabled = true;
    
    // Simulate search delay
    setTimeout(() => {
        searchBtn.innerHTML = '<i class="fas fa-search"></i> অনুসন্ধান করুন';
        searchBtn.disabled = false;
    }, 1000);
}

function resetSearch() {
    document.getElementById('noticeTitleSearch').value = '';
    document.getElementById('noticeTypeFilter').value = '';
    document.getElementById('dateFilter').value = '';
    
    // Reset table to show all notices
    console.log('Search reset');
}

// Enhanced table interactions
function enhanceTableInteractions() {
    const tableRows = document.querySelectorAll('.styled-table tbody tr');
    
    tableRows.forEach(row => {
        row.addEventListener('click', function() {
            // Remove active class from all rows
            tableRows.forEach(r => r.classList.remove('active-row'));
            // Add active class to clicked row
            this.classList.add('active-row');
        });
    });
}

// Initialize table interactions when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    enhanceTableInteractions();
});

// Simple form validation
function validateAndSubmitForm(event) {
    const title = document.getElementById('noticeTitle').value.trim();
    const content = document.getElementById('noticeContent').value.trim();
    
    if (!title) {
        alert('শিরোনাম প্রয়োজনীয়');
        document.getElementById('noticeTitle').focus();
        return false;
    }
    
    if (!content) {
        alert('বিস্তারিত প্রয়োজনীয়');
        document.getElementById('noticeContent').focus();
        return false;
    }
    
    // Show loading state
    const submitBtn = document.querySelector('button[type="submit"]');
    if (submitBtn) {
        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> প্রক্রিয়াকরণ হচ্ছে...';
        submitBtn.disabled = true;
    }
    
    return true;
}


</script>

<jsp:include page="/WEB-INF/includes/admin_footer.jsp" />
