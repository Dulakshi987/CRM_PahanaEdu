package com.billsystem.services;

import com.billsystem.dao.UserDao;
import com.billsystem.models.User;
import com.billsystem.utils.HashPassword;

public class UserServices {
    private UserDao userDao = new UserDao();

    public User login(String username, String password) {
        String hashedPassword = HashPassword.hashPassword(password);
        return userDao.login(username, hashedPassword);
    }



    public boolean register(User user) {
        String hashedPassword = HashPassword.hashPassword(user.getPassword());
        user.setPassword(hashedPassword);
        return userDao.register(user);
    }

}
