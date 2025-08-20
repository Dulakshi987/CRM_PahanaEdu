<%@ page import="java.util.*, java.text.SimpleDateFormat, com.billsystem.models.*, com.billsystem.services.*" %>
<%@ page session="true" %>

<%
    ItemService itemService = new ItemService();
    CustomerService customerService = new CustomerService();

    // Retrieve bill items from request parameters
    String[] itemIds = request.getParameterValues("itemId");
    String[] quantities = request.getParameterValues("quantity");

    List<BillItem> billItems = new ArrayList<>();
    if (itemIds != null && quantities != null && itemIds.length == quantities.length) {
        for (int i = 0; i < itemIds.length; i++) {
            try {
                BillItem bi = new BillItem();
                bi.setItemId(Integer.parseInt(itemIds[i]));
                bi.setQuantity(Integer.parseInt(quantities[i]));
                billItems.add(bi);
            } catch (NumberFormatException e) {
                // Handle invalid number format
            }
        }
    }

    // Calculate subtotal
    double subtotal = 0;
    for (BillItem bi : billItems) {
        Item item = itemService.getItemById(bi.getItemId());
        if (item != null) {
            subtotal += bi.getQuantity() * item.getPricePerUnit();
        }
    }

    // Get other parameters with proper error handling
    double discount = 0;
    double tax = 0;
    String paymentMethod = "";
    int customerId = 0;

    try {
        discount = request.getParameter("discount") != null ? Double.parseDouble(request.getParameter("discount")) : 0;
        tax = request.getParameter("tax") != null ? Double.parseDouble(request.getParameter("tax")) : 0;
        paymentMethod = request.getParameter("paymentMethod") != null ? request.getParameter("paymentMethod") : "";
        customerId = request.getParameter("customerId") != null ? Integer.parseInt(request.getParameter("customerId")) : 0;
    } catch (NumberFormatException e) {
        // Handle invalid number formats
    }

    Customer customer = customerService.getCustomerById(customerId);

    // Calculate totals
// discount is percentage, e.g. 10 for 10%
    double discountAmount = subtotal * (discount / 100);
    double discounted = Math.max(subtotal - discountAmount, 0);

    double taxAmount = discounted * (tax / 100);
    double grandTotal = discounted + taxAmount;


    // Format date
    SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy, hh:mm a");
    String currentDate = sdf.format(new Date());
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bill Receipt</title>
    <style>
        @page {
            size: A4;
            margin: 0;
        }
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 20px;
            color: #333;
            background-color: #fff;
        }
        .receipt-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 30px;
            border: 1px solid #e0e0e0;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            background-color: #fff;
        }
        .header {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 2px solid #d4831f;
        }
        .company-name {
            font-size: 28px;
            font-weight: bold;
            color: #d4831f;
            margin-bottom: 5px;
        }
        .receipt-title {
            font-size: 22px;
            margin: 10px 0;
            color: #555;
        }
        .receipt-info {
            display: flex;
            justify-content: space-between;
            margin-bottom: 25px;
            padding: 15px;
            background-color: #f9f9f9;
            border-radius: 5px;
        }
        .customer-info {
            margin-bottom: 25px;
            padding: 15px;
            background-color: #f5f5f5;
            border-radius: 5px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 25px;
        }
        th {
            background-color: #d4831f;
            color: white;
            padding: 12px;
            text-align: left;
        }
        td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .totals {
            margin-left: auto;
            width: 300px;
            background-color: #f5f5f5;
            padding: 15px;
            border-radius: 5px;
        }
        .totals-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
            padding: 5px 0;
        }
        .grand-total {
            font-weight: bold;
            font-size: 18px;
            border-top: 2px solid #d4831f;
            padding-top: 10px;
            margin-top: 10px;
        }
        .footer {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
            color: #777;
            font-size: 14px;
        }
        .no-print {
            display: none;
        }
        @media print {
            body {
                padding: 0;
            }
            .no-print {
                display: none;
            }
            .receipt-container {
                border: none;
                box-shadow: none;
                padding: 15px;
            }
        }
    </style>
</head>
<body>
<div class="receipt-container">
    <div class="header">
        <div class="company-name">PahanaEdu Book Shop</div>
        <div class="receipt-title">INVOICE RECEIPT</div>
        <div>Date: <%= currentDate %></div>
    </div>

    <div class="receipt-info">
        <div>
            <strong>Receipt No:</strong> <%= System.currentTimeMillis() %><br>
            <strong>Payment Method:</strong> <%= paymentMethod.toUpperCase() %>
        </div>
    </div>

    <% if (customer != null) { %>
    <div class="customer-info">
        <strong>BILL TO:</strong><br>
        Customer Name:<%= customer.getFirstName() %> <%= customer.getLastName() %><br>
        Account No: <%= customer.getAccountNumber() %><br>
        Email: <%= customer.getEmail() %>
    </div>
    <% } %>

    <table>
        <thead>
        <tr>
            <th>Item Code</th>
            <th>Description</th>
            <th>Qty</th>
            <th>Unit Price</th>
            <th>Total</th>
        </tr>
        </thead>
        <tbody>
        <% for (BillItem bi : billItems) {
            Item item = itemService.getItemById(bi.getItemId());
            if (item != null) {
                double total = bi.getQuantity() * item.getPricePerUnit();
        %>
        <tr>
            <td><%= item.getItemCode() %></td>
            <td><%= item.getItemName() %></td>
            <td><%= bi.getQuantity() %></td>
            <td>Rs.<%= String.format("%.2f", item.getPricePerUnit()) %></td>
            <td>Rs.<%= String.format("%.2f", total) %></td>
        </tr>
        <% }
        } %>
        </tbody>
    </table>

    <div class="totals">
        <div class="totals-row">
            <span>Subtotal:</span>
            <span>Rs.<%= String.format("%.2f", subtotal) %></span>
        </div>
        <div class="totals-row">
            <span>Discount:</span>
            <span><%= String.format("%.2f", discount) %>%</span>
        </div>
        <div class="totals-row">
            <span>Tax (<%= tax %>%):</span>
            <span>Rs.<%= String.format("%.2f", taxAmount) %></span>
        </div>
        <div class="totals-row grand-total">
            <span>GRAND TOTAL:</span>
            <span>Rs.<%= String.format("%.2f", grandTotal) %></span>
        </div>
    </div>

    <div class="footer">
        Thank you!<br>
        <strong>PahanaEdu Book Shop</strong><br>
        Contact: infopahanaedu@gmail.com | Phone: (+94) 11-564-851
    </div>

    <div class="no-print" style="text-align: center; margin-top: 30px;">
        <button onclick="window.print()" style="padding: 10px 20px; background-color: #4CAF50; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 16px;">Print Receipt</button>
        <button onclick="window.close()" style="padding: 10px 20px; background-color: #f44336; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; margin-left: 15px;">Close</button>
    </div>
</div>
</body>
</html>