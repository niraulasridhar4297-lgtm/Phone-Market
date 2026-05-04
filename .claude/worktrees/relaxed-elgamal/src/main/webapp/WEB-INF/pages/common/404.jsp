<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 – Page Not Found – PhoneMarket</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body style="background:linear-gradient(135deg,#dbeafe 0%,#ede9fe 100%);min-height:100vh;display:flex;flex-direction:column;">
<div class="error-page" style="flex:1;">
    <div style="font-size:5rem;margin-bottom:.5rem;">📭</div>
    <div class="error-code blue">404</div>
    <h1 style="font-size:1.5rem;font-weight:700;margin-top:.5rem;">Page Not Found</h1>
    <p style="color:var(--muted);font-size:1rem;max-width:420px;line-height:1.7;">
        Oops! The page you're looking for doesn't exist or has been moved.
        Let's get you back on track.
    </p>
    <div style="display:flex;gap:.8rem;flex-wrap:wrap;justify-content:center;margin-top:.5rem;">
        <a href="${pageContext.request.contextPath}/login" class="btn btn-primary btn-lg">Go to Home</a>
        <a href="javascript:history.back()" class="btn btn-outline-muted">Go Back</a>
    </div>
</div>
<footer style="background:#0f172a;color:rgba(255,255,255,.4);text-align:center;padding:1rem;font-size:.82rem;">
    &copy; 2025 PhoneMarket
</footer>
</body>
</html>
