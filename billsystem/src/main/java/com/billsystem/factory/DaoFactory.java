package com.billsystem.factory;

import com.billsystem.dao.CustomerDao;
import com.billsystem.dao.UserDao;

public class DaoFactory {

    public static CustomerDao createCustomerDao() {
        return new CustomerDao();
    }

    public static UserDao createUserDao() {
        return new UserDao();
    }

    // You can add more DAOs here later...
}
