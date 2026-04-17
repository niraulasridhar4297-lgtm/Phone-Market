<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${listing.title} – PhoneMarket</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="/WEB-INF/pages/common/header.jsp" %>

<div class="container main-content">
    <a href="${pageContext.request.contextPath}/user/home" style="color:var(--muted);font-size:.9rem;">← Back to listings</a>

    <c:choose>
        <c:when test="${listing == null}">
            <div class="alert alert-error" style="margin-top:1rem;">Listing not found.</div>
        </c:when>
        <c:otherwise>
            <c:if test="${param.msg == 'request_sent'}">
                <div class="alert alert-success" style="margin-top:1rem;">Your buy request has been sent to the seller!</div>
            </c:if>
            <c:if test="${param.error != null}">
                <div class="alert alert-error" style="margin-top:1rem;">${param.error}</div>
            </c:if>

            <div style="display:flex;gap:2rem;margin-top:1.5rem;flex-wrap:wrap;">
                <!-- Image placeholder -->
                <div style="width:100%;max-width:360px;height:300px;background:#e2e8f0;border-radius:10px;display:flex;align-items:center;justify-content:center;font-size:5rem;flex-shrink:0;">📱</div>

                <!-- Core Info -->
                <div style="flex:1;min-width:280px;">
                    <div style="display:flex;align-items:center;gap:.7rem;flex-wrap:wrap;margin-bottom:.5rem;">
                        <h1 style="font-size:1.6rem;font-weight:800;">${listing.title}</h1>
                        <span class="badge badge-${listing.conditionGrade.toLowerCase()}">${listing.conditionGrade}</span>
                        <span class="badge badge-${listing.status}">${listing.status}</span>
                    </div>
                    <p style="color:var(--muted);font-size:.95rem;margin-bottom:.8rem;">${listing.brand} · ${listing.modelName}</p>
                    <div style="font-size:2rem;font-weight:800;color:var(--primary);margin-bottom:1.2rem;">
                        $<fmt:formatNumber value="${listing.price}" pattern="#,##0.00"/>
                    </div>

                    <!-- Specs -->
                    <div class="card" style="margin-bottom:1.2rem;">
                        <div class="detail-section">
                            <h3>Specifications</h3>
                            <ul class="spec-list">
                                <li><span class="spec-label">Brand</span><span class="spec-val">${listing.brand}</span></li>
                                <li><span class="spec-label">Model</span><span class="spec-val">${listing.modelName}</span></li>
                                <c:if test="${listing.firstBuyDate != null}">
                                    <li><span class="spec-label">First Purchased</span><span class="spec-val"><fmt:formatDate value="${listing.firstBuyDate}" pattern="MMMM yyyy"/></span></li>
                                </c:if>
                                <c:if test="${listing.ramGb > 0}">
                                    <li><span class="spec-label">RAM</span><span class="spec-val">${listing.ramGb} GB</span></li>
                                </c:if>
                                <c:if test="${listing.storageGb > 0}">
                                    <li><span class="spec-label">Storage</span><span class="spec-val">${listing.storageGb} GB</span></li>
                                </c:if>
                                <c:if test="${listing.batteryMah > 0}">
                                    <li><span class="spec-label">Battery</span><span class="spec-val">${listing.batteryMah} mAh</span></li>
                                </c:if>
                                <c:if test="${listing.screenSizeInch != null}">
                                    <li><span class="spec-label">Screen Size</span><span class="spec-val">${listing.screenSizeInch}"</span></li>
                                </c:if>
                                <c:if test="${not empty listing.color}">
                                    <li><span class="spec-label">Color</span><span class="spec-val">${listing.color}</span></li>
                                </c:if>
                                <li><span class="spec-label">Condition</span><span class="spec-val">${listing.conditionGrade}</span></li>
                            </ul>
                        </div>
                    </div>

                    <!-- Seller Info -->
                    <div class="card" style="margin-bottom:1.2rem;">
                        <div class="detail-section">
                            <h3>Seller Information</h3>
                            <ul class="spec-list">
                                <li><span class="spec-label">Name</span><span class="spec-val">${listing.sellerName}</span></li>
                                <li><span class="spec-label">Contact</span><span class="spec-val">${listing.sellerEmail}</span></li>
                                <li><span class="spec-label">Listed On</span><span class="spec-val"><fmt:formatDate value="${listing.createdAt}" pattern="dd MMM yyyy"/></span></li>
                            </ul>
                        </div>
                    </div>

                    <!-- Description -->
                    <c:if test="${not empty listing.description}">
                        <div class="card" style="margin-bottom:1.2rem;">
                            <h3 style="font-size:1rem;color:var(--muted);margin-bottom:.5rem;">Description</h3>
                            <p style="font-size:.92rem;line-height:1.6;">${listing.description}</p>
                        </div>
                    </c:if>

                    <!-- Buy Request Form (only if available & not own listing) -->
                    <c:if test="${listing.status == 'available' && listing.sellerId != sessionScope.userId}">
                        <div class="card">
                            <h3 style="font-size:1rem;margin-bottom:1rem;color:var(--text);">💬 Send a Buy Request</h3>
                            <form method="post" action="${pageContext.request.contextPath}/user/buy-request">
                                <input type="hidden" name="listingId" value="${listing.listingId}">
                                <div class="form-group">
                                    <label for="message">Message to Seller (optional)</label>
                                    <textarea id="message" name="message" class="form-control"
                                              placeholder="E.g. Is the price negotiable? Can we meet at…"></textarea>
                                </div>
                                <button type="submit" class="btn btn-success">Send Request</button>
                            </form>
                        </div>
                    </c:if>

                    <c:if test="${listing.status == 'sold'}">
                        <div class="alert alert-error">This phone has already been sold.</div>
                    </c:if>
                    <c:if test="${listing.sellerId == sessionScope.userId}">
                        <div class="alert alert-info">This is your listing.
                            <a href="${pageContext.request.contextPath}/user/listing?action=edit&id=${listing.listingId}">Edit it</a>
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
