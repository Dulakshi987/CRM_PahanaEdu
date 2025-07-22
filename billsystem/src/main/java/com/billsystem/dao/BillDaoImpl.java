package com.billsystem.dao;

import com.billsystem.models.Bill;
import com.billsystem.models.BillItem;
import com.billsystem.utils.DBConnection;

import java.sql.*;

public class BillDaoImpl implements BillDao {
    @Override
    public void insertBillWithItems(Bill bill) {
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            // Insert into bill
            String sqlBill = "INSERT INTO bill (customer_id, total_amount, discount, tax, grand_total, bill_date) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sqlBill, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, bill.getCustomerId());
            ps.setDouble(2, bill.getTotalAmount());
            ps.setDouble(3, bill.getDiscount());
            ps.setDouble(4, bill.getTax());
            ps.setDouble(5, bill.getGrandTotal());
            ps.setString(6, bill.getBillDate());
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            int billId = 0;
            if (rs.next()) {
                billId = rs.getInt(1);
            }

            // Insert items
            String sqlItem = "INSERT INTO bill_item (bill_id, item_id, quantity, total_price) VALUES (?, ?, ?, ?)";
            PreparedStatement psItem = conn.prepareStatement(sqlItem);
            for (BillItem item : bill.getItems()) {
                psItem.setInt(1, billId);
                psItem.setInt(2, item.getItemId());
                psItem.setInt(3, item.getQuantity());
                psItem.setDouble(4, item.getTotalPrice());
                psItem.addBatch();
            }
            psItem.executeBatch();
            conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
