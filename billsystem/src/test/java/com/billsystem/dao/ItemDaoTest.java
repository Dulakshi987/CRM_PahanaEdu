package com.billsystem.dao;

import com.billsystem.models.Item;
import com.billsystem.utils.DBConnection;
import org.junit.jupiter.api.*;

import java.sql.*;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class ItemDaoTest {

    private static final ItemDao itemDao = new ItemDao();
    private static int testItemId;

    @BeforeEach
    public void setUp() {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "INSERT INTO items (item_name, item_code, description, price_per_unit, stock_quantity, status) VALUES (?, ?, ?, ?, ?, ?)",
                     Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, "TestItem");
            stmt.setString(2, "CODE123");
            stmt.setString(3, "Sample item description");
            stmt.setDouble(4, 100.0);
            stmt.setInt(5, 10);
            stmt.setString(6, "Available");

            stmt.executeUpdate();

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                testItemId = rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Test
    @Order(1)
    public void testAddItem() {
        Item item = new Item();
        item.setItemName("NewItem");
        item.setItemCode("NEW123");
        item.setDescription("New test item");
        item.setPricePerUnit(200.0);
        item.setStockQuantity(20);
        item.setStatus("Active");

        itemDao.addItem(item);

        List<Item> items = itemDao.getAllItems();
        assertFalse(items.isEmpty());

        Item last = items.get(items.size() - 1);
        testItemId = last.getItemId(); // Save for next tests
        assertEquals("NewItem", last.getItemName());
    }

    @Test
    @Order(2)
    public void testGetAllItems() {
        List<Item> items = itemDao.getAllItems();
        assertNotNull(items);
        assertTrue(items.size() > 0);
    }

    @Test
    @Order(3)
    public void testGetItemById() {
        Item item = itemDao.getItemById(testItemId);
        assertNotNull(item);
        assertEquals("NewItem", item.getItemName());
        assertEquals("NEW123", item.getItemCode());
    }

    @Test
    @Order(4)
    public void testUpdateItem() {
        Item item = itemDao.getItemById(testItemId);
        assertNotNull(item);

        item.setItemName("UpdatedItem");
        item.setPricePerUnit(300.0);

        itemDao.updateItem(item);

        Item updated = itemDao.getItemById(testItemId);
        assertEquals("UpdatedItem", updated.getItemName());
        assertEquals(300.0, updated.getPricePerUnit());
    }

    @Test
    @Order(5)
    public void testDeleteItem() {
        itemDao.deleteItem(testItemId);
        Item deleted = itemDao.getItemById(testItemId);
        assertNull(deleted);
    }

    @Test
    @Order(6)
    public void testItemCodeDoesNotExist() {
        assertFalse(itemDao.isItemCodeExist("NONEXISTENT"), "Random item code should not exist");
    }
}
