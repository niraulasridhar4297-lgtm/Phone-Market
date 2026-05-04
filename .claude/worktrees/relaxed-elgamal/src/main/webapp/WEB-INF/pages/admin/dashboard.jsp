<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard – PhoneMarket</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="/WEB-INF/pages/common/header.jsp" %>

<!-- Page Hero -->
<div class="page-hero">
    <div class="container">
        <h1>Admin Dashboard</h1>
        <p>Manage listings, users and platform activity</p>
    </div>
</div>

<div class="container main-content">

    <!-- Flash Messages -->
    <c:if test="${param.msg == 'deleted'}">  <div class="alert alert-success">Listing deleted successfully.</div></c:if>
    <c:if test="${param.msg == 'approved'}"> <div class="alert alert-success">Listing approved and set to available.</div></c:if>
    <c:if test="${param.msg == 'rejected'}"> <div class="alert alert-warning">Listing has been rejected.</div></c:if>
    <c:if test="${param.msg == 'unlocked'}"> <div class="alert alert-success">User account has been unlocked.</div></c:if>

    <!-- Stats Grid -->
    <%-- Pre-calculate counts --%>
    <c:set var="availCount"   value="0"/>
    <c:set var="soldCount"    value="0"/>
    <c:set var="pendingCount" value="0"/>
    <c:set var="rejCount"     value="0"/>
    <c:forEach var="l" items="${allListings}">
        <c:if test="${l.status == 'available'}">     <c:set var="availCount"   value="${availCount   + 1}"/></c:if>
        <c:if test="${l.status == 'sold'}">          <c:set var="soldCount"    value="${soldCount    + 1}"/></c:if>
        <c:if test="${l.status == 'pending_review'}"><c:set var="pendingCount" value="${pendingCount + 1}"/></c:if>
        <c:if test="${l.status == 'rejected'}">      <c:set var="rejCount"     value="${rejCount     + 1}"/></c:if>
    </c:forEach>
    <c:set var="lockedCount" value="0"/>
    <c:forEach var="u" items="${allUsers}">
        <c:if test="${u.locked}"><c:set var="lockedCount" value="${lockedCount + 1}"/></c:if>
    </c:forEach>

    <div class="stats-grid">
        <div class="stat-card blue">
            <span class="stat-icon">📋</span>
            <div class="stat-val">${allListings.size()}</div>
            <div class="stat-label">Total Listings</div>
        </div>
        <div class="stat-card green">
            <span class="stat-icon">✅</span>
            <div class="stat-val">${availCount}</div>
            <div class="stat-label">Available</div>
        </div>
        <div class="stat-card amber">
            <span class="stat-icon">🔖</span>
            <div class="stat-val">${soldCount}</div>
            <div class="stat-label">Sold</div>
        </div>
        <div class="stat-card orange">
            <span class="stat-icon">⏳</span>
            <div class="stat-val">${pendingCount}</div>
            <div class="stat-label">Pending Review</div>
        </div>
        <div class="stat-card gray">
            <span class="stat-icon">🚫</span>
            <div class="stat-val">${rejCount}</div>
            <div class="stat-label">Rejected</div>
        </div>
        <div class="stat-card purple">
            <span class="stat-icon">👥</span>
            <div class="stat-val">${allUsers.size()}</div>
            <div class="stat-label">Registered Users</div>
        </div>
        <div class="stat-card red">
            <span class="stat-icon">🔒</span>
            <div class="stat-val">${lockedCount}</div>
            <div class="stat-label">Locked Accounts</div>
        </div>
    </div>

    <!-- Tabs -->
    <div class="tabs">
        <button class="tab-btn active" onclick="showTab('tab-listings', this)">
            All Listings
            <span style="background:var(--primary);color:#fff;border-radius:10px;padding:.1rem .45rem;font-size:.72rem;margin-left:.3rem;">${allListings.size()}</span>
        </button>
        <button class="tab-btn" onclick="showTab('tab-users', this)">
            Users
            <span style="background:var(--purple);color:#fff;border-radius:10px;padding:.1rem .45rem;font-size:.72rem;margin-left:.3rem;">${allUsers.size()}</span>
        </button>
    </div>

    <!-- ===== TAB: LISTINGS ===== -->
    <div id="tab-listings" class="tab-panel active">
        <c:choose>
            <c:when test="${empty allListings}">
                <div class="card empty-state">
                    <span class="empty-icon">📦</span>
                    <p>No listings in the system yet.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card table-wrapper">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Title</th>
                                <th>Brand / Model</th>
                                <th>Seller</th>
                                <th>Price</th>
                                <th>Condition</th>
                                <th>Status</th>
                                <th>Order</th>
                                <th>Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="l" items="${allListings}">
                                <tr>
                                    <td style="color:var(--muted);font-size:.82rem;">${l.listingId}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/listing?action=view&id=${l.listingId}" style="font-weight:600;">
                                            ${l.title}
                                        </a>
                                    </td>
                                    <td>
                                        <span style="font-weight:600;">${l.brand}</span><br>
                                        <small style="color:var(--muted);">${l.modelName}</small>
                                    </td>
                                    <td>
                                        <span style="font-weight:500;">${l.sellerName}</span><br>
                                        <small style="color:var(--muted);">${l.sellerEmail}</small>
                                    </td>
                                    <td><strong style="color:var(--primary);">$<fmt:formatNumber value="${l.price}" pattern="#,##0.00"/></strong></td>
                                    <td><span class="badge badge-${l.conditionGrade.toLowerCase()}">${l.conditionGrade}</span></td>
                                    <td><span class="badge badge-${l.status}">${l.status}</span></td>
                                    <td>
                                        <div style="display:flex;gap:.3rem;justify-content:center;">
                                            <a href="${pageContext.request.contextPath}/admin/listing?action=reorder&id=${l.listingId}&dir=up"
                                               class="btn btn-outline btn-sm" title="Move Up">&#8593;</a>
                                            <a href="${pageContext.request.contextPath}/admin/listing?action=reorder&id=${l.listingId}&dir=down"
                                               class="btn btn-outline btn-sm" title="Move Down">&#8595;</a>
                                        </div>
                                    </td>
                                    <td style="white-space:nowrap;color:var(--muted);">
                                        <fmt:formatDate value="${l.createdAt}" pattern="dd MMM yy"/>
                                    </td>
                                    <td>
                                        <div class="actions-cell">
                                            <c:if test="${l.status != 'available'}">
                                                <a href="${pageContext.request.contextPath}/admin/listing?action=approve&id=${l.listingId}"
                                                   class="btn btn-success btn-sm">Approve</a>
                                            </c:if>
                                            <c:if test="${l.status == 'available'}">
                                                <a href="${pageContext.request.contextPath}/admin/listing?action=reject&id=${l.listingId}"
                                                   class="btn btn-warning btn-sm">Reject</a>
                                            </c:if>
                                            <a href="${pageContext.request.contextPath}/admin/listing?action=delete&id=${l.listingId}"
                                               class="btn btn-danger btn-sm"
                                               onclick="return confirm('Permanently delete this listing?')">Delete</a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- ===== TAB: USERS ===== -->
    <div id="tab-users" class="tab-panel">
        <c:choose>
            <c:when test="${empty allUsers}">
                <div class="card empty-state">
                    <span class="empty-icon">👤</span>
                    <p>No users registered yet.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card table-wrapper">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Role</th>
                                <th>Status</th>
                                <th>Failed Logins</th>
                                <th>Joined</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="u" items="${allUsers}">
                                <tr>
                                    <td style="color:var(--muted);font-size:.82rem;">${u.userId}</td>
                                    <td style="font-weight:600;">${u.fullName}</td>
                                    <td style="color:var(--muted);">${u.email}</td>
                                    <td style="color:var(--muted);">${empty u.phoneNumber ? '–' : u.phoneNumber}</td>
                                    <td><span class="badge badge-${u.role}">${u.role}</span></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${u.locked}">
                                                <span class="badge badge-sold">Locked</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-available">Active</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="text-align:center;">
                                        <c:choose>
                                            <c:when test="${u.failedAttempts > 0}">
                                                <span style="color:var(--danger);font-weight:700;">${u.failedAttempts}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="color:var(--muted);">0</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="white-space:nowrap;color:var(--muted);">
                                        <fmt:formatDate value="${u.createdAt}" pattern="dd MMM yy"/>
                                    </td>
                                    <td>
                                        <c:if test="${u.locked}">
                                            <a href="${pageContext.request.contextPath}/admin/user?action=unlock&id=${u.userId}"
                                               class="btn btn-success btn-sm">Unlock</a>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%@ include file="/WEB-INF/pages/common/footer.jsp" %>

<script>
function showTab(tabId, btn) {
    document.querySelectorAll('.tab-panel').forEach(function(p) { p.classList.remove('active'); });
    document.querySelectorAll('.tab-btn').forEach(function(b) { b.classList.remove('active'); });
    document.getElementById(tabId).classList.add('active');
    btn.classList.add('active');
}
</script>
</body>
</html>
