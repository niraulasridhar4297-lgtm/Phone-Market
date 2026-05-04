package com.phonemarket.controllers;

import com.phonemarket.service.ListingService;
import com.phonemarket.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private final ListingService listingService = new ListingService();
    private final UserService    userService    = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("allListings", listingService.getAllListingsForAdmin());
        req.setAttribute("allUsers",    userService.getAllUsers());
        req.getRequestDispatcher("/WEB-INF/pages/admin/dashboard.jsp").forward(req, resp);
    }
}
