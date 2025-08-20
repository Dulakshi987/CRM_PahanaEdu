package com.billsystem.controllers.admin;

import com.billsystem.models.Bill;
import com.billsystem.services.BillService;
import com.billsystem.services.BillServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/ViewBillServlet")
public class ViewBillServlet extends HttpServlet {
    private BillService billService = new BillServiceImpl();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Bill> billList = billService.getAllBills();

        if (billList != null && !billList.isEmpty()) {
            request.setAttribute("bills", billList);
        }

        request.getRequestDispatcher("/admin/billRecords.jsp").forward(request, response);
    }
}

