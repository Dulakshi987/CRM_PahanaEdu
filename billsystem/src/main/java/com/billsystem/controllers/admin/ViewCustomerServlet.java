package com.billsystem.controllers.admin;

import com.billsystem.models.Customer;
import com.billsystem.services.CustomerService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


@WebServlet("/ViewCustomerServlet")
    public class ViewCustomerServlet extends HttpServlet {
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            CustomerService service = new CustomerService();
            List<Customer> customers = service.getAllCustomers();
            request.setAttribute("customerList", customers);
            request.getRequestDispatcher("viewCustomer.jsp").forward(request, response);
        }
    }


