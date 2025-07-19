package com.billsystem.services;

import com.billsystem.dao.ItemDao;
import com.billsystem.factory.DaoFactory;
import com.billsystem.models.Item;

public class ItemService {
    private final ItemDao itemDao = DaoFactory.createItemDao();

    public void addItem(Item item) {
        itemDao.addItem(item);
    }
}
