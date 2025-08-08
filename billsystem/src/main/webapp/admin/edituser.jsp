<%--
  Created by IntelliJ IDEA.
  User: Dulakshi
  Date: 06/08/2025
  Time: 9:19 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.billsystem.models.User" %>
<%
    User editUser = (User) request.getAttribute("editUser");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit User - PahanaEdu Book Shop</title>
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
        .form-group input[type="email"],
        .form-group select {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s ease;
        }

        .form-group input:focus,
        .form-group select:focus {
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

        .error-msg {
            color: red;
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
        <h3>Edit User</h3>
    </div>

    <%
        if (editUser == null) {
    %>
    <p class="error-msg">User not found.</p>
    <%
    } else {
    %>

    <div class="form-container">
        <form action="${pageContext.request.contextPath}/admin/UpdateUserServlet" method="post" class="styled-form">
            <input type="hidden" name="id" value="<%= editUser.getId() %>"/>

            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" name="username" id="username" value="<%= editUser.getUsername() %>" required>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" name="email" id="email" value="<%= editUser.getEmail() %>" required>
            </div>

            <div class="form-group">
                <label for="usertype">User Type:</label>
                <select name="usertype" id="usertype" required>
                    <option value="0" <%= (editUser.getUsertype() == 0) ? "selected" : "" %>>Admin</option>
                    <option value="1" <%= (editUser.getUsertype() == 1) ? "selected" : "" %>>Cashier</option>
                </select>
            </div>

            <div class="form-group">
                <input type="submit" value="Update User" class="submit-btn">
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
