<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>500 – Server Error</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div style="min-height:100vh;display:flex;align-items:center;justify-content:center;flex-direction:column;gap:1rem;text-align:center;padding:2rem;">
    <div style="font-size:5rem;">⚠️</div>
    <h1 style="font-size:2.5rem;color:var(--danger);">500</h1>
    <p style="font-size:1.1rem;color:var(--muted);">Something went wrong on our end. Please try again later.</p>
    <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">Go to Home</a>
</div>
</body>
</html>
