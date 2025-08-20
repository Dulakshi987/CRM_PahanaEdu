<%--
  Created by IntelliJ IDEA.
  User: Dulakshi
  Date: 11/08/2025
  Time: 9:34 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    HttpSession sessionObj = request.getSession(false);

    // Step 1: Check if logged in
    if (sessionObj == null || sessionObj.getAttribute("loggedUser") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    // Step 2: Allow only role = 1 (Cashier)
    Integer role = (Integer) sessionObj.getAttribute("role");
    if (role == null || role != 1) { // 1 = cashier
        sessionObj.invalidate(); // destroy session
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    // Step 3: Prevent browser cache
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>


<html>
<head>
    <title>Pahana Edu | Help </title>
    <link rel="stylesheet" href="../assets/css/bootstrap.min.css">

</head>


<style>
    /* Help Section styling */
    .help-container {
        max-width: 900px;
        margin: 30px auto;
        background-color: #fff8e1;
        border: 2px solid #e7993c;
        border-radius: 12px;
        padding: 25px 30px;
        box-shadow: 0 4px 15px rgba(231, 153, 60, 0.3);
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        color: #333;
        line-height: 1.6;
        margin-right: 120px;

    }
    .help-container h2 {
        color: #e7993c;
        margin-bottom: 20px;
        font-weight: 700;
        border-bottom: 2px solid #e7993c;
        padding-bottom: 8px;
    }
    .help-section {
        margin-bottom: 25px;
    }
    .help-section h3 {
        color: #bf6f00;
        margin-bottom: 10px;
    }
    .help-section p {
        margin-left: 20px;
    }
    .help-list {
        margin-left: 40px;
        list-style-type: disc;
    }
    .help-list li {
        margin-bottom: 8px;
    }
</style>

<body>

<%@ include file="layouts/sidebar.jsp" %>
<%@ include file="layouts/navbar.jsp" %>


<br><br><br><br>


<div class="help-container">
    <h2>Billing System - Cashier Help Guide</h2>

    <div class="help-section">
        <h3>1. Logging In</h3>
        <p>To access the system, enter your registered username and password on the login page. Only authorized users can enter. Admins have full access, cashiers have limited access and reset their password.</p>
    </div>

    <div class="help-section">
        <h3>2. Dashboard Overview</h3>
        <p>After login, you are directed to the dashboard where you can:</p>
        <ul class="help-list">
            <li>Navigate to manage customers, bill generate and view bills</li>
        </ul>
    </div>

    <div class="help-section">
        <h3>3.  Manage Customers</h3>
        <p>Go to the " View Customers" section  name, email, contact number, and address. Submit the form to view.</p>
    </div>

    <div class="help-section">
        <h3>4. Generating Bills</h3>
        <p>To create a bill:</p>
        <ul class="help-list">
            <li>Select a customer by name or account number</li>
            <li>Add one or more items by selecting from the list</li>
            <li>Enter quantities; the system calculates totals automatically</li>
            <li>Save the bill; it records transaction details in the database</li>
            <li>Optionally print or email the invoice</li>
        </ul>
    </div>


    <div class="help-section">
        <h3>5. Logging Out</h3>
        <p>Use the logout button at the top-right corner to safely end your session. This prevents unauthorized access if you leave the computer unattended.</p>
    </div>

    <div class="help-section">
        <h3>7. Troubleshooting & Support</h3>
        <p>If you face issues such as login problems, missing data, or unexpected errors:</p>
        <ul class="help-list">
            <li>Check your internet connection</li>
            <li>Clear your browser cache and refresh</li>
            <li>Contact system administrator for account or permission issues</li>
            <li>Report bugs with detailed steps to reproduce</li>
        </ul>
    </div>
</div>
<%@ include file="layouts/footer.jsp" %>

</body>
</html>
