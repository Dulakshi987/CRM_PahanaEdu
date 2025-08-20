package com.billsystem.services;

import com.billsystem.dao.ItemDao;
import com.billsystem.factory.DaoFactory;
import com.billsystem.models.Item;

import java.util.List;

public class ItemService {
    private final ItemDao itemDao = DaoFactory.createItemDao();

    // Check and add item
    public boolean addItem(Item item) {
        if (itemDao.isItemCodeExist(item.getItemCode())) {
            return false; // item code exists → do not add
        } else {
            itemDao.addItem(item);
            return true; // successfully added
        }
    }

    public List<Item> getAllItems() {
        return itemDao.getAllItems();
    }

    public Item getItemById(int itemId) {
        return itemDao.getItemById(itemId);
    }

    public boolean updateItem(Item item) {
        return itemDao.updateItem(item);
    }

    public void deleteItem(int itemId) {
        itemDao.deleteItem(itemId);
    }
}
