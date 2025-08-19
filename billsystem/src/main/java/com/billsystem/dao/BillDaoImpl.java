package com.billsystem.dao;

import com.billsystem.models.Bill;
import com.billsystem.models.BillItem;
import com.billsystem.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
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
                billStmt.setTimestamp(2, bill.getBillDate());
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

    @Override
    public List<Bill> getAllBills() {
        List<Bill> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM bill")) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Bill bill = new Bill();
                bill.setBillId(rs.getInt("bill_id"));
                bill.setCustomerId(rs.getInt("customer_id"));
                bill.setBillDate(rs.getTimestamp("bill_date"));
                bill.setGrandTotal(rs.getDouble("grand_total"));
//                bill.setStatus(rs.getString("status"));
                bill.setPaymentMethod(rs.getString("payment_method"));
                list.add(bill);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Bill getLatestBillByCustomerId(int customerId) {
        String sql = "SELECT * FROM bill WHERE customer_id = ? ORDER BY bill_id DESC LIMIT 1";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Bill bill = new Bill();
                bill.setBillId(rs.getInt("bill_id"));
                bill.setCustomerId(rs.getInt("customer_id"));
                bill.setBillDate(rs.getTimestamp("bill_date"));
                bill.setDiscount(rs.getDouble("discount"));
                bill.setTax(rs.getDouble("tax"));
                bill.setGrandTotal(rs.getDouble("grand_total"));
                bill.setPaymentMethod(rs.getString("payment_method"));
                return bill;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public String getCustomerEmailById(int customerId) {
        String sql = "SELECT email FROM customer WHERE customer_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("email");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public Bill getBillById(int billId) {
        Bill bill = null;
        String sql = "SELECT * FROM bill WHERE bill_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, billId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    bill = new Bill();
                    bill.setBillId(rs.getInt("bill_id"));
                    bill.setCustomerId(rs.getInt("customer_id"));
                    bill.setBillDate(rs.getTimestamp("bill_date"));
                    bill.setTotalAmount(rs.getDouble("total_amount"));
                    bill.setDiscount(rs.getDouble("discount"));
                    bill.setTax(rs.getDouble("tax"));
                    bill.setGrandTotal(rs.getDouble("grand_total"));
                    bill.setPaymentMethod(rs.getString("payment_method"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bill;
    }

    @Override
    public List<BillItem> getBillItemsByBillId(int billId) {
        List<BillItem> items = new ArrayList<>();
        String sql = "SELECT * FROM bill_item WHERE bill_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, billId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    BillItem item = new BillItem();
                    item.setBillId(rs.getInt("bill_id"));
                    item.setItemId(rs.getInt("item_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setItemPrice(rs.getDouble("item_price"));
                    item.setTotalPrice(rs.getDouble("total_price"));
                    items.add(item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return items;
    }

}
