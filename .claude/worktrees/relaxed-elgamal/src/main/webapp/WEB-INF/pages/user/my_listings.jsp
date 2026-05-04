<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Dashboard – PhoneMarket</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="/WEB-INF/pages/common/header.jsp" %>

<!-- Page Hero -->
<div class="page-hero">
    <div class="container">
        <div style="display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:1rem;">
            <div>
                <h1>My Dashboard</h1>
                <p>Manage your listings and track buy requests</p>
            </div>
            <a href="${pageContext.request.contextPath}/user/listing?action=new" class="btn btn-warning btn-lg">+ New Listing</a>
        </div>
    </div>
</div>

<div class="container main-content">

    <c:if test="${param.msg == 'created'}"><div class="alert alert-success">Listing created successfully! It is now pending admin review.</div></c:if>
    <c:if test="${param.msg == 'updated'}"><div class="alert alert-success">Listing updated successfully.</div></c:if>
    <c:if test="${param.msg == 'deleted'}"><div class="alert alert-success">Listing has been deleted.</div></c:if>

    <!-- Stats Row -->
    <div style="display:flex;gap:1rem;flex-wrap:wrap;margin-bottom:1.8rem;">
        <div class="card" style="flex:1;min-width:130px;text-align:center;padding:1.2rem;">
            <div style="font-size:1.8rem;font-weight:800;color:var(--primary);">${myListings.size()}</div>
            <div style="font-size:.78rem;color:var(--muted);font-weight:600;text-transform:uppercase;letter-spacing:.05em;margin-top:.2rem;">My Listings</div>
        </div>
        <div class="card" style="flex:1;min-width:130px;text-align:center;padding:1.2rem;">
            <div style="font-size:1.8rem;font-weight:800;color:var(--success);">${buyRequests.size()}</div>
            <div style="font-size:.78rem;color:var(--muted);font-weight:600;text-transform:uppercase;letter-spacing:.05em;margin-top:.2rem;">Requests Received</div>
        </div>
        <div class="card" style="flex:1;min-width:130px;text-align:center;padding:1.2rem;">
            <div style="font-size:1.8rem;font-weight:800;color:var(--accent);">${myBuyRequests.size()}</div>
            <div style="font-size:.78rem;color:var(--muted);font-weight:600;text-transform:uppercase;letter-spacing:.05em;margin-top:.2rem;">Requests Sent</div>
        </div>
    </div>

    <!-- Tabs -->
    <div class="tabs">
        <button class="tab-btn active" onclick="showTab('tab-listings', this)">
            My Listings
            <c:if test="${myListings.size() > 0}">
                <span style="background:var(--primary);color:#fff;border-radius:10px;padding:.1rem .45rem;font-size:.72rem;margin-left:.3rem;">${myListings.size()}</span>
            </c:if>
        </button>
        <button class="tab-btn" onclick="showTab('tab-received', this)">
            Buy Requests Received
            <c:if test="${buyRequests.size() > 0}">
                <span style="background:var(--success);color:#fff;border-radius:10px;padding:.1rem .45rem;font-size:.72rem;margin-left:.3rem;">${buyRequests.size()}</span>
            </c:if>
        </button>
        <button class="tab-btn" onclick="showTab('tab-sent', this)">
            My Buy Requests
            <c:if test="${myBuyRequests.size() > 0}">
                <span style="background:var(--accent);color:#fff;border-radius:10px;padding:.1rem .45rem;font-size:.72rem;margin-left:.3rem;">${myBuyRequests.size()}</span>
            </c:if>
        </button>
    </div>

    <!-- Tab: My Listings -->
    <div id="tab-listings" class="tab-panel active">
        <c:choose>
            <c:when test="${empty myListings}">
                <div class="card empty-state">
                    <span class="empty-icon">📦</span>
                    <p>You haven't posted any listings yet.</p>
                    <a href="${pageContext.request.contextPath}/user/listing?action=new" class="btn btn-primary">+ Post Your First Listing</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card table-wrapper">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Phone</th>
                                <th>Brand</th>
                                <th>Price</th>
                                <th>Condition</th>
                                <th>Status</th>
                                <th>Listed</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="l" items="${myListings}">
                                <tr>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/user/listing?action=view&id=${l.listingId}" style="font-weight:600;">${l.title}</a>
                                    </td>
                                    <td style="color:var(--muted);">${l.brand}</td>
                                    <td><strong style="color:var(--primary);">$<fmt:formatNumber value="${l.price}" pattern="#,##0.00"/></strong></td>
                                    <td><span class="badge badge-${l.conditionGrade.toLowerCase()}">${l.conditionGrade}</span></td>
                                    <td><span class="badge badge-${l.status}">${l.status}</span></td>
                                    <td style="color:var(--muted);white-space:nowrap;">
                                        <fmt:formatDate value="${l.createdAt}" pattern="dd MMM yyyy"/>
                                    </td>
                                    <td>
                                        <div class="actions-cell">
                                            <a href="${pageContext.request.contextPath}/user/listing?action=edit&id=${l.listingId}" class="btn btn-warning btn-sm">Edit</a>
                                            <a href="${pageContext.request.contextPath}/user/listing?action=delete&id=${l.listingId}"
                                               class="btn btn-danger btn-sm"
                                               onclick="return confirm('Are you sure you want to delete this listing?')">Delete</a>
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

    <!-- Tab: Buy Requests Received -->
    <div id="tab-received" class="tab-panel">
        <c:choose>
            <c:when test="${empty buyRequests}">
                <div class="card empty-state">
                    <span class="empty-icon">📬</span>
                    <p>No buy requests received yet. List a phone to start getting offers!</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card table-wrapper">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Listing</th>
                                <th>Buyer</th>
                                <th>Message</th>
                                <th>Status</th>
                                <th>Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="r" items="${buyRequests}">
                                <tr>
                                    <td style="font-weight:600;">${r.listingTitle}</td>
                                    <td>
                                        <div style="font-weight:600;">${r.buyerName}</div>
                                        <small style="color:var(--muted);">${r.buyerEmail}</small>
                                    </td>
                                    <td style="max-width:200px;color:var(--muted);font-size:.87rem;">
                                        ${empty r.message ? '–' : r.message}
                                    </td>
                                    <td><span class="badge badge-${r.status}">${r.status}</span></td>
                                    <td style="color:var(--muted);white-space:nowrap;">
                                        <fmt:formatDate value="${r.createdAt}" pattern="dd MMM yyyy"/>
                                    </td>
                                    <td>
                                        <c:if test="${r.status == 'pending'}">
                                            <div class="actions-cell">
                                                <form method="post" action="${pageContext.request.contextPath}/user/my-listings" style="display:inline;">
                                                    <input type="hidden" name="requestId" value="${r.requestId}">
                                                    <button name="action" value="accept" class="btn btn-success btn-sm">Accept</button>
                                                </form>
                                                <form method="post" action="${pageContext.request.contextPath}/user/my-listings" style="display:inline;">
                                                    <input type="hidden" name="requestId" value="${r.requestId}">
                                                    <button name="action" value="reject" class="btn btn-danger btn-sm">Reject</button>
                                                </form>
                                            </div>
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

    <!-- Tab: My Buy Requests -->
    <div id="tab-sent" class="tab-panel">
        <c:choose>
            <c:when test="${empty myBuyRequests}">
                <div class="card empty-state">
                    <span class="empty-icon">🛒</span>
                    <p>You haven't sent any buy requests yet.</p>
                    <a href="${pageContext.request.contextPath}/user/home" class="btn btn-primary">Browse Phones</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card table-wrapper">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Phone</th>
                                <th>Your Message</th>
                                <th>Status</th>
                                <th>Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="r" items="${myBuyRequests}">
                                <tr>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/user/listing?action=view&id=${r.listingId}" style="font-weight:600;">${r.listingTitle}</a>
                                    </td>
                                    <td style="color:var(--muted);font-size:.87rem;">${empty r.message ? '–' : r.message}</td>
                                    <td><span class="badge badge-${r.status}">${r.status}</span></td>
                                    <td style="color:var(--muted);white-space:nowrap;">
                                        <fmt:formatDate value="${r.createdAt}" pattern="dd MMM yyyy"/>
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
