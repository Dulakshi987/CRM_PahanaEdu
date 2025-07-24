package com.billsystem.dao;

import com.billsystem.models.Bill;

public interface BillDao {
    boolean saveBillWithItems(Bill bill);
}

