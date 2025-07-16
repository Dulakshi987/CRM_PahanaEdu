<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        .password-strength {
            height: 5px;
            margin-top: 5px;
            margin-bottom: 15px;
        }
        .strength-0 { background: #dc3545; width: 20%; }
        .strength-1 { background: #fd7e14; width: 40%; }
        .strength-2 { background: #ffc107; width: 60%; }
        .strength-3 { background: #28a745; width: 80%; }
        .strength-4 { background: #28a745; width: 100%; }
    </style>
</head>
<body>
<div class="container">
    <div class="register-box">
        <div class="header-text">Create Your Account</div>

        <%-- Error Messages --%>
        <% String error = request.getParameter("error"); %>
        <% if (error != null) { %>
        <div class="alert alert-danger">
            <% switch(error) {
                case "empty": %>
            Please fill all required fields.
            <% break;
                case "invalid_type": %>
            Invalid user type selected.
            <% break;
                case "registration_failed": %>
            Registration failed. Username may already be taken.
            <% break;
                default: %>
            An error occurred during registration.
            <% } %>
        </div>
        <% } %>

        <form id="registerForm" method="post" action="register">
            <div class="mb-3">
                <label class="form-label">Username <span class="text-danger">*</span></label>
                <input type="text" name="username" class="form-control" required
                       pattern="[a-zA-Z0-9]{4,20}"
                       title="4-20 alphanumeric characters">
                <div class="form-text">4-20 alphanumeric characters</div>
            </div>

            <div class="mb-3">
                <label class="form-label">Password <span class="text-danger">*</span></label>
                <input type="password" name="password" id="password" class="form-control" required
                       minlength="6"
                       pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$"
                       title="At least 6 characters with 1 uppercase, 1 lowercase, and 1 number">
                <div class="password-strength" id="passwordStrength"></div>
                <div class="form-text">At least 6 characters with 1 uppercase, 1 lowercase, and 1 number</div>
            </div>

            <div class="mb-3">
                <label class="form-label">Email <span class="text-danger">*</span></label>
                <input type="email" name="email" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">User Type <span class="text-danger">*</span></label>
                <select name="usertype" class="form-select" required>
                    <option value="">Select user type</option>
                    <option value="0">Admin</option>
                    <option value="1">Cashier</option>
                </select>
            </div>

            <button type="submit" class="btn btn-orange w-100">Register</button>
        </form>

        <div class="text-center mt-3">
            Already registered? <a href="login.jsp">Sign In</a>
        </div>
    </div>
</div>

<script src="assets/js/bootstrap.bundle.min.js"></script>
<script>
    // Password strength indicator
    document.getElementById('password').addEventListener('input', function() {
        const password = this.value;
        const strengthBar = document.getElementById('passwordStrength');
        let strength = 0;

        // Length check
        if (password.length > 5) strength++;
        if (password.length > 8) strength++;

        // Character variety checks
        if (/[A-Z]/.test(password)) strength++;
        if (/\d/.test(password)) strength++;
        if (/[^A-Za-z0-9]/.test(password)) strength++;

        // Cap at 4
        strength = Math.min(strength, 4);

        // Update UI
        strengthBar.className = 'password-strength strength-' + strength;
    });

    // Form validation
    document.getElementById('registerForm').addEventListener('submit', function(e) {
        const password = document.getElementById('password').value;
        if (password.length < 6) {
            alert('Password must be at least 6 characters long');
            e.preventDefault();
        }
    });
</script>
</body>
</html>