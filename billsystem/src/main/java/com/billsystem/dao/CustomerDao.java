package com.billsystem.dao;

import com.billsystem.models.Customer;
import com.billsystem.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDao {

    // ✅ Add customer (without ID, as it's auto-incremented)
    public void addCustomer(Customer customer) {
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO customers (account_number, first_name, last_name, nid, address, contact_number, emergency_number, email) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, customer.getAccountNumber());
            ps.setString(2, customer.getFirstName());
            ps.setString(3, customer.getLastName());
            ps.setString(4, customer.getNid());
            ps.setString(5, customer.getAddress());
            ps.setString(6, customer.getContactNumber());
            ps.setString(7, customer.getEmergencyNumber());
            ps.setString(8, customer.getEmail());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //  Get all customers
    public List<Customer> getAllCustomers() {
        List<Customer> list = new ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM customers";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Customer c = new Customer();
                c.setId(rs.getInt("id"));
                c.setAccountNumber(rs.getString("account_number"));
                c.setFirstName(rs.getString("first_name"));
                c.setLastName(rs.getString("last_name"));
                c.setNid(rs.getString("nid"));
                c.setAddress(rs.getString("address"));
                c.setContactNumber(rs.getString("contact_number"));
                c.setEmergencyNumber(rs.getString("emergency_number"));
                c.setEmail(rs.getString("email"));
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    //  Get a single customer by ID
    public Customer getCustomerById(int id) {
        Customer customer = null;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM customers WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                customer = new Customer();
                customer.setId(rs.getInt("id"));
                customer.setAccountNumber(rs.getString("account_number"));
                customer.setFirstName(rs.getString("first_name"));
                customer.setLastName(rs.getString("last_name"));
                customer.setNid(rs.getString("nid"));
                customer.setAddress(rs.getString("address"));
                customer.setContactNumber(rs.getString("contact_number"));
                customer.setEmergencyNumber(rs.getString("emergency_number"));
                customer.setEmail(rs.getString("email"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return customer;
    }

    //  Update customer
    public boolean updateCustomer(Customer customer) {
        boolean success = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "UPDATE customers SET account_number = ?, first_name = ?, last_name = ?, nid = ?, address = ?, contact_number = ?, emergency_number = ?, email = ? WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, customer.getAccountNumber());
            ps.setString(2, customer.getFirstName());
            ps.setString(3, customer.getLastName());
            ps.setString(4, customer.getNid());
            ps.setString(5, customer.getAddress());
            ps.setString(6, customer.getContactNumber());
            ps.setString(7, customer.getEmergencyNumber());
            ps.setString(8, customer.getEmail());
            ps.setInt(9, customer.getId());

            int rows = ps.executeUpdate();
            success = (rows > 0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    //  Delete customer
    public boolean deleteCustomer(int id) {
        boolean success = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "DELETE FROM customers WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            int rows = ps.executeUpdate();
            success = (rows > 0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }
}