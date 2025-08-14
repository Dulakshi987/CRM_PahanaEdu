package com.billsystem.dao;

import com.billsystem.models.Bill;
import com.billsystem.models.BillItem;

import java.util.List;

public interface BillDao {
    boolean saveBillWithItems(Bill bill);

    List<Bill> getAllBills();

    Bill getLatestBillByCustomerId(int customerId);

    String getCustomerEmailById(int customerId);

    Bill getBillById(int billId);

    List<BillItem> getBillItemsByBillId(int billId);




}

