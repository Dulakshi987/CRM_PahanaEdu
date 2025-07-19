<%--
  Created by IntelliJ IDEA.
  User: Dulakshi
  Date: 19/07/2025
  Time: 10:45 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.billsystem.models.Item, java.util.List" %>
<%@ page import="com.billsystem.services.ItemService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>View Items</title>
  <link rel="stylesheet" href="../assets/css/bootstrap.min.css">
  <style>
    body, html {
      height: 100%;
      margin: 0;
      padding: 0;
    }
    .content {
      margin-left: 280px; /* match your sidebar width */
      padding: 30px;
    }
    .custom-thead {
      background: linear-gradient(135deg, #e7993c, #d4831f);
      color: white;
      border-top-left-radius: 10px;
      border-top-right-radius: 10px;
    }
    .table-custom {
      border-radius: 10px;
      overflow: hidden;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
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

<%
  request.setAttribute("activePage", "viewItems");
%>

<%@ include file="layouts/sidebar.jsp" %>
<%@ include file="layouts/navbar.jsp" %>


<br><br><br><br>
<div class="content">
  <h2 class="text-center mb-4">Item List</h2>

  <!-- Search Panel -->
  <div class="mb-3" style="max-width: 1200px; margin: auto;">
    <input type="text" id="searchInput" class="form-control" placeholder="Search by item name or item code">
  </div>

  <%
    ItemService itemService = new ItemService();
    List<Item> items = (List<Item>) request.getAttribute("itemList");
    if (items == null) {
      items = itemService.getAllItems();
    }
  %>

  <div class="table-responsive">
    <table class="table table-bordered table-hover table-custom align-middle">
      <thead class="custom-thead text-center">
      <tr>
        <th>Item Name</th>
        <th>Item Code</th>
        <th>Item BarCode</th>
        <th>Description</th>
        <th>Price Per Unit</th>
        <th>Stock Quantity</th>
        <th>Status</th>
        <th>Created At</th>
        <th>Updated At</th>
      </tr>
      </thead>
      <tbody class="text-center">
      <% for (Item item : items) { %>
      <tr>
        <td><%= item.getItemName() %></td>
        <td><%= item.getItemCode() %></td>
        <td><%= item.getItemName() %></td>
        <td><%= item.getDescription() %></td>
        <td><%= item.getPricePerUnit() %></td>
        <td><%= item.getStockQuantity() %></td>
        <td>
                        <span class="<%= item.getStatus().equals("Active") ? "btn btn-success disabled" : "btn btn-danger disabled" %>">
                            <%= item.getStatus() %>
                        </span>
        </td>
        <td><%= item.getCreatedAt() %></td>
        <td><%= item.getUpdatedAt() %></td>
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
      const itemName = row.cells[0].textContent.toLowerCase();
      const itemCode = row.cells[1].textContent.toLowerCase();

      if (itemName.includes(filter) || itemCode.includes(filter)) {
        row.style.display = '';
      } else {
        row.style.display = 'none';
      }
    });
  });
</script>

</body>
</html>
