<%@ Page Title="All Projects" Language="C#" MasterPageFile="~/MainMaster.master" AutoEventWireup="true" CodeFile="projects.aspx.cs" Inherits="projects" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        :root {
            --navy: #0B1638;
            --ocean: #1756A9;
            --sky: #3B90F5;
            --gold: #E8A020;
            --gold-lt: #F5C96A;
            --cream: #FDF8F0;
            --mist: #F1F5FB;
            --slate: #64748B;
            --border: #E2EAF5;
            --shadow: 0 4px 32px rgba(11,22,56,.10);
            --shadow-lg: 0 12px 56px rgba(11,22,56,.18);
            --r: 14px;
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        html { scroll-behavior: smooth; }
        body { font-family: 'Outfit', sans-serif; background: var(--cream); color: var(--navy); overflow-x: hidden; }

        /* ── PAGE HERO ── */
        .page-hero {
            background: linear-gradient(155deg, #0B1638 0%, #133380 55%, #1756A9 100%);
            padding: 120px 48px 64px;
            position: relative;
            overflow: hidden;
            text-align: center;
        }
        .page-hero::before {
            content: '';
            position: absolute;
            inset: 0;
            background-image:
                radial-gradient(circle at 20% 50%, rgba(232,160,32,.12) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(59,144,245,.15) 0%, transparent 50%),
                linear-gradient(rgba(255,255,255,.03) 1px, transparent 1px),
                linear-gradient(90deg, rgba(255,255,255,.03) 1px, transparent 1px);
            background-size: 100% 100%, 100% 100%, 56px 56px, 56px 56px;
            pointer-events: none;
        }
        .page-hero-inner { position: relative; z-index: 2; max-width: 700px; margin: 0 auto; }
        .page-hero-badge {
            display: inline-flex; align-items: center; gap: 8px;
            background: rgba(232,160,32,.15); border: 1px solid rgba(232,160,32,.4);
            color: var(--gold-lt); font-size: 11px; font-weight: 600;
            letter-spacing: 1.8px; text-transform: uppercase;
            padding: 6px 14px; border-radius: 100px; margin-bottom: 20px;
        }
        .page-hero-badge-dot {
            width: 6px; height: 6px; background: var(--gold);
            border-radius: 50%; animation: blink 2s infinite;
        }
        @keyframes blink {
            0%,100% { opacity:1; transform:scale(1) }
            50%      { opacity:.4; transform:scale(1.5) }
        }
        .page-hero-title {
            font-family: 'Cormorant Garamond', serif;
            font-size: clamp(36px,5vw,64px); font-weight: 700;
            color: #fff; line-height: 1.08; margin-bottom: 16px;
        }
        .page-hero-title em { font-style: italic; color: var(--gold); }
        .page-hero-sub {
            font-size: 16px; color: rgba(255,255,255,.65);
            line-height: 1.75; margin-bottom: 0;
        }

        /* ── MAIN CONTENT ── */
        .projects-page { max-width: 1280px; margin: 0 auto; padding: 56px 48px 80px; }

        /* Filter Bar */
        .filter-bar {
            background: #fff; border: 1px solid var(--border);
            border-radius: var(--r); padding: 20px 24px;
            display: flex; gap: 14px; align-items: flex-end;
            flex-wrap: wrap; box-shadow: var(--shadow); margin-bottom: 32px;
        }
        .fb-group { display: flex; flex-direction: column; gap: 6px; flex: 1; min-width: 130px; }
        .fb-group label { font-size: 11px; font-weight: 600; color: var(--slate); text-transform: uppercase; letter-spacing: .8px; }
        .fb-group select, .fb-group input {
            padding: 10px 14px; border: 1.5px solid var(--border);
            border-radius: 8px; font-size: 13px; font-family: 'Outfit', sans-serif;
            color: var(--navy); background: var(--mist); outline: none;
            transition: border-color .2s; cursor: pointer;
        }
        .fb-group select:focus, .fb-group input:focus { border-color: var(--ocean); }
        .fb-btn {
            padding: 11px 26px; background: var(--navy); color: #fff;
            border: none; border-radius: 9px; font-size: 13.5px; font-weight: 600;
            cursor: pointer; transition: background .2s; font-family: 'Outfit', sans-serif;
            white-space: nowrap; align-self: flex-end;
        }
        .fb-btn:hover { background: var(--ocean); }
        .fb-clear {
            padding: 11px 18px; background: transparent; color: var(--slate);
            border: 1.5px solid var(--border); border-radius: 9px;
            font-size: 13px; font-weight: 600; cursor: pointer;
            transition: all .2s; font-family: 'Outfit', sans-serif;
            white-space: nowrap; align-self: flex-end;
        }
        .fb-clear:hover { border-color: var(--navy); color: var(--navy); }

        /* Results bar */
        .results-bar {
            display: flex; align-items: center; justify-content: space-between;
            margin-bottom: 28px; flex-wrap: wrap; gap: 12px;
        }
        .results-count { font-size: 14px; color: var(--slate); }
        .results-count strong { color: var(--navy); font-weight: 700; }

        /* Sort */
        .sort-wrap { display: flex; align-items: center; gap: 10px; }
        .sort-wrap label { font-size: 13px; color: var(--slate); font-weight: 500; }
        .sort-wrap select {
            padding: 8px 12px; border: 1.5px solid var(--border);
            border-radius: 8px; font-size: 13px; background: #fff;
            color: var(--navy); font-family: 'Outfit', sans-serif;
            outline: none; cursor: pointer;
        }

        /* Properties Grid */
        .properties-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 26px;
        }

        /* Property Card */
        .prop-card {
            background: #fff; border-radius: var(--r);
            border: 1px solid var(--border); overflow: hidden;
            box-shadow: var(--shadow); transition: all .3s;
            cursor: pointer; display: flex; flex-direction: column;
        }
        .prop-card:hover { transform: translateY(-6px); box-shadow: var(--shadow-lg); }

        .prop-img { position: relative; height: 210px; overflow: hidden; }
        .prop-img-real { width: 100%; height: 100%; object-fit: cover; transition: transform .4s; display: block; }
        .prop-card:hover .prop-img-real { transform: scale(1.07); }

        .prop-img-placeholder {
            width: 100%; height: 100%;
            display: flex; flex-direction: column;
            align-items: center; justify-content: center;
            gap: 10px; position: relative; overflow: hidden; transition: transform .4s;
        }
        .prop-card:hover .prop-img-placeholder { transform: scale(1.05); }
        .prop-img-placeholder::before {
            content: ''; position: absolute; inset: 0;
            background-image: radial-gradient(circle, rgba(255,255,255,.12) 1px, transparent 1px);
            background-size: 22px 22px; pointer-events: none;
        }
        .prop-img-placeholder::after {
            content: ''; position: absolute; bottom: 0; left: 0; right: 0;
            height: 70px; background: linear-gradient(to top, rgba(11,22,56,.55), transparent);
            pointer-events: none;
        }
        .ph-emoji { font-size: 46px; line-height: 1; position: relative; z-index: 1; filter: drop-shadow(0 4px 12px rgba(0,0,0,.3)); }
        .ph-label { font-size: 11px; font-weight: 700; letter-spacing: 2px; text-transform: uppercase; color: rgba(255,255,255,.75); position: relative; z-index: 1; background: rgba(255,255,255,.1); padding: 4px 12px; border-radius: 100px; border: 1px solid rgba(255,255,255,.2); backdrop-filter: blur(4px); }
        .ph-plot       { background: linear-gradient(145deg,#0B2A1A,#1C7A40); }
        .ph-house      { background: linear-gradient(145deg,#1A0B2A,#6B2FA0); }
        .ph-colony     { background: linear-gradient(145deg,#0B1638,#1756A9); }
        .ph-township   { background: linear-gradient(145deg,#2A1A0B,#A05820); }
        .ph-commercial { background: linear-gradient(145deg,#1A1A1A,#404040); }
        .ph-default    { background: linear-gradient(145deg,#0B1638,#1756A9); }

        .prop-badge { position: absolute; top: 14px; left: 14px; padding: 4px 11px; border-radius: 100px; font-size: 10.5px; font-weight: 700; letter-spacing: .4px; z-index: 2; }
        .badge-hot { background: #EF4444; color: #fff; }
        .badge-new { background: #22C55E; color: #fff; }
        .badge-up  { background: var(--gold); color: #fff; }
        .badge-ft  { background: var(--ocean); color: #fff; }

        .prop-save { position: absolute; top: 14px; right: 14px; width: 32px; height: 32px; background: rgba(255,255,255,.9); border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 14px; cursor: pointer; transition: background .2s; z-index: 2; }
        .prop-save:hover { background: #fff; }

        .prop-body { padding: 20px; flex: 1; }
        .prop-type { font-size: 11px; font-weight: 700; color: var(--ocean); text-transform: uppercase; letter-spacing: 1px; margin-bottom: 6px; }
        .prop-name { font-family: 'Cormorant Garamond', serif; font-size: 20px; font-weight: 700; color: var(--navy); margin-bottom: 5px; line-height: 1.2; }
        .prop-loc { font-size: 12px; color: var(--slate); display: flex; align-items: center; gap: 5px; margin-bottom: 14px; }
        .prop-meta { display: grid; grid-template-columns: repeat(3,1fr); gap: 10px; padding-top: 14px; border-top: 1px solid var(--border); }
        .pm-item { display: flex; flex-direction: column; gap: 2px; }
        .pm-lbl { font-size: 9.5px; font-weight: 600; color: var(--slate); text-transform: uppercase; letter-spacing: .6px; }
        .pm-val { font-size: 13px; font-weight: 700; color: var(--navy); }

        .prop-footer { display: flex; justify-content: space-between; align-items: center; padding: 14px 20px; border-top: 1px solid var(--border); background: var(--mist); }
        .prop-price-lbl { font-size: 10.5px; color: var(--slate); }
        .prop-price { font-family: 'Cormorant Garamond', serif; font-size: 20px; font-weight: 700; color: var(--navy); }
        .btn-prop { padding: 8px 18px; background: var(--navy); color: #fff; border-radius: 8px; font-size: 12.5px; font-weight: 600; text-decoration: none; transition: background .2s; white-space: nowrap; }
        .btn-prop:hover { background: var(--ocean); }

        /* No results */
        .no-results { grid-column: 1/-1; text-align: center; padding: 80px 24px; color: var(--slate); }
        .no-results-icon { font-size: 56px; margin-bottom: 16px; }
        .no-results h3 { font-family: 'Cormorant Garamond', serif; font-size: 26px; color: var(--navy); margin-bottom: 8px; }

        /* Pagination */
        .pagination { display: flex; align-items: center; justify-content: center; gap: 8px; margin-top: 52px; flex-wrap: wrap; }
        .pg-btn { width: 38px; height: 38px; border-radius: 9px; border: 1.5px solid var(--border); background: #fff; font-size: 13px; font-weight: 600; color: var(--navy); cursor: pointer; transition: all .2s; display: flex; align-items: center; justify-content: center; font-family: 'Outfit', sans-serif; }
        .pg-btn:hover, .pg-btn.active { background: var(--navy); color: #fff; border-color: var(--navy); }
        .pg-btn.prev-next { width: auto; padding: 0 16px; }
        .pg-btn:disabled { opacity: .4; cursor: not-allowed; }

        /* Fade-in */
        .fade-in { opacity: 0; transform: translateY(20px); transition: opacity .55s ease, transform .55s ease; }
        .fade-in.visible { opacity: 1; transform: none; }

        /* ── RESPONSIVE ── */
        @media (max-width: 1024px) {
            .page-hero { padding: 100px 24px 52px; }
            .projects-page { padding: 48px 24px 64px; }
        }
        @media (max-width: 768px) {
            .page-hero { padding: 90px 18px 44px; }
            .projects-page { padding: 36px 18px 52px; }
            .filter-bar { flex-direction: column; align-items: stretch; }
            .fb-group { min-width: 100%; }
            .fb-btn, .fb-clear { width: 100%; text-align: center; }
            .properties-grid { grid-template-columns: 1fr; }
            .results-bar { flex-direction: column; align-items: flex-start; }
        }
        @media (max-width: 480px) {
            .pagination { gap: 5px; }
            .pg-btn { width: 34px; height: 34px; font-size: 12px; }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:HiddenField ID="hfPage" runat="server" Value="1" />

    <!-- PAGE HERO -->
    <div class="page-hero">
        <div class="page-hero-inner">
            <div class="page-hero-badge">
                <span class="page-hero-badge-dot"></span>
                Our Portfolio
            </div>
            <h1 class="page-hero-title">All <em>Projects</em></h1>
            <p class="page-hero-sub">Browse our complete portfolio of premium residential &amp; commercial developments across India.</p>
        </div>
    </div>

    <!-- MAIN -->
    <div class="projects-page">

        <!-- Filter Bar -->
        <div class="filter-bar">
            <div class="fb-group">
                <label>Search</label>
                <asp:TextBox ID="txtSearch" runat="server" placeholder="City, project name…" />
            </div>
            <div class="fb-group">
                <label>Type</label>
                <asp:DropDownList ID="ddlType" runat="server" ClientIDMode="Static" />
            </div>
            <div class="fb-group">
                <label>Status</label>
                <asp:DropDownList ID="ddlStatus" runat="server">
                    <asp:ListItem Value="">All Status</asp:ListItem>
                    <asp:ListItem Value="Active">Active</asp:ListItem>
                    <asp:ListItem Value="Upcoming">Upcoming</asp:ListItem>
                    <asp:ListItem Value="Pre-Launch">Pre-Launch</asp:ListItem>
                    <asp:ListItem Value="Sold Out">Sold Out</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="fb-group">
                <label>City</label>
                <asp:DropDownList ID="ddlCity" runat="server" ClientIDMode="Static" />
            </div>
            <asp:Button ID="btnSearch" runat="server" Text="🔍 Search" CssClass="fb-btn" OnClick="btnSearch_Click" />
            <button class="fb-clear" onclick="clearAll(); return false;">✕ Clear</button>
        </div>

        <!-- Results bar -->
        <div class="results-bar">
            <div class="results-count">
                Showing <strong><asp:Label ID="lblCount" runat="server" Text="0" /></strong> projects
            </div>
            <div class="sort-wrap">
                <label>Sort by</label>
                <asp:DropDownList ID="ddlSort" runat="server" OnSelectedIndexChanged="ddlSort_Changed" AutoPostBack="true">
                    <asp:ListItem Value="newest">Newest First</asp:ListItem>
                    <asp:ListItem Value="oldest">Oldest First</asp:ListItem>
                    <asp:ListItem Value="price_asc">Price: Low to High</asp:ListItem>
                    <asp:ListItem Value="price_desc">Price: High to Low</asp:ListItem>
                    <asp:ListItem Value="name">Name A–Z</asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>

        <!-- Grid -->
        <div class="properties-grid">

            <asp:Panel ID="pnlNoResults" runat="server" Visible="false" CssClass="no-results">
                <div class="no-results-icon">🏗️</div>
                <h3>No Projects Found</h3>
                <p>Try a different city or clear the filters.</p>
            </asp:Panel>

            <asp:Repeater ID="rptProjects" runat="server">
                <ItemTemplate>
                    <div class="prop-card fade-in">

                        <div class="prop-img">
                            <%# !string.IsNullOrEmpty(GetCoverUrl(Eval("CoverImagePath")))
                                ? string.Format("<img src='{0}' class='prop-img-real' alt='{1}' loading='lazy' />",
                                    GetCoverUrl(Eval("CoverImagePath")), Eval("ProjectName"))
                                : string.Format("<div class='prop-img-placeholder {0}'><span class='ph-emoji'>{1}</span><span class='ph-label'>{2}</span></div>",
                                    GetPlaceholderClass(Eval("TypeCode")),
                                    GetTypeEmoji(Eval("TypeCode")),
                                    Eval("ProjectType"))
                            %>
                            <span class="prop-badge <%# GetBadgeClass(Eval("StatusLabel")) %>">
                                <%# GetBadgeText(Eval("StatusLabel")) %>
                            </span>
                            <div class="prop-save" title="Save">♡</div>
                        </div>

                        <div class="prop-body">
                            <div class="prop-type"><%# GetTypeEmoji(Eval("TypeCode")) %> <%# Eval("ProjectType") %></div>
                            <div class="prop-name"><%# Eval("ProjectName") %></div>
                            <div class="prop-loc">📍 <%# Eval("City") %></div>
                            <div class="prop-meta">
                                <div class="pm-item">
                                    <div class="pm-lbl">Total Area</div>
                                    <div class="pm-val"><%# FormatArea(Eval("TotalLandAreaSqYd")) %></div>
                                </div>
                                <div class="pm-item">
                                    <div class="pm-lbl">Units</div>
                                    <div class="pm-val"><%# Eval("TotalUnits") %></div>
                                </div>
                                <div class="pm-item">
                                    <div class="pm-lbl">Status</div>
                                    <div class="pm-val" style="color:<%# GetStatusColor(Eval("StatusLabel")) %>">
                                        <%# Eval("StatusLabel") %>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="prop-footer">
                            <div>
                                <div class="prop-price-lbl">Starting From</div>
                                <div class="prop-price"><%# FormatPrice(Eval("MinPrice")) %></div>
                            </div>
                            <a href='<%# GetDetailUrl(Eval("ProjectID")) %>' class="btn-prop">View Details</a>
                        </div>

                    </div>
                </ItemTemplate>
            </asp:Repeater>

        </div>

        <!-- Pagination -->
        <div class="pagination">
            <asp:Literal ID="litPagination" runat="server" />
        </div>

    </div>

    <script>
        function goPage(n) {
            document.getElementById('<%= hfPage.ClientID %>').value = n;
            __doPostBack('<%= btnSearch.UniqueID %>', '');
        }

        function clearAll() {
            document.getElementById('<%= txtSearch.ClientID %>').value = '';
            document.getElementById('ddlType').selectedIndex = 0;
            document.getElementById('<%= ddlStatus.ClientID %>').selectedIndex = 0;
            document.getElementById('ddlCity').selectedIndex = 0;
            document.getElementById('<%= hfPage.ClientID %>').value = '1';
            __doPostBack('<%= btnSearch.UniqueID %>', '');
        }

        // Fade-in on scroll
        var obs = new IntersectionObserver(function (entries) {
            entries.forEach(function (e, i) {
                if (e.isIntersecting)
                    setTimeout(function () { e.target.classList.add('visible'); }, i * 70);
            });
        }, { threshold: 0.07 });
        document.querySelectorAll('.fade-in').forEach(function (el) { obs.observe(el); });

        // Wishlist heart
        document.querySelectorAll('.prop-save').forEach(function (btn) {
            btn.addEventListener('click', function (e) {
                e.stopPropagation();
                btn.textContent = btn.textContent.trim() === '♡' ? '❤️' : '♡';
            });
        });
    </script>

</asp:Content>
