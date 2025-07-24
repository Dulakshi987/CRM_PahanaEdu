package com.billsystem.services;

import com.billsystem.models.Bill;

public interface BillService {
    boolean saveBillWithItems(Bill bill);
}

