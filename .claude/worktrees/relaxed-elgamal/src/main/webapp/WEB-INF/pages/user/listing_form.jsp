<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${editMode ? 'Edit Listing' : 'Sell a Phone'} – PhoneMarket</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="/WEB-INF/pages/common/header.jsp" %>

<!-- Page Hero -->
<div class="page-hero">
    <div class="container">
        <h1>${editMode ? 'Edit Your Listing' : 'List a Phone for Sale'}</h1>
        <p>${editMode ? 'Update the details of your phone listing.' : 'Fill in the details below to post your phone.'}</p>
    </div>
</div>

<div class="container" style="padding-bottom:3rem;">

    <c:if test="${error != null}">
        <div class="alert alert-error">${error}</div>
    </c:if>

    <div class="card" style="max-width:760px;">
        <form method="post" action="${pageContext.request.contextPath}/user/listing" novalidate>
            <input type="hidden" name="action" value="${editMode ? 'update' : 'create'}">
            <c:if test="${editMode}">
                <input type="hidden" name="listingId" value="${listing.listingId}">
            </c:if>

            <!-- Basic Info -->
            <h3 style="font-size:.78rem;font-weight:700;color:var(--muted);text-transform:uppercase;letter-spacing:.08em;margin-bottom:1rem;">Basic Information</h3>

            <div class="form-group">
                <label for="title">Listing Title *</label>
                <input type="text" id="title" name="title" class="form-control"
                       placeholder="e.g. Samsung Galaxy S21 – Like New" required
                       value="${editMode ? listing.title : ''}">
                <p class="form-hint">Write a clear, descriptive title that will attract buyers.</p>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="brand">Brand *</label>
                    <input type="text" id="brand" name="brand" class="form-control"
                           placeholder="e.g. Apple, Samsung, Xiaomi" required
                           value="${editMode ? listing.brand : ''}">
                </div>
                <div class="form-group">
                    <label for="modelName">Model Name *</label>
                    <input type="text" id="modelName" name="modelName" class="form-control"
                           placeholder="e.g. iPhone 13 Pro" required
                           value="${editMode ? listing.modelName : ''}">
                </div>
            </div>

            <hr class="divider">
            <h3 style="font-size:.78rem;font-weight:700;color:var(--muted);text-transform:uppercase;letter-spacing:.08em;margin-bottom:1rem;">Specifications</h3>

            <div class="form-row">
                <div class="form-group">
                    <label for="firstBuyDate">First Purchase Date</label>
                    <input type="date" id="firstBuyDate" name="firstBuyDate" class="form-control"
                           value="${editMode && listing.firstBuyDate != null ? listing.firstBuyDate : ''}">
                </div>
                <div class="form-group">
                    <label for="color">Color</label>
                    <input type="text" id="color" name="color" class="form-control"
                           placeholder="e.g. Midnight Black"
                           value="${editMode ? listing.color : ''}">
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="ramGb">RAM (GB)</label>
                    <input type="number" id="ramGb" name="ramGb" class="form-control" min="1" max="64"
                           placeholder="e.g. 8"
                           value="${editMode && listing.ramGb > 0 ? listing.ramGb : ''}">
                </div>
                <div class="form-group">
                    <label for="storageGb">Storage (GB)</label>
                    <input type="number" id="storageGb" name="storageGb" class="form-control" min="1" max="2048"
                           placeholder="e.g. 128"
                           value="${editMode && listing.storageGb > 0 ? listing.storageGb : ''}">
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="batteryMah">Battery Capacity (mAh)</label>
                    <input type="number" id="batteryMah" name="batteryMah" class="form-control" min="0"
                           placeholder="e.g. 4000"
                           value="${editMode && listing.batteryMah > 0 ? listing.batteryMah : ''}">
                </div>
                <div class="form-group">
                    <label for="screenSize">Screen Size (inches)</label>
                    <input type="number" id="screenSize" name="screenSize" class="form-control"
                           step="0.01" min="3" max="8" placeholder="e.g. 6.1"
                           value="${editMode && listing.screenSizeInch != null ? listing.screenSizeInch : ''}">
                </div>
            </div>

            <hr class="divider">
            <h3 style="font-size:.78rem;font-weight:700;color:var(--muted);text-transform:uppercase;letter-spacing:.08em;margin-bottom:1rem;">Condition &amp; Price</h3>

            <div class="form-row">
                <div class="form-group">
                    <label for="conditionGrade">Condition *</label>
                    <select id="conditionGrade" name="conditionGrade" class="form-control" required>
                        <option value="">Select Condition</option>
                        <option value="Excellent" ${editMode && 'Excellent' == listing.conditionGrade ? 'selected' : ''}>Excellent – Like New, no visible marks</option>
                        <option value="Good"      ${editMode && 'Good'      == listing.conditionGrade ? 'selected' : ''}>Good – Minor scratches or wear</option>
                        <option value="Fair"      ${editMode && 'Fair'      == listing.conditionGrade ? 'selected' : ''}>Fair – Visible wear, fully functional</option>
                        <option value="Poor"      ${editMode && 'Poor'      == listing.conditionGrade ? 'selected' : ''}>Poor – Heavy wear or damage</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="price">Asking Price (USD) *</label>
                    <input type="number" id="price" name="price" class="form-control"
                           step="0.01" min="0.01" placeholder="0.00" required
                           value="${editMode ? listing.price : ''}">
                </div>
            </div>

            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" class="form-control" rows="5"
                          placeholder="Describe the phone's condition, what accessories are included, reason for selling, and any other relevant details…">${editMode ? listing.description : ''}</textarea>
            </div>

            <hr class="divider">
            <div style="display:flex;gap:.8rem;flex-wrap:wrap;">
                <button type="submit" class="btn btn-primary btn-lg">${editMode ? 'Save Changes' : 'Post Listing'}</button>
                <a href="${pageContext.request.contextPath}/user/my-listings" class="btn btn-outline-muted">Cancel</a>
            </div>
        </form>
    </div>
</div>

<%@ include file="/WEB-INF/pages/common/footer.jsp" %>
</body>
</html>
