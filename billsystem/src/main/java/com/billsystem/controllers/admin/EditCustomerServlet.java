package com.billsystem.controllers.admin;


import com.billsystem.models.Customer;
import com.billsystem.services.CustomerService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/EditCustomerServlet")
    public class EditCustomerServlet extends HttpServlet {
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, IOException {
            int id = Integer.parseInt(request.getParameter("id"));

            CustomerService service = new CustomerService();
            Customer customer = service.getCustomerById(id);

            request.setAttribute("customer", customer);
            request.getRequestDispatcher("/admin/editCustomer.jsp").forward(request, response);
        }
    }

