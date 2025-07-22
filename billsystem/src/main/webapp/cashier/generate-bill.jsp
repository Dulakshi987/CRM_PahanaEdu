<%@ page import="java.util.*, com.billsystem.models.*, com.billsystem.services.*, com.billsystem.services.impl.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Bill</title>
    <link rel="stylesheet" href="../assets/css/bootstrap.min.css">
    <style>
        .form-section {
            background-color: #f8f9fa;
            padding: 2rem;
            border-radius: 15px;
            margin-bottom: 2rem;
            box-shadow: 0 0 12px rgba(0,0,0,0.05);
        }
        .table th {
            background-color: #f0ad4e;
            color: white;
        }
    </style>
</head>
<body>
<%
    CustomerService customerService = new CustomerService();
    ItemService itemService = new ItemService();
    List<Customer> customers = customerService.getAllCustomers();
    List<Item> items = itemService.getAllItems();
%>
<div class="container mt-5">
    <h2 class="mb-4 text-center text-primary">🧾 Bill Creation</h2>
    <form action="${pageContext.request.contextPath}/cashier/BillSubmitServlet" method="post">
        <!-- Customer Info -->
        <div class="form-section">
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="customerSelect" class="form-label">Select Customer</label>
                    <select id="customerSelect" class="form-select" name="customerId">
                        <option selected disabled>-- Select Customer --</option>
                        <% for (Customer c : customers) { %>
                        <option value="<%= c.getId() %>" data-email="<%= c.getEmail() %>">
                            <%= c.getFirstName() %> <%= c.getLastName() %> - <%= c.getAccountNumber() %>
                        </option>
                        <% } %>
                    </select>
                </div>
                <div class="col-md-6">
                    <label for="customerEmail" class="form-label">Customer Email</label>
                    <input type="email" class="form-control" id="customerEmail" readonly>
                </div>
            </div>
        </div>

        <!-- Item Add Section -->
        <div class="form-section">
            <h5>Add Items</h5>
            <div class="row align-items-end">
                <div class="col-md-5">
                    <label class="form-label">Item</label>
                    <select id="itemSelect" class="form-select">
                        <option disabled selected>-- Select Item --</option>
                        <% for (Item i : items) { %>
                        <option value="<%= i.getItemId() %>" data-code="<%= i.getItemCode() %>"
                                data-name="<%= i.getItemName() %>" data-price="<%= i.getPricePerUnit() %>">
                            <%= i.getItemCode() %> - <%= i.getItemName() %>
                        </option>
                        <% } %>
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Quantity</label>
                    <input type="number" id="itemQty" class="form-control" value="1" min="1">
                </div>
                <div class="col-md-2">
                    <button type="button" class="btn btn-primary w-100" onclick="addItem()">Add</button>
                </div>
            </div>
        </div>

        <!-- Bill Items Table -->
        <div class="form-section">
            <h5>Bill Items</h5>
            <table class="table table-bordered" id="billTable">
                <thead>
                <tr>
                    <th>Item Code</th>
                    <th>Name</th>
                    <th>Qty</th>
                    <th>Price</th>
                    <th>Total</th>
                    <th>Remove</th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>

        <!-- Calculator -->
        <div class="form-section">
            <div class="row g-3">
                <div class="col-md-3">
                    <label class="form-label">Subtotal</label>
                    <input type="text" class="form-control" id="subtotal" readonly>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Discount</label>
                    <input type="number" class="form-control" id="discount" name="discount" value="0" oninput="calculateTotal()">
                </div>
                <div class="col-md-3">
                    <label class="form-label">Tax (%)</label>
                    <input type="number" class="form-control" id="tax" name="tax" value="8" oninput="calculateTotal()">
                </div>
                <div class="col-md-3">
                    <label class="form-label">Total</label>
                    <input type="text" class="form-control" id="grandTotal" name="grandTotal" readonly>
                </div>
            </div>
        </div>

        <!-- Hidden items for submit -->
        <div id="itemsContainer"></div>

        <!-- Buttons -->
        <div class="text-end mb-5">
            <button type="submit" class="btn btn-success">💾 Save Bill</button>
            <button type="button" class="btn btn-primary" onclick="window.print()">🖨️ Print Bill</button>
        </div>
    </form>
</div>

<script>
    const billTableBody = document.querySelector("#billTable tbody");

    document.getElementById("customerSelect").addEventListener("change", function () {
        const email = this.selectedOptions[0].getAttribute("data-email");
        document.getElementById("customerEmail").value = email;
    });

    function addItem() {
        const select = document.getElementById("itemSelect");
        const qty = parseInt(document.getElementById("itemQty").value);
        const itemId = select.value;
        const code = select.selectedOptions[0].getAttribute("data-code");
        const name = select.selectedOptions[0].getAttribute("data-name");
        const price = parseFloat(select.selectedOptions[0].getAttribute("data-price"));

        if (!itemId || qty < 1) return;

        const total = qty * price;
        const row = document.createElement("tr");
        row.setAttribute("data-itemid", itemId);
        row.innerHTML = `
            <td>${code}</td>
            <td>${name}</td>
            <td>${qty}</td>
            <td>${price.toFixed(2)}</td>
            <td>${total.toFixed(2)}</td>
            <td><button class="btn btn-danger btn-sm" onclick="removeItem(this)">🗑</button></td>
        `;
        billTableBody.appendChild(row);
        calculateTotal();
    }

    function removeItem(btn) {
        btn.closest("tr").remove();
        calculateTotal();
    }

    function calculateTotal() {
        let subtotal = 0;
        billTableBody.querySelectorAll("tr").forEach(row => {
            const qty = parseInt(row.children[2].innerText);
            const price = parseFloat(row.children[3].innerText);
            subtotal += qty * price;
        });

        document.getElementById("subtotal").value = subtotal.toFixed(2);
        const discount = parseFloat(document.getElementById("discount").value) || 0;
        const tax = parseFloat(document.getElementById("tax").value) || 0;
        const grandTotal = (subtotal - discount) * (1 + tax / 100);
        document.getElementById("grandTotal").value = grandTotal.toFixed(2);
    }

    document.getElementById("billForm").addEventListener("submit", function () {
        const itemsContainer = document.getElementById("itemsContainer");
        itemsContainer.innerHTML = "";
        document.querySelectorAll("#billTable tbody tr").forEach(row => {
            const itemId = row.getAttribute("data-itemid");
            const qty = row.children[2].innerText;
            const price = row.children[3].innerText;
            const total = row.children[4].innerText;
            itemsContainer.innerHTML += `
                <input type="hidden" name="itemId" value="${itemId}">
                <input type="hidden" name="quantity" value="${qty}">
                <input type="hidden" name="price" value="${price}">
                <input type="hidden" name="total" value="${total}">
            `;
        });
    });
</script>
</body>
</html>
