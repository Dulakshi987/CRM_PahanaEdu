package com.billsystem.services;

import com.billsystem.models.Bill;
import com.billsystem.models.BillItem;

import java.util.List;

public interface BillService {
    boolean saveBillWithItems(Bill bill);

    List<Bill> getAllBills();

    Bill getLatestBillByCustomerId(int customerId);

    String getCustomerEmailById(int customerId);

    List<BillItem> getBillItemsByBillId(int billId);

    Bill getBillById(int billId);


}

