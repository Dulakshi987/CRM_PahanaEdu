<%--
  Created by IntelliJ IDEA.
  User: Dulakshi
  Date: 13/08/2025
  Time: 8:18 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="com.billsystem.models.*" %>
<%@ page import="com.billsystem.services.*" %>

<%
    String billIdParam = request.getParameter("billId");

    if (billIdParam == null || billIdParam.isEmpty()) {
        return;
    }

    int billId = Integer.parseInt(billIdParam);

    BillServiceImpl billService = new BillServiceImpl();
    Bill bill = billService.getBillById(billId);

    if (bill == null) {
        return;
    }

    CustomerService customerService = new CustomerService();
    Customer customer = customerService.getCustomerById(bill.getCustomerId());

    List<BillItem> billItems = billService.getBillItemsByBillId(billId);
    ItemService itemService = new ItemService();

    SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy, hh:mm a");

    double subtotal = 0;
    for (BillItem bi : billItems) {
        Item item = itemService.getItemById(bi.getItemId());
        if (item != null) {
            subtotal += bi.getQuantity() * item.getPricePerUnit();
        }
    }


%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Invoice Receipt</title>
    <style>
        @page { size: A4; margin: 0; }
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #fff;
            color: #333;
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
        }
        .receipt-title {
            font-size: 22px;
            margin-top: 10px;
            color: #555;
        }
        .receipt-info, .customer-info {
            padding: 15px;
            background-color: #f9f9f9;
            border-radius: 5px;
            margin-bottom: 20px;
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
            width: 300px;
            margin-left: auto;
            background-color: #f5f5f5;
            padding: 15px;
            border-radius: 5px;
        }
        .totals-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
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
        @media print {
            body { padding: 0; }
            .receipt-container { border: none; box-shadow: none; }
            .no-print { display: none; }
        }
    </style>
</head>
<body>
<div class="receipt-container">
    <div class="header">
        <div class="company-name">PahanaEdu Book Shop</div>
        <div class="receipt-title">INVOICE</div>
        <div>Date: <%= sdf.format(bill.getBillDate()) %></div>
    </div>

    <div class="receipt-info">
        <strong>Invoice No:</strong> <%= bill.getBillId() %><br>
        <strong>Payment Method:</strong> <%= bill.getPaymentMethod() != null ? bill.getPaymentMethod().toUpperCase() : "N/A" %>
    </div>

    <% if (customer != null) { %>
    <div class="customer-info">
        <strong>BILL TO:</strong><br>
        Customer Name: <%= customer.getFirstName() %> <%= customer.getLastName() %><br>
        Account No: <%= customer.getAccountNumber() %><br>
        Email: <%= customer.getEmail() %>
    </div>
    <% } %>

    <table>
        <thead>
        <tr>
            <th>Item Code</th>
            <th>Item Name</th>
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
        <% }} %>
        </tbody>
    </table>

    <div class="totals">

        <div class="totals-row">
            <span>Discount:</span>
            <span><%= String.format("%.2f", bill.getDiscount()) %>%</span>
        </div>

        <div class="totals-row">
            <span>Tax:</span>
            <span><%= String.format("%.2f", bill.getTax()) %>%</span>
        </div>

        <div class="totals-row grand-total">
            <span>Grand Total:</span>
            <span>Rs.<%= String.format("%.2f", bill.getGrandTotal()) %></span>
        </div>

        <div class="totals-row">
            <span>Subtotal:</span>
            <span>Rs.<%= String.format("%.2f", subtotal) %></span>
        </div>

    </div>

    <div class="footer">
        Thank you!<br>
        <strong>PahanaEdu Book Shop</strong><br>
        Contact: infopahanaedu@gmail.com | Phone: (+94) 11-564-851
    </div>

</div>
</body>
</html>
