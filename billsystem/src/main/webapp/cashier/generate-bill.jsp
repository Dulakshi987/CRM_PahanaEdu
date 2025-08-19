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
    if ("success".equals(messageType)) {
%>
<!-- Success Modal -->
<div class="modal fade" id="successModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content text-center">
            <div class="modal-body">
                <h5 style="color: green; font-weight: bold;"><%= message %></h5>
            </div>
            <div class="modal-footer justify-content-center">
                <button type="button" class="btn btn-primary" id="okButton">OK</button>
            </div>
        </div>
    </div>
</div>
<%
        session.removeAttribute("message");
        session.removeAttribute("messageType");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Create Bill</title>
    <link href="../assets/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />

    <style>
        .main-content {
            margin-left: 280px;
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
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .table-hover tbody tr:hover {
            background-color: #fff3e0;
        }

        .btn {
            border-radius: 8px;
        }

        .form-section {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
        }

        .action-buttons .btn {
            margin-left: 10px;
        }
    </style>

</head>
<body>

<%@ include file="layouts/sidebar.jsp" %>
<%@ include file="layouts/navbar.jsp" %>

<br><br><br><br>

<div class="main-content">
    <h2 class="text-center mb-4 " style="color: black;">Create Bill</h2>

    <!-- Add Item Form -->
    <div class="form-section">
        <form action="${pageContext.request.contextPath}/cashier/AddBillItemServlet" method="post" class="row g-3">
            <div class="col-md-6">
                <select name="itemId" id="itemId" class="form-select" required>
                    <option value="" disabled selected>Select Item</option>
                    <% for (Item i : items) { %>
                    <% if ("Active".equals(i.getStatus())) { %>
                    <option value="<%= i.getItemId() %>">
                        <%= i.getItemCode() %> - <%= i.getItemName() %> (LKR<%= String.format("%.2f", i.getPricePerUnit()) %>)
                    </option>
                    <% } %>
                    <% } %>
                </select>
            </div>

            <div class="col-md-3">
                <label for="quantity" class="form-label">Quantity</label>
                <input type="number" name="quantity" id="quantity" class="form-control" value="1" min="1" required />
            </div>

            <div class="col-md-3 d-flex align-items-end">
                <button type="submit" class="btn btn-primary w-30" style="background-color: #e7993c;">
                   </i>Add Item
                </button>
            </div>
        </form>
    </div>

    <form action="${pageContext.request.contextPath}/cashier/SaveBillServlet" method="post">

        <!-- Bill Items Table -->
        <div class="mt-4">
            <h5>Bill Items</h5>
            <div class="table-responsive">
                <table class="table table-bordered table-hover table-custom" id="billTable">
                    <thead class="custom-thead">
                    <tr>
                        <th>Item Code</th>
                        <th>Name</th>
                        <th>Qty</th>
                        <th>Unit Price</th>
                        <th>Total</th>
                        <th>Remove</th>
                    </tr>
                    </thead>

                    <tbody>
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
                            <button type="button" class="btn btn-danger btn-sm" onclick="removeRow(this)">
                                <i class="fas fa-trash-alt"></i>
                            </button>
                        </td>
                    </tr>

                    <!-- Hidden inputs for form submission -->
                    <input type="hidden" name="itemId[]" value="<%= item.getItemId() %>" />
                    <input type="hidden" name="quantity[]" value="<%= bi.getQuantity() %>" />
                    <input type="hidden" name="itemPrice[]" value="<%= item.getPricePerUnit() %>" />
                    <input type="hidden" name="totalPrice[]" value="<%= total %>" />
                    <input type="hidden" name="grandTotal" id="grandTotalHidden" value="0.0" />

                    <%
                        } %>
                    </tbody>
                    <tfoot>
                    <tr>
                        <th colspan="4" class="text-end">Grand Total</th>
                        <th id="grandTotalFooter">Rs.<%= String.format("%.2f", grandTotal) %></th>
                        <th></th>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>

        <!-- Calculation Section -->
        <div class="form-section">
            <div class="row g-3">

                <div class="col-md-3">
                    <label class="form-label">Subtotal</label>
                    <input type="text" class="form-control" id="subtotal" readonly />
                </div>

                <div class="col-md-3">
                    <label class="form-label">Discount (%)</label>
                    <input type="number" class="form-control" name="discount" id="discount" value="0" min="0" oninput="calculateTotal()" />
                </div>

                <div class="col-md-3">
                    <label class="form-label">Tax (%)</label>
                    <input type="number" class="form-control" name="tax" id="tax" value="0" min="0" oninput="calculateTotal()" />
                </div>

                <div class="col-md-3">
                    <label class="form-label">Total</label>
                    <input type="text" class="form-control" id="grandTotal" readonly />
                    <!-- Hidden field for backend -->
                    <input type="hidden" name="grandTotal" id="grandTotalHidden" value="0.0" />
                </div>

            </div>
        </div>

        <!-- Customer Select -->
        <div class="form-section">
            <div class="row g-3 align-items-center">
                <div class="col-md-6">
                    <label for="customerSelect" class="form-label">Select Customer</label>
                    <select id="customerSelect" class="form-select" required>
                        <option selected disabled>Select Customer</option>
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

        <!-- Payment method -->
        <div class="form-section">
            <div class="form-group">
                <div class="col-md-6">
                <label for="paymentMethod">Payment Method</label>
                <select class="form-control" name="paymentMethod" id="paymentMethod" required>
                    <option value="">Select Payment Method</option>
                    <option value="cash">Cash</option>
                    <option value="check">Check</option>
                    <option value="card">Card</option>
                </select>
            </div>
            </div>
        </div>

        <!-- Save & Print Buttons -->
        <div class="text-end mt-4 action-buttons">
            <button type="submit" class="btn btn-success" onclick="sendInvoiceEmail()">
                <i class="fas fa-envelope me-2"></i>Send Email
            </button>
            <button type="submit" class="btn btn-primary" onclick="openPrintPreview()">
                <i class="fas fa-print me-2"></i>Save and Print
            </button>
        </div>
    </form>
</div>

<%@ include file="layouts/footer.jsp" %>

<script>
    // Update customer email and hidden field
    document.getElementById("customerSelect").addEventListener("change", function () {
        const selectedOption = this.options[this.selectedIndex];
        const email = selectedOption.getAttribute("data-email") || "";
        const customerId = selectedOption.value;
        document.getElementById("customerEmail").value = email;
        document.getElementById("customerIdHidden").value = customerId;
        document.getElementById("customerEmailHidden").value = email;
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

        // Get discount and tax percentages
        const discountPercent = parseFloat(document.getElementById("discount").value) || 0;
        const taxPercent = parseFloat(document.getElementById("tax").value) || 0;

        // Calculate discount as percentage
        const discountAmount = subtotal * (discountPercent / 100);

        const discounted = Math.max(subtotal - discountAmount, 0);
        const taxAmount = discounted * (taxPercent / 100);
        const total = discounted + taxAmount;

        document.getElementById("grandTotal").value = total.toFixed(2);
        document.getElementById("grandTotalFooter").innerText = "Rs." + total.toFixed(2);
        document.getElementById("grandTotalHidden").value = total.toFixed(2);
    }

    window.onload = calculateTotal;

    function openPrintPreview() {
        const form = document.querySelector('form');
        const formData = new FormData(form);
        const customerSelect = document.getElementById('customerSelect');
        const customerId = customerSelect.value;

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

        // Open the printable view
        const printWindow = window.open('${pageContext.request.contextPath}/printbill.jsp?' + params.toString(), '_blank');

        // Optional: Wait for load and trigger print
        printWindow.onload = function () {
            printWindow.print();
        };
    }

    function sendInvoiceEmail() {
        const customerId = document.getElementById("customerSelect").value;
        const customerEmail = document.getElementById("customerEmail").value;

        if (!customerId || !customerEmail) {
            alert("Please select a customer first.");
            return;
        }

        // Check if there are any bill items
        const billRows = document.querySelectorAll("#billTable tbody tr");
        if (billRows.length === 0) {
            alert("Please add at least one item to the bill before sending email.");
            return;
        }

        // Get current form values
        const discount = document.getElementById("discount").value || "0";
        const tax = document.getElementById("tax").value || "8";

        // Create form data
        const formData = new URLSearchParams({
            customerId: customerId,
            discount: discount,
            tax: tax,
            sendEmailOnly: 'yes'
        });

        // Show loading message
        const originalText = event.target.innerText;
        event.target.innerText = "Sending...";
        event.target.disabled = true;

        // Send request to SendEmailServlet
        fetch("${pageContext.request.contextPath}/cashier/SendEmailServlet", {
            method: "POST",
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: formData
        })
            .then(response => response.text())
            .then(data => {
                alert(data);
                // Reset button
                event.target.innerText = originalText;
                event.target.disabled = false;
            })
            .catch(error => {
                alert("Failed to send email: " + error);
                // Reset button
                event.target.innerText = originalText;
                event.target.disabled = false;
            });
    }

    window.onload = function () {
        var modal = new bootstrap.Modal(document.getElementById('successModal'));
        modal.show();

        document.getElementById('okButton').addEventListener('click', function () {
            // Clear the bill table
            document.querySelectorAll("#billTable tbody tr").forEach(row => row.remove());
            document.getElementById("grandTotalFooter").innerText = "Rs.0.00";

            // Close modal
            modal.hide();
        });
    }
</script>
</body>
</html>