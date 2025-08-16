package com.billsystem.controllers.admin;

import com.billsystem.models.Item;
import com.billsystem.services.ItemService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin/ItemServlet")
public class ItemServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String itemCode = request.getParameter("itemCode");
        String itemName = request.getParameter("itemName");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("pricePerUnit");
        String stockStr = request.getParameter("stockQuantity");
        String status = request.getParameter("status");

        Item item = new Item();
        item.setItemCode(itemCode);
        item.setItemName(itemName);
        item.setDescription(description);
        try {
            item.setPricePerUnit(Double.parseDouble(priceStr));
        } catch (NumberFormatException e) {
            item.setPricePerUnit(0);
        }
        try {
            item.setStockQuantity(Integer.parseInt(stockStr));
        } catch (NumberFormatException e) {
            item.setStockQuantity(0);
        }
        item.setStatus(status);

        ItemService service = new ItemService();
        service.addItem(item);

// Use context path + absolute path starting from root of webapp
        response.sendRedirect(request.getContextPath() + "/admin/addItem.jsp?success=true");
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            ItemService service = new ItemService();
            service.deleteItem(id);

            HttpSession session = request.getSession();
            session.setAttribute("successMessage", "Item deleted successfully!");

            response.sendRedirect("ViewItemsServlet");
        }
    }


}
