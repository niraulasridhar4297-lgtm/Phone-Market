package com.phonemarket.controllers;

import com.phonemarket.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * ContactServlet - Handles the Contact Us page.
 * GET  - Displays the contact form.
 * POST - Validates the inquiry form and shows a success/error message.
 */
@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/common/contact.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name    = ValidationUtil.sanitize(request.getParameter("name"));
        String email   = ValidationUtil.sanitize(request.getParameter("email"));
        String subject = ValidationUtil.sanitize(request.getParameter("subject"));
        String message = ValidationUtil.sanitize(request.getParameter("message"));

        // Basic validation
        if (!ValidationUtil.isNotEmpty(name) || !ValidationUtil.isNotEmpty(email)
                || !ValidationUtil.isNotEmpty(subject) || !ValidationUtil.isNotEmpty(message)) {
            request.setAttribute("error", "Please fill in all required fields.");
            request.getRequestDispatcher("/WEB-INF/pages/common/contact.jsp")
                   .forward(request, response);
            return;
        }

        if (!ValidationUtil.isValidEmail(email)) {
            request.setAttribute("error", "Please enter a valid email address.");
            request.getRequestDispatcher("/WEB-INF/pages/common/contact.jsp")
                   .forward(request, response);
            return;
        }

        // In a production system, the inquiry would be saved to a database or emailed.
        // For this demo, we simply acknowledge the submission.
        request.setAttribute("success",
                "Thank you, " + name + "! Your message has been received. "
                + "We will get back to you at " + email + " within 1–2 business days.");
        request.getRequestDispatcher("/WEB-INF/pages/common/contact.jsp")
               .forward(request, response);
    }
}
