<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us – PhoneMarket</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="/WEB-INF/pages/common/header.jsp" %>

<!-- About Hero -->
<section class="about-hero">
    <h1>About PhoneMarket</h1>
    <p>
        Nepal's trusted platform for buying and selling second-hand smartphones safely,
        quickly, and transparently.
    </p>
</section>

<!-- Mission & Vision -->
<section class="section-block">
    <div class="container">
        <div style="display:grid;grid-template-columns:1fr 1fr;gap:2rem;max-width:900px;margin:0 auto;">
            <div class="card" style="border-top:4px solid var(--primary);text-align:center;padding:2rem;">
                <div style="font-size:2.5rem;margin-bottom:1rem;">🎯</div>
                <h2 style="font-size:1.2rem;font-weight:700;margin-bottom:.8rem;">Our Mission</h2>
                <p style="color:var(--muted);font-size:.92rem;line-height:1.7;">
                    To make second-hand phone trading safe, transparent, and accessible to everyone
                    in Nepal by connecting genuine buyers and sellers on a trusted marketplace.
                </p>
            </div>
            <div class="card" style="border-top:4px solid var(--accent);text-align:center;padding:2rem;">
                <div style="font-size:2.5rem;margin-bottom:1rem;">🔭</div>
                <h2 style="font-size:1.2rem;font-weight:700;margin-bottom:.8rem;">Our Vision</h2>
                <p style="color:var(--muted);font-size:.92rem;line-height:1.7;">
                    To become the leading second-hand electronics marketplace in South Asia,
                    promoting sustainable consumption and making quality phones affordable for all.
                </p>
            </div>
        </div>
    </div>
</section>

<!-- Why PhoneMarket -->
<section class="section-block alt" id="features">
    <div class="container">
        <div style="text-align:center;margin-bottom:1rem;">
            <h2 style="font-size:1.8rem;font-weight:800;margin-bottom:.5rem;">Why Choose PhoneMarket?</h2>
            <p style="color:var(--muted);font-size:.95rem;">Everything you need to buy and sell second-hand phones with confidence.</p>
        </div>
        <div class="features-grid">
            <div class="feature-card">
                <span class="feature-icon">🔒</span>
                <h3>Secure &amp; Verified</h3>
                <p>All listings go through admin review before going live. BCrypt password encryption and role-based access keep your account safe.</p>
            </div>
            <div class="feature-card">
                <span class="feature-icon">🔍</span>
                <h3>Smart Search</h3>
                <p>Filter by brand, condition, and price. Sort by newest or featured to quickly find the phone you're looking for.</p>
            </div>
            <div class="feature-card">
                <span class="feature-icon">💬</span>
                <h3>Direct Communication</h3>
                <p>Send buy requests with personal messages directly to sellers. No middlemen — just transparent buyer–seller interaction.</p>
            </div>
            <div class="feature-card">
                <span class="feature-icon">📊</span>
                <h3>Detailed Listings</h3>
                <p>Full phone specifications including RAM, storage, battery, screen size, colour, and condition grade for informed buying decisions.</p>
            </div>
            <div class="feature-card">
                <span class="feature-icon">📱</span>
                <h3>Mobile Friendly</h3>
                <p>Fully responsive design built with pure CSS — works perfectly on desktops, tablets, and smartphones without any frameworks.</p>
            </div>
            <div class="feature-card">
                <span class="feature-icon">⚡</span>
                <h3>Free to Use</h3>
                <p>Listing your phone is completely free. Create an account, post your listing, and reach buyers instantly — no hidden fees.</p>
            </div>
        </div>
    </div>
</section>

