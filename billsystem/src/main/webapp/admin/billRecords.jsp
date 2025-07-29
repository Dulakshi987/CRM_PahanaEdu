<%--
  Created by IntelliJ IDEA.
  User: Dulakshi
  Date: 29/07/2025
  Time: 9:55 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.*, java.text.SimpleDateFormat" %>
<%@ page import="com.billsystem.models.*, com.billsystem.services.*, com.billsystem.services.impl.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Bill> bills = (List<Bill>) request.getAttribute("bills");
    CustomerService customerService = new CustomerService();
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy hh:mm a");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bill Records</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .table thead {
            background: linear-gradient(135deg, #e7993c, #d4831f);
            color: white;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4 text-center text-primary">📄 All Bills</h2>

    <table class="table table-hover table-bordered">
        <thead>
        <tr>
            <th>Bill Number</th>
            <th>Customer</th>
            <th>Account No</th>
            <th>Date & Time</th>
            <th>Total</th>
            <th>Status</th>
            <th>Payment</th>
            <th>PDF</th>
        </tr>
        </thead>
        <tbody>
        <% if (bills != null && !bills.isEmpty()) {
            for (Bill b : bills) {
                Customer customer = customerService.getCustomerById(b.getCustomerId());
        %>
        <tr>
            <td>BILL<%= b.getBillId() %></td>
            <td><%= customer != null ? customer.getFirstName() : "Unknown" %></td>
            <td><%= customer != null ? customer.getAccountNumber() : "-" %></td>
            <td><%= b.getBillDate() != null ? sdf.format(b.getBillDate()) : "-" %></td>
            <td>LKR <%= String.format("%.2f", b.getGrandTotal()) %></td>
<%--            <td>--%>
<%--                <% if ("Paid".equalsIgnoreCase(b.getStatus())) { %>--%>
<%--                <span class="badge bg-success">Paid</span>--%>
<%--                <% } else if ("Unpaid".equalsIgnoreCase(b.getStatus())) { %>--%>
<%--                <span class="badge bg-warning text-dark">Unpaid</span>--%>
<%--                <% } else { %>--%>
<%--                <span class="badge bg-secondary">Unknown</span>--%>
<%--                <% } %>--%>
<%--            </td>--%>
            <td><%= b.getPaymentMethod() %></td>
            <td>
                <a href="DownloadBillServlet?billId=<%= b.getBillId() %>" class="btn btn-outline-primary btn-sm">Download</a>
            </td>
        </tr>
        <% }
        } else { %>
        <tr>
            <td colspan="8" class="text-center text-danger">No bills found.</td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
