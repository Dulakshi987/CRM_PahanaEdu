package com.billsystem.controllers.cashier;

import com.billsystem.models.BillItem;
import com.billsystem.models.Item;
import com.billsystem.services.ItemService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cashier/AddBillItemServlet")
public class AddBillItemServlet extends HttpServlet {
    private final ItemService itemService = new ItemService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String itemIdStr = req.getParameter("itemId");
        String qtyStr = req.getParameter("quantity");

        if(itemIdStr == null || qtyStr == null) {
            resp.sendRedirect("generate-bill.jsp"); // fallback
            return;
        }

        int itemId = Integer.parseInt(itemIdStr);
        int quantity = Integer.parseInt(qtyStr);
        if (quantity < 1) quantity = 1;

        // Get the item
        Item item = itemService.getItemById(itemId);
        if (item == null) {
            resp.sendRedirect("generate-bill.jsp");
            return;
        }

        // Get current bill items from session
        HttpSession session = req.getSession();
        List<BillItem> billItems = (List<BillItem>) session.getAttribute("billItems");
        if (billItems == null) {
            billItems = new ArrayList<>();
        }

        // Check if item already exists in bill, update quantity
        boolean updated = false;
        for (BillItem bi : billItems) {
            if (bi.getItemId() == itemId) {
                bi.setQuantity(bi.getQuantity() + quantity);
                updated = true;
                break;
            }
        }
        if (!updated) {
            BillItem newBillItem = new BillItem();
            newBillItem.setItemId(itemId);
            newBillItem.setQuantity(quantity);
            billItems.add(newBillItem);
        }

        // Save updated list
        session.setAttribute("billItems", billItems);

        resp.sendRedirect("generate-bill.jsp");

    }
}