<!-- How It Works -->
<section class="section-block" id="how-it-works">
    <div class="container">
        <div style="text-align:center;margin-bottom:1rem;">
            <h2 style="font-size:1.8rem;font-weight:800;margin-bottom:.5rem;">How It Works</h2>
            <p style="color:var(--muted);font-size:.95rem;">Buying or selling a phone has never been this simple.</p>
        </div>
        <div style="display:grid;grid-template-columns:1fr 1fr;gap:3rem;margin-top:2rem;">
            <!-- Buying -->
            <div>
                <h3 style="font-size:1.1rem;font-weight:700;margin-bottom:1.5rem;color:var(--primary);text-align:center;">For Buyers</h3>
                <div class="steps-grid" style="grid-template-columns:1fr 1fr;">
                    <div class="step-card">
                        <div class="step-num">1</div>
                        <h3>Create Account</h3>
                        <p>Register for free with your email address and a secure password.</p>
                    </div>
                    <div class="step-card">
                        <div class="step-num">2</div>
                        <h3>Browse Listings</h3>
                        <p>Search and filter through available phones by brand, condition, and price.</p>
                    </div>
                    <div class="step-card">
                        <div class="step-num">3</div>
                        <h3>Send Request</h3>
                        <p>Found your phone? Send a buy request with a personal message to the seller.</p>
                    </div>
                    <div class="step-card">
                        <div class="step-num">4</div>
                        <h3>Complete Deal</h3>
                        <p>Once accepted, arrange payment and handover directly with the seller.</p>
                    </div>
                </div>
            </div>
            <!-- Selling -->
            <div>
                <h3 style="font-size:1.1rem;font-weight:700;margin-bottom:1.5rem;color:var(--success);text-align:center;">For Sellers</h3>
                <div class="steps-grid" style="grid-template-columns:1fr 1fr;">
                    <div class="step-card">
                        <div class="step-num" style="background:linear-gradient(135deg,var(--success),#15803d);">1</div>
                        <h3>Create Account</h3>
                        <p>Sign up free and set up your profile to start selling your phone.</p>
                    </div>
                    <div class="step-card">
                        <div class="step-num" style="background:linear-gradient(135deg,var(--success),#15803d);">2</div>
                        <h3>Post Listing</h3>
                        <p>Fill in your phone's details, specs, condition, and asking price.</p>
                    </div>
                    <div class="step-card">
                        <div class="step-num" style="background:linear-gradient(135deg,var(--success),#15803d);">3</div>
                        <h3>Get Requests</h3>
                        <p>Receive buy requests from interested buyers with their messages.</p>
                    </div>
                    <div class="step-card">
                        <div class="step-num" style="background:linear-gradient(135deg,var(--success),#15803d);">4</div>
                        <h3>Accept &amp; Sell</h3>
                        <p>Accept the best offer and arrange the handover to complete the sale.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- About the Platform -->
<section class="section-block alt" id="faq">
    <div class="container" style="max-width:800px;">
        <h2 style="font-size:1.8rem;font-weight:800;text-align:center;margin-bottom:2rem;">Frequently Asked Questions</h2>

        <div style="display:flex;flex-direction:column;gap:1rem;">
            <details class="card" style="cursor:pointer;">
                <summary style="font-weight:700;font-size:.97rem;padding:.2rem 0;">Is it free to list a phone?</summary>
                <p style="margin-top:.8rem;color:var(--muted);font-size:.9rem;line-height:1.7;">
                    Yes! Creating an account and posting listings is completely free. There are no commission fees or hidden charges.
                </p>
            </details>
            <details class="card" style="cursor:pointer;">
                <summary style="font-weight:700;font-size:.97rem;padding:.2rem 0;">How are listings verified?</summary>
                <p style="margin-top:.8rem;color:var(--muted);font-size:.9rem;line-height:1.7;">
                    Every listing goes through an admin review before it appears publicly. This ensures only genuine and accurate listings are shown to buyers.
                </p>
            </details>
            <details class="card" style="cursor:pointer;">
                <summary style="font-weight:700;font-size:.97rem;padding:.2rem 0;">How do I contact a seller?</summary>
                <p style="margin-top:.8rem;color:var(--muted);font-size:.9rem;line-height:1.7;">
                    Use the "Send Buy Request" button on any listing page. You can include a personal message. Once accepted, the seller's email is visible for direct contact.
                </p>
            </details>
            <details class="card" style="cursor:pointer;">
                <summary style="font-weight:700;font-size:.97rem;padding:.2rem 0;">Is my data secure?</summary>
                <p style="margin-top:.8rem;color:var(--muted);font-size:.9rem;line-height:1.7;">
                    Yes. We use BCrypt password hashing (12 salt rounds), session-based authentication with 30-minute timeouts, and role-based access control to protect your account.
                </p>
            </details>
        </div>
    </div>
