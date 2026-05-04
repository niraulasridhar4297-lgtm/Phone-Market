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

<div class="container main-content">
    <h1 class="page-title">🛠️ Admin Dashboard</h1>

    <!-- Flash messages -->
    <c:if test="${param.msg == 'deleted'}">  <div class="alert alert-success">Listing deleted successfully.</div></c:if>
    <c:if test="${param.msg == 'approved'}"> <div class="alert alert-success">Listing approved and set to available.</div></c:if>
    <c:if test="${param.msg == 'rejected'}"> <div class="alert alert-warning">Listing rejected.</div></c:if>
    <c:if test="${param.msg == 'unlocked'}"> <div class="alert alert-success">User account unlocked.</div></c:if>

    <!-- Stats Cards -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-val">${allListings.size()}</div>
            <div class="stat-label">Total Listings</div>
        </div>
        <div class="stat-card">
            <div class="stat-val">
                <c:set var="avail" value="0"/>
                <c:forEach var="l" items="${allListings}">
                    <c:if test="${l.status == 'available'}"><c:set var="avail" value="${avail + 1}"/></c:if>
                </c:forEach>
                ${avail}
            </div>
            <div class="stat-label">Available</div>
        </div>
        <div class="stat-card">
            <div class="stat-val">
                <c:set var="soldCount" value="0"/>
                <c:forEach var="l" items="${allListings}">
                    <c:if test="${l.status == 'sold'}"><c:set var="soldCount" value="${soldCount + 1}"/></c:if>
                </c:forEach>
                ${soldCount}
            </div>
            <div class="stat-label">Sold</div>
        </div>
        <div class="stat-card">
            <div class="stat-val">${allUsers.size()}</div>
            <div class="stat-label">Registered Users</div>
        </div>
        <div class="stat-card">
            <div class="stat-val">
                <c:set var="lockedCount" value="0"/>
                <c:forEach var="u" items="${allUsers}">
                    <c:if test="${u.locked}"><c:set var="lockedCount" value="${lockedCount + 1}"/></c:if>
                </c:forEach>
                ${lockedCount}
            </div>
            <div class="stat-label">Locked Accounts</div>
        </div>
    </div>

    <!-- Tabs -->
    <div class="tabs">
        <button class="tab-btn active" onclick="showTab('tab-listings', this)">All Listings</button>
        <button class="tab-btn"        onclick="showTab('tab-users',    this)">Users</button>
    </div>

    <!-- ==================== TAB: LISTINGS ==================== -->
    <div id="tab-listings" class="tab-panel active">
        <c:choose>
            <c:when test="${empty allListings}">
                <div class="card" style="text-align:center;padding:2.5rem;">
                    <p style="color:var(--muted);">No listings in the system yet.</p>
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
                            <c:forEach var="l" items="${allListings}" varStatus="st">
                                <tr>
                                    <td style="color:var(--muted);font-size:.85rem;">${l.listingId}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/listing?action=view&id=${l.listingId}">
                                            ${l.title}
                                        </a>
                                    </td>
                                    <td>${l.brand}<br><small style="color:var(--muted);">${l.modelName}</small></td>
                                    <td>${l.sellerName}<br><small style="color:var(--muted);">${l.sellerEmail}</small></td>
                                    <td><strong>$<fmt:formatNumber value="${l.price}" pattern="#,##0.00"/></strong></td>
                                    <td><span class="badge badge-${l.conditionGrade.toLowerCase()}">${l.conditionGrade}</span></td>
                                    <td><span class="badge badge-${l.status}">${l.status}</span></td>
                                    <td style="text-align:center;">
                                        <div style="display:flex;gap:.3rem;justify-content:center;">
                                            <a href="${pageContext.request.contextPath}/admin/listing?action=reorder&id=${l.listingId}&dir=up"
                                               class="btn btn-outline btn-sm" title="Move Up">↑</a>
                                            <a href="${pageContext.request.contextPath}/admin/listing?action=reorder&id=${l.listingId}&dir=down"
                                               class="btn btn-outline btn-sm" title="Move Down">↓</a>
                                        </div>
                                    </td>
                                    <td style="white-space:nowrap;"><fmt:formatDate value="${l.createdAt}" pattern="dd MMM yy"/></td>
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

    <!-- ==================== TAB: USERS ==================== -->
    <div id="tab-users" class="tab-panel">
        <c:choose>
            <c:when test="${empty allUsers}">
                <div class="card" style="text-align:center;padding:2.5rem;">
                    <p style="color:var(--muted);">No regular users registered yet.</p>
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
                                    <td style="color:var(--muted);font-size:.85rem;">${u.userId}</td>
                                    <td>${u.fullName}</td>
                                    <td>${u.email}</td>
                                    <td>${empty u.phoneNumber ? '–' : u.phoneNumber}</td>
                                    <td><span class="badge badge-${u.role}">${u.role}</span></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${u.locked}">
                                                <span class="badge badge-sold">🔒 Locked</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-available">Active</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="text-align:center;">${u.failedAttempts}</td>
                                    <td style="white-space:nowrap;"><fmt:formatDate value="${u.createdAt}" pattern="dd MMM yy"/></td>
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
    document.querySelectorAll('.tab-panel').forEach(p => p.classList.remove('active'));
    document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
    document.getElementById(tabId).classList.add('active');
    btn.classList.add('active');
}
</script>
</body>
</html>
