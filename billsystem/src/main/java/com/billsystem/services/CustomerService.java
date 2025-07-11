package com.billsystem.services;

import com.billsystem.dao.CustomerDao;
import com.billsystem.models.Customer;

public class CustomerService {

        CustomerDao customerDao = new CustomerDao();

        public void addCustomer(Customer customer) {
            customerDao.addCustomer(customer);
        }
    }


