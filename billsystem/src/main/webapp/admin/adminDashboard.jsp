<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.billsystem.models.User" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || user.getUsertype() != 0) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - PahanaEdu Book Shop</title>
    <link rel="stylesheet" href="../assets/css/bootstrap.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
        }

        .sidebar {
            position: fixed;
            width: 280px;
            height: 100vh;
            background: linear-gradient(135deg, #e7993c 0%, #d4831f 100%);
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
        }

        .sidebar-header .subtitle {
            font-size: 12px;
            opacity: 0.8;
            margin-top: 5px;
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
            opacity: 0.8;
            margin-bottom: 10px;
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

        .content {
            margin-left: 280px;
            padding: 30px;
            min-height: 100vh;
            transition: margin-left 0.3s ease;
        }

        .mobile-header {
            display: none;
            background: white;
            padding: 15px 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 999;
        }

        .mobile-header .navbar-brand {
            font-weight: 600;
            color: #e7993c;
            margin: 0;
        }

        .mobile-toggle {
            background: none;
            border: none;
            color: #e7993c;
            font-size: 24px;
            cursor: pointer;
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

        .content-header {
            background: white;
            padding: 25px 30px;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }

        .content-header h3 {
            margin: 0;
            color: #333;
            font-weight: 600;
            font-size: 28px;
        }

        .content-header .breadcrumb {
            margin: 8px 0 0 0;
            font-size: 14px;
            color: #666;
            text-align: right;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .card-box {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .card-box:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }

        .card-box::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #e7993c, #d4831f);
        }

        .card-content {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .card-info h5 {
            margin: 0 0 10px 0;
            color: #333;
            font-size: 16px;
            font-weight: 600;
        }

        .card-info .number {
            font-size: 32px;
            font-weight: 700;
            color: #e7993c;
            line-height: 1;
            margin-bottom: 10px;
        }

        .card-info .label {
            font-size: 12px;
            color: #666;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .card-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, #e7993c, #d4831f);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
        }

        .card-footer {
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #eee;
        }

        .card-footer a {
            color: #e7993c;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 5px;
            transition: all 0.3s ease;
        }

        .card-footer a:hover {
            color: #d4831f;
            gap: 10px;
        }

        /* Status specific colors */
        .status-total { --status-color: #3498db; }
        .status-new { --status-color: #e74c3c; }
        .status-packed { --status-color: #f39c12; }
        .status-dispatched { --status-color: #95a5a6; }
        .status-transit { --status-color: #f39c12; }
        .status-delivery { --status-color: #3498db; }
        .status-delivered { --status-color: #27ae60; }
        .status-cancelled { --status-color: #e74c3c; }
        .status-users { --status-color: #2c3e50; }
        .status-books { --status-color: #95a5a6; }
        .status-categories { --status-color: #17a2b8; }
        .status-subcategories { --status-color: #3498db; }

        .card-box[class*="status-"] .number {
            color: var(--status-color);
        }

        .card-box[class*="status-"] .card-icon {
            background: linear-gradient(135deg, var(--status-color), var(--status-color));
        }

        .card-box[class*="status-"] .card-footer a {
            color: var(--status-color);
        }

        /* Responsive Design */
        @media (max-width: 991.98px) {
            .sidebar {
                width: 280px;
                transform: translateX(-100%);
            }

            .sidebar.active {
                transform: translateX(0);
            }

            .content {
                margin-left: 0;
                padding-top: 80px;
            }

            .mobile-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
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

        @media (max-width: 576px) {
            .content {
                padding: 80px 15px 15px;
            }

            .dashboard-grid {
                grid-template-columns: 1fr;
                gap: 15px;
            }

            .card-box {
                padding: 20px;
            }

            .card-content {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .card-icon {
                align-self: flex-end;
            }

            .content-header {
                padding: 20px;
            }

            .content-header h3 {
                font-size: 24px;
            }
        }

        @media (max-width: 375px) {
            .sidebar {
                width: 100%;
            }

            .card-box {
                padding: 15px;
            }

            .card-info .number {
                font-size: 28px;
            }

            .card-icon {
                width: 50px;
                height: 50px;
                font-size: 20px;
            }
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
    </style>
</head>
<body>
<!-- Mobile Header -->
<div class="mobile-header">
    <h5 class="navbar-brand">
        <i class="fas fa-book"></i> PahanaEdu Books
    </h5>
    <button class="mobile-toggle" onclick="toggleSidebar()">
        <i class="fas fa-bars"></i>
    </button>
</div>

<!-- Sidebar Overlay -->
<div class="sidebar-overlay" onclick="closeSidebar()"></div>

<div class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <h4>
            <i class="fas fa-book"></i>
            PahanaEdu Books
        </h4>
    </div>

    <div class="sidebar-menu">
        <a href="adminDashboard.jsp" class="active">
            <i class="fas fa-tachometer-alt"></i>
            Dashboard
        </a>
        <a href="#">
            <i class="fas fa-user-shield"></i>
            Admin Details
        </a>
        <a href="#">
            <i class="fas fa-cash-register"></i>
            Cashier Details
        </a>
        <a href="addCustomer.jsp">
            <i class="fas fa-users"></i>
            Add Customer
        </a>
        <a href="viewCustomer.jsp">
            <i class="fas fa-users"></i>
            Customer Details
        </a>
        <a href="addBook.jsp">
            <i class="fas fa-plus-circle"></i>
            Add Book Item
        </a>
        <a href="#">
            <i class="fas fa-book-open"></i>
            Manage Book Item
        </a>
        <a href="#">
            <i class="fas fa-receipt"></i>
            Bill System
        </a>
        <a href="#">
            <i class="fas fa-print"></i>
            View / Print Bills
        </a>
    </div>

    <div class="sidebar-footer">
        <div class="user-info">
            <i class="fas fa-user"></i>
            Logged in as: <%= user.getUsername() %>
        </div>
        <a href="login.jsp" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i>
            Logout
        </a>
    </div>
</div>

<div class="content">
    <div class="container-fluid">
        <div class="row">
            <div class="col-12">
                <div class="content-header">
                    <h3>Admin Dashboard</h3>


                </div>
            </div>
        </div>


        <div class="row">
            <div class="col-xl-3 col-lg-4 col-md-6 col-sm-6 col-12 mb-4">
                <div class="card-box status-total">
                    <div class="card-content">
                        <div class="card-info">
                            <h5>Total Admins</h5>
                            <div class="number">7</div>
                        </div>
                        <div class="card-icon">
                            <i class="fas fa-user-shield"></i>
                        </div>
                    </div>
                    <div class="card-footer">
                        <a href="#">
                            View Details <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-lg-4 col-md-6 col-sm-6 col-12 mb-4">
                <div class="card-box status-new">
                    <div class="card-content">
                        <div class="card-info">
                            <h5>Total Cashiers</h5>
                            <div class="number">3</div>
                        </div>
                        <div class="card-icon">
                            <i class="fas fa-cash-register"></i>
                        </div>
                    </div>
                    <div class="card-footer">
                        <a href="#">
                            View Details <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-lg-4 col-md-6 col-sm-6 col-12 mb-4">
                <div class="card-box status-packed">
                    <div class="card-content">
                        <div class="card-info">
                            <h5>Total Customers</h5>
                            <div class="number">0</div>
                        </div>
                        <div class="card-icon">
                            <i class="fas fa-users"></i>
                        </div>
                    </div>
                    <div class="card-footer">
                        <a href="#">
                            View Tasks <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-lg-4 col-md-6 col-sm-6 col-12 mb-4">
                <div class="card-box status-dispatched">
                    <div class="card-content">
                        <div class="card-info">
                            <h5>Total Books</h5>
                            <div class="number">1</div>
                        </div>
                        <div class="card-icon">
                            <i class="fas fa-book"></i>
                        </div>
                    </div>
                    <div class="card-footer">
                        <a href="#">
                            View Requests <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-lg-4 col-md-6 col-sm-6 col-12 mb-4">
                <div class="card-box status-dispatched">
                    <div class="card-content">
                        <div class="card-info">
                            <h5>Total Cancel Books</h5>
                            <div class="number">1</div>
                        </div>
                        <div class="card-icon">
                            <i class="fas fa-book-dead"></i>
                        </div>
                    </div>
                    <div class="card-footer">
                        <a href="#">
                            View Requests <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-lg-4 col-md-6 col-sm-6 col-12 mb-4">
                <div class="card-box status-transit">
                    <div class="card-content">
                        <div class="card-info">
                            <h5>Total Bills</h5>
                            <div class="number">0</div>
                        </div>
                        <div class="card-icon">
                            <i class="fas fa-file-invoice-dollar"></i>
                        </div>
                    </div>
                    <div class="card-footer">
                        <a href="#">
                            View Details <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-lg-4 col-md-6 col-sm-6 col-12 mb-4">
                <div class="card-box status-delivery">
                    <div class="card-content">
                        <div class="card-info">
                            <h5>Total Email Bills</h5>
                            <div class="number">0</div>
                        </div>
                        <div class="card-icon">
                            <i class="fas fa-envelope-open-text"></i>
                        </div>
                    </div>
                    <div class="card-footer">
                        <a href="#">
                            View Details <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-lg-4 col-md-6 col-sm-6 col-12 mb-4">
                <div class="card-box status-users">
                    <div class="card-content">
                        <div class="card-info">
                            <h5>Total Cancel Bills</h5>
                            <div class="number">2</div>
                        </div>
                        <div class="card-icon">
                            <i class="fas fa-file-invoice"></i>
                        </div>
                    </div>
                    <div class="card-footer">
                        <a href="#">
                            View Requests <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>



<script src="../assets/js/bootstrap.bundle.min.js"></script>
<script>
    function toggleSidebar() {
        const sidebar = document.getElementById('sidebar');
        const overlay = document.querySelector('.sidebar-overlay');

        sidebar.classList.toggle('active');
        overlay.classList.toggle('active');
    }

    function closeSidebar() {
        const sidebar = document.getElementById('sidebar');
        const overlay = document.querySelector('.sidebar-overlay');

        sidebar.classList.remove('active');
        overlay.classList.remove('active');
    }

    // Close sidebar when clicking on menu items in mobile
    document.querySelectorAll('.sidebar a').forEach(link => {
        link.addEventListener('click', function() {
            if (window.innerWidth <= 991) {
                closeSidebar();
            }
        });
    });

    // Handle window resize
    window.addEventListener('resize', function() {
        if (window.innerWidth > 991) {
            closeSidebar();
        }
    });
</script>
</body>
</html>