package com.billsystem.controllers.admin;

import com.billsystem.models.Item;
import com.billsystem.services.ItemService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/UpdateItemServlet")
public class UpdateItemServlet extends HttpServlet {
    private final ItemService itemService = new ItemService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int itemId = Integer.parseInt(request.getParameter("itemId"));
            String itemCode = request.getParameter("itemCode");
            String itemName = request.getParameter("itemName");
            String description = request.getParameter("description");
            double pricePerUnit = Double.parseDouble(request.getParameter("pricePerUnit"));
            int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
            String status = request.getParameter("status");

            Item item = new Item();
            item.setItemId(itemId);
            item.setItemCode(itemCode);  // Include itemCode here
            item.setItemName(itemName);
            item.setDescription(description);
            item.setPricePerUnit(pricePerUnit);
            item.setStockQuantity(stockQuantity);
            item.setStatus(status);

            boolean success = itemService.updateItem(item);

            HttpSession session = request.getSession();
            if (success) {
                session.setAttribute("successMessage", "Item updated successfully!");
            } else {
                session.setAttribute("errorMessage", "Failed to update item.");
            }
            response.sendRedirect("ViewItemsServlet");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Invalid input data. Please try again.");
            request.getRequestDispatcher("/admin/editItem.jsp").forward(request, response);
        }
    }
}
