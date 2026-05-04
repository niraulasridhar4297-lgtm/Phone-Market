<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Listings – PhoneMarket</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="/WEB-INF/pages/common/header.jsp" %>

<div class="container main-content">
    <div style="display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:1rem;margin-bottom:1.4rem;">
        <h1 class="page-title" style="margin-bottom:0;">My Dashboard</h1>
        <a href="${pageContext.request.contextPath}/user/listing?action=new" class="btn btn-primary">+ New Listing</a>
    </div>

    <c:if test="${param.msg == 'created'}"><div class="alert alert-success">Listing created successfully!</div></c:if>
    <c:if test="${param.msg == 'updated'}"><div class="alert alert-success">Listing updated successfully!</div></c:if>
    <c:if test="${param.msg == 'deleted'}"><div class="alert alert-success">Listing deleted.</div></c:if>

    <!-- Tabs -->
    <div class="tabs">
        <button class="tab-btn active" onclick="showTab('my-listings-tab', this)">My Listings (${myListings.size()})</button>
        <button class="tab-btn"        onclick="showTab('buy-requests-tab', this)">Buy Requests Received (${buyRequests.size()})</button>
        <button class="tab-btn"        onclick="showTab('my-requests-tab',  this)">My Buy Requests (${myBuyRequests.size()})</button>
    </div>

    <!-- Tab: My Listings -->
    <div id="my-listings-tab" class="tab-panel active">
        <c:choose>
            <c:when test="${empty myListings}">
                <div class="card" style="text-align:center;padding:2.5rem;">
                    <p style="color:var(--muted);">You haven't posted any listings yet.</p>
                    <a href="${pageContext.request.contextPath}/user/listing?action=new" class="btn btn-primary" style="margin-top:1rem;">+ Post Your First Listing</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card table-wrapper">
                    <table class="data-table">
                        <thead>
                            <tr><th>Title</th><th>Brand</th><th>Price</th><th>Condition</th><th>Status</th><th>Date</th><th>Actions</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach var="l" items="${myListings}">
                                <tr>
                                    <td><a href="${pageContext.request.contextPath}/user/listing?action=view&id=${l.listingId}">${l.title}</a></td>
                                    <td>${l.brand}</td>
                                    <td><strong>$<fmt:formatNumber value="${l.price}" pattern="#,##0.00"/></strong></td>
                                    <td><span class="badge badge-${l.conditionGrade.toLowerCase()}">${l.conditionGrade}</span></td>
                                    <td><span class="badge badge-${l.status}">${l.status}</span></td>
                                    <td><fmt:formatDate value="${l.createdAt}" pattern="dd MMM yyyy"/></td>
                                    <td>
                                        <div class="actions-cell">
                                            <a href="${pageContext.request.contextPath}/user/listing?action=edit&id=${l.listingId}" class="btn btn-warning btn-sm">Edit</a>
                                            <a href="${pageContext.request.contextPath}/user/listing?action=delete&id=${l.listingId}"
                                               class="btn btn-danger btn-sm"
                                               onclick="return confirm('Delete this listing?')">Delete</a>
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
    <div id="buy-requests-tab" class="tab-panel">
        <c:choose>
            <c:when test="${empty buyRequests}">
                <div class="card" style="text-align:center;padding:2.5rem;">
                    <p style="color:var(--muted);">No buy requests received yet.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card table-wrapper">
                    <table class="data-table">
                        <thead>
                            <tr><th>Listing</th><th>Buyer</th><th>Message</th><th>Status</th><th>Date</th><th>Actions</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach var="r" items="${buyRequests}">
                                <tr>
                                    <td>${r.listingTitle}</td>
                                    <td>${r.buyerName}<br><small style="color:var(--muted);">${r.buyerEmail}</small></td>
                                    <td style="max-width:200px;">${empty r.message ? '–' : r.message}</td>
                                    <td><span class="badge badge-${r.status}">${r.status}</span></td>
                                    <td><fmt:formatDate value="${r.createdAt}" pattern="dd MMM yyyy"/></td>
                                    <td>
                                        <c:if test="${r.status == 'pending'}">
                                            <form method="post" action="${pageContext.request.contextPath}/user/my-listings" style="display:inline;">
                                                <input type="hidden" name="requestId" value="${r.requestId}">
                                                <button name="action" value="accept" class="btn btn-success btn-sm">Accept</button>
                                            </form>
                                            <form method="post" action="${pageContext.request.contextPath}/user/my-listings" style="display:inline;">
                                                <input type="hidden" name="requestId" value="${r.requestId}">
                                                <button name="action" value="reject" class="btn btn-danger btn-sm">Reject</button>
                                            </form>
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
    <div id="my-requests-tab" class="tab-panel">
        <c:choose>
            <c:when test="${empty myBuyRequests}">
                <div class="card" style="text-align:center;padding:2.5rem;">
                    <p style="color:var(--muted);">You haven't sent any buy requests yet.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card table-wrapper">
                    <table class="data-table">
                        <thead>
                            <tr><th>Phone</th><th>Your Message</th><th>Status</th><th>Date</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach var="r" items="${myBuyRequests}">
                                <tr>
                                    <td><a href="${pageContext.request.contextPath}/user/listing?action=view&id=${r.listingId}">${r.listingTitle}</a></td>
                                    <td>${empty r.message ? '–' : r.message}</td>
                                    <td><span class="badge badge-${r.status}">${r.status}</span></td>
                                    <td><fmt:formatDate value="${r.createdAt}" pattern="dd MMM yyyy"/></td>
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
