<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<nav class="navbar">
    <a class="brand" href="${pageContext.request.contextPath}/${sessionScope.userRole == 'admin' ? 'admin/dashboard' : (not empty sessionScope.userRole ? 'user/home' : 'login')}">
        📱 Phone<span>Market</span>
    </a>

    <button class="hamburger" id="hamburgerBtn" onclick="toggleHamburger()" aria-label="Toggle menu">
        <span></span>
        <span></span>
        <span></span>
    </button>

    <nav class="main-nav" id="mainNav">
        <c:choose>
            <c:when test="${sessionScope.userRole == 'admin'}">
                <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
                <a href="${pageContext.request.contextPath}/about">About</a>
                <a href="${pageContext.request.contextPath}/contact">Contact</a>
                <span class="user-greeting">Hi, ${sessionScope.userName}</span>
                <a href="${pageContext.request.contextPath}/logout" class="btn-nav">Logout</a>
            </c:when>
            <c:when test="${not empty sessionScope.userRole}">
                <a href="${pageContext.request.contextPath}/user/home">Browse</a>
                <a href="${pageContext.request.contextPath}/user/listing?action=new">+ Sell Phone</a>
                <a href="${pageContext.request.contextPath}/user/my-listings">My Listings</a>
                <a href="${pageContext.request.contextPath}/user/profile">Profile</a>
                <a href="${pageContext.request.contextPath}/about">About</a>
                <a href="${pageContext.request.contextPath}/contact">Contact</a>
                <span class="user-greeting">Hi, ${sessionScope.userName}</span>
                <a href="${pageContext.request.contextPath}/logout" class="btn-nav">Logout</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/about">About</a>
                <a href="${pageContext.request.contextPath}/contact">Contact</a>
                <a href="${pageContext.request.contextPath}/login">Sign In</a>
                <a href="${pageContext.request.contextPath}/register" class="btn-nav">Register</a>
            </c:otherwise>
        </c:choose>
    </nav>
</nav>

<script>
function toggleHamburger() {
    var btn = document.getElementById('hamburgerBtn');
    var nav = document.getElementById('mainNav');
    btn.classList.toggle('open');
    nav.classList.toggle('open');
}
</script>
