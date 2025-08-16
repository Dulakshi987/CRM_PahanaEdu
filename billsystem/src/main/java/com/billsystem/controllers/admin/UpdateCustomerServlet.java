package com.billsystem.controllers.admin;

import com.billsystem.models.Customer;
import com.billsystem.services.CustomerService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin/UpdateCustomerServlet")
public class UpdateCustomerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String accountNumber = request.getParameter("accountNumber");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String nid = request.getParameter("nid");
        String address = request.getParameter("address");
        String contactNumber = request.getParameter("contactNumber");
        String emergencyNumber = request.getParameter("emergencyNumber");
        String email = request.getParameter("email");

        Customer customer = new Customer();
        customer.setId(id);
        customer.setAccountNumber(accountNumber);
        customer.setFirstName(firstName);
        customer.setLastName(lastName);
        customer.setNid(nid);
        customer.setAddress(address);
        customer.setContactNumber(contactNumber);
        customer.setEmergencyNumber(emergencyNumber);
        customer.setEmail(email);

        CustomerService service = new CustomerService();
        service.updateCustomer(customer);  //update logic in service layer

        //  Set success message in session
        HttpSession session = request.getSession();
        session.setAttribute("successMessage", "Customer updated successfully!");


        response.sendRedirect(request.getContextPath() + "/admin/ViewCustomerServlet");
    }


}
