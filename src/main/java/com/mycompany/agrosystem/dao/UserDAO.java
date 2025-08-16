// --- File 1: Place this in 'com.mycompany.agrosystem.dao' package ---
// --- File Name: UserDAO.java ---
package com.mycompany.agrosystem.dao;

import com.mycompany.agrosystem.model.Admin;
import com.mycompany.agrosystem.model.Crop;
import com.mycompany.agrosystem.model.Farmer;
import com.mycompany.agrosystem.model.User;
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
 * Handles all database operations related to Users (Farmers and Admins).
 */
public class UserDAO {

    /**
     * Registers a new farmer. On success, returns the newly created Farmer object.
     * @param farmer The Farmer object with registration data.
     * @return The created Farmer object with its new ID, or null on failure.
     */
    public Farmer registerFarmer(Farmer farmer) {
        String insertUserSQL = "INSERT INTO users (name, phone_number, password, user_type, created_at) VALUES (?, ?, ?, 'FARMER', CURRENT_TIMESTAMP)";
        String insertFarmerSQL = "INSERT INTO farmers (user_id, location, land_size_acres, soil_conditions) VALUES (?, ?, ?, ?)";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Start transaction

            PreparedStatement psUser = conn.prepareStatement(insertUserSQL, Statement.RETURN_GENERATED_KEYS);
            psUser.setString(1, farmer.getName());
            psUser.setString(2, farmer.getPhoneNumber());
            psUser.setString(3, farmer.getPassword()); // In a real app, HASH this password
            psUser.executeUpdate();

            ResultSet generatedKeys = psUser.getGeneratedKeys();
            int userId;
            if (generatedKeys.next()) {
                userId = generatedKeys.getInt(1);
                farmer.setId(userId); // Set the new ID to the farmer object
            } else {
                conn.rollback();
                return null;
            }

            PreparedStatement psFarmer = conn.prepareStatement(insertFarmerSQL);
            psFarmer.setInt(1, userId);
            psFarmer.setString(2, farmer.getLocation());
            psFarmer.setDouble(3, farmer.getLandSizeAcres());
            psFarmer.setString(4, farmer.getSoilConditions());
            psFarmer.executeUpdate();

            conn.commit(); // Commit transaction
            return farmer;
        } catch (SQLException e) {
            if (conn != null) { try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); } }
            e.printStackTrace();
            return null;
        } finally {
            if (conn != null) { try { conn.setAutoCommit(true); conn.close(); } catch (SQLException e) { e.printStackTrace(); } }
        }
    }

    /**
     * Authenticates a user and retrieves their full profile.
     * @param phone The user's phone number.
     * @param password The user's password.
     * @return A User object (either Farmer or Admin) if login is successful, otherwise null.
     */
    public User loginUser(String phone, String password) {
        String sql = "SELECT * FROM users WHERE phone_number = ? AND password = ?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, phone);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String userType = rs.getString("user_type");
                int userId = rs.getInt("id");
                if ("FARMER".equals(userType)) {
                    return getFarmerDetails(userId, conn);
                } else if ("ADMIN".equals(userType)) {
                    return getAdminDetails(userId, conn);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn);
        }
        return null;
    }

    private Farmer getFarmerDetails(int userId, Connection conn) throws SQLException {
        String sql = "SELECT u.id, u.name, u.phone_number, u.password, u.created_at, f.location, f.land_size_acres, f.soil_conditions " +
                     "FROM users u JOIN farmers f ON u.id = f.user_id WHERE u.id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Farmer farmer = new Farmer();
                farmer.setId(rs.getInt("id"));
                farmer.setName(rs.getString("name"));
                farmer.setPhoneNumber(rs.getString("phone_number"));
                farmer.setPassword(rs.getString("password")); // Add password field
                farmer.setLocation(rs.getString("location"));
                farmer.setLandSizeAcres(rs.getDouble("land_size_acres"));
                farmer.setSoilConditions(rs.getString("soil_conditions"));
                
                // Handle created_at field
                java.sql.Timestamp createdAt = rs.getTimestamp("created_at");
                if (createdAt != null) {
                    farmer.setCreatedAt(createdAt.toLocalDateTime());
                }
                
                return farmer;
            }
        }
        return null;
    }

    private Admin getAdminDetails(int userId, Connection conn) throws SQLException {
        String sql = "SELECT u.id, u.name, u.phone_number, u.password, u.created_at, a.email, a.experience_years " +
                     "FROM users u JOIN admins a ON u.id = a.user_id WHERE u.id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Admin admin = new Admin();
                admin.setId(rs.getInt("id"));
                admin.setName(rs.getString("name"));
                admin.setPhoneNumber(rs.getString("phone_number"));
                admin.setPassword(rs.getString("password")); // Add password field
                admin.setEmail(rs.getString("email"));
                admin.setExperienceYears(rs.getInt("experience_years"));
                
                // Handle created_at field
                java.sql.Timestamp createdAt = rs.getTimestamp("created_at");
                if (createdAt != null) {
                    admin.setCreatedAt(createdAt.toLocalDateTime());
                }
                
                return admin;
            }
        }
        return null;
    }

    /**
     * Retrieves a list of all farmers for the admin panel.
     * @return A list of Farmer objects.
     */
    public List<Farmer> getAllFarmers() {
        List<Farmer> farmers = new ArrayList<>();
        String sql = "SELECT u.id, u.name, u.phone_number, u.created_at, f.location, f.land_size_acres, f.soil_conditions " +
                     "FROM users u JOIN farmers f ON u.id = f.user_id WHERE u.user_type = 'FARMER' ORDER BY u.name";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Farmer farmer = new Farmer();
                farmer.setId(rs.getInt("id"));
                farmer.setName(rs.getString("name"));
                farmer.setPhoneNumber(rs.getString("phone_number"));
                farmer.setLocation(rs.getString("location"));
                farmer.setLandSizeAcres(rs.getDouble("land_size_acres"));
                farmer.setSoilConditions(rs.getString("soil_conditions"));
                
                // Handle created_at field
                java.sql.Timestamp createdAt = rs.getTimestamp("created_at");
                if (createdAt != null) {
                    farmer.setCreatedAt(createdAt.toLocalDateTime());
                }
                
                // Fetch crops for this farmer
                List<Crop> crops = getFarmerCrops(farmer.getId(), conn);
                farmer.setCrops(crops);
                
                farmers.add(farmer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn);
        }
        return farmers;
    }

    /**
     * Deletes a farmer from the database.
     * @param userId The ID of the user to delete.
     * @return true if deletion was successful, false otherwise.
     */
    public boolean deleteFarmer(int userId) {
        String sql = "DELETE FROM users WHERE id = ? AND user_type = 'FARMER'";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }
    
    /**
     * Counts the total number of registered farmers.
     * @return The total count of farmers.
     */
    public int getFarmerCount() {
        String sql = "SELECT COUNT(id) FROM users WHERE user_type = 'FARMER'";
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
     * Retrieves a single farmer's details by their user ID.
     * @param userId The ID of the farmer to retrieve.
     * @return A Farmer object, or null if not found.
     */
    public Farmer getFarmerById(int userId) {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            return getFarmerDetails(userId, conn);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn);
        }
        return null;
    }

    /**
     * Updates a farmer's profile information in the database.
     * @param farmer The Farmer object with updated information.
     * @return true if the update was successful, false otherwise.
     */
    public boolean updateFarmer(Farmer farmer) {
        String updateUserSql = "UPDATE users SET name = ?, phone_number = ? WHERE id = ?";
        String updateFarmerSql = "UPDATE farmers SET location = ?, land_size_acres = ?, soil_conditions = ? WHERE user_id = ?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Start transaction

            try (PreparedStatement psUser = conn.prepareStatement(updateUserSql)) {
                psUser.setString(1, farmer.getName());
                psUser.setString(2, farmer.getPhoneNumber());
                psUser.setInt(3, farmer.getId());
                psUser.executeUpdate();
            }

            try (PreparedStatement psFarmer = conn.prepareStatement(updateFarmerSql)) {
                psFarmer.setString(1, farmer.getLocation());
                psFarmer.setDouble(2, farmer.getLandSizeAcres());
                psFarmer.setString(3, farmer.getSoilConditions());
                psFarmer.setInt(4, farmer.getId());
                psFarmer.executeUpdate();
            }

            conn.commit(); // Commit transaction
            return true;
        } catch (SQLException e) {
            if (conn != null) { try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); } }
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) { try { conn.setAutoCommit(true); conn.close(); } catch (SQLException e) { e.printStackTrace(); } }
        }
    }
    
    /**
     * Updates a user's password.
     * @param userId The ID of the user whose password to update.
     * @param newPassword The new hashed password.
     * @return true if update was successful, false otherwise.
     */
    public boolean updatePassword(int userId, String newPassword) {
        String sql = "UPDATE users SET password = ? WHERE id = ?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, newPassword);
            ps.setInt(2, userId);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }
    
    /**
     * Gets unique locations from all farmers for filtering purposes.
     * @return List of unique location strings.
     */
    public List<String> getUniqueLocations() {
        List<String> locations = new ArrayList<>();
        String sql = "SELECT DISTINCT location FROM farmers WHERE location IS NOT NULL AND location != '' ORDER BY location";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                locations.add(rs.getString("location"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn);
        }
        return locations;
    }
    
    /**
     * Gets crops for a specific farmer.
     * @param farmerId The ID of the farmer.
     * @param conn The database connection to use.
     * @return List of crops for the farmer.
     */
    private List<Crop> getFarmerCrops(int farmerId, Connection conn) throws SQLException {
        List<Crop> crops = new ArrayList<>();
        String sql = "SELECT c.id, c.name, c.description, c.created_at " +
                     "FROM crops c " +
                     "JOIN farmer_crops fc ON c.id = fc.crop_id " +
                     "WHERE fc.farmer_user_id = ? " +
                     "ORDER BY c.name";
        
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, farmerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Crop crop = new Crop();
                crop.setId(rs.getInt("id"));
                crop.setName(rs.getString("name"));
                crop.setDescription(rs.getString("description"));
                
                // Handle created_at field
                java.sql.Timestamp createdAt = rs.getTimestamp("created_at");
                if (createdAt != null) {
                    crop.setCreatedAt(createdAt.toLocalDateTime());
                }
                
                crops.add(crop);
            }
        }
        return crops;
    }

    // Report-related methods
    public int getTotalFarmers() {
        String sql = "SELECT COUNT(*) FROM users WHERE user_type = 'FARMER'";
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
    
    public int getNewFarmersThisMonth() {
        String sql = "SELECT COUNT(*) FROM users WHERE user_type = 'FARMER' AND MONTH(created_at) = MONTH(CURRENT_DATE()) AND YEAR(created_at) = YEAR(CURRENT_DATE())";
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
    
    public int getActiveFarmers() {
        String sql = "SELECT COUNT(DISTINCT u.id) FROM users u INNER JOIN farmer_crops fc ON u.id = fc.farmer_user_id WHERE u.user_type = 'FARMER'";
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
    
    public double getTotalLandArea() {
        String sql = "SELECT SUM(land_size_acres) FROM farmers";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn);
        }
        return 0.0;
    }
    
    public double getNewLandAreaThisMonth() {
        String sql = "SELECT SUM(f.land_size_acres) FROM farmers f INNER JOIN users u ON f.user_id = u.id WHERE u.user_type = 'FARMER' AND MONTH(u.created_at) = MONTH(CURRENT_DATE()) AND YEAR(u.created_at) = YEAR(CURRENT_DATE())";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn);
        }
        return 0.0;
    }
    
    public double getGrowthRate() {
        // Calculate growth rate based on new registrations this month vs last month
        String sql = "SELECT " +
                    "(SELECT COUNT(*) FROM users WHERE user_type = 'FARMER' AND MONTH(created_at) = MONTH(CURRENT_DATE()) AND YEAR(created_at) = YEAR(CURRENT_DATE())) as current_month, " +
                    "(SELECT COUNT(*) FROM users WHERE user_type = 'FARMER' AND MONTH(created_at) = MONTH(DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH)) AND YEAR(created_at) = YEAR(DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH))) as last_month";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int currentMonth = rs.getInt("current_month");
                int lastMonth = rs.getInt("last_month");
                if (lastMonth > 0) {
                    return ((double)(currentMonth - lastMonth) / lastMonth) * 100;
                } else if (currentMonth > 0) {
                    return 100.0; // 100% growth if no previous data
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn);
        }
        return 0.0;
    }
    
    public List<Map<String, Object>> getFarmersByLocation() {
        List<Map<String, Object>> result = new ArrayList<>();
        String sql = "SELECT location, COUNT(*) as count FROM farmers GROUP BY location ORDER BY count DESC";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("location", rs.getString("location"));
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
    
    public List<Map<String, Object>> getRegistrationTrends(String timePeriod) {
        List<Map<String, Object>> result = new ArrayList<>();
        String sql = "SELECT DATE(created_at) as date, COUNT(*) as count FROM users WHERE user_type = 'FARMER' AND created_at >= DATE_SUB(CURRENT_DATE(), INTERVAL ? DAY) GROUP BY DATE(created_at) ORDER BY date";
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
    
    public List<Map<String, Object>> getLocationDistribution() {
        List<Map<String, Object>> result = new ArrayList<>();
        String sql = "SELECT location, COUNT(*) as farmer_count, SUM(land_size_acres) as total_land FROM farmers GROUP BY location ORDER BY farmer_count DESC";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("location", rs.getString("location"));
                row.put("farmerCount", rs.getInt("farmer_count"));
                row.put("totalLand", rs.getDouble("total_land"));
                result.add(row);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn);
        }
        return result;
    }
    
    public List<Map<String, Object>> getLandAreaByLocation() {
        List<Map<String, Object>> result = new ArrayList<>();
        String sql = "SELECT location, AVG(land_size_acres) as avg_land, MIN(land_size_acres) as min_land, MAX(land_size_acres) as max_land FROM farmers GROUP BY location ORDER BY avg_land DESC";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("location", rs.getString("location"));
                row.put("avgLand", rs.getDouble("avg_land"));
                row.put("minLand", rs.getDouble("min_land"));
                row.put("maxLand", rs.getDouble("max_land"));
                result.add(row);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn);
        }
        return result;
    }
    
    public List<Map<String, Object>> getGrowthTrends(String timePeriod) {
        List<Map<String, Object>> result = new ArrayList<>();
        String sql = "SELECT DATE(created_at) as date, COUNT(*) as new_farmers FROM users WHERE user_type = 'FARMER' AND created_at >= DATE_SUB(CURRENT_DATE(), INTERVAL ? DAY) GROUP BY DATE(created_at) ORDER BY date";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(timePeriod));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("date", rs.getDate("date").toString());
                row.put("newFarmers", rs.getInt("new_farmers"));
                result.add(row);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn);
        }
        return result;
    }
    
    public List<Map<String, Object>> getMonthlyGrowth() {
        List<Map<String, Object>> result = new ArrayList<>();
        String sql = "SELECT YEAR(created_at) as year, MONTH(created_at) as month, COUNT(*) as count FROM users WHERE user_type = 'FARMER' GROUP BY YEAR(created_at), MONTH(created_at) ORDER BY year DESC, month DESC LIMIT 12";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("year", rs.getInt("year"));
                row.put("month", rs.getInt("month"));
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
    
    public Map<String, Object> getPerformanceMetrics(String timePeriod) {
        Map<String, Object> result = new HashMap<>();
        String sql = "SELECT " +
                    "COUNT(*) as total_farmers, " +
                    "COUNT(DISTINCT f.location) as total_locations, " +
                    "AVG(f.land_size_acres) as avg_land_size, " +
                    "SUM(f.land_size_acres) as total_land_area " +
                    "FROM users u INNER JOIN farmers f ON u.id = f.user_id " +
                    "WHERE u.user_type = 'FARMER' AND u.created_at >= DATE_SUB(CURRENT_DATE(), INTERVAL ? DAY)";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(timePeriod));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                result.put("totalFarmers", rs.getInt("total_farmers"));
                result.put("totalLocations", rs.getInt("total_locations"));
                result.put("avgLandSize", rs.getDouble("avg_land_size"));
                result.put("totalLandArea", rs.getDouble("total_land_area"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn);
        }
        return result;
    }
    
    public List<Map<String, Object>> getKeyMetrics() {
        List<Map<String, Object>> result = new ArrayList<>();
        String sql = "SELECT " +
                    "'Total Farmers' as metric, COUNT(*) as value FROM users WHERE user_type = 'FARMER' " +
                    "UNION ALL " +
                    "SELECT 'Active Farmers' as metric, COUNT(DISTINCT u.id) as value FROM users u INNER JOIN farmer_crops fc ON u.id = fc.farmer_user_id WHERE u.user_type = 'FARMER' " +
                    "UNION ALL " +
                    "SELECT 'Total Land Area' as metric, SUM(land_size_acres) as value FROM farmers " +
                    "UNION ALL " +
                    "SELECT 'Average Land Size' as metric, AVG(land_size_acres) as value FROM farmers";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("metric", rs.getString("metric"));
                row.put("value", rs.getDouble("value"));
                result.add(row);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn);
        }
        return result;
    }
    
    public List<Map<String, Object>> getSavedReports() {
        // This is a placeholder - in a real application, you'd have a reports table
        List<Map<String, Object>> result = new ArrayList<>();
        // For now, return empty list
        return result;
    }

    /**
     * Gets user details by ID for refreshing session data.
     * @param userId The ID of the user.
     * @return A User object (either Farmer or Admin) if found, otherwise null.
     */
    public User getUserById(int userId) {
        String sql = "SELECT * FROM users WHERE id = ?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String userType = rs.getString("user_type");
                if ("FARMER".equals(userType)) {
                    return getFarmerDetails(userId, conn);
                } else if ("ADMIN".equals(userType)) {
                    return getAdminDetails(userId, conn);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn);
        }
        return null;
    }
}
