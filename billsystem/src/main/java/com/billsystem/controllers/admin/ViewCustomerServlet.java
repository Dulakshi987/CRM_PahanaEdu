package com.billsystem.controllers.admin;

import com.billsystem.models.Customer;
import com.billsystem.services.CustomerService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/ViewCustomersServlet")
public class ViewCustomerServlet extends HttpServlet {

    private final CustomerService service = new CustomerService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Customer> customers = service.getAllCustomers();
        request.setAttribute("customers", customers);

        // Forward to JSP page to display customers
        request.getRequestDispatcher("/admin/viewCustomer.jsp").forward(request, response);
    }

}
