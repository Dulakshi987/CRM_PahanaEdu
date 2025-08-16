package com.billsystem.controllers.admin;

import com.billsystem.models.User;
import com.billsystem.services.UserServices;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/UserManagementServlet")
public class UserManagementServlet extends HttpServlet {
    private final UserServices userService = new UserServices();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            userService.deleteUserById(id);

            // Set success message in session
            HttpSession session = request.getSession();
            session.setAttribute("successMessage", "User deleted successfully!");

            // Redirect to prevent form resubmission
            response.sendRedirect("UserManagementServlet");
            return; // Important: stop further processing
        }


        if ("edit".equalsIgnoreCase(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            User user = userService.getUserById(id);
            request.setAttribute("editUser", user);
        }

        List<User> users = userService.getAllUsers();
        request.setAttribute("users", users);
        request.getRequestDispatcher("/admin/viewUser.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        int usertype = Integer.parseInt(request.getParameter("usertype"));

        User user = new User();
        user.setId(id);
        user.setUsername(username);
        user.setEmail(email);
        user.setUsertype(usertype);

        userService.updateUser(user);
        response.sendRedirect("UserManagementServlet");
    }
}
