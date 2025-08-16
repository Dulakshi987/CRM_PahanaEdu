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
        String sql = "INSERT INTO Item (item_code, item_name, description, price_per_unit, stock_quantity, status) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, item.getItemCode());
            ps.setString(2, item.getItemName());
            ps.setString(3, item.getDescription());
            ps.setDouble(4, item.getPricePerUnit());
            ps.setInt(5, item.getStockQuantity());
            ps.setString(6, item.getStatus());

            ps.executeUpdate();

        } catch (SQLException e) {
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
                item.setItemCode(rs.getString("item_code"));
                item.setItemName(rs.getString("item_name"));
                item.setDescription(rs.getString("description"));
                item.setPricePerUnit(rs.getDouble("price_per_unit"));
                item.setStockQuantity(rs.getInt("stock_quantity"));
                item.setStatus(rs.getString("status"));

                itemList.add(item);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return itemList;
    }

    public boolean updateItem(Item item) {
        String sql = "UPDATE Item SET item_code=?, item_name=?, description=?, price_per_unit=?, stock_quantity=?, status=? WHERE item_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, item.getItemCode());
            ps.setString(2, item.getItemName());
            ps.setString(3, item.getDescription());
            ps.setDouble(4, item.getPricePerUnit());
            ps.setInt(5, item.getStockQuantity());
            ps.setString(6, item.getStatus());
            ps.setInt(7, item.getItemId());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteItem(int itemId) {
        String sql = "DELETE FROM Item WHERE item_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, itemId);

            int rowsDeleted = ps.executeUpdate();
            return rowsDeleted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Item getItemById(int itemId) {
        String sql = "SELECT * FROM Item WHERE item_id = ?";
        Item item = null;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, itemId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    item = new Item();
                    item.setItemId(rs.getInt("item_id"));
                    item.setItemCode(rs.getString("item_code"));
                    item.setItemName(rs.getString("item_name"));
                    item.setDescription(rs.getString("description"));
                    item.setPricePerUnit(rs.getDouble("price_per_unit"));
                    item.setStockQuantity(rs.getInt("stock_quantity"));
                    item.setStatus(rs.getString("status"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return item;
    }

}