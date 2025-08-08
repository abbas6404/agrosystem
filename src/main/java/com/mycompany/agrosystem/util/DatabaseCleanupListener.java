package com.mycompany.agrosystem.util;

import jakarta.servlet.ServletContextListener;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.annotation.WebListener;

/**
 * Database cleanup listener to properly handle MySQL JDBC driver cleanup
 * and prevent memory leaks during application shutdown.
 */
@WebListener
public class DatabaseCleanupListener implements ServletContextListener {
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // Application startup - nothing special needed here
        System.out.println("AgroSyst application starting up...");
    }
    
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        try {
            // Properly cleanup MySQL JDBC driver
            com.mysql.cj.jdbc.AbandonedConnectionCleanupThread.checkedShutdown();
            System.out.println("MySQL JDBC driver cleanup completed successfully.");
        } catch (Exception e) {
            System.err.println("Error during MySQL JDBC driver cleanup: " + e.getMessage());
        }
    }
}
