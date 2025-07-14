package com.billsystem.utils;

import java.sql.*;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/bill_system?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root"; //  MySQL username
    private static final String PASSWORD = ""; //  MySQL password

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
