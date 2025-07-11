<%@ page import="com.billsystem.models.User" %><% User user; %><%--
  Created by IntelliJ IDEA.
  User: Dulakshi
  Date: 11/07/2025
  Time: 3:24 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SideBar</title>
</head>
<body>
<!-- Sidebar Overlay -->
<div class="sidebar-overlay" onclick="closeSidebar()"></div>

<div class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <h4>
            <i class="fas fa-book"></i>
            PahanaEdu Book Shop
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
        <a href="#">
            <i class="fas fa-users"></i>
            Customer Details
        </a>
        <a href="#">
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
        <a href="#">
            <i class="fas fa-print"></i>
            Cancel Bills
        </a>
    </div>

    <div class="sidebar-footer">

        <a href="login.jsp" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i>
            Logout
        </a>
    </div>
</div>
</body>
</html>
