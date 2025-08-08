<%--
  Created by IntelliJ IDEA.
  User: Dulakshi
  Date: 06/08/2025
  Time: 6:16 am
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="java.util.*, com.billsystem.models.User, com.billsystem.services.UserServices" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
  <title>View Users</title>
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
</head>
<body>

<%@ include file="layouts/sidebar.jsp" %>
<%@ include file="layouts/navbar.jsp" %>

<br><br><br><br>

<div class="main-content" style="margin-left: 280px; padding: 30px;">
  <h2 class="text-center mb-4">All Users</h2>

  <%
    String successMessage = (String) session.getAttribute("successMessage");
    if (successMessage != null) {
  %>
  <div style="color: green; font-weight: bold; margin-bottom: 20px;">
    <%= successMessage %>
  </div>
  <%
      session.removeAttribute("successMessage");
    }
  %>


  <%
    UserServices userService = new UserServices();
    List<User> userList = userService.getAllUsers();
  %>

  <div class="table-responsive">
    <table class="table table-bordered table-hover table-custom align-middle">
      <thead class="custom-thead text-white text-center">
      <tr>
        <th>ID</th>
        <th>Username</th>
        <th>Email</th>
        <th>User Type</th>
        <th>Actions</th>
      </tr>
      </thead>
      <tbody class="text-center">
      <%
        for (User user : userList) {
      %>
      <tr>
        <td><%= user.getId() %></td>
        <td><%= user.getUsername() %></td>
        <td><%= user.getEmail() %></td>
        <td><%= (user.getUsertype() == 0) ? "Admin" : "Cashier" %></td>
        <td>
          <a class="btn btn-sm btn-primary" title="Edit" href="EditUserServlet?id=<%= user.getId() %>"> <i class="fas fa-edit"></i></a>
          <a class="btn btn-sm btn-danger" href="UserManagementServlet?action=delete&id=${user.id}" onclick="return confirm('Are you sure you want to delete this user?')">
            <i class="fas fa-trash-alt"></i>
          </a>

        </td>
      </tr>
      <%
        }
      %>
      </tbody>
    </table>
  </div>
</div>

<script src="assets/js/bootstrap.bundle.min.js"></script>

</body>
</html>
