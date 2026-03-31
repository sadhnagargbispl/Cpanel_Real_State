<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.master" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <style>
        .types-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit,minmax(260px,1fr));
            gap: 30px;
        }

        /* Glass Card */
        .type-card {
            position: relative;
            padding: 30px;
            border-radius: 20px;
            background: rgba(255,255,255,0.05);
            backdrop-filter: blur(12px);
            border: 1px solid rgba(255,255,255,0.1);
            color: #fff;
            transition: 0.4s ease;
            overflow: hidden;
        }

            /* Gradient Glow */
            .type-card::before {
                content: '';
                position: absolute;
                inset: 0;
                border-radius: 20px;
                padding: 1px;
                background: linear-gradient(120deg,#38bdf8,#22c55e,#6366f1);
                -webkit-mask: linear-gradient(#fff 0 0) content-box, linear-gradient(#fff 0 0);
                -webkit-mask-composite: xor;
                mask-composite: exclude;
                opacity: 0;
                transition: 0.4s;
            }

            .type-card:hover::before {
                opacity: 1;
            }

            /* Hover Lift */
            .type-card:hover {
                transform: translateY(-12px) scale(1.02);
                box-shadow: 0 20px 40px rgba(0,0,0,0.4);
            }

        /* Icon */
        .icon {
            font-size: 42px;
            margin-bottom: 16px;
        }

        /* Title */
        .type-card h3 {
            font-size: 20px;
            margin-bottom: 10px;
        }

        /* Text */
        .type-card p {
            font-size: 14px;
            opacity: 0.75;
            margin-bottom: 18px;
        }

        /* Button */
        .type-card a {
            display: inline-block;
            font-size: 14px;
            color: #f7f8f8;
            text-decoration: none;
            transition: 0.3s;
        }

            .type-card a:hover {
                color: #f7f8f8;
                transform: translateX(5px);
            }
        /* Grid */
        .types-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr); /* Desktop: 4 columns */
            gap: 24px;
        }

        /* Glass Card */
        .type-card {
            position: relative;
            padding: 28px 24px;
            border-radius: 20px;
            background: rgba(255,255,255,0.05);
            backdrop-filter: blur(12px);
            border: 1px solid rgba(255,255,255,0.08);
            color: #fff;
            transition: transform 0.35s ease, box-shadow 0.35s ease;
            overflow: hidden;
        }

        /* ... baaki .type-card::before, hover styles same rahenge ... */

        /* ── RESPONSIVE BREAKPOINTS ── */

        /* Tablet landscape (≤1100px): 3 columns */
        @media (max-width: 1100px) {
            .types-grid {
                grid-template-columns: repeat(3, 1fr);
            }
        }

        /* Tablet portrait (≤768px): 2 columns */
        @media (max-width: 768px) {
            .services-section {
                padding: 60px 24px;
            }

            .types-grid {
                grid-template-columns: repeat(2, 1fr);
                gap: 16px;
            }

            .type-card {
                padding: 22px 18px;
            }

            .icon {
                font-size: 32px;
            }

            .type-card h3 {
                font-size: 15px;
            }
        }

        /* Mobile (≤480px): 2 compact columns */
        @media (max-width: 480px) {
            .types-grid {
                grid-template-columns: repeat(2, 1fr);
                gap: 12px;
            }

            .type-card {
                padding: 18px 14px;
                border-radius: 14px;
            }

            .icon {
                font-size: 28px;
            }

            .type-card h3 {
                font-size: 13px;
            }

            .type-card p {
                font-size: 11px;
            }

            .type-card a {
                font-size: 11px;
            }
        }

        /* Very small phones (≤360px): single column */
        @media (max-width: 360px) {
            .types-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>




</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!-- HERO -->
    <section class="hero">
        <div class="hero-bg-orbs">
            <div class="orb orb-1"></div>
            <div class="orb orb-2"></div>
            <div class="orb orb-3"></div>
        </div>
        <div class="hero-grid"></div>
        <div class="hero-content">
            <div class="hero-left">
                <div class="hero-badge"><span></span>INDIA's #1 Real Estate Partner</div>
                <h1 class="hero-title">Find Your <em>Dream</em> Property Today</h1>
                <p class="hero-subtitle">Premium plots, houses, and colonies designed for modern living. Trusted by thousands of families across INDIA.</p>
                <div class="hero-actions">
                    <a href="#projects" class="btn-hero-primary">🏘️ Explore Projects</a>
                    <a href="#contact" class="btn-hero-outline">📞 Talk to an Agent</a>
                </div>
                <div class="hero-stats">
                    <div class="hero-stat">
                        <div class="hero-stat-num">500+</div>
                        <div class="hero-stat-label">Projects</div>
                    </div>
                    <div class="hero-stat">
                        <div class="hero-stat-num">12K+</div>
                        <div class="hero-stat-label">Happy Clients</div>
                    </div>
                    <div class="hero-stat">
                        <div class="hero-stat-num">18</div>
                        <div class="hero-stat-label">Cities</div>
                    </div>
                </div>
            </div>

            <!-- Search Card -->
            <div class="hero-card">
                <div class="hero-card-title">🔍 Search Properties</div>
               <%-- <div class="search-tabs">
                    <button class="search-tab active" onclick="setTab(this)">Buy</button>
                    <button class="search-tab" onclick="setTab(this)">Plots</button>
                    <button class="search-tab" onclick="setTab(this)">Houses</button>
                    <button class="search-tab" onclick="setTab(this)">Colonies</button>
                </div>--%>
                <div class="form-group">
                    <label class="form-label">City / Location</label>
                    <input type="text" id="txtCity" runat="server"
                        class="form-input" placeholder="e.g. Delhi, Jaipur...">
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Property Type</label>
                        <asp:DropDownList ID="ddlProjectType" class="form-select" runat="server" />
                        <%-- <select class="form-select">
                            <option>All Types</option>
                            <option>Plot</option>
                            <option>House</option>
                            <option>Colony</option>
                            <option>Township</option>
                        </select>--%>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Budget</label>
                        <select id="ddlBudget" runat="server" class="form-select">
                            <option value="">Any Budget</option>
                            <option value="under-50L">Under 50 Lac</option>
                            <option value="50L-1Cr">50L – 1 Crore</option>
                            <option value="1Cr-3Cr">1–3 Crore</option>
                            <option value="3Cr+">3 Crore+</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="form-label">Size</label>
                    <asp:DropDownList ID="ddlCategory" class="form-select" runat="server" />
                    <%--<select class="form-select">
                        <option>Any Size</option>
                        <option>3 Marla</option>
                        <option>5 Marla</option>
                        <option>10 Marla</option>
                        <option>1 Kanal</option>
                        <option>2 Kanal+</option>
                    </select>--%>
                </div>
                <button class="btn-search" runat="server" id="btnSearch"
                    onserverclick="btnSearch_Click">
                    🔍 Search Properties</button>
                <%--<button class="btn-search">🔍 Search Properties</button>--%>
            </div>
        </div>
    </section>

    <!-- MARQUEE -->
    <div class="marquee-wrapper">
        <div class="marquee-track">
            <div class="marquee-item"><span class="marquee-dot"></span>Delhi Smart City</div>
            <div class="marquee-item"><span class="marquee-dot"></span>Blue World City</div>
            <div class="marquee-item"><span class="marquee-dot"></span>Kingdom Valley</div>
            <div class="marquee-item"><span class="marquee-dot"></span>Al-Kabir Town</div>
            <div class="marquee-item"><span class="marquee-dot"></span>Nova City</div>
            <div class="marquee-item"><span class="marquee-dot"></span>Capital Smart City</div>
            <div class="marquee-item"><span class="marquee-dot"></span>Silver City</div>
            <div class="marquee-item"><span class="marquee-dot"></span>Citi Housing</div>
            <!-- duplicate for loop -->
            <div class="marquee-item"><span class="marquee-dot"></span>Delhi Smart City</div>
            <div class="marquee-item"><span class="marquee-dot"></span>Blue World City</div>
            <div class="marquee-item"><span class="marquee-dot"></span>Kingdom Valley</div>
            <div class="marquee-item"><span class="marquee-dot"></span>Al-Kabir Town</div>
            <div class="marquee-item"><span class="marquee-dot"></span>Nova City</div>
            <div class="marquee-item"><span class="marquee-dot"></span>Capital Smart City</div>
            <div class="marquee-item"><span class="marquee-dot"></span>Silver City</div>
            <div class="marquee-item"><span class="marquee-dot"></span>Citi Housing</div>
        </div>
    </div>


    <section style="padding: 100px 48px; background: #0f172a;">
        <div class="container">

            <div class="section-header">
                <div class="section-header-left">
                    <div class="section-label" style="color: #38bdf8;">Our Services</div>
                    <h2 class="section-title" style="color: #fff;">Explore Our Smart Solutions</h2>
                </div>
            </div>

            <div class="types-grid">

                <!-- Card -->
                <div class="type-card">
                    <div class="icon">🌿</div>
                    <h3>Ayurvedic Portal</h3>
                    <p>Natural healthcare products & herbal remedies</p>
                    <a href="#">Explore →</a>
                </div>

                <div class="type-card">
                    <a href="https://shopping.skyisyourlimit.com/" target="_blank">
                        <div class="icon">🛒</div>
                        <h3>E-Commerce Portal</h3>
                        <p>Sell & purchase products with ease</p>
                        <a href="https://shopping.skyisyourlimit.com/" target="_blank">Shop Now →</a>
                    </a>
                </div>

                <div class="type-card">
                    <div class="icon">🛡️</div>
                    <h3>Insurance Portal</h3>
                    <p>Secure your future with smart policies</p>
                    <a href="#">Get Covered →</a>
                </div>

                <div class="type-card">
                    <div class="icon">⚡</div>
                    <h3>EV Bike</h3>
                    <p>Electric mobility for a greener tomorrow</p>
                    <a href="#">Explore →</a>
                </div>

                <div class="type-card">
                    <div class="icon">☀️</div>
                    <h3>Solar Panel</h3>
                    <p>Clean energy solutions for your home</p>
                    <a href="#">Get Started →</a>
                </div>

                <div class="type-card">
                    <div class="icon">✈️</div>
                    <h3>Tour Packages</h3>
                    <p>Affordable & customized travel experiences</p>
                    <a href="#">Book Now →</a>
                </div>

                <div class="type-card">
                    <div class="icon">🏢</div>
                    <h3>Real Estate</h3>
                    <p>Find the best property deals & investments</p>
                    <a href="#">View →</a>
                </div>

                <div class="type-card">
                    <div class="icon">👤</div>
                    <h3>Individual Real Estate</h3>
                    <p>Direct deals with property owners</p>
                    <a href="#">Explore →</a>
                </div>

            </div>
        </div>
    </section>

    <hr>
    <!-- FEATURED PROJECTS -->
    <section class="projects-section" id="projects">
        <div class="container">
            <div class="section-header">
                <div class="section-header-left">
                    <div class="section-label">Featured Projects</div>
                    <h2 class="section-title">Explore Our Premium Developments</h2>
                    <p class="section-sub">Handpicked projects offering the best value, amenities, and location advantage.</p>
                </div>
                <a href="#" class="link-more">View All Projects →</a>
            </div>
            <div class="projects-grid">
                <!-- Card 1 — Large -->
                <div class="project-card fade-in">
                    <div class="card-img">
                        <div class="card-img-bg" style="background: linear-gradient(135deg,#0D1B4B,#1E6FBF,#2a9fd6)">
                            <span class="img-placeholder">🏙️</span>
                        </div>
                        <span class="card-badge badge-hot">🔥 Hot</span>
                    </div>
                    <div class="card-body">
                        <div class="card-type">🏘️ Colony / Township</div>
                        <div class="card-name">Sky Residencia Delhie</div>
                        <div class="card-loc">
                            <svg width="14" height="14" fill="currentColor" viewBox="0 0 24 24">
                                <path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5c-1.38 0-2.5-1.12-2.5-2.5s1.12-2.5 2.5-2.5 2.5 1.12 2.5 2.5-1.12 2.5-2.5 2.5z" />
                            </svg>
                            Raiwind Road, Delhie
         
                        </div>
                        <div class="card-meta">
                            <div class="card-meta-item"><span class="card-meta-label">Total Area</span><span class="card-meta-value">500 Kanal</span></div>
                            <div class="card-meta-item"><span class="card-meta-label">Total Plots</span><span class="card-meta-value">1,200</span></div>
                            <div class="card-meta-item"><span class="card-meta-label">Launch</span><span class="card-meta-value">Jan 2024</span></div>
                            <div class="card-meta-item"><span class="card-meta-label">Status</span><span class="card-meta-value" style="color: #22C55E">Active</span></div>
                        </div>
                    </div>
                    <div class="card-footer">
                        <div>
                            <div class="card-price-label">Starting From</div>
                            <div class="card-price">INR 45 Lac</div>
                        </div>
                        <a href="#" class="btn-card">View Details</a>
                    </div>
                </div>
                <!-- Card 2 -->
                <div class="project-card fade-in">
                    <div class="card-img">
                        <div class="card-img-bg" style="background: linear-gradient(135deg,#6B2D8B,#9333EA)">
                            <span class="img-placeholder">🏠</span>
                        </div>
                        <span class="card-badge badge-upcoming">Upcoming</span>
                    </div>
                    <div class="card-body">
                        <div class="card-type">🏠 Housing Project</div>
                        <div class="card-name">Sky Villas Delhi</div>
                        <div class="card-loc">
                            <svg width="14" height="14" fill="currentColor" viewBox="0 0 24 24">
                                <path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5c-1.38 0-2.5-1.12-2.5-2.5s1.12-2.5 2.5-2.5 2.5 1.12 2.5 2.5-1.12 2.5-2.5 2.5z" />
                            </svg>
                            B-17, Delhi
         
                        </div>
                        <div class="card-meta">
                            <div class="card-meta-item"><span class="card-meta-label">Total Area</span><span class="card-meta-value">200 Kanal</span></div>
                            <div class="card-meta-item"><span class="card-meta-label">Total Units</span><span class="card-meta-value">480</span></div>
                        </div>
                    </div>
                    <div class="card-footer">
                        <div>
                            <div class="card-price-label">Starting From</div>
                            <div class="card-price">INR 85 Lac</div>
                        </div>
                        <a href="#" class="btn-card">View Details</a>
                    </div>
                </div>
                <!-- Card 3 -->
                <div class="project-card fade-in">
                    <div class="card-img">
                        <div class="card-img-bg" style="background: linear-gradient(135deg,#0F766E,#14B8A6)">
                            <span class="img-placeholder">📐</span>
                        </div>
                        <span class="card-badge badge-active">Active</span>
                    </div>
                    <div class="card-body">
                        <div class="card-type">📐 Plot Scheme</div>
                        <div class="card-name">Sky Gardens Noida</div>
                        <div class="card-loc">
                            <svg width="14" height="14" fill="currentColor" viewBox="0 0 24 24">
                                <path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5c-1.38 0-2.5-1.12-2.5-2.5s1.12-2.5 2.5-2.5 2.5 1.12 2.5 2.5-1.12 2.5-2.5 2.5z" />
                            </svg>
                            Canal Road, Noida
         
                        </div>
                        <div class="card-meta">
                            <div class="card-meta-item"><span class="card-meta-label">Total Area</span><span class="card-meta-value">320 Kanal</span></div>
                            <div class="card-meta-item"><span class="card-meta-label">Total Plots</span><span class="card-meta-value">750</span></div>
                        </div>
                    </div>
                    <div class="card-footer">
                        <div>
                            <div class="card-price-label">Starting From</div>
                            <div class="card-price">INR 28 Lac</div>
                        </div>
                        <a href="#" class="btn-card">View Details</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- STATS -->
    <section class="stats-section">
        <div class="container">
            <div class="stats-grid">
                <div class="stat-card fade-in">
                    <div class="stat-icon">🏗️</div>
                    <div class="stat-number">500+</div>
                    <div class="stat-label">Projects Completed</div>
                </div>
                <div class="stat-card fade-in">
                    <div class="stat-icon">👨‍👩‍👧</div>
                    <div class="stat-number">12K+</div>
                    <div class="stat-label">Happy Families</div>
                </div>
                <div class="stat-card fade-in">
                    <div class="stat-icon">🏙️</div>
                    <div class="stat-number">18</div>
                    <div class="stat-label">Cities Covered</div>
                </div>
                <div class="stat-card fade-in">
                    <div class="stat-icon">🤝</div>
                    <div class="stat-number">200+</div>
                    <div class="stat-label">Trusted Agents</div>
                </div>
            </div>
        </div>
    </section>

    <!-- PROPERTY TYPES -->
    <section style="padding: 100px 48px;">
        <div class="container">
            <div class="section-header">
                <div class="section-header-left">
                    <div class="section-label">Browse By Type</div>
                    <h2 class="section-title">What Are You Looking For?</h2>
                </div>
            </div>
            <div class="types-grid">
                <div class="type-card">
                    <div class="type-bg type-bg-1"><span>📐</span></div>
                    <div class="type-overlay"></div>
                    <div class="type-content">
                        <div class="type-name">Plots</div>
                        <div class="type-count">248 Available</div>
                    </div>
                </div>
                <div class="type-card">
                    <div class="type-bg type-bg-2"><span>🏠</span></div>
                    <div class="type-overlay"></div>
                    <div class="type-content">
                        <div class="type-name">Houses</div>
                        <div class="type-count">132 Available</div>
                    </div>
                </div>
                <div class="type-card">
                    <div class="type-bg type-bg-3"><span>🏘️</span></div>
                    <div class="type-overlay"></div>
                    <div class="type-content">
                        <div class="type-name">Colonies</div>
                        <div class="type-count">56 Active</div>
                    </div>
                </div>
                <div class="type-card">
                    <div class="type-bg type-bg-4"><span>🌆</span></div>
                    <div class="type-overlay"></div>
                    <div class="type-content">
                        <div class="type-name">Townships</div>
                        <div class="type-count">18 Upcoming</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- AMENITIES -->
    <section class="amenities-section">
        <div class="container">
            <div style="text-align: center; margin-bottom: 56px;">
                <div class="section-label" style="display: inline-block">World-Class Amenities</div>
                <h2 class="section-title" style="margin-top: 16px">Everything You Need, Right at Your Doorstep</h2>
            </div>
            <div class="amenities-grid">
                <div class="amenity-card fade-in">
                    <span class="amenity-icon">🔒</span><div class="amenity-name">Gated Security</div>
                </div>
                <div class="amenity-card fade-in">
                    <span class="amenity-icon">🌳</span><div class="amenity-name">Parks & Gardens</div>
                </div>
                <div class="amenity-card fade-in">
                    <span class="amenity-icon">🕌</span><div class="amenity-name">Mosques</div>
                </div>
                <div class="amenity-card fade-in">
                    <span class="amenity-icon">🏫</span><div class="amenity-name">Schools</div>
                </div>
                <div class="amenity-card fade-in">
                    <span class="amenity-icon">🏥</span><div class="amenity-name">Hospitals</div>
                </div>
                <div class="amenity-card fade-in">
                    <span class="amenity-icon">🛒</span><div class="amenity-name">Shopping Mall</div>
                </div>
                <div class="amenity-card fade-in">
                    <span class="amenity-icon">💡</span><div class="amenity-name">Underground Electric</div>
                </div>
                <div class="amenity-card fade-in">
                    <span class="amenity-icon">💧</span><div class="amenity-name">Water Supply</div>
                </div>
                <div class="amenity-card fade-in">
                    <span class="amenity-icon">🏊</span><div class="amenity-name">Swimming Pool</div>
                </div>
                <div class="amenity-card fade-in">
                    <span class="amenity-icon">🏃</span><div class="amenity-name">Jogging Track</div>
                </div>
                <div class="amenity-card fade-in">
                    <span class="amenity-icon">⛽</span><div class="amenity-name">Natural Gas</div>
                </div>
                <div class="amenity-card fade-in">
                    <span class="amenity-icon">🚗</span><div class="amenity-name">Wide Roads</div>
                </div>
            </div>
        </div>
    </section>

    <!-- HOW IT WORKS -->
    <section style="padding: 100px 48px;">
        <div class="container">
            <div style="text-align: center; margin-bottom: 72px;">
                <div class="section-label" style="display: inline-block">Simple Process</div>
                <h2 class="section-title" style="margin-top: 16px">How It Works</h2>
                <p class="section-sub" style="margin: 16px auto 0;">Get your dream property in four simple steps</p>
            </div>
            <div class="steps-grid">
                <div class="steps-line"></div>
                <div class="step-card fade-in">
                    <div class="step-num">01</div>
                    <div class="step-title">Browse Projects</div>
                    <div class="step-desc">Explore our portfolio of approved and upcoming real estate projects across INDIA.</div>
                </div>
                <div class="step-card fade-in">
                    <div class="step-num">02</div>
                    <div class="step-title">Choose Your Plot</div>
                    <div class="step-desc">Select from available plots with preferred size, facing, and location in any project.</div>
                </div>
                <div class="step-card fade-in">
                    <div class="step-num">03</div>
                    <div class="step-title">Book & Pay</div>
                    <div class="step-desc">Register with an agent, make your booking payment, and get your official receipt instantly.</div>
                </div>
                <div class="step-card fade-in">
                    <div class="step-num">04</div>
                    <div class="step-title">Move In</div>
                    <div class="step-desc">Complete your installments, receive your documents, and enjoy your new property.</div>
                </div>
            </div>
        </div>
    </section>

    <!-- TESTIMONIALS -->
    <section class="testimonials-section">
        <div class="container">
            <div style="text-align: center; margin-bottom: 56px;">
                <div class="section-label" style="display: inline-block; border-color: rgba(245,166,35,0.3)">Client Stories</div>
                <h2 class="section-title" style="margin-top: 16px">What Our Clients Say</h2>
                <p class="section-sub" style="margin: 16px auto 0; color: rgba(255,255,255,0.55)">Real experiences from thousands of happy property owners.</p>
            </div>
            <div class="testimonials-grid">
                <div class="testimonial-card">
                    <div class="testimonial-stars">★★★★★</div>
                    <p class="testimonial-text">"Sky Is Your Limit made buying my first plot incredibly smooth. The agent was professional, paperwork was quick, and I got the best plot in the project. Highly recommended!"</p>
                    <div class="testimonial-author">
                        <div class="author-avatar">A</div>
                        <div class="author-info"><span class="author-name">Ranjan</span><span class="author-role">Plot Owner — Sky Residencia</span></div>
                    </div>
                </div>
                <div class="testimonial-card">
                    <div class="testimonial-stars">★★★★★</div>
                    <p class="testimonial-text">"I invested in three plots through Sky Is Your Limit. The installment plan is very flexible and the team is always available to answer questions. Great experience overall."</p>
                    <div class="testimonial-author">
                        <div class="author-avatar">S</div>
                        <div class="author-info"><span class="author-name">Sana Malik</span><span class="author-role">Investor — Multiple Projects</span></div>
                    </div>
                </div>
                <div class="testimonial-card">
                    <div class="testimonial-stars">★★★★☆</div>
                    <p class="testimonial-text">"The online portal to track my booking status and payment schedule is very convenient. I can check everything from my phone. The customer service is excellent too."</p>
                    <div class="testimonial-author">
                        <div class="author-avatar">U</div>
                        <div class="author-info"><span class="author-name">Vinod</span><span class="author-role">Customer — Sky Villas</span></div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA -->
    <section class="cta-section" id="contact">
        <div class="container">
            <h2 class="cta-title">Ready to Find Your Dream Property?</h2>
            <p class="cta-sub">Talk to our expert agents today — zero commission, full guidance.</p>
            <a href="#" class="btn-cta-white">📞 Contact an Agent Now</a>
        </div>
    </section>
</asp:Content>

