package com.billsystem.dao;

import com.billsystem.models.Bill;
import com.billsystem.models.BillItem;
import com.billsystem.utils.DBConnection;

import java.sql.*;
import java.util.List;

public class BillDaoImpl implements BillDao {
    private Connection conn = DBConnection.getConnection();

    @Override
    public boolean saveBillWithItems(Bill bill) {
        String billSql = "INSERT INTO bill (customer_id, bill_date, total_amount, discount, tax, grand_total, payment_method) VALUES (?, ?, ?, ?, ?, ?, ?)";
        String itemSql = "INSERT INTO bill_item (bill_id, item_id, quantity, item_price, total_price) VALUES (?, ?, ?, ?, ?)";

        try {
            conn.setAutoCommit(false);

            try (PreparedStatement billStmt = conn.prepareStatement(billSql, Statement.RETURN_GENERATED_KEYS)) {
                billStmt.setInt(1, bill.getCustomerId());
                billStmt.setString(2, bill.getBillDate());
                billStmt.setDouble(3, bill.getTotalAmount());
                billStmt.setDouble(4, bill.getDiscount());
                billStmt.setDouble(5, bill.getTax());
                billStmt.setDouble(6, bill.getGrandTotal());
                billStmt.setString(7, bill.getPaymentMethod());


                int billResult = billStmt.executeUpdate();

                if (billResult == 0) {
                    conn.rollback();
                    return false;
                }

                try (ResultSet rs = billStmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        int billId = rs.getInt(1);

                        try (PreparedStatement itemStmt = conn.prepareStatement(itemSql)) {
                            for (BillItem item : bill.getItems()) {
                                itemStmt.setInt(1, billId);
                                itemStmt.setInt(2, item.getItemId());
                                itemStmt.setInt(3, item.getQuantity());
                                itemStmt.setDouble(4, item.getItemPrice());
                                itemStmt.setDouble(5, item.getTotalPrice());
                                itemStmt.addBatch();
                            }

                            int[] results = itemStmt.executeBatch();

                            for (int result : results) {
                                if (result == PreparedStatement.EXECUTE_FAILED) {
                                    conn.rollback();
                                    return false;
                                }
                            }
                        }
                    } else {
                        conn.rollback();
                        return false;
                    }
                }
            }

            conn.commit();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            try {
                conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            return false;
        } finally {
            try {
                conn.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
