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

<!-- Hero Banner -->
<c:if test="${empty keyword && empty selectedBrand && empty selectedCond && (empty selectedSort || selectedSort == '')}">
<section class="hero">
    <div class="hero-content">
        <h1>Buy &amp; Sell <span>Second-Hand</span> Phones</h1>
        <p>Find great deals on used smartphones or list yours in minutes. Trusted by buyers and sellers across Nepal.</p>
        <form method="get" action="${pageContext.request.contextPath}/user/home" class="hero-search">
            <input type="text" name="keyword" placeholder="Search by brand, model, or title…" autocomplete="off">
            <button type="submit">Search</button>
        </form>
        <div class="hero-stats">
            <div class="hero-stat">
                <div class="num">${listings.size()}</div>
                <div class="lbl">Active Listings</div>
            </div>
            <div class="hero-stat">
                <div class="num">${brands.size()}</div>
                <div class="lbl">Brands Available</div>
            </div>
            <div class="hero-stat">
                <div class="num">100%</div>
                <div class="lbl">Free to List</div>
            </div>
        </div>
    </div>
</section>
</c:if>

<div class="container main-content">

    <!-- Recently Added / Featured Section (only on unfiltered home) -->
    <c:if test="${empty keyword && empty selectedBrand && empty selectedCond && (empty selectedSort || selectedSort == '') && not empty listings}">
        <div style="margin-bottom:2.5rem;">
            <div class="section-header">
                <h2 class="section-title">Recently <span>Added</span></h2>
                <a href="${pageContext.request.contextPath}/user/home?sort=newest" class="btn btn-outline btn-sm">View All Newest</a>
            </div>
            <div class="featured-strip">
                <c:forEach var="listing" items="${listings}" begin="0" end="2">
                    <div class="listing-card">
                        <div class="listing-card-img">
                            📱
                            <span class="card-badge badge badge-new">NEW</span>
                        </div>
                        <div class="listing-card-body">
                            <div class="listing-card-title">${listing.title}</div>
                            <div class="listing-card-brand">${listing.brand} &middot; ${listing.modelName}</div>
                            <div class="listing-card-price">
                                $<fmt:formatNumber value="${listing.price}" pattern="#,##0.00"/>
                            </div>
                            <div class="listing-card-specs">
                                <c:if test="${listing.ramGb > 0}">
                                    <span class="spec-chip">${listing.ramGb}GB RAM</span>
                                </c:if>
                                <c:if test="${listing.storageGb > 0}">
                                    <span class="spec-chip">${listing.storageGb}GB</span>
                                </c:if>
                                <span class="badge badge-${listing.conditionGrade.toLowerCase()}">${listing.conditionGrade}</span>
                            </div>
                            <div class="listing-card-seller">Seller: ${listing.sellerName}</div>
                        </div>
                        <div class="listing-card-footer">
                            <a href="${pageContext.request.contextPath}/user/listing?action=view&id=${listing.listingId}"
                               class="btn btn-primary btn-sm">View Details</a>
                            <span style="font-size:.75rem;color:var(--muted);">
                                <fmt:formatDate value="${listing.createdAt}" pattern="dd MMM yyyy"/>
                            </span>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </c:if>

    <!-- Section Title for all listings -->
    <div class="section-header">
        <h2 class="section-title">
            <c:choose>
                <c:when test="${not empty keyword || not empty selectedBrand || not empty selectedCond}">
                    Search <span>Results</span>
                </c:when>
                <c:otherwise>All <span>Listings</span></c:otherwise>
            </c:choose>
        </h2>
        <a href="${pageContext.request.contextPath}/user/listing?action=new" class="btn btn-primary btn-sm">+ Sell a Phone</a>
    </div>

    <!-- Search & Filter Bar -->
    <form method="get" action="${pageContext.request.contextPath}/user/home" class="filter-bar">
        <div class="form-group" style="flex:2;min-width:180px;">
            <label for="keyword">Search</label>
            <input type="text" id="keyword" name="keyword" class="form-control search-input"
                   placeholder="Title, brand, model…" value="${keyword}">
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
                <option value=""           ${"" == selectedSort         ? 'selected' : ''}>Featured</option>
                <option value="price_asc"  ${"price_asc"  == selectedSort ? 'selected' : ''}>Price: Low to High</option>
                <option value="price_desc" ${"price_desc" == selectedSort ? 'selected' : ''}>Price: High to Low</option>
                <option value="newest"     ${"newest"     == selectedSort ? 'selected' : ''}>Newest First</option>
            </select>
        </div>
        <div class="form-group" style="align-self:flex-end;">
            <button type="submit" class="btn btn-primary">Search</button>
            <a href="${pageContext.request.contextPath}/user/home" class="btn btn-outline-muted" style="margin-left:.4rem;">Reset</a>
        </div>
    </form>

    <!-- Results -->
    <c:choose>
        <c:when test="${empty listings}">
            <div class="card empty-state">
                <span class="empty-icon">🔍</span>
                <p>No phones found matching your search. Try adjusting the filters.</p>
                <a href="${pageContext.request.contextPath}/user/home" class="btn btn-outline">Clear Filters</a>
            </div>
        </c:when>
        <c:otherwise>
            <p style="color:var(--muted);font-size:.88rem;margin-bottom:1rem;">
                Showing <strong>${listings.size()}</strong> listing(s)
            </p>
            <div class="listings-grid">
                <c:forEach var="listing" items="${listings}">
                    <div class="listing-card">
                        <div class="listing-card-img">📱</div>
                        <div class="listing-card-body">
                            <div class="listing-card-title">${listing.title}</div>
                            <div class="listing-card-brand">${listing.brand} &middot; ${listing.modelName}</div>
                            <div class="listing-card-price">
                                $<fmt:formatNumber value="${listing.price}" pattern="#,##0.00"/>
                            </div>
                            <div class="listing-card-specs">
                                <c:if test="${listing.ramGb > 0}">
                                    <span class="spec-chip">${listing.ramGb}GB RAM</span>
                                </c:if>
                                <c:if test="${listing.storageGb > 0}">
                                    <span class="spec-chip">${listing.storageGb}GB</span>
                                </c:if>
                                <span class="badge badge-${listing.conditionGrade.toLowerCase()}">${listing.conditionGrade}</span>
                            </div>
                            <div class="listing-card-seller">Seller: ${listing.sellerName}</div>
                        </div>
                        <div class="listing-card-footer">
                            <a href="${pageContext.request.contextPath}/user/listing?action=view&id=${listing.listingId}"
                               class="btn btn-primary btn-sm">View Details</a>
                            <span style="font-size:.75rem;color:var(--muted);">
                                <fmt:formatDate value="${listing.createdAt}" pattern="dd MMM yy"/>
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
