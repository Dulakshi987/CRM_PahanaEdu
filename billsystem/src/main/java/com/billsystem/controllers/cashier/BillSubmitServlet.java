package com.billsystem.controllers.cashier;

import com.billsystem.models.Bill;
import com.billsystem.models.BillItem;
import com.billsystem.services.BillService;
import com.billsystem.services.BillServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


@WebServlet("/cashier/BillSubmitServlet")
public class BillSubmitServlet extends HttpServlet {
    @Override

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        double discount = Double.parseDouble(request.getParameter("discount"));
        double tax = Double.parseDouble(request.getParameter("tax"));
        double grandTotal = Double.parseDouble(request.getParameter("grandTotal"));

        String[] itemIds = request.getParameterValues("itemId");
        String[] quantities = request.getParameterValues("quantity");
        String[] prices = request.getParameterValues("price");
        String[] totals = request.getParameterValues("total");

        List<BillItem> items = new ArrayList<>();
        for (int i = 0; i < itemIds.length; i++) {
            BillItem item = new BillItem();
            item.setItemId(Integer.parseInt(itemIds[i]));
            item.setQuantity(Integer.parseInt(quantities[i]));
            item.setTotalPrice(Double.parseDouble(totals[i]));
            items.add(item);
        }

        Bill bill = new Bill();
        bill.setCustomerId(customerId);
        bill.setDiscount(discount);
        bill.setTax(tax);
        bill.setGrandTotal(grandTotal);
        bill.setTotalAmount(grandTotal); // or calc subtotal if needed
        bill.setBillDate(java.time.LocalDate.now().toString());
        bill.setItems(items);

        BillService billService = new BillServiceImpl();
        billService.saveBillWithItems(bill);

        request.getRequestDispatcher("/generate-bill.jsp").forward(request, response);
    }


}

