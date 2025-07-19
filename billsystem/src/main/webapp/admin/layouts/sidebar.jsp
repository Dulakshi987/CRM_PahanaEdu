<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.billsystem.models.User" %>
<%
    User user = (User) session.getAttribute("user");
%>
<html>
<head>
    <title>Sidebar</title>
    <link rel="stylesheet" href="/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        /* Sidebar Styles */
        .sidebar {
            position: fixed;
            width: 280px;
            height: 100vh;
            background: linear-gradient(135deg, #e7993c, #d4831f);
            padding: 0;
            color: white;
            box-shadow: 4px 0 20px rgba(0,0,0,0.1);
            z-index: 1000;
            overflow-y: auto;
            transform: translateX(-100%);
            transition: transform 0.3s ease;
        }

        .sidebar.active {
            transform: translateX(0);
        }

        .sidebar-header {
            padding: 25px 20px;
            background: rgba(0,0,0,0.1);
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .sidebar-header h4 {
            margin: 0;
            font-size: 20px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
            color: #ffffff; /* White title */

        }

        .sidebar-menu {
            padding: 20px 0;
        }

        .sidebar-menu a {
            color: rgba(255,255,255,0.9);
            text-decoration: none;
            display: flex;
            align-items: center;
            padding: 15px 25px;
            transition: all 0.3s ease;
            border-left: 3px solid transparent;
            gap: 12px;
        }

        .sidebar-menu a:hover {
            background: rgba(255,255,255,0.1);
            border-left-color: #fff;
            color: #fff;
            transform: translateX(5px);
        }

        .sidebar-menu a.active {
            background: rgba(255,255,255,0.15);
            border-left-color: #fff;
            color: #fff;
        }

        .sidebar-menu a i {
            width: 20px;
            text-align: center;
        }

        .sidebar-footer {
            position: absolute;
            bottom: 0;
            width: 100%;
            padding: 20px;
            background: rgba(0,0,0,0.1);
            border-top: 1px solid rgba(255,255,255,0.1);
        }

        .user-info {
            font-size: 12px;
            opacity: 0.85;
            margin-bottom: 10px;
            color: white;
        }

        .logout-btn {
            background: rgba(255,255,255,0.1);
            border: 1px solid rgba(255,255,255,0.2);
            color: white;
            padding: 8px 15px;
            border-radius: 5px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            font-size: 12px;
        }

        .logout-btn:hover {
            background: rgba(255,255,255,0.2);
            color: white;
        }

        .sidebar-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0,0,0,0.5);
            z-index: 999;
        }

        /* Scrollbar styling */
        .sidebar::-webkit-scrollbar {
            width: 6px;
        }

        .sidebar::-webkit-scrollbar-track {
            background: rgba(0,0,0,0.1);
        }

        .sidebar::-webkit-scrollbar-thumb {
            background: rgba(255,255,255,0.3);
            border-radius: 3px;
        }

        .sidebar::-webkit-scrollbar-thumb:hover {
            background: rgba(255,255,255,0.5);
        }

        /* Responsive Sidebar */
        @media (max-width: 991.98px) {
            .sidebar {
                transform: translateX(-100%);
            }

            .sidebar.active {
                transform: translateX(0);
            }

            .sidebar-overlay.active {
                display: block;
            }
        }

        @media (min-width: 992px) {
            .sidebar {
                transform: translateX(0);
            }
        }

        @media (max-width: 375px) {
            .sidebar {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<!-- Sidebar Overlay -->
<div class="sidebar-overlay" onclick="closeSidebar()"></div>

<!-- Sidebar -->
<div class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <h4>
            <i class="fas fa-book"></i> PahanaEdu
        </h4>
    </div>

    <div class="sidebar-menu">
        <a href="admin/adminDashboard.jsp" class="active"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
        <a href="#"><i class="fas fa-cash-register"></i> Cashier Details</a>
        <a href="${pageContext.request.contextPath}/admin/ViewCustomerServlet">
            <i class="fas fa-users"></i> Customer Details
        </a>        <a href="addCustomer.jsp"><i class="fas fa-user-plus"></i> Add Customer</a>
        <a href="#"><i class="fas fa-user-plus"></i> Add Cashier</a>
        <a href="addItem.jsp"><i class="fas fa-plus-circle"></i> Add  Item</a>
        <a href="${pageContext.request.contextPath}/admin/ViewItemsServlet">
            <i class="fas fa-users"></i>  Manage Item
        </a>        <a href="#"><i class="fas fa-receipt"></i> Bill System</a>
        <a href="#"><i class="fas fa-print"></i> View / Print Bills</a>
    </div>

    <div class="sidebar-footer">
        <div class="user-info">
            <i class="fas fa-user"></i> Logged in as: <%= user.getUsername() %>
        </div>
        <a href="login.jsp" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
    </div>
</div>

</body>
</html>
