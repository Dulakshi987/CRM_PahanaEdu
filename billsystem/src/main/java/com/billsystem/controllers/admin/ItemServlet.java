package com.billsystem.controllers.admin;

import com.billsystem.models.Item;
import com.billsystem.services.ItemService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/ItemServlet")
public class ItemServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Item item = new Item();
        item.setItemCode(request.getParameter("itemCode"));
        item.setItemName(request.getParameter("itemName"));
        item.setDescription(request.getParameter("description"));
        item.setPricePerUnit(Double.parseDouble(request.getParameter("pricePerUnit")));
        item.setStockQuantity(Integer.parseInt(request.getParameter("stockQuantity")));
        item.setStatus(request.getParameter("status"));

        ItemService service = new ItemService();
        service.addItem(item);

        response.sendRedirect("addItem.jsp?success=true");
    }
}
