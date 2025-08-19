<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
    if (role == null || role != 0) { // 0 = admin
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
    <title>Register - PahanaEdu Book Shop</title>
    <link href="../assets/css/bootstrap.min.css" rel="stylesheet">
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

<%@ include file="layouts/sidebar.jsp" %>
<%@ include file="layouts/navbar.jsp" %>

<br><br><br><br>

<div class="container">
    <div class="register-box">
        <div class="header-text">Create Your Account</div>

        <%-- Success message --%>
        <% String success = request.getParameter("success"); %>
        <% if ("true".equals(success)) { %>
        <div class="alert alert-success">
            Registration successful! You can now log in.
        </div>
        <% } %>

        <%-- Error messages --%>
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
            Registration failed. Username or email may already be taken.
            <% break;
                default: %>
            An error occurred during registration.
            <% } %>

        </div>
        <% } %>


        <form id="registerForm" method="post" action="${pageContext.request.contextPath}/admin/RegisterServlet">
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

            <button type="submit" class="btn btn-orange w-100" style="background-color: #e7993c;">Register</button>
        </form>

    </div>
</div>

<script src="../assets/js/bootstrap.bundle.min.js"></script>
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

<%@ include file="layouts/footer.jsp" %>

</body>
</html>