package com.billsystem.dao;

import com.billsystem.models.User;
import org.junit.jupiter.api.*;

import static org.junit.jupiter.api.Assertions.*;

public class UserDaoTest {

    private static UserDao userDao;
    private static User testUser;

    @BeforeAll
    static void setup() {
        userDao = new UserDao();
        testUser = new User();
        testUser.setUsername("testuser");
        testUser.setPassword("hashedpassword123"); // assume pre-hashed or test hashing method
        testUser.setEmail("testuser@example.com");
        testUser.setUsertype(1);
    }

    @Test
    @Order(1)
    void testRegister() {
        boolean result = userDao.register(testUser);
        assertTrue(result, "User should be registered successfully");
    }

    @Test
    @Order(2)
    void testLogin() {
        User user = userDao.login("testuser", "hashedpassword123");
        assertNotNull(user, "Login should succeed and return a user");
        assertEquals("testuser", user.getUsername());
    }

    @Test
    @Order(3)
    void testGetAllUsers() {
        var users = userDao.getAllUsers();
        assertTrue(users.size() > 0, "User list should contain at least one user");
    }

    @Test
    @Order(4)
    void testGetUserById() {
        User user = userDao.login("testuser", "hashedpassword123");
        assertNotNull(user);
        User userById = userDao.getUserById(user.getId());
        assertNotNull(userById);
        assertEquals(user.getUsername(), userById.getUsername());
    }

    @Test
    @Order(5)
    void testUpdateUser() {
        User user = userDao.login("testuser", "hashedpassword123");
        assertNotNull(user);
        user.setEmail("updated@example.com");
        userDao.updateUser(user);

        User updatedUser = userDao.getUserById(user.getId());
        assertEquals("updated@example.com", updatedUser.getEmail());
    }

    @Test
    @Order(6)
    void testUpdatePasswordByUsername() {
        boolean updated = userDao.updatePasswordByUsername("testuser", "newhashedpassword");
        assertTrue(updated);

        User user = userDao.login("testuser", "newhashedpassword");
        assertNotNull(user);
    }

    @Test
    @Order(7)
    void testDeleteUser() {
        User user = userDao.login("testuser", "newhashedpassword");
        assertNotNull(user);
        userDao.deleteUserById(user.getId());

        User deletedUser = userDao.getUserById(user.getId());
        assertNull(deletedUser);
    }
}
