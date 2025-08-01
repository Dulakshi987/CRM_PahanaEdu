<%@ page import="java.util.*, com.billsystem.models.*, com.billsystem.services.*" %>
<%@ page session="true" %>

<%
    ItemService itemService = new ItemService();
    CustomerService customerService = new CustomerService();

    List<Item> items = itemService.getAllItems();
    List<Customer> customers = customerService.getAllCustomers();

    List<BillItem> billItems = (List<BillItem>) session.getAttribute("billItems");
    if (billItems == null) {
        billItems = new ArrayList<>();
    }
%>

<%
    String message = (String) session.getAttribute("message");
    String messageType = (String) session.getAttribute("messageType");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Create Bill</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>

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
            background-color: #fff3e0;
        }

        .btn {
            border-radius: 8px;
        }

        .form-section {
            background-color: #fffaf1;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
        }

        .form-label {
            font-weight: 600;
        }

        h2, h5 {
            font-weight: bold;
            color: #d4831f;
        }

    </style>
</head>
<body>

<%@ include file="layouts/sidebar.jsp" %>
<%@ include file="layouts/navbar.jsp" %>

<div class="main-content" style="margin-left: 280px; padding: 100px;">
    <h2 class="mb-4 text-center">Bill Creation</h2>

    <% if (message != null) { %>
    <div class="alert alert-<%= "success".equals(messageType) ? "success" : "danger" %> alert-dismissible fade show" role="alert">
        <%= message %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <%
            session.removeAttribute("message");
            session.removeAttribute("messageType");
        }
    %>

    <!-- Add Item Form -->
    <form action="${pageContext.request.contextPath}/cashier/AddBillItemServlet" method="post" class="row g-3 mb-4">
        <div class="col-md-6">
            <label for="itemId" class="form-label">Select Item</label>
            <select name="itemId" id="itemId" class="form-select" required>
                <option value="" disabled selected> Select Item </option>
                <% for (Item i : items) { %>
                <option value="<%= i.getItemId() %>">
                    <%= i.getItemCode() %> - <%= i.getItemName() %> ($<%= String.format("%.2f", i.getPricePerUnit()) %>)
                </option>
                <% } %>
            </select>
        </div>

        <div class="col-md-3">
            <label for="quantity" class="form-label">Quantity</label>
            <input type="number" name="quantity" id="quantity" class="form-control" value="1" min="1" required />
        </div>

        <div class="col-md-3 d-flex align-items-end">
            <button type="submit" class="btn btn-add w-100" style=" background-color: #d4831f;
            padding: 10px 10px;color: white;">Add Item</button>
        </div>
    </form>

    <form action="${pageContext.request.contextPath}/cashier/SaveBillServlet" method="post">
        <!-- Bill Items Table -->
        <div class="mt-4">
            <h6>Bill Items</h6>
            <table class="table table-bordered table-hover table-custom align-middle" id="billTable">
                <thead class="custom-thead text-center">
                <tr>
                    <th>Item Code</th>
                    <th>Name</th>
                    <th>Qty</th>
                    <th>Unit Price</th>
                    <th>Total</th>
                    <th>Remove</th>
                </tr>
                </thead>
                <tbody class="text-center">
                <%
                    double grandTotal = 0;
                    for (BillItem bi : billItems) {
                        Item item = itemService.getItemById(bi.getItemId());
                        if (item == null) continue;
                        double total = bi.getQuantity() * item.getPricePerUnit();
                        grandTotal += total;
                %>
                <tr>
                    <td><%= item.getItemCode() %></td>
                    <td><%= item.getItemName() %></td>
                    <td><%= bi.getQuantity() %></td>
                    <td><%= String.format("%.2f", item.getPricePerUnit()) %></td>
                    <td class="rowTotal"><%= String.format("%.2f", total) %></td>
                    <td>
                        <button type="button" class="btn btn-danger btn-sm" onclick="removeRow(this)">Remove</button>
                    </td>
                </tr>
                <!-- Hidden Inputs -->
                <input type="hidden" name="itemId[]" value="<%= item.getItemId() %>" />
                <input type="hidden" name="quantity[]" value="<%= bi.getQuantity() %>" />
                <input type="hidden" name="itemPrice[]" value="<%= item.getPricePerUnit() %>" />
                <input type="hidden" name="totalPrice[]" value="<%= total %>" />
                <% } %>
                </tbody>
                <tfoot>
                <tr>
                    <th colspan="4" class="text-end">Grand Total</th>
                    <th id="grandTotalFooter">$<%= String.format("%.2f", grandTotal) %></th>
                    <th></th>
                </tr>
                </tfoot>
            </table>
        </div>

        <!-- Calculation Section -->
        <div class="form-section mt-4">
            <div class="row g-3">
                <div class="col-md-3">
                    <label class="form-label">Subtotal</label>
                    <input type="text" class="form-control" id="subtotal" readonly />
                </div>
                <div class="col-md-3">
                    <label class="form-label">Discount</label>
                    <input type="number" class="form-control" name="discount" id="discount" value="0" min="0" oninput="calculateTotal()" />
                </div>
                <div class="col-md-3">
                    <label class="form-label">Tax (%)</label>
                    <input type="number" class="form-control" name="tax" id="tax" value="8" min="0" oninput="calculateTotal()" />
                </div>
                <div class="col-md-3">
                    <label class="form-label">Total</label>
                    <input type="text" class="form-control" id="grandTotal" readonly />
                    <input type="hidden" name="grandTotal" id="grandTotalHidden" value="0.0" />
                </div>
            </div>
        </div>

        <!-- Customer Selection -->
        <div class="form-section mt-4">
            <div class="row g-3 align-items-center">
                <div class="col-md-6">
                    <label for="customerSelect" class="form-label">Select Customer</label>
                    <select id="customerSelect" class="form-select" required>
                        <option selected disabled> Select Customer </option>
                        <% for (Customer c : customers) { %>
                        <option value="<%= c.getId() %>" data-email="<%= c.getEmail() %>">
                            <%= c.getFirstName() %> <%= c.getLastName() %> - <%= c.getAccountNumber() %>
                        </option>
                        <% } %>
                    </select>
                    <input type="hidden" name="customerId" id="customerIdHidden" />
                </div>
                <div class="col-md-6">
                    <label for="customerEmail" class="form-label">Customer Email</label>
                    <input type="email" id="customerEmail" class="form-control" readonly />
                </div>
            </div>
        </div>

        <!-- Payment Method -->
        <div class="form-section mt-4">
            <div class="col-md-6">
                <label for="paymentMethod">Payment Method</label>
                <select class="form-control" name="paymentMethod" id="paymentMethod" required>
                    <option value=""> Select Payment Method </option>
                    <option value="cash">Cash</option>
                    <option value="check">Check</option>
                    <option value="card">Card</option>
                </select>
            </div>
        </div>

        <!-- Save and Print Buttons -->
        <div class="text-end mt-4">
            <button type="button" class="btn btn-secondary" onclick="openPrintPreview()">Print Bill</button>
            <button type="submit" class="btn btn-success"> Save to Database</button>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById("customerSelect").addEventListener("change", function () {
        const selectedOption = this.options[this.selectedIndex];
        const email = selectedOption.getAttribute("data-email") || "";
        const customerId = selectedOption.value;
        document.getElementById("customerEmail").value = email;
        document.getElementById("customerIdHidden").value = customerId;
    });

    function removeRow(button) {
        const row = button.closest("tr");
        row.remove();
        calculateTotal();
    }

    function calculateTotal() {
        let subtotal = 0;
        document.querySelectorAll("#billTable tbody tr").forEach(row => {
            const rowTotalText = row.querySelector(".rowTotal").innerText;
            const rowTotal = parseFloat(rowTotalText);
            if (!isNaN(rowTotal)) {
                subtotal += rowTotal;
            }
        });

        document.getElementById("subtotal").value = subtotal.toFixed(2);
        const discount = parseFloat(document.getElementById("discount").value) || 0;
        const tax = parseFloat(document.getElementById("tax").value) || 0;

        const discounted = Math.max(subtotal - discount, 0);
        const taxAmount = discounted * (tax / 100);
        const total = discounted + taxAmount;

        document.getElementById("grandTotal").value = total.toFixed(2);
        document.getElementById("grandTotalFooter").innerText = "$" + total.toFixed(2);
        document.getElementById("grandTotalHidden").value = total.toFixed(2);
    }

    window.onload = calculateTotal;

    function openPrintPreview() {
        // Get all form values
        const form = document.querySelector('form');
        const formData = new FormData(form);

        // Get customer selection
        const customerSelect = document.getElementById('customerSelect');
        const customerId = customerSelect.value;

        // Create URL parameters
        const params = new URLSearchParams();

        // Add bill items
        document.querySelectorAll('input[name="itemId[]"]').forEach((input, index) => {
            params.append('itemId', input.value);
            params.append('quantity', document.querySelectorAll('input[name="quantity[]"]')[index].value);
        });

        // Add other form values
        params.append('discount', document.getElementById('discount').value);
        params.append('tax', document.getElementById('tax').value);
        params.append('paymentMethod', document.getElementById('paymentMethod').value);
        params.append('customerId', customerId);
        params.append('grandTotal', document.getElementById('grandTotalHidden').value);

        // Open print preview with all parameters
        window.open('${pageContext.request.contextPath}/cashier/printbill.jsp?' + params.toString(), '_blank');
    }

</script>
</body>
</html>