</section>

<!-- Institution Info -->
<section class="section-block">
    <div class="container">
        <div style="text-align:center;max-width:700px;margin:0 auto;">
            <h2 style="font-size:1.6rem;font-weight:800;margin-bottom:.8rem;">About This Project</h2>
            <p style="color:var(--muted);font-size:.93rem;line-height:1.8;margin-bottom:1.5rem;">
                PhoneMarket is a web application developed as part of the
                <strong>CS5003NI – Data Structures and Specialist Programming</strong> module
                at <strong>Islington College</strong>, affiliated with London Metropolitan University.
                The system is built using Java EE, JSP, Servlets, and MySQL, following strict MVC architecture principles.
            </p>
            <div style="display:flex;justify-content:center;gap:2rem;flex-wrap:wrap;">
                <div class="card" style="min-width:200px;text-align:center;padding:1.5rem;">
                    <div style="font-size:2rem;margin-bottom:.5rem;">🏫</div>
                    <div style="font-weight:700;margin-bottom:.2rem;">Islington College</div>
                    <div style="font-size:.85rem;color:var(--muted);">Kathmandu, Nepal</div>
                </div>
                <div class="card" style="min-width:200px;text-align:center;padding:1.5rem;">
                    <div style="font-size:2rem;margin-bottom:.5rem;">🎓</div>
                    <div style="font-weight:700;margin-bottom:.2rem;">CS5003NI</div>
                    <div style="font-size:.85rem;color:var(--muted);">AY 2024–2025</div>
                </div>
                <div class="card" style="min-width:200px;text-align:center;padding:1.5rem;">
                    <div style="font-size:2rem;margin-bottom:.5rem;">💻</div>
                    <div style="font-weight:700;margin-bottom:.2rem;">Java EE + MySQL</div>
                    <div style="font-size:.85rem;color:var(--muted);">JSP, Servlets, JDBC</div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- CTA Section -->
<section class="cta-section">
    <h2>Ready to Buy or Sell?</h2>
    <p>Join PhoneMarket today and find great deals on second-hand phones.</p>
    <div style="display:flex;gap:1rem;justify-content:center;flex-wrap:wrap;">
        <a href="${pageContext.request.contextPath}/register" class="btn-cta">Create Free Account</a>
        <a href="${pageContext.request.contextPath}/user/home"
           style="background:rgba(255,255,255,.15);color:#fff;padding:.85rem 2.2rem;border-radius:50px;font-size:1rem;font-weight:700;text-decoration:none;display:inline-block;transition:background .2s;"
           onmouseover="this.style.background='rgba(255,255,255,.25)'"
           onmouseout="this.style.background='rgba(255,255,255,.15)'">Browse Phones</a>
    </div>
</section>

<%@ include file="/WEB-INF/pages/common/footer.jsp" %>

<style>
details summary { list-style: none; }
details summary::-webkit-details-marker { display: none; }
details summary::after { content: ' +'; color: var(--primary); }
details[open] summary::after { content: ' −'; }
@media(max-width:768px) {
    div[style*="grid-template-columns:1fr 1fr"] { grid-template-columns: 1fr !important; }
}
</style>
</body>
</html>
