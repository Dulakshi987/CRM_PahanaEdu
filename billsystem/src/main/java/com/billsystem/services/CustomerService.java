package com.billsystem.services;

import com.billsystem.dao.CustomerDao;
import com.billsystem.models.Customer;

import java.util.List;

public class CustomerService {

    // Make DAO final since it doesn’t change
    private final CustomerDao customerDao = new CustomerDao();


    public void addCustomer(Customer customer) {
        customerDao.addCustomer(customer);
    }

}