package com.billsystem.controllers.cashier;

import com.billsystem.models.Bill;
import com.billsystem.models.BillItem;
import com.billsystem.services.BillService;
import com.billsystem.services.BillServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cashier/SaveBillServlet")
public class BillSubmitServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int customerId = Integer.parseInt(request.getParameter("customerId").trim());
            double discount = Double.parseDouble(request.getParameter("discount").trim());
            double tax = Double.parseDouble(request.getParameter("tax").trim());
            double grandTotal = Double.parseDouble(request.getParameter("grandTotal").trim());
            String paymentMethod = request.getParameter("paymentMethod");


            // Read bill items  from request
            String[] itemIds = request.getParameterValues("itemId[]");
            String[] quantities = request.getParameterValues("quantity[]");
            String[] itemPrices = request.getParameterValues("itemPrice[]");
            String[] totalPrices = request.getParameterValues("totalPrice[]");

            List<BillItem> itemList = new ArrayList<>();
            if (itemIds != null) {
                for (int i = 0; i < itemIds.length; i++) {
                    int itemId = Integer.parseInt(itemIds[i].trim());
                    int quantity = Integer.parseInt(quantities[i].trim());
                    double itemPrice = Double.parseDouble(itemPrices[i].trim());
                    double totalPrice = Double.parseDouble(totalPrices[i].trim());

                    BillItem item = new BillItem();
                    item.setItemId(itemId);
                    item.setQuantity(quantity);
                    item.setItemPrice(itemPrice);
                    item.setTotalPrice(totalPrice);

                    itemList.add(item);
                }
            }

            Bill bill = new Bill();
            bill.setCustomerId(customerId);
            bill.setDiscount(discount);
            bill.setTax(tax);
            bill.setGrandTotal(grandTotal);
            bill.setPaymentMethod(paymentMethod);
            bill.setItems(itemList);

            // Save bill with items in the bill_item table

            BillService billService = new BillServiceImpl();
            boolean isSaved = billService.saveBillWithItems(bill);

            HttpSession session = request.getSession();
            if (isSaved) {
                session.setAttribute("message", "Bill saved successfully.");
                session.setAttribute("messageType", "success");
                response.sendRedirect("generate-bill.jsp");
            } else {
                session.setAttribute("message", "Something went wrong while saving the bill.");
                session.setAttribute("messageType", "error");
                response.sendRedirect("generate-bill.jsp");
            }


        } catch (Exception e) {
            response.sendRedirect("error.jsp");
        }
    }
}
