<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register – PhoneMarket</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="auth-wrapper">
    <div class="auth-box" style="max-width:500px;">
        <h1>📱 Create Account</h1>
        <p class="subtitle">Join PhoneMarket – buy and sell phones easily</p>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error">${error}</div>
        <% } %>

        <form method="post" action="${pageContext.request.contextPath}/register">
            <div class="form-group">
                <label for="fullName">Full Name</label>
                <input type="text" id="fullName" name="fullName" class="form-control" placeholder="John Doe" required>
            </div>
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" class="form-control" placeholder="you@example.com" required>
            </div>
            <div class="form-group">
                <label for="phoneNumber">Phone Number (optional)</label>
                <input type="text" id="phoneNumber" name="phoneNumber" class="form-control" placeholder="+977 9800000000">
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" class="form-control" placeholder="Min 8 chars" required>
                </div>
                <div class="form-group">
                    <label for="confirmPassword">Confirm Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Repeat password" required>
                </div>
            </div>
            <p style="font-size:.8rem;color:var(--muted);margin-bottom:.8rem;">
                Password must be at least 8 characters, include uppercase, lowercase, digit and a special character (@$!%*#?&).
            </p>
            <button type="submit" class="btn btn-primary btn-full">Create Account</button>
        </form>

        <p style="text-align:center;margin-top:1.2rem;font-size:.9rem;color:var(--muted);">
            Already have an account?
            <a href="${pageContext.request.contextPath}/login">Sign in</a>
        </p>
    </div>
</div>
</body>
</html>
