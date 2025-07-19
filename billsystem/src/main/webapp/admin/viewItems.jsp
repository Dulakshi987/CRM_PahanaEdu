<%@ page import="com.billsystem.models.Item, java.util.List" %>
<%@ page import="com.billsystem.services.ItemService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>View Items</title>
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
  <h2 class="text-center mb-4">Item List</h2>

  <%
    List<Item> items = (List<Item>) request.getAttribute("items");
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
    <input type="text" id="searchInput" class="form-control" placeholder="Search by Item Code or Name...">
  </div>

  <div class="table-responsive">
    <table class="table table-bordered table-hover table-custom align-middle">
      <thead class="custom-thead text-white text-center">
      <tr>
        <th>Item ID</th>
        <th>Item Name</th>
        <th>Item Code</th>
        <th>Description</th>
        <th>Price/Unit</th>
        <th>Stock Quantity</th>
        <th>Status</th>
        <th>Actions</th>
      </tr>
      </thead>
      <tbody class="text-center">
      <% for (Item i : items) { %>
      <tr>
        <td><%= i.getItemId() %></td>
        <td><%= i.getItemName() %></td>
        <td><%= i.getItemCode() %></td>
        <td><%= i.getDescription() %></td>
        <td><%= String.format("%.2f", i.getPricePerUnit()) %></td>
        <td><%= i.getStockQuantity() %></td>
        <td>
          <% if ("Active".equals(i.getStatus())) { %>
          <span class="btn btn-success btn-sm" style="pointer-events:none;">Active</span>
          <% } else { %>
          <span class="btn btn-secondary btn-sm" style="pointer-events:none;">Discontinued</span>
          <% } %>
        </td>
        <td>
          <a href="EditItemServlet?id=<%= i.getItemId() %>" class="btn btn-sm btn-primary" title="Edit">
            <i class="fas fa-edit"></i>
          </a>
          <a href="ItemServlet?action=delete&id=<%= i.getItemId() %>"
             class="btn btn-sm btn-danger"
             onclick="return confirm('Are you sure you want to delete this item?');"
             title="Delete">
            <i class="fas fa-trash-alt"></i>
          </a>
        </td>
      </tr>
      <% } %>
      </tbody>
    </table>
  </div>
</div>

<script src="assets/js/bootstrap.bundle.min.js"></script>
<script>
  document.getElementById('searchInput').addEventListener('keyup', function () {
    const filter = this.value.toLowerCase();
    const rows = document.querySelectorAll('table tbody tr');

    rows.forEach(row => {
      const itemName = row.cells[1].textContent.toLowerCase(); // Item Name
      const itemCode = row.cells[2].textContent.toLowerCase(); // Item Code

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
