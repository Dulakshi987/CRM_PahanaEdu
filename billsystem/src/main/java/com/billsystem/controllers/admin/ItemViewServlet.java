package com.billsystem.controllers.admin;

import com.billsystem.models.Item;
import com.billsystem.services.ItemService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/ViewItemsServlet")
public class ItemViewServlet extends HttpServlet {

    private final ItemService itemService = new ItemService();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String searchQuery = request.getParameter("search"); // get search term

        List<Item> itemList;
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            itemList = itemService.searchItemsByName(searchQuery.trim());
        } else {
            itemList = itemService.getAllItems();
        }

        request.setAttribute("itemList", itemList);
        request.setAttribute("searchQuery", searchQuery); // to keep the search box filled
        request.getRequestDispatcher("/admin/viewItems.jsp").forward(request, response);
    }

}
