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
                crops.add(crop);
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        } finally {
            DBConnection.closeConnection(conn);
        }
        return crops;
    }

    public boolean addCrop(String cropName, String description) {
        String sql = "INSERT INTO crops (name, description) VALUES (?, ?)";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, cropName);
            ps.setString(2, description);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { 
            e.printStackTrace(); 
            return false; 
        } finally {
            DBConnection.closeConnection(conn);
        }
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
        
        String insertSql = "INSERT INTO crops (name) VALUES (?)";
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
                Notice notice = new Notice();
                notice.setId(rs.getInt("id"));
                notice.setTitle(rs.getString("title"));
                notice.setContent(rs.getString("content"));
                notice.setCreatedAt(rs.getTimestamp("created_at"));
                notices.add(notice);
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        } finally {
            DBConnection.closeConnection(conn);
        }
        return notices;
    }

    public boolean addNotice(String title, String content, int adminId) {
        String sql = "INSERT INTO notices (title, content, created_by_admin_id) VALUES (?, ?, ?)";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, title);
            ps.setString(2, content);
            ps.setInt(3, adminId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { 
            e.printStackTrace(); 
            return false; 
        } finally {
            DBConnection.closeConnection(conn);
        }
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
}