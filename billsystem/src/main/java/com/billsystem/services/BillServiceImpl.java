package com.billsystem.services;

import com.billsystem.dao.BillDao;
import com.billsystem.dao.BillDaoImpl;
import com.billsystem.models.Bill;

import java.util.List;


public class BillServiceImpl implements BillService {
    private BillDao billDao = new BillDaoImpl();

    @Override
    public boolean saveBillWithItems(Bill bill) {
        return billDao.saveBillWithItems(bill);
    }
    @Override
    public List<Bill> getAllBills() {
        return billDao.getAllBills();
    }

    @Override
    public Bill getLatestBillByCustomerId(int customerId) {
        return billDao.getLatestBillByCustomerId(customerId);
    }

    @Override
    public String getCustomerEmailById(int customerId) {
        return billDao.getCustomerEmailById(customerId);
    }

}



