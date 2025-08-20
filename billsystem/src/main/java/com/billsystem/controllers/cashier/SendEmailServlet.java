package com.billsystem.controllers.cashier;

import com.billsystem.models.BillItem;
import com.billsystem.models.Customer;
import com.billsystem.models.Item;
import com.billsystem.services.CustomerService;
import com.billsystem.services.ItemService;
import com.billsystem.utils.EmailUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/cashier/SendEmailServlet")
public class SendEmailServlet extends HttpServlet {
    private final CustomerService customerService = new CustomerService();
    private final ItemService itemService = new ItemService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");

        try {
            // Get customer ID from request
            int customerId = Integer.parseInt(request.getParameter("customerId"));

            // Get customer details
            Customer customer = customerService.getCustomerById(customerId);
            if (customer == null) {
                response.getWriter().write("Customer not found.");
                return;
            }

            String customerEmail = customer.getEmail();
            if (customerEmail == null || customerEmail.trim().isEmpty()) {
                response.getWriter().write("Customer email not found.");
                return;
            }

            // Get bill items from session
            HttpSession session = request.getSession();
            List<BillItem> billItems = (List<BillItem>) session.getAttribute("billItems");

            if (billItems == null || billItems.isEmpty()) {
                response.getWriter().write("No items in the current bill to send.");
                return;
            }

            // Get form values for calculations
            double discount = 0;
            double taxRate = 8; // Default tax rate

            try {
                if (request.getParameter("discount") != null && !request.getParameter("discount").isEmpty()) {
                    discount = Double.parseDouble(request.getParameter("discount"));
                }
                if (request.getParameter("tax") != null && !request.getParameter("tax").isEmpty()) {
                    taxRate = Double.parseDouble(request.getParameter("tax"));
                }
            } catch (NumberFormatException e) {
                // Use default values if parsing fails
            }

            // Calculate totals
            double subtotal = 0;
            StringBuilder itemsHtml = new StringBuilder();

            itemsHtml.append("<table border='1' cellpadding='8' cellspacing='0' style='border-collapse: collapse; width: 100%;'>")
                    .append("<tr style='background-color: #f8f9fa;'>")
                    .append("<th>Item Code</th><th>Item Name</th><th>Quantity</th><th>Unit Price</th><th>Total</th>")
                    .append("</tr>");

            for (BillItem billItem : billItems) {
                Item item = itemService.getItemById(billItem.getItemId());
                if (item != null) {
                    double itemTotal = billItem.getQuantity() * item.getPricePerUnit();
                    subtotal += itemTotal;

                    itemsHtml.append("<tr>")
                            .append("<td>").append(item.getItemCode()).append("</td>")
                            .append("<td>").append(item.getItemName()).append("</td>")
                            .append("<td>").append(billItem.getQuantity()).append("</td>")
                            .append("<td>Rs.").append(String.format("%.2f", item.getPricePerUnit())).append("</td>")
                            .append("<td>Rs.").append(String.format("%.2f", itemTotal)).append("</td>")
                            .append("</tr>");
                }
            }

            itemsHtml.append("</table>");

            // discount is percentage, e.g. 10 for 10%
            double discountAmount = subtotal * (discount / 100);
            double discountedAmount = Math.max(subtotal - discountAmount, 0);

            double taxAmount = discountedAmount * (taxRate / 100);
            double grandTotal = discountedAmount + taxAmount;

            // Compose email content
            String subject = "Invoice Preview - Thank you for your purchase!";
            StringBuilder emailBody = new StringBuilder();

            emailBody.append("<div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;'>")
                    .append("<h2 style='color: #007bff; text-align: center;'>Invoice Preview</h2>")
                    .append("<div style='margin-bottom: 20px;'>")
                    .append("<p><strong>Customer:</strong> ").append(customer.getFirstName()).append(" ").append(customer.getLastName()).append("</p>")
                    .append("<p><strong>Account Number:</strong> ").append(customer.getAccountNumber()).append("</p>")
                    .append("<p><strong>Email:</strong> ").append(customerEmail).append("</p>")
                    .append("<p><strong>Date:</strong> ").append(new java.util.Date()).append("</p>")
                    .append("</div>")
                    .append("<h3>Items:</h3>")
                    .append(itemsHtml.toString())
                    .append("<div style='margin-top: 20px; text-align: right;'>")
                    .append("<p><strong>Subtotal: Rs.").append(String.format("%.2f", subtotal)).append("</strong></p>")
                    .append("<p><strong>Discount:").append(String.format("%.2f", discount)).append("%</strong></p>")
                    .append("<p><strong>Tax (").append(String.format("%.1f", taxRate)).append("%): Rs.").append(String.format("%.2f", taxAmount)).append("</strong></p>")
                    .append("<h3 style='color: #28a745;'>Grand Total: Rs.").append(String.format("%.2f", grandTotal)).append("</h3>")
                    .append("</div>")
                    .append("<div style='margin-top: 30px; padding: 15px; background-color: #f8f9fa; border-radius: 5px;'>")
                    .append("<p style='margin: 0; font-size: 14px; color: #6c757d;'>This is a preview of your invoice. The actual invoice will be generated when the bill is saved.</p>")
                    .append("</div>")
                    .append("</div>");

            // Test email configuration first
            System.out.println("Testing email configuration...");
            if (!EmailUtil.testEmailConfiguration()) {
                response.getWriter().write("Email configuration test failed. Please check SMTP settings and credentials.");
                return;
            }

            // Send email
            System.out.println("Sending email to: " + customerEmail);
            boolean emailSent = EmailUtil.sendEmail(customerEmail, subject, emailBody.toString());

            if (emailSent) {
                response.getWriter().write("Invoice preview sent successfully to " + customerEmail);
                System.out.println("Email sent successfully to: " + customerEmail);
            } else {
                response.getWriter().write("Failed to send invoice email. Please check server logs for details.");
                System.out.println("Failed to send email to: " + customerEmail);
            }

        } catch (NumberFormatException e) {
            response.getWriter().write("Invalid customer ID provided.");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error occurred while sending email: " + e.getMessage());
        }
    }
}