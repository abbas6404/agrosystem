package com.mycompany.agrosystem.dao;

import com.mycompany.agrosystem.model.Crop;
import com.mycompany.agrosystem.model.Notice;
import com.mycompany.agrosystem.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

/**
 * Handles all database operations for master data like Crops and Notices.
 */
public class ContentDAO {

    // --- Crop Management Methods (for Admin) ---
    public List<Crop> getAllCrops() {
        List<Crop> crops = new ArrayList<>();
        String sql = "SELECT * FROM crops ORDER BY name";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Crop crop = new Crop();
                crop.setId(rs.getInt("id"));
                crop.setName(rs.getString("name"));
                crop.setDescription(rs.getString("description"));
                crop.setType(rs.getString("type"));
                crop.setSeason(rs.getString("season"));
                
                // Handle created_at field
                java.sql.Timestamp createdAt = rs.getTimestamp("created_at");
                if (createdAt != null) {
                    crop.setCreatedAt(createdAt.toLocalDateTime());
                }
                
                crops.add(crop);
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        } finally {
            DBConnection.closeConnection(conn);
        }
        return crops;
    }

    public boolean addCrop(String cropName, String description, String type, String season) {
        String sql = "INSERT INTO crops (name, description, type, season, created_at) VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, cropName);
            ps.setString(2, description);
            ps.setString(3, type);
            ps.setString(4, season);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { 
            e.printStackTrace(); 
            return false; 
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    public boolean updateCrop(int cropId, String cropName, String description, String type, String season) {
        String sql = "UPDATE crops SET name = ?, description = ?, type = ?, season = ? WHERE id = ?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, cropName);
            ps.setString(2, description);
            ps.setString(3, type);
            ps.setString(4, season);
            ps.setInt(5, cropId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { 
            e.printStackTrace(); 
            return false; 
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    public Crop getCropById(int cropId) {
        String sql = "SELECT * FROM crops WHERE id = ?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, cropId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Crop crop = new Crop();
                crop.setId(rs.getInt("id"));
                crop.setName(rs.getString("name"));
                crop.setDescription(rs.getString("description"));
                crop.setType(rs.getString("type"));
                crop.setSeason(rs.getString("season"));
                
                // Handle created_at field
                java.sql.Timestamp createdAt = rs.getTimestamp("created_at");
                if (createdAt != null) {
                    crop.setCreatedAt(createdAt.toLocalDateTime());
                }
                
                return crop;
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        } finally {
            DBConnection.closeConnection(conn);
        }
        return null;
    }

    public boolean deleteCrop(int cropId) {
        String sql = "DELETE FROM crops WHERE id = ?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, cropId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { 
            e.printStackTrace(); 
            return false; 
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // --- Farmer's Crop Selection Methods ---
    private int findOrCreateCrop(String cropName, Connection conn) throws SQLException {
        String findSql = "SELECT id FROM crops WHERE name = ?";
        try (PreparedStatement findPs = conn.prepareStatement(findSql)) {
            findPs.setString(1, cropName);
            ResultSet rs = findPs.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }
        }
        
        String insertSql = "INSERT INTO crops (name, created_at) VALUES (?, CURRENT_TIMESTAMP)";
        try (PreparedStatement insertPs = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
            insertPs.setString(1, cropName);
            insertPs.executeUpdate();
            ResultSet generatedKeys = insertPs.getGeneratedKeys();
            if (generatedKeys.next()) {
                return generatedKeys.getInt(1);
            }
        }
        throw new SQLException("Creating crop failed, no ID obtained.");
    }

    public boolean addCropToFarmer(int farmerId, String cropName) {
        String checkLinkSql = "SELECT id FROM farmer_crops WHERE farmer_user_id = ? AND crop_id = ?";
        String insertLinkSql = "INSERT INTO farmer_crops (farmer_user_id, crop_id) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection()) {
            int cropId = findOrCreateCrop(cropName, conn);
            
            try (PreparedStatement checkPs = conn.prepareStatement(checkLinkSql)) {
                checkPs.setInt(1, farmerId);
                checkPs.setInt(2, cropId);
                if (checkPs.executeQuery().next()) {
                    return true; // Already exists
                }
            }
            
            try (PreparedStatement insertLinkPs = conn.prepareStatement(insertLinkSql)) {
                insertLinkPs.setInt(1, farmerId);
                insertLinkPs.setInt(2, cropId);
                return insertLinkPs.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // --- Notice Board Methods ---
    public List<Notice> getRecentNotices(int limit) {
        List<Notice> notices = new ArrayList<>();
        String sql = "SELECT * FROM notices ORDER BY created_at DESC LIMIT ?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Notice notice = mapResultSetToNotice(rs);
                notices.add(notice);
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        } finally {
            DBConnection.closeConnection(conn);
        }
        return notices;
    }

    public List<Notice> getAllNotices() {
        List<Notice> notices = new ArrayList<>();
        String sql = "SELECT * FROM notices ORDER BY created_at DESC";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Notice notice = mapResultSetToNotice(rs);
                notices.add(notice);
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        } finally {
            DBConnection.closeConnection(conn);
        }
        return notices;
    }

    public Notice getNoticeById(int noticeId) {
        String sql = "SELECT * FROM notices WHERE id = ?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, noticeId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToNotice(rs);
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        } finally {
            DBConnection.closeConnection(conn);
        }
        return null;
    }

    public boolean addNotice(String title, String content, String type, String targetGroup, int expiry, int adminId) {
        String sql = "INSERT INTO notices (title, content, type, target_group, expiry, created_by_admin_id, created_at) VALUES (?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                System.err.println("Database connection failed");
                return false;
            }
            
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, title);
            ps.setString(2, content);
            ps.setString(3, type != null ? type : "general");
            ps.setString(4, targetGroup != null ? targetGroup : "all");
            ps.setInt(5, expiry);
            ps.setInt(6, adminId);
            
            int result = ps.executeUpdate();
            System.out.println("Notice added successfully. Rows affected: " + result);
            return result > 0;
        } catch (SQLException e) { 
            System.err.println("Error adding notice: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    public boolean updateNotice(int noticeId, String title, String content, String type, String targetGroup, int expiry) {
        // Try the new schema first
        String sql = "UPDATE notices SET title = ?, content = ?, type = ?, target_group = ?, expiry = ? WHERE id = ?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, title);
            ps.setString(2, content);
            ps.setString(3, type != null ? type : "general");
            ps.setString(4, targetGroup != null ? targetGroup : "all");
            ps.setInt(5, expiry);
            ps.setInt(6, noticeId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { 
            // If new columns don't exist, try the old schema
            try {
                sql = "UPDATE notices SET title = ?, content = ? WHERE id = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, title);
                ps.setString(2, content);
                ps.setInt(3, noticeId);
                return ps.executeUpdate() > 0;
            } catch (SQLException e2) {
                e2.printStackTrace();
                return false;
            }
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    public boolean deleteNotice(int noticeId) {
        String sql = "DELETE FROM notices WHERE id = ?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, noticeId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { 
            e.printStackTrace(); 
            return false; 
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    public int getNoticeCount() {
        String sql = "SELECT COUNT(*) FROM notices";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn);
        }
        return 0;
    }

    public int getMonthlyNoticeCount() {
        String sql = "SELECT COUNT(*) FROM notices WHERE MONTH(created_at) = MONTH(CURRENT_DATE()) AND YEAR(created_at) = YEAR(CURRENT_DATE())";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn);
        }
        return 0;
    }

    public int getImportantNoticeCount() {
        String sql = "SELECT COUNT(*) FROM notices WHERE type IN ('important', 'urgent')";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            // If type column doesn't exist, return 0
            return 0;
        } finally {
            DBConnection.closeConnection(conn);
        }
        return 0;
    }

    public int getTodayViewCount() {
        // This is a placeholder - in a real system, you'd track views in a separate table
        return 0;
    }

    private Notice mapResultSetToNotice(ResultSet rs) throws SQLException {
        Notice notice = new Notice();
        notice.setId(rs.getInt("id"));
        notice.setTitle(rs.getString("title"));
        notice.setContent(rs.getString("content"));
        
        // Handle new columns that might not exist yet
        try {
            notice.setType(rs.getString("type"));
        } catch (SQLException e) {
            notice.setType("general"); // Default value
        }
        
        try {
            notice.setTargetGroup(rs.getString("target_group"));
        } catch (SQLException e) {
            notice.setTargetGroup("all"); // Default value
        }
        
        try {
            notice.setExpiry(rs.getInt("expiry"));
        } catch (SQLException e) {
            notice.setExpiry(30); // Default value
        }
        
        notice.setCreatedAt(rs.getTimestamp("created_at"));
        
        try {
            notice.setAdminId(rs.getInt("created_by_admin_id"));
        } catch (SQLException e) {
            notice.setAdminId(1); // Default admin ID
        }
        
        return notice;
    }
    
    /**
     * Counts the total number of master crops in the system.
     * @return The total count of crops.
     */
    public int getCropCount() {
        String sql = "SELECT COUNT(id) FROM crops";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn);
        }
        return 0;
    }

    /**
     * Counts the number of farmers who have selected crops.
     * @return The count of farmers with crops.
     */
    public int getFarmerCropCount() {
        String sql = "SELECT COUNT(DISTINCT farmer_user_id) FROM farmer_crops";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn);
        }
        return 0;
    }

    /**
     * Counts the number of crops added in the current month.
     * @return The count of crops added this month.
     */
    public int getMonthlyCropCount() {
        String sql = "SELECT COUNT(id) FROM crops WHERE MONTH(created_at) = MONTH(CURRENT_DATE()) AND YEAR(created_at) = YEAR(CURRENT_DATE())";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn);
        }
        return 0;
    }

    /**
     * Retrieves a list of all crops selected by a specific farmer.
     * @param farmerId The ID of the farmer.
     * @return A list of Crop objects.
     */
    public List<Crop> getFarmerCrops(int farmerId) {
        List<Crop> farmerCrops = new ArrayList<>();
        String sql = "SELECT c.id, c.name, c.description FROM crops c " +
                     "JOIN farmer_crops fc ON c.id = fc.crop_id " +
                     "WHERE fc.farmer_user_id = ?";
        
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            
            ps.setInt(1, farmerId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Crop crop = new Crop();
                crop.setId(rs.getInt("id"));
                crop.setName(rs.getString("name"));
                crop.setDescription(rs.getString("description"));
                farmerCrops.add(crop);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn);
        }
        return farmerCrops;
    }

    // Report-related methods
    public List<Map<String, Object>> getCropsByType() {
        List<Map<String, Object>> result = new ArrayList<>();
        String sql = "SELECT type, COUNT(*) as count FROM crops GROUP BY type ORDER BY count DESC";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("type", rs.getString("type"));
                row.put("count", rs.getInt("count"));
                result.add(row);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn);
        }
        return result;
    }
    
    public List<Map<String, Object>> getCropsBySeason() {
        List<Map<String, Object>> result = new ArrayList<>();
        String sql = "SELECT season, COUNT(*) as count FROM crops GROUP BY season ORDER BY count DESC";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("season", rs.getString("season"));
                row.put("count", rs.getInt("count"));
                result.add(row);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn);
        }
        return result;
    }
    
    public List<Map<String, Object>> getCropTrends(String timePeriod) {
        List<Map<String, Object>> result = new ArrayList<>();
        String sql = "SELECT DATE(c.created_at) as date, COUNT(*) as count FROM crops c WHERE c.created_at >= DATE_SUB(CURRENT_DATE(), INTERVAL ? DAY) GROUP BY DATE(c.created_at) ORDER BY date";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(timePeriod));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("date", rs.getDate("date").toString());
                row.put("count", rs.getInt("count"));
                result.add(row);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn);
        }
        return result;
    }
    
    public List<Map<String, Object>> getSeasonalAnalysis() {
        List<Map<String, Object>> result = new ArrayList<>();
        String sql = "SELECT season, COUNT(*) as crop_count, COUNT(DISTINCT type) as type_count FROM crops GROUP BY season ORDER BY crop_count DESC";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("season", rs.getString("season"));
                row.put("cropCount", rs.getInt("crop_count"));
                row.put("typeCount", rs.getInt("type_count"));
                result.add(row);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn);
        }
        return result;
    }
    
    public List<Map<String, Object>> getCropSeasonDistribution() {
        List<Map<String, Object>> result = new ArrayList<>();
        String sql = "SELECT c.season, c.type, COUNT(*) as count FROM crops c GROUP BY c.season, c.type ORDER BY c.season, count DESC";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("season", rs.getString("season"));
                row.put("type", rs.getString("type"));
                row.put("count", rs.getInt("count"));
                result.add(row);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn);
        }
        return result;
    }
    
    public List<Map<String, Object>> getCropTypeDistribution() {
        List<Map<String, Object>> result = new ArrayList<>();
        String sql = "SELECT type, COUNT(*) as count, GROUP_CONCAT(name SEPARATOR ', ') as crop_names FROM crops GROUP BY type ORDER BY count DESC";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("type", rs.getString("type"));
                row.put("count", rs.getInt("count"));
                row.put("cropNames", rs.getString("crop_names"));
                result.add(row);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn);
        }
        return result;
    }
    
    public List<Map<String, Object>> getCropUsageByFarmers() {
        List<Map<String, Object>> result = new ArrayList<>();
        String sql = "SELECT c.name, c.type, c.season, COUNT(fc.farmer_user_id) as farmer_count FROM crops c LEFT JOIN farmer_crops fc ON c.id = fc.crop_id GROUP BY c.id, c.name, c.type, c.season ORDER BY farmer_count DESC";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("name", rs.getString("name"));
                row.put("type", rs.getString("type"));
                row.put("season", rs.getString("season"));
                row.put("farmerCount", rs.getInt("farmer_count"));
                result.add(row);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn);
        }
        return result;
    }
    
    public List<Map<String, Object>> getNoticeStatistics() {
        List<Map<String, Object>> result = new ArrayList<>();
        String sql = "SELECT type, COUNT(*) as count FROM notices GROUP BY type ORDER BY count DESC";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("type", rs.getString("type"));
                row.put("count", rs.getInt("count"));
                result.add(row);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn);
        }
        return result;
    }
    
    public List<Map<String, Object>> getNoticeTrends(String timePeriod) {
        List<Map<String, Object>> result = new ArrayList<>();
        String sql = "SELECT DATE(created_at) as date, COUNT(*) as count FROM notices WHERE created_at >= DATE_SUB(CURRENT_DATE(), INTERVAL ? DAY) GROUP BY DATE(created_at) ORDER BY date";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(timePeriod));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("date", rs.getDate("date").toString());
                row.put("count", rs.getInt("count"));
                result.add(row);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn);
        }
        return result;
    }
}