package com.billsystem.services;

import com.billsystem.dao.CustomerDao;
import com.billsystem.factory.DaoFactory;
import com.billsystem.models.Customer;

import java.util.List;

public class CustomerService {

    // DAO is created via factory, not directly
    private final CustomerDao customerDao = DaoFactory.createCustomerDao();

    public void addCustomer(Customer customer) {
        customerDao.addCustomer(customer);
    }
    public List<Customer> getAllCustomers() {
        return customerDao.getAllCustomers();
    }

}