package com.phonemarket.controllers;

import com.phonemarket.model.PhoneListing;
import com.phonemarket.service.ListingService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;

@WebServlet("/user/listing")
public class ListingServlet extends HttpServlet {

    private final ListingService listingService = new ListingService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("new".equals(action)) {
            req.getRequestDispatcher("/WEB-INF/pages/user/listing_form.jsp").forward(req, resp);
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            PhoneListing listing = listingService.getListingById(id);
            int userId = (int) req.getSession().getAttribute("userId");
            if (listing == null || listing.getSellerId() != userId) {
                resp.sendRedirect(req.getContextPath() + "/user/my-listings");
                return;
            }
            req.setAttribute("listing", listing);
            req.setAttribute("editMode", true);
            req.getRequestDispatcher("/WEB-INF/pages/user/listing_form.jsp").forward(req, resp);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            int userId = (int) req.getSession().getAttribute("userId");
            listingService.deleteListing(id, userId);
            resp.sendRedirect(req.getContextPath() + "/user/my-listings?msg=deleted");
        } else if ("view".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            PhoneListing listing = listingService.getListingById(id);
            req.setAttribute("listing", listing);
            req.getRequestDispatcher("/WEB-INF/pages/user/listing_detail.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        int userId = (int) req.getSession().getAttribute("userId");

        PhoneListing l = new PhoneListing();
        l.setSellerId(userId);
        l.setTitle(req.getParameter("title"));
        l.setBrand(req.getParameter("brand"));
        l.setModelName(req.getParameter("modelName"));

        String dateStr = req.getParameter("firstBuyDate");
        if (dateStr != null && !dateStr.isEmpty()) l.setFirstBuyDate(Date.valueOf(dateStr));

        try { l.setRamGb(Integer.parseInt(req.getParameter("ramGb"))); } catch (Exception e) {}
        try { l.setStorageGb(Integer.parseInt(req.getParameter("storageGb"))); } catch (Exception e) {}
        try { l.setBatteryMah(Integer.parseInt(req.getParameter("batteryMah"))); } catch (Exception e) {}
        try { l.setScreenSizeInch(new BigDecimal(req.getParameter("screenSize"))); } catch (Exception e) {}

        l.setColor(req.getParameter("color"));
        l.setConditionGrade(req.getParameter("conditionGrade"));
        try { l.setPrice(new BigDecimal(req.getParameter("price"))); } catch (Exception e) {}
        l.setDescription(req.getParameter("description"));

        if ("create".equals(action)) {
            String error = listingService.createListing(l);
            if (error != null) {
                req.setAttribute("error", error);
                req.getRequestDispatcher("/WEB-INF/pages/user/listing_form.jsp").forward(req, resp);
                return;
            }
            resp.sendRedirect(req.getContextPath() + "/user/my-listings?msg=created");
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(req.getParameter("listingId"));
            l.setListingId(id);
            String error = listingService.updateListing(l, userId);
            if (error != null) {
                req.setAttribute("error", error);
                req.setAttribute("listing", l);
                req.setAttribute("editMode", true);
                req.getRequestDispatcher("/WEB-INF/pages/user/listing_form.jsp").forward(req, resp);
                return;
            }
            resp.sendRedirect(req.getContextPath() + "/user/my-listings?msg=updated");
        }
    }
}
