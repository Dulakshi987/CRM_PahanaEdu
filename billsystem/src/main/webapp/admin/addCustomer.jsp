<%--
  Created by IntelliJ IDEA.
  User: Dulakshi
  Date: 11/07/2025
  Time: 3:50 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>PahanEdu</title>
</head>

<body>
<h2>Add Customer</h2>
<form action="CustomerServlet" method="post">
    First Name: <input type="text" name="firstName" required><br><br>
    Last Name: <input type="text" name="lastName" required><br><br>
    Account Number: <input type="text" name="accountNumber" required><br><br>
    NID: <input type="text" name="nid" required><br><br>
    Address: <input type="text" name="address" required><br><br>
    Contact Number: <input type="number" name="contactNumber" required><br><br>
    Emergency Number: <input type="number" name="emergencyNumber" required><br><br>
    Email: <input type="email" name="email" required><br><br>
    <input type="submit" value="Add Customer">
</form>
<% if ("true".equals(request.getParameter("success"))) { %>
<p style="color: green;">Customer added successfully!</p>
<% } %>



</body>
</html>
