package com.billsystem.controllers;

import com.billsystem.services.UserServices;
import com.billsystem.utils.HashPassword;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {
    private UserServices userService;

    @Override
    public void init() throws ServletException {
        super.init();
        userService = new UserServices();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String newPassword = request.getParameter("newPassword");

        // Hash the password
        String hashedPassword = HashPassword.hashPassword(newPassword);

        boolean success = userService.resetPassword(username, hashedPassword);

        if (success) {
            request.setAttribute("message", "Password reset successfully.");
        } else {
            request.setAttribute("message", "Invalid username or error occurred.");
        }

        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
