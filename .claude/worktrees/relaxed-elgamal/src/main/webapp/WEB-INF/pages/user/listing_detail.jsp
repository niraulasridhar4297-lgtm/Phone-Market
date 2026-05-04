<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${listing != null ? listing.title : 'Listing'} – PhoneMarket</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="/WEB-INF/pages/common/header.jsp" %>

<div class="container main-content">
    <a href="${pageContext.request.contextPath}/user/home" class="back-link">&#8592; Back to listings</a>

    <c:choose>
        <c:when test="${listing == null}">
            <div class="alert alert-error">Listing not found or has been removed.</div>
        </c:when>
        <c:otherwise>
            <c:if test="${param.msg == 'request_sent'}">
                <div class="alert alert-success">Your buy request has been sent to the seller!</div>
            </c:if>
            <c:if test="${param.error != null}">
                <div class="alert alert-error">${param.error}</div>
            </c:if>

            <div style="display:flex;gap:2rem;flex-wrap:wrap;margin-top:.5rem;">

                <!-- Phone Image -->
                <div style="flex-shrink:0;">
                    <div style="width:320px;height:320px;max-width:100%;background:linear-gradient(135deg,#e2e8f0,#cbd5e1);border-radius:var(--radius-lg);display:flex;align-items:center;justify-content:center;font-size:6rem;box-shadow:var(--shadow-md);border:1px solid var(--border);">
                        📱
                    </div>
                    <div style="margin-top:1rem;display:flex;gap:.5rem;flex-wrap:wrap;">
                        <span class="badge badge-${listing.conditionGrade.toLowerCase()}">${listing.conditionGrade}</span>
                        <span class="badge badge-${listing.status}">${listing.status}</span>
                    </div>
                </div>

                <!-- Core Info -->
                <div style="flex:1;min-width:280px;">
                    <h1 style="font-size:1.7rem;font-weight:800;line-height:1.2;margin-bottom:.4rem;">${listing.title}</h1>
                    <p style="color:var(--muted);font-size:.95rem;margin-bottom:.8rem;">${listing.brand} &middot; ${listing.modelName}</p>

                    <div style="font-size:2.2rem;font-weight:800;color:var(--primary);margin-bottom:1.5rem;line-height:1;">
                        $<fmt:formatNumber value="${listing.price}" pattern="#,##0.00"/>
                    </div>

                    <!-- Specs Card -->
                    <div class="card" style="margin-bottom:1.2rem;">
                        <div class="detail-section" style="margin-bottom:0;">
                            <h3>Specifications</h3>
                            <ul class="spec-list">
                                <li><span class="spec-label">Brand</span><span class="spec-val">${listing.brand}</span></li>
                                <li><span class="spec-label">Model</span><span class="spec-val">${listing.modelName}</span></li>
                                <c:if test="${listing.firstBuyDate != null}">
                                    <li><span class="spec-label">First Purchased</span>
                                        <span class="spec-val"><fmt:formatDate value="${listing.firstBuyDate}" pattern="MMMM yyyy"/></span>
                                    </li>
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
                                    <li><span class="spec-label">Screen Size</span><span class="spec-val">${listing.screenSizeInch}&quot;</span></li>
                                </c:if>
                                <c:if test="${not empty listing.color}">
                                    <li><span class="spec-label">Color</span><span class="spec-val">${listing.color}</span></li>
                                </c:if>
                                <li><span class="spec-label">Condition</span>
                                    <span class="spec-val"><span class="badge badge-${listing.conditionGrade.toLowerCase()}">${listing.conditionGrade}</span></span>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <!-- Seller Card -->
                    <div class="card" style="margin-bottom:1.2rem;">
                        <div class="detail-section" style="margin-bottom:0;">
                            <h3>Seller Information</h3>
                            <ul class="spec-list">
                                <li><span class="spec-label">Seller Name</span><span class="spec-val">${listing.sellerName}</span></li>
                                <li><span class="spec-label">Contact Email</span><span class="spec-val">${listing.sellerEmail}</span></li>
                                <li><span class="spec-label">Listed On</span>
                                    <span class="spec-val"><fmt:formatDate value="${listing.createdAt}" pattern="dd MMM yyyy"/></span>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <!-- Description -->
                    <c:if test="${not empty listing.description}">
                        <div class="card" style="margin-bottom:1.2rem;">
                            <h3 style="font-size:.78rem;font-weight:700;color:var(--muted);text-transform:uppercase;letter-spacing:.08em;margin-bottom:.7rem;">Description</h3>
                            <p style="font-size:.93rem;line-height:1.7;white-space:pre-line;">${listing.description}</p>
                        </div>
                    </c:if>

                    <!-- Buy Request -->
                    <c:if test="${listing.status == 'available' && listing.sellerId != sessionScope.userId}">
                        <div class="card" style="border-left:4px solid var(--success);">
                            <h3 style="font-size:1rem;font-weight:700;margin-bottom:1rem;">Send a Buy Request</h3>
                            <form method="post" action="${pageContext.request.contextPath}/user/buy-request">
                                <input type="hidden" name="listingId" value="${listing.listingId}">
                                <div class="form-group">
                                    <label for="message">Message to Seller <span style="font-weight:400;color:var(--muted);">(optional)</span></label>
                                    <textarea id="message" name="message" class="form-control" rows="3"
                                              placeholder="E.g. Is the price negotiable? When can we meet?"></textarea>
                                </div>
                                <button type="submit" class="btn btn-success">Send Buy Request</button>
                            </form>
                        </div>
                    </c:if>

                    <c:if test="${listing.status == 'sold'}">
                        <div class="alert alert-error">This phone has already been sold.</div>
                    </c:if>
                    <c:if test="${listing.status == 'pending_review'}">
                        <div class="alert alert-warning">This listing is awaiting admin approval.</div>
                    </c:if>
                    <c:if test="${listing.sellerId == sessionScope.userId}">
                        <div class="alert alert-info">
                            This is your listing. &nbsp;
                            <a href="${pageContext.request.contextPath}/user/listing?action=edit&id=${listing.listingId}" style="font-weight:700;">Edit listing</a>
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
