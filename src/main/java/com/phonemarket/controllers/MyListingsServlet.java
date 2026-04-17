package com.phonemarket.controllers;

import com.phonemarket.service.ListingService;
import com.phonemarket.service.PurchaseService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/user/my-listings")
public class MyListingsServlet extends HttpServlet {

    private final ListingService  listingService  = new ListingService();
    private final PurchaseService purchaseService = new PurchaseService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int userId = (int) req.getSession().getAttribute("userId");

        req.setAttribute("myListings",    listingService.getListingsBySeller(userId));
        req.setAttribute("buyRequests",   purchaseService.getRequestsForSeller(userId));
        req.setAttribute("myBuyRequests", purchaseService.getRequestsByBuyer(userId));

        req.getRequestDispatcher("/WEB-INF/pages/user/my_listings.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action    = req.getParameter("action");
        int    requestId = Integer.parseInt(req.getParameter("requestId"));

        if ("accept".equals(action)) {
            purchaseService.updateRequestStatus(requestId, "accepted");
        } else if ("reject".equals(action)) {
            purchaseService.updateRequestStatus(requestId, "rejected");
        }
        resp.sendRedirect(req.getContextPath() + "/user/my-listings");
    }
}
