<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Customer - PahanaEdu Book Shop</title>
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
        <h3>Add Customer</h3>
    </div>


    <div class="form-container">
        <% if ("true".equals(request.getParameter("success"))) { %>
        <p class="success-msg">Customer added successfully!</p>
        <% } %>


        <form action="CustomerServlet" method="post" class="styled-form">
            <div class="form-group">
                <label>First Name:</label>
                <input type="text" name="firstName" required>
            </div>

            <div class="form-group">
                <label>Last Name:</label>
                <input type="text" name="lastName" required>
            </div>

            <div class="form-group">
                <label>Account Number:</label>
                <input type="text" name="accountNumber" required>
            </div>

            <div class="form-group">
                <label>NID:</label>
                <input type="text" name="nid">
            </div>

            <div class="form-group">
                <label>Address:</label>
                <input type="text" name="address">
            </div>

            <div class="form-group">
                <label>Contact Number:</label>
                <input type="text" name="contactNumber">
            </div>

            <div class="form-group">
                <label>Emergency Number:</label>
                <input type="text" name="emergencyNumber">
            </div>

            <div class="form-group">
                <label>Email:</label>
                <input type="email" name="email">
            </div>

            <div class="form-group">
                <input type="submit" value="Add Customer" class="submit-btn">
            </div>

            <% if ("true".equals(request.getParameter("success"))) { %>
            <p class="success-msg">Customer added successfully!</p>
            <% } %>
        </form>
    </div>
</div>

<%@ include file="layouts/footer.jsp" %>

</body>
</html>
