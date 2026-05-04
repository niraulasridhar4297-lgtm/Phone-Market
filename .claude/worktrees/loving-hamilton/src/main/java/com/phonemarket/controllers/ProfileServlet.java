package com.phonemarket.controllers;

import com.phonemarket.model.User;
import com.phonemarket.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/user/profile")
public class ProfileServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/pages/user/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        int    userId = (int) req.getSession().getAttribute("userId");

        if ("updateProfile".equals(action)) {
            String error = userService.updateProfile(userId,
                    req.getParameter("fullName"), req.getParameter("phoneNumber"));
            if (error != null) {
                req.setAttribute("profileError", error);
            } else {
                // Refresh session name
                User updated = userService.getUserById(userId);
                req.getSession().setAttribute("userName",     updated.getFullName());
                req.getSession().setAttribute("loggedInUser", updated);
                req.setAttribute("profileSuccess", "Profile updated successfully.");
            }
        } else if ("changePassword".equals(action)) {
            String error = userService.changePassword(userId,
                    req.getParameter("currentPassword"),
                    req.getParameter("newPassword"));
            if (error != null) {
                req.setAttribute("passwordError", error);
            } else {
                req.setAttribute("passwordSuccess", "Password changed successfully.");
            }
        }

        req.getRequestDispatcher("/WEB-INF/pages/user/profile.jsp").forward(req, resp);
    }
}
