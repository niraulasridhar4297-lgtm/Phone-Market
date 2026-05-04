<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile – PhoneMarket</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="/WEB-INF/pages/common/header.jsp" %>

<div class="container main-content">
    <h1 class="page-title">👤 My Profile</h1>

    <div style="display:grid;grid-template-columns:1fr 1fr;gap:1.5rem;max-width:900px;">

        <!-- Update Profile -->
        <div class="card">
            <h2 style="font-size:1.1rem;margin-bottom:1.2rem;">Personal Information</h2>

            <c:if test="${profileSuccess != null}"><div class="alert alert-success">${profileSuccess}</div></c:if>
            <c:if test="${profileError   != null}"><div class="alert alert-error">${profileError}</div></c:if>

            <form method="post" action="${pageContext.request.contextPath}/user/profile">
                <input type="hidden" name="action" value="updateProfile">
                <div class="form-group">
                    <label for="fullName">Full Name</label>
                    <input type="text" id="fullName" name="fullName" class="form-control"
                           value="${sessionScope.loggedInUser.fullName}" required>
                </div>
                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" class="form-control" value="${sessionScope.loggedInUser.email}" disabled>
                    <small style="color:var(--muted);">Email cannot be changed.</small>
                </div>
                <div class="form-group">
                    <label for="phoneNumber">Phone Number</label>
                    <input type="text" id="phoneNumber" name="phoneNumber" class="form-control"
                           value="${sessionScope.loggedInUser.phoneNumber}">
                </div>
                <button type="submit" class="btn btn-primary">Update Profile</button>
            </form>
        </div>

        <!-- Change Password -->
        <div class="card">
            <h2 style="font-size:1.1rem;margin-bottom:1.2rem;">Change Password</h2>

            <c:if test="${passwordSuccess != null}"><div class="alert alert-success">${passwordSuccess}</div></c:if>
            <c:if test="${passwordError   != null}"><div class="alert alert-error">${passwordError}</div></c:if>

            <form method="post" action="${pageContext.request.contextPath}/user/profile">
                <input type="hidden" name="action" value="changePassword">
                <div class="form-group">
                    <label for="currentPassword">Current Password</label>
                    <input type="password" id="currentPassword" name="currentPassword" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="newPassword">New Password</label>
                    <input type="password" id="newPassword" name="newPassword" class="form-control" required>
                </div>
                <p style="font-size:.8rem;color:var(--muted);margin-bottom:.8rem;">
                    Min 8 chars, include uppercase, lowercase, digit and special character.
                </p>
                <button type="submit" class="btn btn-warning">Change Password</button>
            </form>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/pages/common/footer.jsp" %>

<style>
@media(max-width:768px){
    div[style*="grid-template-columns:1fr 1fr"]{grid-template-columns:1fr !important;}
}
</style>
</body>
</html>
