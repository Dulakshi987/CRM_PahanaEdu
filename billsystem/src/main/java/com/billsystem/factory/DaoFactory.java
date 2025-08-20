package com.billsystem.factory;

import com.billsystem.dao.CustomerDao;
import com.billsystem.dao.ItemDao;
import com.billsystem.dao.UserDao;

public class DaoFactory {

    public static CustomerDao createCustomerDao() {
        return new CustomerDao();
    }

    public static UserDao createUserDao() {
        return new UserDao();
    }

    public static ItemDao createItemDao() {
        return new ItemDao();
    }
}

