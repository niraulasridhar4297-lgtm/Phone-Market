package com.phonemarket.controllers;

import com.phonemarket.model.User;
import com.phonemarket.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Redirect already-logged-in users
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("loggedInUser") != null) {
            String role = (String) session.getAttribute("userRole");
            redirectByRole(req, resp, role);
            return;
        }
        req.getRequestDispatcher("/WEB-INF/pages/common/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String email    = req.getParameter("email");
        String password = req.getParameter("password");

        String[] errorOut = {null};
        User user = userService.login(email, password, errorOut);

        if (user == null) {
            req.setAttribute("error", errorOut[0]);
            req.getRequestDispatcher("/WEB-INF/pages/common/login.jsp").forward(req, resp);
            return;
        }

        HttpSession session = req.getSession(true);
        session.setAttribute("loggedInUser", user);
        session.setAttribute("userId",       user.getUserId());
        session.setAttribute("userRole",     user.getRole());
        session.setAttribute("userName",     user.getFullName());
        session.setMaxInactiveInterval(30 * 60); // 30 min

        redirectByRole(req, resp, user.getRole());
    }

    private void redirectByRole(HttpServletRequest req, HttpServletResponse resp, String role)
            throws IOException {
        if ("admin".equals(role)) {
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
        } else {
            resp.sendRedirect(req.getContextPath() + "/user/home");
        }
    }
}
