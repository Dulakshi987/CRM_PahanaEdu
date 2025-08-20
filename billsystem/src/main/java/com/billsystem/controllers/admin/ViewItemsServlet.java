package com.billsystem.controllers.admin;

import com.billsystem.models.Item;
import com.billsystem.services.ItemService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/ViewItemsServlet")
public class ViewItemsServlet extends HttpServlet {

    private final ItemService itemService = new ItemService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Item> items = itemService.getAllItems();
        req.setAttribute("items", items);

        req.getRequestDispatcher("/admin/viewItems.jsp").forward(req, resp);
    }


}
