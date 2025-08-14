<%--
  Created by IntelliJ IDEA.
  User: Dulakshi
  Date: 29/07/2025
  Time: 9:55 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.*, java.text.SimpleDateFormat" %>
<%@ page import="com.billsystem.models.*, com.billsystem.services.*, com.billsystem.services.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Bill> bills = (List<Bill>) request.getAttribute("bills");
    CustomerService customerService = new CustomerService();
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy hh:mm a");
%>

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
    if (role == null || role != 1) { // 1 = admin
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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bill Records - PahanaEdu Book Shop</title>
    <link href="../assets/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            background: #f9f9f9;
        }

        .navbar {
            position: fixed;
            top: 0;
            left: 260px; /* Sidebar width */
            right: 0;
            height: 60px;
            z-index: 1000;
        }

        .main-content {
            margin-left: 260px; /* Matches sidebar width */
            padding: 30px;
            padding-top: 100px; /* Leave space for navbar */
        }

        .form-container {
            background: white;
            padding: 30px;
            border-radius: 15px;
            max-width: 1000px;
            margin: auto;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }

        .table thead {
            background: linear-gradient(135deg, #e7993c, #d4831f);
            color: white;
        }

        .title {
            text-align: center;
            color: black;
            margin-bottom: 25px;
            font-size: 28px;
            font-weight: 600;
        }
    </style>
</head>
<body>

<%@ include file="layouts/sidebar.jsp" %>
<%@ include file="layouts/navbar.jsp" %>



<div class="main-content">
    <div class="form-container">
        <h2 class="title">View all of bills</h2>

        <%--search bar--%>
        <div class="mb-3">
            <input type="text" id="searchInput" class="form-control" placeholder="Search by Account No or Date (YYYY-MM-DD)">
        </div>


        <table class="table table-hover table-bordered">
            <thead>
            <tr>
                <th>Bill Number</th>
                <th>Customer</th>
                <th>Account No</th>
                <th>Date & Time</th>
                <th>Total</th>
                <th>Payment</th>
                <th>View</th>
            </tr>
            </thead>
            <tbody>
            <% if (bills != null && !bills.isEmpty()) {
                for (Bill b : bills) {
                    Customer customer = customerService.getCustomerById(b.getCustomerId());
            %>
            <tr>
                <td>BILL<%= b.getBillId() %></td>
                <td><%= customer != null ? customer.getFirstName() : "Unknown" %></td>
                <td><%= customer != null ? customer.getAccountNumber() : "-" %></td>
                <td><%= b.getBillDate() != null ? sdf.format(b.getBillDate()) : "-" %></td>
                <td>Rs. <%= String.format("%.2f", b.getGrandTotal()) %></td>
                <td><%= b.getPaymentMethod() != null ? b.getPaymentMethod() : "N/A" %></td>
                <td>

                    <a href="../printinvoice.jsp?billId=<%= b.getBillId() %>"
                       target="_blank"
                       class="btn btn-outline-success btn-sm" style="background-color: #e7993c; color: black;">View</a>
                </td>
            </tr>
            <% }
            } else { %>
            <tr>
                <td colspan="7" class="text-center text-danger">No bills found.</td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>

<%@ include file="layouts/footer.jsp" %>

<script>
    document.getElementById('searchInput').addEventListener('keyup', function () {
        const filter = this.value.toLowerCase();
        const rows = document.querySelectorAll('table tbody tr');

        rows.forEach(row => {
            const accountNo = row.cells[2].textContent.toLowerCase(); // Account No column
            const billDate = row.cells[3].textContent.toLowerCase(); // Date & Time column

            if (accountNo.includes(filter) || billDate.includes(filter)) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    });
</script>


</body>

</html>
