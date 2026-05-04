<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<footer class="footer">
    <div class="footer-grid">
        <div>
            <div class="footer-brand-name">📱 Phone<span>Market</span></div>
            <p class="footer-desc">
                Nepal's trusted second-hand phone marketplace. Buy and sell used smartphones
                safely with verified listings and secure buyer–seller communication.
            </p>
            <p style="font-size:.82rem;color:rgba(255,255,255,.35);">Islington College &bull; CS5003NI Project</p>
        </div>
        <div class="footer-col">
            <h4>Marketplace</h4>
            <c:choose>
                <c:when test="${not empty sessionScope.userRole}">
                    <a href="${pageContext.request.contextPath}/user/home">Browse Phones</a>
                    <a href="${pageContext.request.contextPath}/user/listing?action=new">Sell a Phone</a>
                    <a href="${pageContext.request.contextPath}/user/my-listings">My Listings</a>
                    <a href="${pageContext.request.contextPath}/user/profile">My Profile</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login">Browse Phones</a>
                    <a href="${pageContext.request.contextPath}/register">Sell a Phone</a>
                    <a href="${pageContext.request.contextPath}/login">Sign In</a>
                    <a href="${pageContext.request.contextPath}/register">Register</a>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="footer-col">
            <h4>Company</h4>
            <a href="${pageContext.request.contextPath}/about">About Us</a>
            <a href="${pageContext.request.contextPath}/contact">Contact Us</a>
            <a href="${pageContext.request.contextPath}/about#how-it-works">How It Works</a>
        </div>
        <div class="footer-col">
            <h4>Support</h4>
            <a href="${pageContext.request.contextPath}/contact">Help Centre</a>
            <a href="${pageContext.request.contextPath}/contact">Report an Issue</a>
            <a href="${pageContext.request.contextPath}/about#faq">FAQs</a>
        </div>
    </div>
    <div class="footer-bottom">
        <span>&copy; 2025 PhoneMarket &mdash; Second-Hand Phone Marketplace</span>
        <span>
            <a href="${pageContext.request.contextPath}/about">About</a> &bull;
            <a href="${pageContext.request.contextPath}/contact">Contact</a>
        </span>
    </div>
</footer>
