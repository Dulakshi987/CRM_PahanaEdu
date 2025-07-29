package com.billsystem.controllers.cashier;

import com.billsystem.models.BillItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/RemoveBillItemServlet")
public class RemoveBillItemServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String itemIdStr = req.getParameter("itemId");
        if (itemIdStr != null) {
            int itemId = Integer.parseInt(itemIdStr);
            HttpSession session = req.getSession();
            List<BillItem> billItems = (List<BillItem>) session.getAttribute("billItems");

            if (billItems != null) {
                System.out.println("Attempting to remove itemId: " + itemId);
                billItems.removeIf(bi -> {
                    System.out.println("Checking item: " + bi.getItemId());
                    return bi.getItemId() == itemId;
                });

                session.setAttribute("billItems", billItems); // Re-set the list
            }
        }

        resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        resp.sendRedirect("generate-bill.jsp");
    }
}
