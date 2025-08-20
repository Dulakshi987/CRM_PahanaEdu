package com.billsystem.services;

import com.billsystem.dao.CustomerDao;
import com.billsystem.factory.DaoFactory;
import com.billsystem.models.Customer;

import java.util.List;

public class CustomerService {

    // DAO is created via factory, not directly
    private final CustomerDao customerDao = DaoFactory.createCustomerDao();
    public boolean addCustomer(Customer customer) {
        // check duplicate first
        if (customerDao.accountNumberExists(customer.getAccountNumber())) {
            return false; // already exists
        }
        customerDao.addCustomer(customer);
        return true;
    }


    public List<Customer> getAllCustomers() {
        return customerDao.getAllCustomers();
    }

    public void deleteCustomer(int id) {
        customerDao.deleteCustomer(id);
    }

    public void updateCustomer(Customer customer) {
        customerDao.updateCustomer(customer);
    }

    public Customer getCustomerById(int id) {
        return customerDao.getCustomerById(id);
    }

}