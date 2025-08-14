<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.billsystem.models.Customer" %>

<%--session and cache handling--%>
<%
    HttpSession sessionObj = request.getSession(false);

    //Not logged in → go to login
    if (sessionObj == null || sessionObj.getAttribute("loggedUser") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    //Role mismatch → logout and go to login
    Integer role = (Integer) sessionObj.getAttribute("role");
    if (role == null || role != 1) { // 0 = admin
        sessionObj.invalidate(); // end session
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    //Prevent browser cache (so back button won't reopen restricted pages)
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>


<!DOCTYPE html>
<html>
<head>
    <title>Edit Customer - PahanaEdu Book Shop</title>
    <link rel="stylesheet" href="../assets/css/bootstrap.min.css">

    <style>
        .form-container {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: auto;
            margin-top: 30px;
        }

        .styled-form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            margin-bottom: 5px;
            font-weight: 500;
            color: #333;
        }

        .form-group input[type="text"],
        .form-group input[type="email"] {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s ease;
        }

        .form-group input:focus {
            border-color: #e7993c;
            outline: none;
        }

        .submit-btn {
            background: #e7993c;
            color: white;
            border: none;
            padding: 12px;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .submit-btn:hover {
            background: #d4831f;
        }

        .success-msg {
            color: green;
            font-weight: bold;
            margin-top: 15px;
            text-align: center;
        }
    </style>
</head>
<body>

<%@ include file="layouts/sidebar.jsp" %>
<%@ include file="layouts/navbar.jsp" %>

<br><br><br><br>

<div class="content">
    <div class="content-header" style="text-align: center">
        <h3>Edit Customer</h3>
    </div>

    <%
        Customer c = (Customer) request.getAttribute("customer");
        if (c == null) {
    %>
    <p class="success-msg" style="color: red;">Customer not found.</p>
    <%
    } else {
    %>

    <div class="form-container">
        <form action="${pageContext.request.contextPath}/cashier/UpdateCustomerServlet" method="post" class="styled-form">
            <input type="hidden" name="id" value="<%= c.getId() %>"/>

            <div class="form-group">
                <label>First Name:</label>
                <input type="text" name="firstName" value="<%= c.getFirstName() %>" required>
            </div>

            <div class="form-group">
                <label>Last Name:</label>
                <input type="text" name="lastName" value="<%= c.getLastName() %>" required>
            </div>

            <div class="form-group">
                <label>Account Number:</label>
                <input type="text" name="accountNumber" value="<%= c.getAccountNumber() %>" required>
            </div>

            <div class="form-group">
                <label>NID:</label>
                <input type="text" name="nid" value="<%= c.getNid() %>">
            </div>

            <div class="form-group">
                <label>Address:</label>
                <input type="text" name="address" value="<%= c.getAddress() %>">
            </div>

            <div class="form-group">
                <label>Contact Number:</label>
                <input type="text" name="contactNumber" value="<%= c.getContactNumber() %>">
            </div>

            <div class="form-group">
                <label>Emergency Number:</label>
                <input type="text" name="emergencyNumber" value="<%= c.getEmergencyNumber() %>">
            </div>

            <div class="form-group">
                <label>Email:</label>
                <input type="email" name="email" value="<%= c.getEmail() %>">
            </div>

            <div class="form-group">
                <input type="submit" value="Update Customer" class="submit-btn">
            </div>
        </form>
    </div>

    <%
        }
    %>
</div>

<%@ include file="layouts/footer.jsp" %>

</body>
</html>
