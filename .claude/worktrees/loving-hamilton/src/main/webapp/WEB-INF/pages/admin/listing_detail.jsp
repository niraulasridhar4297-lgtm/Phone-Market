<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Review Listing – PhoneMarket Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="/WEB-INF/pages/common/header.jsp" %>

<div class="container main-content">
    <a href="${pageContext.request.contextPath}/admin/dashboard" style="color:var(--muted);font-size:.9rem;">← Back to Dashboard</a>

    <c:choose>
        <c:when test="${listing == null}">
            <div class="alert alert-error" style="margin-top:1rem;">Listing not found.</div>
        </c:when>
        <c:otherwise>
            <div style="display:flex;align-items:center;gap:1rem;margin-top:1.5rem;margin-bottom:1.4rem;flex-wrap:wrap;">
                <h1 style="font-size:1.5rem;font-weight:800;">${listing.title}</h1>
                <span class="badge badge-${listing.conditionGrade.toLowerCase()}">${listing.conditionGrade}</span>
                <span class="badge badge-${listing.status}">${listing.status}</span>
            </div>

            <!-- Admin Action Bar -->
            <div class="card" style="margin-bottom:1.5rem;display:flex;gap:.8rem;flex-wrap:wrap;align-items:center;">
                <strong style="color:var(--muted);font-size:.9rem;">Admin Actions:</strong>
                <c:if test="${listing.status != 'available'}">
                    <a href="${pageContext.request.contextPath}/admin/listing?action=approve&id=${listing.listingId}"
                       class="btn btn-success btn-sm">✔ Approve Listing</a>
                </c:if>
                <c:if test="${listing.status == 'available'}">
                    <a href="${pageContext.request.contextPath}/admin/listing?action=reject&id=${listing.listingId}"
                       class="btn btn-warning btn-sm">✖ Reject Listing</a>
                </c:if>
                <a href="${pageContext.request.contextPath}/admin/listing?action=delete&id=${listing.listingId}"
                   class="btn btn-danger btn-sm"
                   onclick="return confirm('Permanently delete this listing?')">🗑 Delete Listing</a>
            </div>

            <div class="detail-grid">
                <!-- Left: Specs -->
                <div>
                    <div class="card">
                        <div class="detail-section">
                            <h3>Phone Specifications</h3>
                            <ul class="spec-list">
                                <li><span class="spec-label">Brand</span>        <span class="spec-val">${listing.brand}</span></li>
                                <li><span class="spec-label">Model</span>        <span class="spec-val">${listing.modelName}</span></li>
                                <li><span class="spec-label">First Purchased</span>
                                    <span class="spec-val">
                                        <c:choose>
                                            <c:when test="${listing.firstBuyDate != null}">
                                                <fmt:formatDate value="${listing.firstBuyDate}" pattern="MMMM yyyy"/>
                                            </c:when>
                                            <c:otherwise>N/A</c:otherwise>
                                        </c:choose>
                                    </span>
                                </li>
                                <li><span class="spec-label">RAM</span>          <span class="spec-val">${listing.ramGb > 0 ? listing.ramGb.concat(' GB') : 'N/A'}</span></li>
                                <li><span class="spec-label">Storage</span>      <span class="spec-val">${listing.storageGb > 0 ? listing.storageGb.concat(' GB') : 'N/A'}</span></li>
                                <li><span class="spec-label">Battery</span>      <span class="spec-val">${listing.batteryMah > 0 ? listing.batteryMah.concat(' mAh') : 'N/A'}</span></li>
                                <li><span class="spec-label">Screen</span>       <span class="spec-val">${listing.screenSizeInch != null ? listing.screenSizeInch.concat('"') : 'N/A'}</span></li>
                                <li><span class="spec-label">Color</span>        <span class="spec-val">${empty listing.color ? 'N/A' : listing.color}</span></li>
                                <li><span class="spec-label">Condition</span>    <span class="spec-val">${listing.conditionGrade}</span></li>
                                <li><span class="spec-label">Price</span>
                                    <span class="spec-val" style="color:var(--primary);font-size:1.1rem;">
                                        $<fmt:formatNumber value="${listing.price}" pattern="#,##0.00"/>
                                    </span>
                                </li>
                                <li><span class="spec-label">Listing Order</span><span class="spec-val">#${listing.listingOrder}</span></li>
                            </ul>
                        </div>
                    </div>
                </div>

                <!-- Right: Seller + Description -->
                <div>
                    <div class="card" style="margin-bottom:1.2rem;">
                        <div class="detail-section">
                            <h3>Seller Information</h3>
                            <ul class="spec-list">
                                <li><span class="spec-label">Name</span>      <span class="spec-val">${listing.sellerName}</span></li>
                                <li><span class="spec-label">Email</span>     <span class="spec-val">${listing.sellerEmail}</span></li>
                                <li><span class="spec-label">Listed On</span> <span class="spec-val"><fmt:formatDate value="${listing.createdAt}" pattern="dd MMM yyyy, HH:mm"/></span></li>
                                <li><span class="spec-label">Last Updated</span> <span class="spec-val"><fmt:formatDate value="${listing.updatedAt}" pattern="dd MMM yyyy, HH:mm"/></span></li>
                            </ul>
                        </div>
                    </div>

                    <c:if test="${not empty listing.description}">
                        <div class="card">
                            <h3 style="font-size:1rem;color:var(--muted);margin-bottom:.6rem;">Seller Description</h3>
                            <p style="font-size:.92rem;line-height:1.7;white-space:pre-line;">${listing.description}</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="/WEB-INF/pages/common/footer.jsp" %>
</body>
</html>
