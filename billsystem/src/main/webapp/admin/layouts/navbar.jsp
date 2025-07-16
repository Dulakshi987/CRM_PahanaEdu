<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <title>PahanaEdu Navbar</title>
    <link rel="stylesheet" href="../assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
        }

        /* Mobile Header */
        .mobile-header {
            display: none;
            background: linear-gradient(135deg, #e7993c, #d4831f);
            color: white;
            padding: 15px 20px;
            border-left: 4px solid #d17b12; /* same as sidebar */
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 999;
        }

        .mobile-header .navbar-brand {
            font-weight: 600;
            font-size: 18px;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .typewriter-text {
            overflow: hidden;
            white-space: nowrap;
            border-right: 2px solid white;
            animation: typing 2.5s steps(30, end), blink-caret 0.75s step-end infinite;
        }

        .mobile-toggle {
            background: none;
            border: none;
            color: white;
            font-size: 24px;
            cursor: pointer;
        }

        /* Desktop Top Navbar */
        .top-navbar {
            display: none;
            background: linear-gradient(135deg, #e7993c, #d4831f);
            color: white;
            padding: 15px 0;
            border-left: 4px solid #d17b12; /* consistent with sidebar */
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            position: fixed;
            top: 0;
            left: 280px;
            right: 0;
            z-index: 998;
        }

        .navbar-container {
            padding: 0 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .welcome-text {
            font-size: 18px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .navbar-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .navbar-item {
            font-size: 15px;
            font-weight: 500;
            color: white;
            cursor: pointer;
        }

        .navbar-item i {
            margin-right: 5px;
        }

        .dropdown {
            position: relative;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            background-color: white;
            color: black;
            min-width: 150px;
            box-shadow: 0px 8px 16px rgba(0,0,0,0.2);
            z-index: 1000;
            border-radius: 4px;
            overflow: hidden;
        }

        .dropdown-content a {
            color: #333;
            padding: 10px 15px;
            display: block;
            text-decoration: none;
        }

        .dropdown-content a:hover {
            background-color: #f1f1f1;
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }

        @keyframes typing {
            from { width: 0 }
            to { width: 100% }
        }

        @keyframes blink-caret {
            from, to { border-color: transparent }
            50% { border-color: white }
        }

        @media (max-width: 991.98px) {
            .mobile-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .top-navbar {
                display: none;
            }
        }

        @media (min-width: 992px) {
            .top-navbar {
                display: block;
            }
            .mobile-header {
                display: none;
            }
        }
    </style>
</head>
<body>

<!-- Mobile Navbar -->
<div class="mobile-header">
    <h5 class="navbar-brand">
        <i class="fas fa-book"></i>
        <span class="typewriter-text">PahanaEdu Book Shop</span>
    </h5>
    <button class="mobile-toggle" onclick="toggleSidebar()">
        <i class="fas fa-bars"></i>
    </button>
</div>

<!-- Desktop Navbar -->
<div class="top-navbar">
    <div class="navbar-container">
        <div class="welcome-text">
            <i class="fas fa-book"></i>
            <span class="typewriter-text">PahanaEdu Book Shop</span>
        </div>
        <div class="navbar-right">
            <div class="navbar-item" title="Search">
                <i class="fas fa-search"></i>
            </div>
<%--            <div class="navbar-item" title="Notifications">--%>
<%--                <i class="fas fa-bell"></i>--%>
<%--            </div>--%>
            <div class="navbar-item dropdown">
                <span><i class="fas fa-user-circle"></i> Admin</span>
                <div class="dropdown-content">
<%--                    <a href="#"><i class="fas fa-user"></i> Profile</a>--%>
                    <a href="login.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Optional Sidebar (for testing toggle) -->
<div id="sidebar" style="display:none; background:#f2f2f2; width:250px; height:100vh; position:fixed; top:0; left:0; z-index:1000; box-shadow:2px 0 10px rgba(0,0,0,0.1); padding:20px;">
    <h4>Sidebar Content</h4>
    <p>This is your sidebar.</p>
    <button onclick="toggleSidebar()">Close Sidebar</button>
</div>

<script>
    function toggleSidebar() {
        const sidebar = document.getElementById("sidebar");
        sidebar.style.display = sidebar.style.display === "block" ? "none" : "block";
    }
</script>

</body>
</html>
