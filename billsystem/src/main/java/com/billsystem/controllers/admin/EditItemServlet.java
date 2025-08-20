package com.billsystem.controllers.admin;

import com.billsystem.models.Item;
import com.billsystem.services.ItemService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/EditItemServlet")
public class EditItemServlet extends HttpServlet {
    private final ItemService itemService = new ItemService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int itemId = Integer.parseInt(request.getParameter("id"));
        Item item = itemService.getItemById(itemId);

        if (item != null) {
            request.setAttribute("item", item);
            request.getRequestDispatcher("editItem.jsp").forward(request, response);
        } else {
            response.sendRedirect("viewItems.jsp");
        }
    }
}
