package com.billsystem.services;

import com.billsystem.dao.BillDao;
import com.billsystem.dao.BillDaoImpl;
import com.billsystem.models.Bill;

public class BillServiceImpl implements BillService {
    private BillDao billDao = new BillDaoImpl();

    public void saveBillWithItems(Bill bill) {
        billDao.insertBillWithItems(bill);
    }
}
