<%--
  Created by IntelliJ IDEA.
  User: Dulakshi
  Date: 13/07/2025
  Time: 7:40 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.billsystem.models.Customer" %>
<%
    Customer customer = (Customer) request.getAttribute("customer");
%>
<html>
<head>
    <title>Edit Customer</title>
</head>
<body>
<h2>Edit Customer</h2>
<form action="UpdateCustomerServlet" method="post">
    <input type="hidden" name="id" value="<%= customer.getId() %>">
    Account Number: <input type="text" name="accountNumber" value="<%= customer.getAccountNumber() %>" required><br><br>
    First Name: <input type="text" name="firstName" value="<%= customer.getFirstName() %>" required><br><br>
    Last Name: <input type="text" name="lastName" value="<%= customer.getLastName() %>" required><br><br>
    NID: <input type="text" name="nid" value="<%= customer.getNid() %>" required><br><br>
    Address: <input type="text" name="address" value="<%= customer.getAddress() %>" required><br><br>
    Contact Number: <input type="text" name="contactNumber" value="<%= customer.getContactNumber() %>" required><br><br>
    Emergency Number: <input type="text" name="emergencyNumber" value="<%= customer.getEmergencyNumber() %>" required><br><br>
    Email: <input type="email" name="email" value="<%= customer.getEmail() %>" required><br><br>
    <input type="submit" value="Update Customer">
</form>
</body>
</html>

