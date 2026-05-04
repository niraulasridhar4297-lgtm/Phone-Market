package com.phonemarket.controllers;

import com.phonemarket.service.PurchaseService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/user/buy-request")
public class BuyRequestServlet extends HttpServlet {

    private final PurchaseService purchaseService = new PurchaseService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int    listingId = Integer.parseInt(req.getParameter("listingId"));
        int    buyerId   = (int) req.getSession().getAttribute("userId");
        String message   = req.getParameter("message");

        // Prevent seller from buying own listing - handled in JSP, double-check here
        String error = purchaseService.sendRequest(listingId, buyerId, message);
        if (error != null) {
            resp.sendRedirect(req.getContextPath() + "/user/listing?action=view&id=" + listingId + "&error=" + error);
        } else {
            resp.sendRedirect(req.getContextPath() + "/user/listing?action=view&id=" + listingId + "&msg=request_sent");
        }
    }
}
