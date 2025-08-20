<%@ page import="com.billsystem.models.Customer, java.util.List" %>
<%@ page import="com.billsystem.services.CustomerService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--session and cache handling--%>
<%
    HttpSession sessionObj = request.getSession(false);

    // Step 1: Check if logged in
    if (sessionObj == null || sessionObj.getAttribute("loggedUser") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    // Step 2: Allow only role = 1 (Cashier)
    Integer role = (Integer) sessionObj.getAttribute("role");
    if (role == null || role != 1) { // 1 = cashier
        sessionObj.invalidate(); // destroy session
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    // Step 3: Prevent browser cache
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html>
<html>
<head>
    <title>View Customers</title>
    <link rel="stylesheet" href="../assets/css/bootstrap.min.css">

    <style>
        .custom-thead {
            background: linear-gradient(135deg, #e7993c, #d4831f);
            color: white;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }

        .table-custom {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .table-hover tbody tr:hover {
            background-color: #fff3e0; /* light orange hover */
        }

        .btn {
            border-radius: 8px;
        }
    </style>

<%--    <link rel="stylesheet" href="assets/css/bootstrap.min.css">--%>

</head>
<body>

<%@ include file="layouts/sidebar.jsp" %>
<%@ include file="layouts/navbar.jsp" %>

<br><br><br><br>

<div class="main-content" style="margin-left: 280px; padding: 30px;">
    <h2 class="text-center mb-4">Customer List</h2>

<%--    <%--%>
<%--        CustomerService service = new CustomerService();--%>
<%--        List<Customer> customers = service.getAllCustomers();--%>
<%--    %>--%>

    <%
        List<Customer> customers = (List<Customer>) request.getAttribute("customers");
    %>

    <%
        String successMessage = (String) session.getAttribute("successMessage");
        if (successMessage != null) {
    %>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <%= successMessage %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <%
            session.removeAttribute("successMessage"); // Clear after displaying
        }
    %>

    <div class="mb-3">
        <input type="text" id="searchInput" class="form-control" placeholder="Search by Account No or NID...">
    </div>


    <div class="table-responsive">
        <table class="table table-bordered table-hover table-custom align-middle">
            <thead class="custom-thead text-white text-center">
            <tr>
                <th>Account No</th>
                <th>Name</th>
                <th>NID</th>
                <th>Address</th>
                <th>Contact</th>
                <th>Email</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody class="text-center">
            <% for (Customer c : customers) { %>
            <tr>
                <td><%= c.getAccountNumber() %></td>
                <td><%= c.getFirstName() + " " + c.getLastName() %></td>
                <td><%= c.getNid() %></td>
                <td><%= c.getAddress() %></td>
                <td><%= c.getContactNumber() %></td>
                <td><%= c.getEmail() %></td>
                <td>
                    <a href="EditCustomerServlet?id=<%= c.getId() %>"
                       class="btn btn-sm btn-primary" title="Edit">
                        <i class="fas fa-edit"></i>
                    </a>

                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>

<script src="../assets/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById('searchInput').addEventListener('keyup', function () {
        const filter = this.value.toLowerCase();
        const rows = document.querySelectorAll('table tbody tr');

        rows.forEach(row => {
            const accountNo = row.cells[0].textContent.toLowerCase(); // Account No
            const nid = row.cells[2].textContent.toLowerCase();       // NID

            if (accountNo.includes(filter) || nid.includes(filter)) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    });
</script>

</body>
<script src="../assets/js/bootstrap.bundle.min.js"></script>

</html>
