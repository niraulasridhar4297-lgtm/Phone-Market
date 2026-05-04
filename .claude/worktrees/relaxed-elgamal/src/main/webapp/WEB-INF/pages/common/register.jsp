<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account – PhoneMarket</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="auth-wrapper">
    <div class="auth-box" style="max-width:520px;">
        <div class="auth-logo">📱 Phone<span>Market</span></div>
        <p class="subtitle">Create your free account to buy and sell phones</p>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error">${error}</div>
        <% } %>

        <form method="post" action="${pageContext.request.contextPath}/register" novalidate>
            <div class="form-group">
                <label for="fullName">Full Name *</label>
                <input type="text" id="fullName" name="fullName" class="form-control"
                       placeholder="e.g. John Doe" autocomplete="name" required>
            </div>
            <div class="form-group">
                <label for="email">Email Address *</label>
                <input type="email" id="email" name="email" class="form-control"
                       placeholder="you@example.com" autocomplete="email" required>
            </div>
            <div class="form-group">
                <label for="phoneNumber">Phone Number <span style="font-weight:400;color:var(--muted);">(optional)</span></label>
                <input type="text" id="phoneNumber" name="phoneNumber" class="form-control"
                       placeholder="+977 9800000000" autocomplete="tel">
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label for="password">Password *</label>
                    <input type="password" id="password" name="password" class="form-control"
                           placeholder="Min 8 characters" autocomplete="new-password" required>
                </div>
                <div class="form-group">
                    <label for="confirmPassword">Confirm Password *</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" class="form-control"
                           placeholder="Repeat password" autocomplete="new-password" required>
                </div>
            </div>
            <p class="form-hint" style="margin-bottom:1rem;">
                Password must be at least 8 characters and include uppercase, lowercase, a digit and a special character (@$!%*#?&amp;).
            </p>
            <button type="submit" class="btn btn-primary btn-full">Create Account</button>
        </form>

        <hr class="divider">

        <p style="text-align:center;font-size:.9rem;color:var(--muted);">
            Already have an account?
            <a href="${pageContext.request.contextPath}/login" style="font-weight:600;">Sign in</a>
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
