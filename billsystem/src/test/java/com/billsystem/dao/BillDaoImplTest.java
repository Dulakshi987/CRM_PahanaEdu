package com.billsystem.dao;

import com.billsystem.models.Bill;
import com.billsystem.models.BillItem;
import org.junit.jupiter.api.*;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class BillDaoImplTest {

    private BillDao billDao;
    private final int customerId = 1; // Must exist in DB
    private final int itemId1 = 3;    // Must exist in DB
    private final int itemId2 = 2;    // Must exist in DB

    @BeforeEach
    public void setUp() {
        billDao = new BillDaoImpl();
    }

    private Bill generateSampleBill() {
        Bill bill = new Bill();
        bill.setCustomerId(customerId);
        bill.setBillDate(new Timestamp(System.currentTimeMillis()));
        bill.setTotalAmount(0.0);
        bill.setDiscount(100.0);
        bill.setTax(50.0);
        bill.setGrandTotal(950.0);
        bill.setPaymentMethod("Cash");

        List<BillItem> items = new ArrayList<>();

        BillItem item1 = new BillItem();
        item1.setItemId(2);
        item1.setQuantity(2);
        item1.setItemPrice(100.0);
        item1.setTotalPrice(200.0);

        BillItem item2 = new BillItem();
        item2.setItemId(2);
        item2.setQuantity(3);
        item2.setItemPrice(100.0);
        item2.setTotalPrice(300.0);

        items.add(item1);
        items.add(item2);

        bill.setItems(items);

        return bill;
    }

    @Test
    @Order(1)
    public void testSaveBillWithItems() {
        Bill bill = generateSampleBill();
        boolean result = billDao.saveBillWithItems(bill);
        assertTrue(result, "Bill should be saved successfully");
    }

    @Test
    @Order(2)
    public void testGetAllBills() {
        List<Bill> bills = billDao.getAllBills();
        assertNotNull(bills, "Bills list should not be null");
        assertFalse(bills.isEmpty(), "Bills list should contain at least one bill");
    }

    @Test
    @Order(3)
    public void testGetLatestBillByCustomerId() {
        Bill latestBill = billDao.getLatestBillByCustomerId(customerId);
        assertNotNull(latestBill, "Latest bill should not be null");
        assertEquals(customerId, latestBill.getCustomerId(), "Customer ID should match");
    }

    @Test
    @Order(4)
    public void testGetCustomerEmailById() {
        String email = billDao.getCustomerEmailById(2);
        assertNotNull(email, "Email should not be null");
        assertTrue(email.contains("@"), "Email should contain '@'");
    }

    @Test
    @Order(5)
    public void testGetBillById() {

        Bill bill = generateSampleBill();
        boolean saved = billDao.saveBillWithItems(bill);
        assertTrue(saved, "Bill should be saved successfully");

        Bill latestBill = billDao.getLatestBillByCustomerId(customerId);
        assertNotNull(latestBill, "Latest bill should not be null");

        Bill fetchedBill = billDao.getBillById(latestBill.getBillId());
        assertNotNull(fetchedBill, "Bill should be fetched by ID");
        assertEquals(latestBill.getBillId(), fetchedBill.getBillId(), "Bill IDs should match");
        assertEquals(customerId, fetchedBill.getCustomerId(), "Customer ID should match");
    }

    @Test
    @Order(6)
    public void testGetBillItemsByBillId() {

        Bill latestBill = billDao.getLatestBillByCustomerId(customerId);
        assertNotNull(latestBill, "Latest bill should not be null");

        List<BillItem> items = billDao.getBillItemsByBillId(latestBill.getBillId());
        assertNotNull(items, "Bill items list should not be null");
        assertFalse(items.isEmpty(), "Bill should contain items");
        assertEquals(latestBill.getBillId(), items.get(0).getBillId(), "Each item should belong to the bill");
    }

}
