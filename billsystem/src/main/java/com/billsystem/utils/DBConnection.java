package com.billsystem.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static Connection connection;

    // Prevent instantiation
    private DBConnection() {}

    // Thread-safe, logged connection getter
    public static synchronized Connection getConnection() {
        try {
            if (connection == null || connection.isClosed()) {
                System.out.println("🔌 Connecting to the database (bill_system)...");
                Class.forName("com.mysql.cj.jdbc.Driver");

                connection = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/bill_system?useSSL=false&serverTimezone=UTC",
                        "root", ""
                );

                if (connection != null) {
                    System.out.println(" Database Connected Successfully!");
                } else {
                    System.err.println(" ERROR: Connection returned NULL!");
                }
            }
        } catch (ClassNotFoundException e) {
            System.err.println(" JDBC Driver not found: " + e.getMessage());
        } catch (SQLException e) {
            System.err.println(" Database Connection Failed: " + e.getMessage());
        }

        return connection;
    }
}
