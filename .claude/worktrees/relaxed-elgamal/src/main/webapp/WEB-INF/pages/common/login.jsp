<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In – PhoneMarket</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="auth-wrapper">
    <div class="auth-box">
        <div class="auth-logo">📱 Phone<span>Market</span></div>
        <p class="subtitle">Sign in to buy or sell second-hand phones</p>

        <% if ("session".equals(request.getParameter("error"))) { %>
            <div class="alert alert-warning">Your session has expired. Please sign in again.</div>
        <% } %>
        <% if ("registered".equals(request.getParameter("success"))) { %>
            <div class="alert alert-success">Account created successfully! You can now sign in.</div>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error">${error}</div>
        <% } %>

        <form method="post" action="${pageContext.request.contextPath}/login" novalidate>
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" class="form-control"
                       placeholder="you@example.com" autocomplete="email" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" class="form-control"
                       placeholder="Enter your password" autocomplete="current-password" required>
            </div>
            <button type="submit" class="btn btn-primary btn-full" style="margin-top:.6rem;">
                Sign In
            </button>
        </form>

        <hr class="divider">

        <p style="text-align:center;font-size:.9rem;color:var(--muted);">
            Don't have an account?
            <a href="${pageContext.request.contextPath}/register" style="font-weight:600;">Create one free</a>
        </p>
        <p style="text-align:center;margin-top:.6rem;font-size:.82rem;color:var(--muted);">
            <a href="${pageContext.request.contextPath}/about">About PhoneMarket</a>
            &nbsp;&bull;&nbsp;
            <a href="${pageContext.request.contextPath}/contact">Contact Us</a>
        </p>
    </div>
</div>
</body>
</html>
