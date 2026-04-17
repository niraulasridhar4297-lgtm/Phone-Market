<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login – PhoneMarket</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="auth-wrapper">
    <div class="auth-box">
        <h1>📱 PhoneMarket</h1>
        <p class="subtitle">Sign in to buy or sell second-hand phones</p>

        <% if ("session".equals(request.getParameter("error"))) { %>
            <div class="alert alert-warning">Your session expired. Please log in again.</div>
        <% } %>
        <% if ("registered".equals(request.getParameter("success"))) { %>
            <div class="alert alert-success">Registration successful! You can now log in.</div>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error">${error}</div>
        <% } %>

        <form method="post" action="${pageContext.request.contextPath}/login">
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" class="form-control" placeholder="you@example.com" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" class="form-control" placeholder="••••••••" required>
            </div>
            <button type="submit" class="btn btn-primary btn-full" style="margin-top:.5rem;">Sign In</button>
        </form>

        <p style="text-align:center;margin-top:1.2rem;font-size:.9rem;color:var(--muted);">
            Don't have an account?
            <a href="${pageContext.request.contextPath}/register">Create one</a>
        </p>
    </div>
</div>
</body>
</html>
