package com.billsystem.dao;

import com.billsystem.models.Item;
import com.billsystem.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class ItemDao {
    public void addItem(Item item) {
        String sql = "INSERT INTO Item (item_code,item_name, description, price_per_unit, stock_quantity, status) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, item.getItemCode());
            ps.setString(2, item.getItemName());
            ps.setString(3, item.getDescription());
            ps.setDouble(4, item.getPricePerUnit());
            ps.setInt(5, item.getStockQuantity());
            ps.setString(6, item.getStatus());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                System.out.println("Item added successfully.");
            } else {
                System.out.println("Item insert failed.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
