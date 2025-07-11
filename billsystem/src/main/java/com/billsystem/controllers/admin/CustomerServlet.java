package com.billsystem.controllers.admin;


import com.billsystem.models.Customer;
import com.billsystem.services.CustomerService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("/CustomerServlet")
public class CustomerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Customer customer = new Customer();
        customer.setAccountNumber(request.getParameter("accountNumber"));
        customer.setFirstName(request.getParameter("firstName"));
        customer.setLastName(request.getParameter("lastName"));
        customer.setNid(request.getParameter("nid"));
        customer.setAddress(request.getParameter("address"));
        customer.setContactNumber(request.getParameter("contactNumber"));
        customer.setEmergencyNumber(request.getParameter("emergencyNumber"));
        customer.setEmail(request.getParameter("email"));

        CustomerService service = new CustomerService();
        service.addCustomer(customer);

        response.sendRedirect("addCustomer.jsp?success=true");
    }
}




