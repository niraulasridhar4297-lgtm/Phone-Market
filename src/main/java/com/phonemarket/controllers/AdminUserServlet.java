package com.phonemarket.controllers;

import com.phonemarket.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/user")
public class AdminUserServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        int id = 0;
        try { id = Integer.parseInt(req.getParameter("id")); } catch (Exception ignored) {}

        if ("unlock".equals(action)) {
            userService.unlockUser(id);
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard?msg=unlocked");
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
        }
    }
}
