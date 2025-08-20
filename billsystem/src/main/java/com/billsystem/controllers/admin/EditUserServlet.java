package com.billsystem.controllers.admin;

import com.billsystem.models.User;
import com.billsystem.services.UserServices;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/EditUserServlet")
public class EditUserServlet extends HttpServlet {
    private final UserServices userService = new UserServices();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        User user = userService.getUserById(id);
        request.setAttribute("editUser", user);
        request.getRequestDispatcher("/admin/edituser.jsp").forward(request, response);
    }
}
