<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.billsystem.models.Item" %>

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
    if (role == null || role != 0) { // 0 = admin
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
<html>
<head>
    <title>Edit Item - PahanaEdu Book Shop</title>
    <link rel="stylesheet" href="../assets/css/bootstrap.min.css">

    <style>
        .form-container {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: auto;
            margin-top: 30px;
        }

        .styled-form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            margin-bottom: 5px;
            font-weight: 500;
            color: #333;
        }

        .form-group input[type="text"],
        .form-group input[type="number"],
        .form-group textarea,
        .form-group select {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s ease;
        }

        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            border-color: #e7993c;
            outline: none;
        }

        .submit-btn {
            background: #e7993c;
            color: white;
            border: none;
            padding: 12px;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .submit-btn:hover {
            background: #d4831f;
        }

        .error-msg {
            color: red;
            font-weight: bold;
            margin-top: 15px;
            text-align: center;
        }
    </style>
</head>
<body>

<%@ include file="layouts/sidebar.jsp" %>
<%@ include file="layouts/navbar.jsp" %>

<br><br><br><br>

<div class="content">
    <div class="content-header" style="text-align: center">
        <h3>Edit Item</h3>
    </div>

    <%
        Item item = (Item) request.getAttribute("item");
        if (item == null) {
    %>
    <p class="error-msg">Item not found.</p>
    <%
    } else {
    %>

    <div class="form-container">
        <form action="${pageContext.request.contextPath}/admin/UpdateItemServlet" method="post" class="styled-form">
            <input type="hidden" name="itemId" value="<%= item.getItemId() %>"/>

            <div class="form-group">
                <label for="itemName">Item Name:</label>
                <input type="text" name="itemName" id="itemName" value="<%= item.getItemName() %>" required>
            </div>

            <div class="form-group">
                <label for="itemCode">Item Code:</label>
                <input type="text" name="itemCode" id="itemCode" value="<%= item.getItemCode() %>" required>
            </div>


            <div class="form-group">
                <label for="description">Description:</label>
                <textarea name="description" id="description" rows="3"><%= item.getDescription() != null ? item.getDescription() : "" %></textarea>
            </div>

            <div class="form-group">
                <label for="pricePerUnit">Price Per Unit:</label>
                <input type="number" step="0.01" name="pricePerUnit" id="pricePerUnit" value="<%= item.getPricePerUnit() %>" required>
            </div>

            <div class="form-group">
                <label for="stockQuantity">Stock Quantity:</label>
                <input type="number" name="stockQuantity" id="stockQuantity" value="<%= item.getStockQuantity() %>" required>
            </div>

            <div class="form-group">
                <label for="status">Status:</label>
                <select name="status" id="status" required>
                    <option value="Active" <%= "Active".equals(item.getStatus()) ? "selected" : "" %>>Active</option>
                    <option value="Discontinued" <%= "Discontinued".equals(item.getStatus()) ? "selected" : "" %>>Discontinued</option>
                </select>

            </div>

            <div class="form-group">
                <input type="submit" value="Update Item" class="submit-btn">
            </div>
        </form>
    </div>

    <%
        }
    %>
</div>

<%@ include file="layouts/footer.jsp" %>

</body>
</html>
