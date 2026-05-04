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

<!-- Page Hero -->
<div class="page-hero">
    <div class="container">
        <h1>My Profile</h1>
        <p>Manage your personal information and account security</p>
    </div>
</div>

<div class="container main-content">

    <!-- Profile Header Card -->
    <div class="card" style="margin-bottom:1.5rem;display:flex;align-items:center;gap:1.5rem;flex-wrap:wrap;">
        <div class="profile-avatar">
            ${sessionScope.userName.substring(0,1).toUpperCase()}
        </div>
        <div>
            <h2 style="font-size:1.3rem;font-weight:700;margin-bottom:.2rem;">${sessionScope.loggedInUser.fullName}</h2>
            <p style="color:var(--muted);font-size:.9rem;margin-bottom:.3rem;">${sessionScope.loggedInUser.email}</p>
            <span class="badge badge-${sessionScope.userRole}">${sessionScope.userRole}</span>
        </div>
    </div>

    <div style="display:grid;grid-template-columns:1fr 1fr;gap:1.5rem;max-width:920px;">

        <!-- Update Profile -->
        <div class="card">
            <h2 style="font-size:1.05rem;font-weight:700;margin-bottom:1.3rem;padding-bottom:.7rem;border-bottom:1px solid var(--border);">
                Personal Information
            </h2>

            <c:if test="${profileSuccess != null}"><div class="alert alert-success">${profileSuccess}</div></c:if>
            <c:if test="${profileError   != null}"><div class="alert alert-error">${profileError}</div></c:if>

            <form method="post" action="${pageContext.request.contextPath}/user/profile" novalidate>
                <input type="hidden" name="action" value="updateProfile">
                <div class="form-group">
                    <label for="fullName">Full Name</label>
                    <input type="text" id="fullName" name="fullName" class="form-control"
                           value="${sessionScope.loggedInUser.fullName}" required>
                </div>
                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" class="form-control" value="${sessionScope.loggedInUser.email}" disabled>
                    <p class="form-hint">Email address cannot be changed.</p>
                </div>
                <div class="form-group">
                    <label for="phoneNumber">Phone Number</label>
                    <input type="text" id="phoneNumber" name="phoneNumber" class="form-control"
                           placeholder="e.g. +977 9800000000"
                           value="${sessionScope.loggedInUser.phoneNumber}">
                </div>
                <button type="submit" class="btn btn-primary">Update Profile</button>
            </form>
        </div>

        <!-- Change Password -->
        <div class="card">
            <h2 style="font-size:1.05rem;font-weight:700;margin-bottom:1.3rem;padding-bottom:.7rem;border-bottom:1px solid var(--border);">
                Change Password
            </h2>

            <c:if test="${passwordSuccess != null}"><div class="alert alert-success">${passwordSuccess}</div></c:if>
            <c:if test="${passwordError   != null}"><div class="alert alert-error">${passwordError}</div></c:if>

            <form method="post" action="${pageContext.request.contextPath}/user/profile" novalidate>
                <input type="hidden" name="action" value="changePassword">
                <div class="form-group">
                    <label for="currentPassword">Current Password</label>
                    <input type="password" id="currentPassword" name="currentPassword" class="form-control"
                           placeholder="Enter current password" autocomplete="current-password" required>
                </div>
                <div class="form-group">
                    <label for="newPassword">New Password</label>
                    <input type="password" id="newPassword" name="newPassword" class="form-control"
                           placeholder="Enter new password" autocomplete="new-password" required>
                </div>
                <p class="form-hint" style="margin-bottom:1rem;">
                    Min 8 characters. Must include uppercase, lowercase, a digit and a special character (@$!%*#?&amp;).
                </p>
                <button type="submit" class="btn btn-warning">Change Password</button>
            </form>
        </div>
    </div>

    <!-- Account Info Card -->
    <div class="card" style="max-width:920px;margin-top:1.5rem;">
        <h2 style="font-size:1.05rem;font-weight:700;margin-bottom:1rem;padding-bottom:.7rem;border-bottom:1px solid var(--border);">
            Account Security
        </h2>
        <div style="display:flex;gap:2rem;flex-wrap:wrap;">
            <div>
                <p style="font-size:.82rem;color:var(--muted);font-weight:600;text-transform:uppercase;letter-spacing:.05em;margin-bottom:.3rem;">Account Status</p>
                <span class="badge badge-available">Active</span>
            </div>
            <div>
                <p style="font-size:.82rem;color:var(--muted);font-weight:600;text-transform:uppercase;letter-spacing:.05em;margin-bottom:.3rem;">Role</p>
                <span class="badge badge-${sessionScope.userRole}">${sessionScope.userRole}</span>
            </div>
            <div>
                <p style="font-size:.82rem;color:var(--muted);font-weight:600;text-transform:uppercase;letter-spacing:.05em;margin-bottom:.3rem;">Session</p>
                <span style="font-size:.88rem;color:var(--text);">Active (30 min timeout)</span>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/pages/common/footer.jsp" %>

<style>
@media(max-width:768px) {
    div[style*="grid-template-columns:1fr 1fr"] { grid-template-columns: 1fr !important; }
}
</style>
</body>
</html>
