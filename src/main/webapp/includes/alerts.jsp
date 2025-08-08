<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="alerts-container">
    <% if (session.getAttribute("message") != null) { %>
        <div class="alert alert-success">
            <i class="fas fa-check-circle"></i>
            <%= session.getAttribute("message") %>
        </div>
        <% session.removeAttribute("message"); %>
    <% } %>
    
    <% if (session.getAttribute("errorMessage") != null) { %>
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle"></i>
            <%= session.getAttribute("errorMessage") %>
        </div>
        <% session.removeAttribute("errorMessage"); %>
    <% } %>
</div>
