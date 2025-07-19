<%--
  Created by IntelliJ IDEA.
  User: Dulakshi
  Date: 19/07/2025
  Time: 9:49 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Item - PahanaEdu Book Shop</title>
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

        .success-msg {
            color: green;
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
        <h3>Add Item</h3>
    </div>

    <div class="form-container">
        <% if ("true".equals(request.getParameter("success"))) { %>
        <p class="success-msg">Item added successfully!</p>
        <% } %>

        <form action="ItemServlet" method="post" class="styled-form">
            <div class="form-group">
                <label>Item Name:</label>
                <input type="text" name="itemName" required>
            </div>

            <div class="form-group">
                <label>Item Code:</label>
                <input type="text" name="itemCode" required maxlength="50" class="form-control" placeholder="Enter unique Item Code">
            </div>


            <div class="form-group">
                <label>Description:</label>
                <textarea name="description" rows="3"></textarea>
            </div>

            <div class="form-group">
                <label>Price Per Unit:</label>
                <input type="number" step="0.01" name="pricePerUnit" required>
            </div>

            <div class="form-group">
                <label>Stock Quantity:</label>
                <input type="number" name="stockQuantity" required>
            </div>

            <div class="form-group">
                <label>Status:</label>
                <select name="status">
                    <option value="Active">Active</option>
                    <option value="Discontinued">Discontinued</option>
                </select>
            </div>

            <div class="form-group">
                <input type="submit" value="Add Item" class="submit-btn">
            </div>

            <%
                String successMessage = (String) session.getAttribute("successMessage");
                if (successMessage != null) {
            %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <%= successMessage %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <%
                    session.removeAttribute("successMessage");
                }
            %>

        </form>
    </div>
</div>

<%@ include file="layouts/footer.jsp" %>

</body>
</html>

