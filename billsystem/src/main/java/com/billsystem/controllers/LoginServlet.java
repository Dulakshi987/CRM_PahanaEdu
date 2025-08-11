package com.billsystem.controllers;

import com.billsystem.models.User;
import com.billsystem.services.UserServices;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;


@WebServlet("/LoginServlet")
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
            session.setAttribute("loggedUser", user.getUsername());
            session.setAttribute("role", user.getUsertype()); // 0 = admin, 1 = cashier
            session.setMaxInactiveInterval(30 * 60);

            if (user.getUsertype() == 0) {
                response.sendRedirect(request.getContextPath() + "/admin/adminDashboard.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/cashier/cashierDashboard.jsp");
            }
        }
    }
}
