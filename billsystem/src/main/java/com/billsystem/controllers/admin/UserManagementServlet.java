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

            // Fetch the actual user by ID
            User user = userService.getUserById(id);

            if (user != null) {
                // Allow deleting Admin (0) or Cashier (1)
                if (user.getUsertype() == 0 || user.getUsertype() == 1) {
                    userService.deleteUserById(user.getId()); // <-- delete by exact ID
                    HttpSession session = request.getSession();
                    session.setAttribute("successMessage",
                            "User (" + user.getUsername() + ") deleted successfully!");
                } else {
                    HttpSession session = request.getSession();
                    session.setAttribute("errorMessage", "This user type cannot be deleted!");
                }
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("errorMessage", "User not found!");
            }

            response.sendRedirect("UserManagementServlet");
            return;
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
