package com.billsystem.services;

import com.billsystem.dao.ItemDao;
import com.billsystem.factory.DaoFactory;
import com.billsystem.models.Item;

import java.util.List;

public class ItemService {
    private final ItemDao itemDao = DaoFactory.createItemDao();

    public void addItem(Item item) {
        itemDao.addItem(item);
    }

    public List<Item> getAllItems() {
        return itemDao.getAllItems();
    }

    public List<Item> searchItemsByName(String name) {
        return itemDao.searchItemsByName(name);
    }
}
