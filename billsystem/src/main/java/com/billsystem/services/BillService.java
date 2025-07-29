package com.billsystem.services;

import com.billsystem.models.Bill;

import java.util.List;

public interface BillService {
    boolean saveBillWithItems(Bill bill);

    List<Bill> getAllBills();

}

