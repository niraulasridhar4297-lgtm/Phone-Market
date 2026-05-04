package com.phonemarket.controllers;

import com.phonemarket.service.ListingService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/listing")
public class AdminListingServlet extends HttpServlet {

    private final ListingService listingService = new ListingService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        int id = 0;
        try { id = Integer.parseInt(req.getParameter("id")); } catch (Exception ignored) {}

        switch (action == null ? "" : action) {
            case "delete":
                listingService.adminDeleteListing(id);
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard?msg=deleted");
                break;
            case "approve":
                listingService.adminUpdateStatus(id, "available");
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard?msg=approved");
                break;
            case "reject":
                listingService.adminUpdateStatus(id, "rejected");
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard?msg=rejected");
                break;
            case "reorder":
                String direction = req.getParameter("dir");
                listingService.adminReorder(id, direction);
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
                break;
            case "view":
                req.setAttribute("listing", listingService.getListingById(id));
                req.getRequestDispatcher("/WEB-INF/pages/admin/listing_detail.jsp").forward(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
        }
    }
}
