<%--
  Created by IntelliJ IDEA.
  User: Dulakshi
  Date: 13/07/2025
  Time: 7:15 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.billsystem.models.Customer" %>


<html>
<head>
    <title>Customer List</title>
</head>
<body>
<div class="container mt-5">
    <h2>Customer List</h2>

    <table class="table table-bordered mt-3">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Account Number</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>NID</th>
            <th>Address</th>
            <th>Contact</th>
            <th>Emergency</th>
            <th>Email</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Customer> list = (List<Customer>) request.getAttribute("customerList");
            if (list != null && !list.isEmpty()) {
                for (Customer c : list) {
        %>
        <tr>
            <td><%= c.getId() %></td>
            <td><%= c.getAccountNumber() %></td>
            <td><%= c.getFirstName() %></td>
            <td><%= c.getLastName() %></td>
            <td><%= c.getNid() %></td>
            <td><%= c.getAddress() %></td>
            <td><%= c.getContactNumber() %></td>
            <td><%= c.getEmergencyNumber() %></td>
            <td><%= c.getEmail() %></td>
            <td>
                <a href="editCustomer.jsp?id=<%= c.getId() %>" class="btn btn-sm btn-primary">Edit</a>
                <a href="DeleteCustomerServlet?id=<%= c.getId() %>" class="btn btn-sm btn-danger"
                   onclick="return confirm('Are you sure?')">Delete</a>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr><td colspan="10" class="text-center">No customers found.</td></tr>
        <% } %>
        </tbody>
    </table>
</div>

</body>
</html>
