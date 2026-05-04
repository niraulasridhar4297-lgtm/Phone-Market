<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us – PhoneMarket</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="/WEB-INF/pages/common/header.jsp" %>

<!-- Page Hero -->
<div class="about-hero" style="padding:3rem 1.2rem 3.5rem;">
    <h1 style="font-size:2.2rem;">Contact Us</h1>
    <p>Have a question or need help? We're here for you. Fill in the form below or reach out directly.</p>
</div>

<div class="container main-content">

    <% if (request.getAttribute("success") != null) { %>
        <div class="alert alert-success">${success}</div>
    <% } %>
    <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error">${error}</div>
    <% } %>

    <div class="contact-grid">

        <!-- Contact Info -->
        <div class="contact-info-card">
            <h2>Get in Touch</h2>
            <p>We'd love to hear from you. Whether you have a question about a listing, need technical support, or just want to give feedback — we're happy to help.</p>

            <div class="contact-detail">
                <div class="contact-detail-icon">📍</div>
                <div class="contact-detail-text">
                    <h4>Address</h4>
                    <p>Islington College<br>Kamal Pokhari, Kathmandu<br>Nepal</p>
                </div>
            </div>

            <div class="contact-detail">
                <div class="contact-detail-icon">✉️</div>
                <div class="contact-detail-text">
                    <h4>Email Support</h4>
                    <p>support@phonemarket.np<br>admin@phonemarket.np</p>
                </div>
            </div>

            <div class="contact-detail">
                <div class="contact-detail-icon">📞</div>
                <div class="contact-detail-text">
                    <h4>Phone</h4>
                    <p>+977 1 4412345<br>Mon – Fri, 9am – 5pm</p>
                </div>
            </div>

            <div class="contact-detail">
                <div class="contact-detail-icon">🕐</div>
                <div class="contact-detail-text">
                    <h4>Support Hours</h4>
                    <p>Sunday – Friday<br>9:00 AM – 5:00 PM NST</p>
                </div>
            </div>
        </div>

        <!-- Contact Form -->
        <div class="card" style="padding:2rem;">
            <h2 style="font-size:1.2rem;font-weight:700;margin-bottom:1.5rem;padding-bottom:.8rem;border-bottom:1px solid var(--border);">
                Send Us a Message
            </h2>

            <form method="post" action="${pageContext.request.contextPath}/contact" novalidate>
                <div class="form-row">
                    <div class="form-group">
                        <label for="name">Your Name *</label>
                        <input type="text" id="name" name="name" class="form-control"
                               placeholder="John Doe"
                               value="${param.name}" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email Address *</label>
                        <input type="email" id="email" name="email" class="form-control"
                               placeholder="you@example.com"
                               value="${param.email}" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="subject">Subject *</label>
                    <select id="subject" name="subject" class="form-control" required>
                        <option value="">Select a topic…</option>
                        <option value="Listing Inquiry"   ${param.subject == 'Listing Inquiry'    ? 'selected' : ''}>Listing Inquiry</option>
                        <option value="Account Support"   ${param.subject == 'Account Support'    ? 'selected' : ''}>Account Support</option>
                        <option value="Technical Issue"   ${param.subject == 'Technical Issue'    ? 'selected' : ''}>Technical Issue</option>
                        <option value="Report a Listing"  ${param.subject == 'Report a Listing'   ? 'selected' : ''}>Report a Listing</option>
                        <option value="General Feedback"  ${param.subject == 'General Feedback'   ? 'selected' : ''}>General Feedback</option>
                        <option value="Other"             ${param.subject == 'Other'              ? 'selected' : ''}>Other</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="phone">Phone Number <span style="font-weight:400;color:var(--muted);">(optional)</span></label>
                    <input type="text" id="phone" name="phone" class="form-control"
                           placeholder="+977 9800000000"
                           value="${param.phone}">
                </div>

                <div class="form-group">
                    <label for="message">Message *</label>
                    <textarea id="message" name="message" class="form-control" rows="6"
                              placeholder="Please describe your question or issue in detail…" required>${param.message}</textarea>
                </div>

                <button type="submit" class="btn btn-primary btn-lg btn-full">Send Message</button>
                <p class="form-hint" style="text-align:center;margin-top:.7rem;">
                    We typically respond within 1–2 business days.
                </p>
            </form>
        </div>
    </div>

    <!-- Quick Help Links -->
    <div style="margin-top:3rem;">
        <h2 style="font-size:1.2rem;font-weight:700;text-align:center;margin-bottom:1.5rem;">Quick Help</h2>
        <div style="display:grid;grid-template-columns:repeat(auto-fill,minmax(220px,1fr));gap:1rem;">
            <a href="${pageContext.request.contextPath}/about#faq" class="card" style="text-align:center;padding:1.5rem;text-decoration:none;color:var(--text);transition:transform .2s,box-shadow .2s;"
               onmouseover="this.style.transform='translateY(-3px)';this.style.boxShadow='var(--shadow-md)'"
               onmouseout="this.style.transform='';this.style.boxShadow=''">
                <div style="font-size:1.8rem;margin-bottom:.5rem;">❓</div>
                <div style="font-weight:700;margin-bottom:.2rem;">FAQs</div>
                <div style="font-size:.85rem;color:var(--muted);">Find answers to common questions</div>
            </a>
            <a href="${pageContext.request.contextPath}/about#how-it-works" class="card" style="text-align:center;padding:1.5rem;text-decoration:none;color:var(--text);transition:transform .2s,box-shadow .2s;"
               onmouseover="this.style.transform='translateY(-3px)';this.style.boxShadow='var(--shadow-md)'"
               onmouseout="this.style.transform='';this.style.boxShadow=''">
                <div style="font-size:1.8rem;margin-bottom:.5rem;">📖</div>
                <div style="font-weight:700;margin-bottom:.2rem;">How It Works</div>
                <div style="font-size:.85rem;color:var(--muted);">Step-by-step guide for buyers &amp; sellers</div>
            </a>
            <c:if test="${not empty sessionScope.userRole}">
            <a href="${pageContext.request.contextPath}/user/profile" class="card" style="text-align:center;padding:1.5rem;text-decoration:none;color:var(--text);transition:transform .2s,box-shadow .2s;"
               onmouseover="this.style.transform='translateY(-3px)';this.style.boxShadow='var(--shadow-md)'"
               onmouseout="this.style.transform='';this.style.boxShadow=''">
                <div style="font-size:1.8rem;margin-bottom:.5rem;">👤</div>
                <div style="font-weight:700;margin-bottom:.2rem;">My Account</div>
                <div style="font-size:.85rem;color:var(--muted);">Manage your profile and settings</div>
            </a>
            </c:if>
            <a href="${pageContext.request.contextPath}/${not empty sessionScope.userRole ? 'user/home' : 'login'}"
               class="card" style="text-align:center;padding:1.5rem;text-decoration:none;color:var(--text);transition:transform .2s,box-shadow .2s;"
               onmouseover="this.style.transform='translateY(-3px)';this.style.boxShadow='var(--shadow-md)'"
               onmouseout="this.style.transform='';this.style.boxShadow=''">
                <div style="font-size:1.8rem;margin-bottom:.5rem;">📱</div>
                <div style="font-weight:700;margin-bottom:.2rem;">Browse Phones</div>
                <div style="font-size:.85rem;color:var(--muted);">Find phones for sale now</div>
            </a>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/pages/common/footer.jsp" %>
</body>
</html>
