package com.billsystem.controllers;

import com.billsystem.models.User;
import com.billsystem.services.UserServices;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class LoginServlet extends HttpServlet {
    private final UserServices userService = new UserServices();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = userService.login(username, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Redirect based on usertype
            if (user.getUsertype() == 0) {
                response.sendRedirect("admin/adminDashboard.jsp");
            } else {
                response.sendRedirect("cashier/cashierDashboard.jsp");
            }
        } else {
            response.sendRedirect("login.jsp?error=invalid");
        }
    }
}
