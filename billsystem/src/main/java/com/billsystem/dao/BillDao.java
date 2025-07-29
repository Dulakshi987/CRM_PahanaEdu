package com.billsystem.dao;

import com.billsystem.models.Bill;

import java.util.List;

public interface BillDao {
    boolean saveBillWithItems(Bill bill);

    List<Bill> getAllBills();

}

