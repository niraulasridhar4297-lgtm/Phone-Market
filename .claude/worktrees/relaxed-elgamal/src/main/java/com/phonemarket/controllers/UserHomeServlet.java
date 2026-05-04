package com.phonemarket.controllers;

import com.phonemarket.service.ListingService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/user/home")
public class UserHomeServlet extends HttpServlet {

    private final ListingService listingService = new ListingService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String keyword        = req.getParameter("keyword");
        String brand          = req.getParameter("brand");
        String conditionGrade = req.getParameter("condition");
        String sortBy         = req.getParameter("sort");

        req.setAttribute("listings",      listingService.searchListings(keyword, brand, conditionGrade, sortBy));
        req.setAttribute("brands",        listingService.getDistinctBrands());
        req.setAttribute("keyword",       keyword);
        req.setAttribute("selectedBrand", brand);
        req.setAttribute("selectedCond",  conditionGrade);
        req.setAttribute("selectedSort",  sortBy);

        req.getRequestDispatcher("/WEB-INF/pages/user/home.jsp").forward(req, resp);
    }
}
