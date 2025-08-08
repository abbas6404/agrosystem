// --- File 1: Place this in 'com.mycompany.agrosystem.dao' package ---
// --- File Name: UserDAO.java ---
package com.mycompany.agrosystem.dao;

import com.mycompany.agrosystem.model.Admin;
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
        String insertUserSQL = "INSERT INTO users (name, phone_number, password, user_type) VALUES (?, ?, ?, 'FARMER')";
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
        String sql = "SELECT u.id, u.name, u.phone_number, f.location, f.land_size_acres, f.soil_conditions " +
                     "FROM users u JOIN farmers f ON u.id = f.user_id WHERE u.id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Farmer farmer = new Farmer();
                farmer.setId(rs.getInt("id"));
                farmer.setName(rs.getString("name"));
                farmer.setPhoneNumber(rs.getString("phone_number"));
                farmer.setLocation(rs.getString("location"));
                farmer.setLandSizeAcres(rs.getDouble("land_size_acres"));
                farmer.setSoilConditions(rs.getString("soil_conditions"));
                return farmer;
            }
        }
        return null;
    }

    private Admin getAdminDetails(int userId, Connection conn) throws SQLException {
        String sql = "SELECT u.id, u.name, u.phone_number, a.email, a.experience_years " +
                     "FROM users u JOIN admins a ON u.id = a.user_id WHERE u.id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Admin admin = new Admin();
                admin.setId(rs.getInt("id"));
                admin.setName(rs.getString("name"));
                admin.setPhoneNumber(rs.getString("phone_number"));
                admin.setEmail(rs.getString("email"));
                admin.setExperienceYears(rs.getInt("experience_years"));
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
        String sql = "SELECT u.id, u.name, u.phone_number, f.location, f.land_size_acres, f.soil_conditions " +
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
}
