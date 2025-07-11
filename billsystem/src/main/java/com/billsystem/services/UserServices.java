package com.billsystem.services;

import com.billsystem.dao.UserDao;
import com.billsystem.models.User;

public class UserServices {
    private UserDao userDao = new UserDao();

    public User login(String username, String password) {
        return userDao.login(username, password);
    }

    public boolean register(User user) {
        return userDao.register(user);
    }
}
