package com.billsystem.dao;

import com.billsystem.models.Customer;
import com.billsystem.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDao {

    public void addCustomer(Customer customer) {
        String sql = "INSERT INTO customers (account_number, first_name, last_name, nid, address, contact_number, emergency_number, email) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            System.out.println("Inserting Customer: ");
            System.out.println("Account No: " + customer.getAccountNumber());
            System.out.println("First Name: " + customer.getFirstName());
            System.out.println("Last Name: " + customer.getLastName());

            ps.setString(1, customer.getAccountNumber());
            ps.setString(2, customer.getFirstName());
            ps.setString(3, customer.getLastName());
            ps.setString(4, customer.getNid());
            ps.setString(5, customer.getAddress());
            ps.setString(6, customer.getContactNumber());
            ps.setString(7, customer.getEmergencyNumber());
            ps.setString(8, customer.getEmail());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                System.out.println(" Customer inserted into DB.");
            } else {
                System.out.println(" Insert failed: no rows affected.");
            }
        } catch (Exception e) {
            System.out.println(" Exception while inserting customer:");
            e.printStackTrace();
        }
    }

    public List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM customers";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Customer customer = new Customer();
                customer.setId(rs.getInt("id"));
                customer.setAccountNumber(rs.getString("account_number"));
                customer.setFirstName(rs.getString("first_name"));
                customer.setLastName(rs.getString("last_name"));
                customer.setNid(rs.getString("nid"));
                customer.setAddress(rs.getString("address"));
                customer.setContactNumber(rs.getString("contact_number"));
                customer.setEmergencyNumber(rs.getString("emergency_number"));
                customer.setEmail(rs.getString("email"));

                customers.add(customer);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return customers;
    }

}