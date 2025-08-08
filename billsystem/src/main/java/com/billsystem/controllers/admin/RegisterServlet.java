package com.billsystem.controllers.admin;

import com.billsystem.models.User;
import com.billsystem.services.UserServices;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class RegisterServlet extends HttpServlet {
    private final UserServices userService = new UserServices();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get data from form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        int usertype = Integer.parseInt(request.getParameter("usertype")); // 0 = admin or 1 =cashier

        // Set to model
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setEmail(email);
        user.setUsertype(usertype);

        // Save using service
        if (userService.register(user)) {
            response.sendRedirect("login.jsp?registered=true");
        } else {
            response.sendRedirect("register.jsp?error=1");
        }
    }
}
