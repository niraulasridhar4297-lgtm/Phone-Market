package com.phonemarket.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebFilter(urlPatterns = {"/user/*", "/admin/*"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  req  = (HttpServletRequest)  request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String path = req.getServletPath();
        boolean loggedIn = (session != null && session.getAttribute("loggedInUser") != null);

        if (!loggedIn) {
            resp.sendRedirect(req.getContextPath() + "/login?error=session");
            return;
        }

        String role = (String) session.getAttribute("userRole");

        // Prevent regular users from accessing admin URLs
        if (path.startsWith("/admin") && !"admin".equals(role)) {
            resp.sendRedirect(req.getContextPath() + "/user/home");
            return;
        }

        // Prevent admins from accessing user URLs (optional: redirect to admin home)
        if (path.startsWith("/user") && "admin".equals(role)) {
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override public void init(FilterConfig f) {}
    @Override public void destroy() {}
}
