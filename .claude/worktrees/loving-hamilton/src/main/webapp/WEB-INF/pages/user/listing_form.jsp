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

<div class="container main-content">
    <h1 class="page-title">${editMode ? '✏️ Edit Listing' : '📱 Sell a Phone'}</h1>

    <c:if test="${error != null}">
        <div class="alert alert-error">${error}</div>
    </c:if>

    <div class="card" style="max-width:720px;">
        <form method="post" action="${pageContext.request.contextPath}/user/listing">
            <input type="hidden" name="action" value="${editMode ? 'update' : 'create'}">
            <c:if test="${editMode}">
                <input type="hidden" name="listingId" value="${listing.listingId}">
            </c:if>

            <div class="form-group">
                <label for="title">Listing Title *</label>
                <input type="text" id="title" name="title" class="form-control"
                       placeholder="e.g. Samsung Galaxy S21 – Like New" required
                       value="${editMode ? listing.title : ''}">
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="brand">Brand *</label>
                    <input type="text" id="brand" name="brand" class="form-control"
                           placeholder="e.g. Apple, Samsung…" required
                           value="${editMode ? listing.brand : ''}">
                </div>
                <div class="form-group">
                    <label for="modelName">Model Name *</label>
                    <input type="text" id="modelName" name="modelName" class="form-control"
                           placeholder="e.g. iPhone 13 Pro" required
                           value="${editMode ? listing.modelName : ''}">
                </div>
            </div>

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
                    <input type="number" id="ramGb" name="ramGb" class="form-control" min="1"
                           placeholder="e.g. 8"
                           value="${editMode ? listing.ramGb : ''}">
                </div>
                <div class="form-group">
                    <label for="storageGb">Storage (GB)</label>
                    <input type="number" id="storageGb" name="storageGb" class="form-control" min="1"
                           placeholder="e.g. 128"
                           value="${editMode ? listing.storageGb : ''}">
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="batteryMah">Battery (mAh)</label>
                    <input type="number" id="batteryMah" name="batteryMah" class="form-control" min="0"
                           placeholder="e.g. 4000"
                           value="${editMode ? listing.batteryMah : ''}">
                </div>
                <div class="form-group">
                    <label for="screenSize">Screen Size (inches)</label>
                    <input type="number" id="screenSize" name="screenSize" class="form-control"
                           step="0.01" min="3" max="8" placeholder="e.g. 6.1"
                           value="${editMode && listing.screenSizeInch != null ? listing.screenSizeInch : ''}">
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="conditionGrade">Condition *</label>
                    <select id="conditionGrade" name="conditionGrade" class="form-control" required>
                        <option value="">Select Condition</option>
                        <option value="Excellent" ${editMode && 'Excellent' == listing.conditionGrade ? 'selected' : ''}>Excellent – Like New</option>
                        <option value="Good"      ${editMode && 'Good'      == listing.conditionGrade ? 'selected' : ''}>Good – Minor Wear</option>
                        <option value="Fair"      ${editMode && 'Fair'      == listing.conditionGrade ? 'selected' : ''}>Fair – Visible Wear</option>
                        <option value="Poor"      ${editMode && 'Poor'      == listing.conditionGrade ? 'selected' : ''}>Poor – Heavy Wear</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="price">Asking Price ($) *</label>
                    <input type="number" id="price" name="price" class="form-control"
                           step="0.01" min="0.01" placeholder="0.00" required
                           value="${editMode ? listing.price : ''}">
                </div>
            </div>

            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" class="form-control"
                          placeholder="Describe the phone's condition, accessories included, reason for selling…"
                          rows="4">${editMode ? listing.description : ''}</textarea>
            </div>

            <div style="display:flex;gap:.8rem;margin-top:.5rem;">
                <button type="submit" class="btn btn-primary">${editMode ? 'Save Changes' : 'Post Listing'}</button>
                <a href="${pageContext.request.contextPath}/user/my-listings" class="btn btn-outline">Cancel</a>
            </div>
        </form>
    </div>
</div>

<%@ include file="/WEB-INF/pages/common/footer.jsp" %>
</body>
</html>
