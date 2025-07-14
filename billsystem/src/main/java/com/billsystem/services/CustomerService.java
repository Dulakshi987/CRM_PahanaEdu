package com.billsystem.services;

import com.billsystem.dao.CustomerDao;
import com.billsystem.models.Customer;

import java.util.List;

public class CustomerService {

    private CustomerDao customerDao = new CustomerDao();

    //  Add customer
    public void addCustomer(Customer customer) {
        customerDao.addCustomer(customer);
    }

    //  Get all customers
    public List<Customer> getAllCustomers() {
        return customerDao.getAllCustomers();
    }

    // ✅ Get single customer by ID (for editing)
    public Customer getCustomerById(int id) {
        return customerDao.getCustomerById(id);
    }

    //  Update customer
    public boolean updateCustomer(Customer customer) {
        return customerDao.updateCustomer(customer);
    }

    // Delete customer
    public boolean deleteCustomer(int id) {
        return customerDao.deleteCustomer(id);
    }
}
