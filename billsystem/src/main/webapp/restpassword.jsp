<%--
  Created by IntelliJ IDEA.
  User: Dulakshi
  Date: 07/08/2025
  Time: 6:23 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Reset Password</title>
    <style>
        body {
            font-family: Arial;
            background: #f4f4f4;
            padding: 50px;
        }
        .form-container {
            background: white;
            width: 400px;
            margin: 0 auto;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 0 10px gray;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
        }
        input[type="submit"] {
            background: #e7993c;
            color: white;
            padding: 10px 20px;
            margin-top: 20px;
            border: none;
            width: 100%;
        }
        .message {
            margin-top: 15px;
            color: #e7993c;
        }
    </style>
</head>
<body>
<div class="form-container">
    <h2>Reset Password</h2>
    <form action="ResetPasswordServlet" method="post">
        <label>Username:</label>
        <input type="text" name="username" required>

        <label>New Password:</label>
        <input type="password" name="newPassword" required>

        <input type="submit" value="Reset Password">
    </form>


</div>
</body>
</html>

