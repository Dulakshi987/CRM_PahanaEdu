<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register - PahanaEdu Book Shop</title>
    <link href="assets/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #fff7e6;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .register-box {
            max-width: 500px;
            margin: 60px auto;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }

        .btn-orange {
            background-color: #e7993c;
            color: white;
        }

        .btn-orange:hover {
            background-color: #cc7e22;
        }

        .header-text {
            text-align: center;
            color: #e7993c;
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        a {
            color: #e7993c;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="register-box">
        <div class="header-text">Create Your Account</div>

        <form method="post" action="register">
            <div class="mb-3">
                <label class="form-label">Username</label>
                <input type="text" name="username" class="form-control" required />
            </div>

            <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="password" name="password" class="form-control" required />
            </div>

            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" name="email" class="form-control" required />
            </div>

            <div class="mb-3">
                <label class="form-label">User Type</label>
                <select name="usertype" class="form-select">
                    <option value="0">Admin</option>
                    <option value="1">Cashier</option>
                </select>
            </div>

            <button type="submit" class="btn btn-orange w-100">Register</button>
        </form>

        <% String error = request.getParameter("error"); %>
        <% if ("1".equals(error)) { %>
        <div class="alert alert-danger mt-3">Registration failed. Try again.</div>
        <% } %>

        <div class="text-center mt-3">
            Already registered? <a href="login.jsp">Sign In</a>
        </div>
    </div>
</div>

<script src="assets/js/bootstrap.bundle.min.js"></script>
</body>
</html>
