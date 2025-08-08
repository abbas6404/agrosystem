package com.mycompany.agrosystem.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * A utility class to handle database connections.
 * This ensures that all parts of the application connect to the database in a consistent way.
 */
public class DBConnection {
    // Database connection details. Update these if your setup is different.
    private static final String URL = "jdbc:mysql://localhost:3306/agro_system_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USER = "root"; // Default XAMPP username
    private static final String PASSWORD = "";   // Default XAMPP password is empty
    
    // Static block to register the driver once
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found: " + e.getMessage());
        }
    }

    /**
     * Establishes and returns a connection to the database.
     * @return A Connection object or null if connection fails.
     */
    public static Connection getConnection() {
        Connection connection = null;
        try {
            // Attempt to create a connection
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (SQLException e) {
            // Print error details to the console for debugging
            System.err.println("Database connection failed: " + e.getMessage());
            e.printStackTrace();
        }
        return connection;
    }
    
    /**
     * Safely closes a database connection.
     * @param connection The connection to close.
     */
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                System.err.println("Error closing database connection: " + e.getMessage());
            }
        }
    }
}
