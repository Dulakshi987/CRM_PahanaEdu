<%@ page import="java.util.*, com.billsystem.models.*, com.billsystem.services.*" %>
<%@ page session="true" %>


<%--item and customer id retrieve--%>
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

<%--sucess message if save database--%>

<%
    String message = (String) session.getAttribute("message");
    String messageType = (String) session.getAttribute("messageType");
    if (message != null) {
%>
<div style="color: <%= "success".equals(messageType) ? "green" : "red" %>; font-weight: bold;">
    <%= message %>
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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4 text-center text-primary">Bill Creation</h2>

    <!-- Add Item Form -->

    <form action="${pageContext.request.contextPath}/cashier/AddBillItemServlet" method="post" class="row g-3 mb-4">
        <div class="col-md-6">

            <label for="itemId" class="form-label">Select Item</label>
            <select name="itemId" id="itemId" class="form-select" required>
                <option value="" disabled selected>-- Select Item --</option>
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
            <button type="submit" class="btn btn-primary w-100">Add Item</button>
        </div>
    </form>

    <form action="${pageContext.request.contextPath}/cashier/SaveBillServlet" method="post">

        <!-- Bill Items Table -->

        <div class="mt-4">
            <h5>Bill Items</h5>

            <table class="table table-bordered" id="billTable">
                <thead class="table-warning">
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
                        <button type="button" class="btn btn-danger btn-sm" onclick="removeRow(this)">Remove</button>
                    </td>

                </tr>

                <!-- I am added for hidden inputs for form submission -->
                <input type="hidden" name="itemId[]" value="<%= item.getItemId() %>" />
                <input type="hidden" name="quantity[]" value="<%= bi.getQuantity() %>" />
                <input type="hidden" name="itemPrice[]" value="<%= item.getPricePerUnit() %>" />
                <input type="hidden" name="totalPrice[]" value="<%= total %>" />
                <%
                    } %>

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

        <div class="form-section mt-4 p-3 border rounded bg-light">
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

                    <!-- I am added for hidden form submission -->
                    <input type="hidden" name="grandTotal" id="grandTotalHidden" value="0.0" />

                </div>
            </div>
        </div>

        <!-- Customer Selection -->

        <div class="mb-4 row g-3 align-items-center">
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

<%--                I am added for hidden from submission--%>

                <input type="hidden" name="customerId" id="customerIdHidden" />

            </div>

            <div class="col-md-6">
                <label for="customerEmail" class="form-label">Customer Email</label>
                <input type="email" id="customerEmail" class="form-control" readonly />
            </div>
        </div>

        <%--        payament method--%>

        <div class="form-group">
            <label for="paymentMethod">Payment Method</label>
            <select class="form-control" name="paymentMethod" id="paymentMethod" required>
                <option value="">-- Select Payment Method --</option>
                <option value="cash">Cash</option>
                <option value="check">Check</option>
                <option value="card">Card</option>
            </select>
        </div>

        <!-- Save & Print Buttons -->

        <div class="text-end mt-4">
            <button type="button" class="btn btn-secondary" onclick="window.print()"> Print Bill</button>
            <button type="submit" class="btn btn-success"> Save to Database</button>
        </div>
    </form>

</div>

<script>

    // Update customer email and hidden field

    document.getElementById("customerSelect").addEventListener("change", function () {
        const selectedOption = this.options[this.selectedIndex];
        const email = selectedOption.getAttribute("data-email") || "";
        const customerId = selectedOption.value;
        document.getElementById("customerEmail").value = email;
        document.getElementById("customerIdHidden").value = customerId;
    });

    // remove added item feilds

    function removeRow(button) {
        const row = button.closest("tr");
        row.remove();
        calculateTotal();
    }

    // calculate items

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

</script>
</body>
</html>
