package com.phonemarket.controllers;

import com.phonemarket.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/pages/common/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String fullName    = req.getParameter("fullName");
        String email       = req.getParameter("email");
        String password    = req.getParameter("password");
        String confirmPw   = req.getParameter("confirmPassword");
        String phoneNumber = req.getParameter("phoneNumber");

        if (!password.equals(confirmPw)) {
            req.setAttribute("error", "Passwords do not match.");
            req.getRequestDispatcher("/WEB-INF/pages/common/register.jsp").forward(req, resp);
            return;
        }

        String error = userService.register(fullName, email, password, phoneNumber);
        if (error != null) {
            req.setAttribute("error", error);
            req.getRequestDispatcher("/WEB-INF/pages/common/register.jsp").forward(req, resp);
            return;
        }

        resp.sendRedirect(req.getContextPath() + "/login?success=registered");
    }
}
