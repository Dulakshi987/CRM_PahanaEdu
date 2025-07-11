package com.billsystem.dao;

import com.billsystem.utils.DBConnection;
import com.billsystem.models.Customer;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class CustomerDao {


        public void addCustomer(Customer customer) {
            try {
                Connection conn = DBConnection.getConnection();
                String sql = "INSERT INTO customers (id, account_number, first_name, last_name, nid, address, contact_number, emergency_number, email) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, customer.getId());
                ps.setString(2, customer.getAccountNumber());
                ps.setString(3, customer.getFirstName());
                ps.setString(4, customer.getLastName());
                ps.setString(5, customer.getNid());
                ps.setString(6, customer.getAddress());
                ps.setString(7, customer.getContactNumber());
                ps.setString(8, customer.getEmergencyNumber());
                ps.setString(9, customer.getEmail());
                ps.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }


