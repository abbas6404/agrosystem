package com.mycompany.agrosystem.controller;

import com.mycompany.agrosystem.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.logging.Logger;
import java.util.logging.Level;

@WebServlet("/test")
public class TestServlet extends HttpServlet {
    
    private static final Logger logger = Logger.getLogger(TestServlet.class.getName());
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().println("<html><body>");
        response.getWriter().println("<h1>Database Test Results</h1>");
        
        try {
            // Test database connection
            response.getWriter().println("<h2>Testing Database Connection...</h2>");
            Connection conn = DBConnection.getConnection();
            
            if (conn != null) {
                response.getWriter().println("<p style='color: green;'>✓ Database connection successful!</p>");
                
                // Test basic query
                response.getWriter().println("<h2>Testing Basic Queries...</h2>");
                
                // Test users table
                try (Statement stmt = conn.createStatement()) {
                    ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as count FROM users");
                    if (rs.next()) {
                        int userCount = rs.getInt("count");
                        response.getWriter().println("<p>✓ Users table: " + userCount + " records found</p>");
                    }
                }
                
                // Test farmers table
                try (Statement stmt = conn.createStatement()) {
                    ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as count FROM farmers");
                    if (rs.next()) {
                        int farmerCount = rs.getInt("count");
                        response.getWriter().println("<p>✓ Farmers table: " + farmerCount + " records found</p>");
                    }
                }
                
                // Test crops table
                try (Statement stmt = conn.createStatement()) {
                    ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as count FROM crops");
                    if (rs.next()) {
                        int cropCount = rs.getInt("count");
                        response.getWriter().println("<p>✓ Crops table: " + cropCount + " records found</p>");
                    }
                }
                
                // Test farmer_crops table
                try (Statement stmt = conn.createStatement()) {
                    ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as count FROM farmer_crops");
                    if (rs.next()) {
                        int farmerCropCount = rs.getInt("count");
                        response.getWriter().println("<p>✓ Farmer_crops table: " + farmerCropCount + " records found</p>");
                    }
                }
                
                // Test sample data from users table
                response.getWriter().println("<h2>Sample Users Data:</h2>");
                try (Statement stmt = conn.createStatement()) {
                    ResultSet rs = stmt.executeQuery("SELECT id, name, phone_number, user_type, created_at FROM users LIMIT 5");
                    response.getWriter().println("<table border='1' style='border-collapse: collapse;'>");
                    response.getWriter().println("<tr><th>ID</th><th>Name</th><th>Phone</th><th>Type</th><th>Created At</th></tr>");
                    while (rs.next()) {
                        response.getWriter().println("<tr>");
                        response.getWriter().println("<td>" + rs.getInt("id") + "</td>");
                        response.getWriter().println("<td>" + rs.getString("name") + "</td>");
                        response.getWriter().println("<td>" + rs.getString("phone_number") + "</td>");
                        response.getWriter().println("<td>" + rs.getString("user_type") + "</td>");
                        response.getWriter().println("<td>" + rs.getTimestamp("created_at") + "</td>");
                        response.getWriter().println("</tr>");
                    }
                    response.getWriter().println("</table>");
                }
                
                // Test sample data from farmers table
                response.getWriter().println("<h2>Sample Farmers Data:</h2>");
                try (Statement stmt = conn.createStatement()) {
                    ResultSet rs = stmt.executeQuery("SELECT f.user_id, u.name, f.location, f.land_size_acres FROM farmers f JOIN users u ON f.user_id = u.id LIMIT 5");
                    response.getWriter().println("<table border='1' style='border-collapse: collapse;'>");
                    response.getWriter().println("<tr><th>User ID</th><th>Name</th><th>Location</th><th>Land Size</th></tr>");
                    while (rs.next()) {
                        response.getWriter().println("<tr>");
                        response.getWriter().println("<td>" + rs.getInt("user_id") + "</td>");
                        response.getWriter().println("<td>" + rs.getString("name") + "</td>");
                        response.getWriter().println("<td>" + rs.getString("location") + "</td>");
                        response.getWriter().println("<td>" + rs.getDouble("land_size_acres") + "</td>");
                        response.getWriter().println("</tr>");
                    }
                    response.getWriter().println("</table>");
                }
                
                conn.close();
                response.getWriter().println("<p style='color: green;'>✓ All tests completed successfully!</p>");
                
            } else {
                response.getWriter().println("<p style='color: red;'>✗ Database connection failed!</p>");
            }
            
        } catch (Exception e) {
            response.getWriter().println("<p style='color: red;'>✗ Error during testing: " + e.getMessage() + "</p>");
            e.printStackTrace(response.getWriter());
            logger.log(Level.SEVERE, "Error during database testing", e);
        }
        
        response.getWriter().println("<br><a href='javascript:history.back()'>Go Back</a>");
        response.getWriter().println("</body></html>");
    }
}
