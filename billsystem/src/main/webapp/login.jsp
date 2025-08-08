<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - PahanaEdu Book Shop</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #f7f3ec;
        }

        .container-fluid {
            height: 100vh;
            display: flex;
        }

        .left-panel {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px;
            background-color: #f7f3ec;
        }

        .card {
            background-color: #fff8f0;
            border-radius: 16px;
            padding: 40px 30px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            max-width: 400px;
            width: 100%;
        }

        .card h2 {
            color: #e7993c;
            font-weight: bold;
            text-align: center;
        }

        .card small {
            color: #8b6f4e;
        }

        .form-control {
            border-radius: 8px;
            border: 1px solid #d5c4b2;
        }

        .btn-login {
            background-color: #e7993c;
            border: none;
            color: white;
            width: 100%;
            border-radius: 8px;
        }

        .btn-login:hover {
            background-color: #e7993c;
        }

        .right-panel {
            flex: 1;
            background-image: url('assets/images/book_shop.jpg'); /* your right image */
            background-size: cover;
            background-position: center;
        }

        .signup-link {
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
        }

        .signup-link a {
            color: #e7993c;
            text-decoration: none;
            font-weight: bold;
        }

        .signup-link a:hover {
            text-decoration: underline;
        }

        .header-title {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 20px;
            color: #e7993c;
            text-align: center;
        }

        .feedback {
            color: green;
            text-align: center;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .error-feedback {
            color: red;
            text-align: center;
            font-weight: bold;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="left-panel">
        <div class="card">

            <div class="header-title"><span id="typewriter"></span></div>

            <% String message = (String) request.getAttribute("message"); %>
            <% if (message != null) { %>
            <div class="feedback"><%= message %></div>
            <% } %>


            <% String registered = request.getParameter("registered"); %>
            <% if ("true".equals(registered)) { %>
            <div class="feedback">Registration successful! Please log in.</div>
            <% } %>

            <% String error = request.getParameter("error"); %>
            <% if ("invalid".equals(error)) { %>
            <div class="error-feedback">Invalid username or password!</div>
            <% } %>

            <h2>Sign In</h2>
            <%--            <small>Please enter your details</small>--%>

            <form method="post" action="login" class="mt-4">
                <div class="mb-3">
                    <label>Username</label>
                    <input type="text" name="username" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label>Password</label>
                    <input type="password" name="password" class="form-control" required>
                </div>

                <div class="mb-3 form-check">
                    <input type="checkbox" class="form-check-input" id="remember">
                    <label class="form-check-label" for="remember">Remember me</label>
                    <%--                    <a href="#" class="float-end" style="font-size: 12px;">Forgot password?</a>--%>
                </div>

                <button type="submit" class="btn btn-login mt-2">Sign In</button>


                <div class="text-center mt-3">
                    <a href="restpassword.jsp" style="color: #e7993c; text-decoration: none; font-weight: bold;">
                        Forgot Password?
                    </a>
                </div>

            </form>
        </div>
    </div>
    <div class="right-panel"></div>
</div>
</body>

<script src="assets/js/bootstrap.bundle.min.js"></script>
<script src="assets/js/bootstrap.bundle.min.js"></script>
<script>
    const text = "Welcome to PahanaEdu Book Shop";
    const speed = 70;
    let i = 0;

    function typeWriter() {
        if (i < text.length) {
            document.getElementById("typewriter").innerHTML += text.charAt(i);
            i++;
            setTimeout(typeWriter, speed);
        }
    }

    window.onload = typeWriter;
</script>
</body>
</html>

</html>
