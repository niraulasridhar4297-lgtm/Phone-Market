<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<nav class="navbar">
    <a class="brand" href="${pageContext.request.contextPath}/${sessionScope.userRole == 'admin' ? 'admin/dashboard' : 'user/home'}">
        📱 Phone<span>Market</span>
    </a>
    <nav>
        <c:choose>
            <c:when test="${sessionScope.userRole == 'admin'}">
                <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/user/home">Browse</a>
                <a href="${pageContext.request.contextPath}/user/listing?action=new">+ Sell Phone</a>
                <a href="${pageContext.request.contextPath}/user/my-listings">My Listings</a>
                <a href="${pageContext.request.contextPath}/user/profile">Profile</a>
            </c:otherwise>
        </c:choose>
        <span style="color:rgba(255,255,255,.6);font-size:.85rem;">Hi, ${sessionScope.userName}</span>
        <a href="${pageContext.request.contextPath}/logout" class="btn-nav">Logout</a>
    </nav>
</nav>
