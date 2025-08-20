package com.billsystem.controllers.admin;

import com.billsystem.models.User;
import com.billsystem.services.UserServices;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/UpdateUserServlet")
public class UpdateUserServlet extends HttpServlet {
    private final UserServices userService = new UserServices();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        int usertype = Integer.parseInt(request.getParameter("usertype"));

        User existingUser = userService.getUserById(id);

        User user = new User();
        user.setId(id);
        user.setUsername(username);
        user.setEmail(email);
        user.setUsertype(usertype);
        if (password != null && !password.trim().isEmpty()) {
            user.setPassword(password);
        } else {
            user.setPassword(existingUser.getPassword());
        }

        userService.updateUser(user);
        request.getSession().setAttribute("successMessage", "User updated successfully!");

        response.sendRedirect("UserManagementServlet");
    }
}
