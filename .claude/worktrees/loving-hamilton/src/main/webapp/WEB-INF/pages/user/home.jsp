<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Phones – PhoneMarket</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="/WEB-INF/pages/common/header.jsp" %>

<div class="container main-content">
    <h1 class="page-title">📱 Browse Phones</h1>

    <!-- Search & Filter Bar -->
    <form method="get" action="${pageContext.request.contextPath}/user/home" class="filter-bar">
        <div class="form-group" style="flex:2;">
            <label for="keyword">Search</label>
            <input type="text" id="keyword" name="keyword" class="form-control search-input"
                   placeholder="Search by title, brand, model…" value="${keyword}">
        </div>
        <div class="form-group">
            <label for="brand">Brand</label>
            <select id="brand" name="brand" class="form-control">
                <option value="">All Brands</option>
                <c:forEach var="b" items="${brands}">
                    <option value="${b}" ${b == selectedBrand ? 'selected' : ''}>${b}</option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group">
            <label for="condition">Condition</label>
            <select id="condition" name="condition" class="form-control">
                <option value="">Any Condition</option>
                <option value="Excellent" ${'Excellent' == selectedCond ? 'selected' : ''}>Excellent</option>
                <option value="Good"      ${'Good'      == selectedCond ? 'selected' : ''}>Good</option>
                <option value="Fair"      ${'Fair'      == selectedCond ? 'selected' : ''}>Fair</option>
                <option value="Poor"      ${'Poor'      == selectedCond ? 'selected' : ''}>Poor</option>
            </select>
        </div>
        <div class="form-group">
            <label for="sort">Sort By</label>
            <select id="sort" name="sort" class="form-control">
                <option value=""          ${"" == selectedSort ? 'selected' : ''}>Featured</option>
                <option value="price_asc" ${"price_asc" == selectedSort ? 'selected' : ''}>Price: Low to High</option>
                <option value="price_desc" ${"price_desc" == selectedSort ? 'selected' : ''}>Price: High to Low</option>
                <option value="newest"    ${"newest" == selectedSort ? 'selected' : ''}>Newest First</option>
            </select>
        </div>
        <div class="form-group" style="align-self:flex-end;">
            <button type="submit" class="btn btn-primary">Search</button>
            <a href="${pageContext.request.contextPath}/user/home" class="btn btn-outline" style="margin-left:.4rem;">Reset</a>
        </div>
    </form>

    <!-- Results -->
    <c:choose>
        <c:when test="${empty listings}">
            <div class="card" style="text-align:center;padding:3rem;">
                <div style="font-size:3rem;margin-bottom:.8rem;">🔍</div>
                <p style="color:var(--muted);font-size:1rem;">No phones found. Try adjusting your search.</p>
            </div>
        </c:when>
        <c:otherwise>
            <p style="color:var(--muted);font-size:.9rem;margin-bottom:1rem;">${listings.size()} phone(s) found</p>
            <div class="listings-grid">
                <c:forEach var="listing" items="${listings}">
                    <div class="listing-card">
                        <div class="listing-card-img">📱</div>
                        <div class="listing-card-body">
                            <div class="listing-card-title">${listing.title}</div>
                            <div class="listing-card-brand">${listing.brand} · ${listing.modelName}</div>
                            <div class="listing-card-price">$<fmt:formatNumber value="${listing.price}" pattern="#,##0.00"/></div>
                            <div class="listing-card-specs">
                                <c:if test="${listing.ramGb > 0}">
                                    <span class="spec-chip">${listing.ramGb}GB RAM</span>
                                </c:if>
                                <c:if test="${listing.storageGb > 0}">
                                    <span class="spec-chip">${listing.storageGb}GB</span>
                                </c:if>
                                <span class="badge badge-${listing.conditionGrade.toLowerCase()}">${listing.conditionGrade}</span>
                            </div>
                            <div style="font-size:.8rem;color:var(--muted);">Seller: ${listing.sellerName}</div>
                        </div>
                        <div class="listing-card-footer">
                            <a href="${pageContext.request.contextPath}/user/listing?action=view&id=${listing.listingId}"
                               class="btn btn-primary btn-sm">View Details</a>
                            <span style="font-size:.78rem;color:var(--muted);">
                                <fmt:formatDate value="${listing.createdAt}" pattern="dd MMM yyyy"/>
                            </span>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="/WEB-INF/pages/common/footer.jsp" %>
</body>
</html>
