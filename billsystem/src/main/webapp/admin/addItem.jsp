<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
    <title>Add Item - PahanaEdu Book Shop</title>
    <style>
        /* Same style as your addCustomer.jsp or customize */
        .form-container {
            background: white;
            padding: 30px;
            border-radius: 15px;
            max-width: 600px;
            margin: auto;
            margin-top: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        .styled-form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        .form-group {
            display: flex;
            flex-direction: column;
        }
        .form-group label {
            font-weight: 600;
            margin-bottom: 5px;
        }
        .form-group input, select {
            padding: 10px;
            border-radius: 8px;
            border: 1px solid #ccc;
        }
        .submit-btn {
            background-color: #e7993c;
            color: white;
            border: none;
            padding: 12px;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
        }
        .submit-btn:hover {
            background-color: #d4831f;
        }
        .success-msg {
            color: green;
            font-weight: bold;
            margin-bottom: 15px;
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
            <label for="itemCode">Item Code</label>
            <input type="text" id="itemCode" name="itemCode" required>
        </div>
        <div class="form-group">
            <label for="itemName">Item Name</label>
            <input type="text" id="itemName" name="itemName" required>
        </div>
        <div class="form-group">
            <label for="description">Description</label>
            <input type="text" id="description" name="description">
        </div>
        <div class="form-group">
            <label for="pricePerUnit">Price per Unit</label>
            <input type="number" step="0.01" id="pricePerUnit" name="pricePerUnit" required>
        </div>
        <div class="form-group">
            <label for="stockQuantity">Stock Quantity</label>
            <input type="number" id="stockQuantity" name="stockQuantity" required>
        </div>
        <div class="form-group">
            <label for="status">Status</label>
            <select id="status" name="status" required>
                <option value="Active" selected>Active</option>
                <option value="Discontinued">Discontinued</option>
            </select>
        </div>
        <input type="submit" value="Add Item" class="submit-btn">
    </form>
</div>
</div>

<%@ include file="layouts/footer.jsp" %>

</body>
</html>
