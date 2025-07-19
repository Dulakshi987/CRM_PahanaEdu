package com.billsystem.dao;

import com.billsystem.models.Item;
import com.billsystem.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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

    public List<Item> getAllItems() {
        List<Item> itemList = new ArrayList<>();
        String sql = "SELECT * FROM Item";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Item item = new Item();
                item.setItemId(rs.getInt("item_id"));
                item.setItemName(rs.getString("item_name"));
                item.setItemCode(rs.getString("item_code"));
                item.setDescription(rs.getString("description"));
                item.setPricePerUnit(rs.getDouble("price_per_unit"));
                item.setStockQuantity(rs.getInt("stock_quantity"));
                item.setStatus(rs.getString("status"));
                item.setCreatedAt(rs.getTimestamp("created_at"));
                item.setUpdatedAt(rs.getTimestamp("updated_at"));

                itemList.add(item);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return itemList;
    }

    public List<Item> searchItemsByName(String name) {
        List<Item> itemList = new ArrayList<>();
        String sql = "SELECT * FROM Item WHERE item_name LIKE ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, "%" + name + "%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Item item = new Item();
                item.setItemId(rs.getInt("item_id"));
                item.setItemName(rs.getString("item_name"));
                item.setItemCode(rs.getString("item_code"));
                item.setDescription(rs.getString("description"));
                item.setPricePerUnit(rs.getDouble("price_per_unit"));
                item.setStockQuantity(rs.getInt("stock_quantity"));
                item.setStatus(rs.getString("status"));
                item.setCreatedAt(rs.getTimestamp("created_at"));
                item.setUpdatedAt(rs.getTimestamp("updated_at"));

                itemList.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return itemList;
    }
}
