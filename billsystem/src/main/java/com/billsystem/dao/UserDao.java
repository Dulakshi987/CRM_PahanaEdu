package com.billsystem.dao;

import com.billsystem.models.User;
import com.billsystem.utils.DBConnection;
import com.billsystem.utils.HashPassword;

import java.sql.*;

public class UserDao {

    public User login(String username, String hashedPassword) {
        User user = null;
        String sql = "SELECT * FROM users WHERE username=? AND password=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            // Hash the password for comparison
//            String hashedPassword = HashPassword.hashPassword(password);

            //  Debugging: print inputs
            System.out.println(" Login Attempt");
            System.out.println("Username: " + username);
            System.out.println("Hashed Password: " + hashedPassword);

            ps.setString(1, username);
            ps.setString(2, hashedPassword);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setUsertype(rs.getInt("usertype"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public boolean register(User user) {
        String sql = "INSERT INTO users (username, password, email, usertype) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            // Debug user data
            System.out.println(" Registering new user:");
            System.out.println("Username: " + user.getUsername());
            System.out.println("Email: " + user.getEmail());
            System.out.println("Usertype: " + user.getUsertype());
            System.out.println("Hashed Password: " + user.getPassword());

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());
            ps.setInt(4, user.getUsertype());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updatePasswordByUsername(String username, String newPassword) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE users SET password = ? WHERE username = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, newPassword);
            stmt.setString(2, username);

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}
