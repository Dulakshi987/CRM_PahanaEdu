package com.billsystem.dao;

import com.billsystem.models.Customer;
import com.billsystem.utils.DBConnection;
import org.junit.jupiter.api.*;

import java.sql.*;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class CustomerDaoTest {

    private static final CustomerDao customerDao = new CustomerDao();
    private static int testCustomerId;

    @BeforeEach
    public void setUp() {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "INSERT INTO customers (account_number, first_name, last_name, nid, address, contact_number, emergency_number, email) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
                     Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, "ACC12345");
            stmt.setString(2, "John");
            stmt.setString(3, "Doe");
            stmt.setString(4, "991234567V");
            stmt.setString(5, "123 Main St");
            stmt.setString(6, "0771234567");
            stmt.setString(7, "0777654321");
            stmt.setString(8, "john@example.com");

            stmt.executeUpdate();

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                testCustomerId = rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Test
    @Order(1)
    public void testAddCustomer() {
        Customer customer = new Customer();
        customer.setAccountNumber("ACC12345");
        customer.setFirstName("John");
        customer.setLastName("Doe");
        customer.setNid("123456789V");
        customer.setAddress("123 Street");
        customer.setContactNumber("0771234567");
        customer.setEmergencyNumber("0777654321");
        customer.setEmail("john@example.com");

        customerDao.addCustomer(customer);

        List<Customer> customers = customerDao.getAllCustomers();
        assertFalse(customers.isEmpty());

        Customer last = customers.get(customers.size() - 1);
        testCustomerId = last.getId(); // Save for later tests
        assertEquals("John", last.getFirstName());

    }

    @Test
    @Order(2)
    public void testGetAllCustomers() {
        List<Customer> customers = customerDao.getAllCustomers();
        assertNotNull(customers);
        assertTrue(customers.size() > 0);
    }

    @Test
    @Order(3)
    public void testGetCustomerById() {
        Customer customer = customerDao.getCustomerById(testCustomerId);
        assertNotNull(customer, "Customer should not be null");
        assertEquals("John", customer.getFirstName());
        assertEquals("ACC12345", customer.getAccountNumber());
    }

    @Test
    @Order(4)
    public void testUpdateCustomer() {
        Customer customer = customerDao.getCustomerById(testCustomerId);
        assertNotNull(customer);
        customer.setFirstName("Jane");
        customer.setEmail("jane@example.com");

        customerDao.updateCustomer(customer);

        Customer updated = customerDao.getCustomerById(testCustomerId);
        assertEquals("Jane", updated.getFirstName());
        assertEquals("jane@example.com", updated.getEmail());
    }

    @Test
    @Order(5)
    public void testDeleteCustomer() {
        customerDao.deleteCustomer(testCustomerId);

        Customer deleted = customerDao.getCustomerById(testCustomerId);
        assertNull(deleted);
    }
    @Test
    @Order(6)
    public void testAccountNumberDoesNotExist() {
        assertFalse(customerDao.accountNumberExists("NONEXISTENT"), "Random account number should not exist");
    }
}
