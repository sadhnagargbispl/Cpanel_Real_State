<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.master" AutoEventWireup="true" CodeFile="property-detail.aspx.cs" Inherits="property_detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        :root {
            --navy: #0B1638;
            --ocean: #1756A9;
            --sky: #3B90F5;
            --gold: #E8A020;
            --cream: #FDF8F0;
            --white: #FFFFFF;
            --mist: #F1F5FB;
            --slate: #64748B;
            --border: #E2EAF5;
            --green: #16A34A;
            --red: #EF4444;
            --shadow: 0 4px 32px rgba(11,22,56,.10);
            --shadow-lg: 0 12px 56px rgba(11,22,56,.18);
            --r: 14px;
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        html { scroll-behavior: smooth; }
        body { font-family: 'Outfit', sans-serif; background: var(--cream); color: var(--navy); overflow-x: hidden; }

        /* ── BREADCRUMB ── */
        .breadcrumb-wrap { margin-top: 68px; background: var(--white); border-bottom: 1px solid var(--border); padding: 14px 48px; }
        .breadcrumb { max-width: 1280px; margin: 0 auto; display: flex; align-items: center; gap: 8px; font-size: 13px; color: var(--slate); flex-wrap: wrap; }
        .breadcrumb a { color: var(--slate); text-decoration: none; transition: color .2s; }
        .breadcrumb a:hover { color: var(--ocean); }
        .breadcrumb-sep { color: var(--border); }
        .breadcrumb-current { color: var(--navy); font-weight: 600; }

        /* ── GALLERY ── */
        .gallery-section { background: var(--white); }
        .gallery-inner { max-width: 1280px; margin: 0 auto; padding: 32px 48px 0; }
        .prop-title-row { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 20px; flex-wrap: wrap; gap: 16px; }
        .prop-badge-row { display: flex; gap: 8px; flex-wrap: wrap; margin-bottom: 10px; }
        .pbadge { display: inline-flex; align-items: center; gap: 5px; padding: 4px 12px; border-radius: 100px; font-size: 11px; font-weight: 700; letter-spacing: .4px; }
        .pbadge-hot    { background: #FEF2F2; color: var(--red);    border: 1px solid #FECACA; }
        .pbadge-active { background: #F0FDF4; color: #16A34A;       border: 1px solid #BBF7D0; }
        .pbadge-type   { background: var(--mist); color: var(--ocean); border: 1px solid var(--border); }
        .prop-main-title { font-family: 'Cormorant Garamond', serif; font-size: clamp(26px,4vw,46px); font-weight: 700; color: var(--navy); line-height: 1.1; margin-bottom: 8px; }
        .prop-location { display: flex; align-items: center; gap: 6px; font-size: 14px; color: var(--slate); }
        .prop-title-right { display: flex; flex-direction: column; align-items: flex-end; gap: 10px; }
        .prop-price-big { text-align: right; }
        .prop-price-lbl { font-size: 11px; color: var(--slate); text-transform: uppercase; letter-spacing: .8px; }
        .prop-price-val { font-family: 'Cormorant Garamond', serif; font-size: 36px; font-weight: 700; color: var(--navy); line-height: 1; }

        /* Gallery Grid */
        .gallery-grid { display: grid; grid-template-columns: 2fr 1fr; grid-template-rows: 280px 180px; gap: 8px; border-radius: var(--r); overflow: hidden; }
        .gallery-main  { grid-row: span 2; position: relative; overflow: hidden; cursor: pointer; }
        .gallery-thumb { position: relative; overflow: hidden; cursor: pointer; }
        .gallery-img   { width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; overflow: hidden; }
        .gallery-img img { width: 100%; height: 100%; object-fit: cover; transition: transform .4s; }
        .gallery-img:hover img { transform: scale(1.06); }
        .gallery-overlay { position: absolute; inset: 0; background: linear-gradient(180deg,transparent 50%,rgba(0,0,0,.45)); opacity: 0; transition: opacity .3s; pointer-events: none; }
        .gallery-main:hover .gallery-overlay, .gallery-thumb:hover .gallery-overlay { opacity: 1; }
        .gallery-count { position: absolute; bottom: 16px; right: 16px; background: rgba(0,0,0,.65); color: #fff; font-size: 12px; font-weight: 600; padding: 6px 14px; border-radius: 100px; backdrop-filter: blur(4px); }

        /* ── DETAIL BODY ── */
        .detail-body { max-width: 1280px; margin: 0 auto; padding: 44px 48px 80px; }
        .detail-layout { display: grid; grid-template-columns: 1fr 360px; gap: 36px; align-items: start; }

        /* Quick Stats */
        .qs-strip { display: grid; grid-template-columns: repeat(4,1fr); background: var(--white); border: 1px solid var(--border); border-radius: var(--r); overflow: hidden; box-shadow: var(--shadow); margin-bottom: 32px; }
        .qs-item { padding: 20px; text-align: center; border-right: 1px solid var(--border); }
        .qs-item:last-child { border-right: none; }
        .qs-icon { font-size: 22px; margin-bottom: 6px; }
        .qs-val  { font-family: 'Cormorant Garamond', serif; font-size: 20px; font-weight: 700; color: var(--navy); }
        .qs-lbl  { font-size: 11px; color: var(--slate); text-transform: uppercase; letter-spacing: .7px; margin-top: 3px; }

        /* Tabs */
        .tab-nav { display: flex; gap: 4px; background: var(--mist); border-radius: 10px; padding: 4px; margin-bottom: 24px; border: 1px solid var(--border); }
        .tab-btn { flex: 1; padding: 9px 8px; border: none; border-radius: 8px; background: transparent; font-size: 13px; font-weight: 500; color: var(--slate); cursor: pointer; transition: all .2s; font-family: 'Outfit', sans-serif; }
        .tab-btn.active { background: var(--white); color: var(--navy); font-weight: 700; box-shadow: var(--shadow); }
        .tab-pane { display: none; }
        .tab-pane.active { display: block; }

        /* Detail Sections */
        .detail-section { background: var(--white); border: 1px solid var(--border); border-radius: var(--r); padding: 30px; box-shadow: var(--shadow); margin-bottom: 24px; }
        .ds-title { font-family: 'Cormorant Garamond', serif; font-size: 22px; font-weight: 700; color: var(--navy); margin-bottom: 18px; padding-bottom: 14px; border-bottom: 1px solid var(--border); display: flex; align-items: center; gap: 10px; }
        .overview-text { font-size: 14.5px; color: var(--slate); line-height: 1.85; }
        .overview-text p { margin-bottom: 12px; }
        .overview-text p:last-child { margin-bottom: 0; }

        /* Details Grid */
        .details-grid { display: grid; grid-template-columns: repeat(3,1fr); gap: 16px; }
        .dg-item { background: var(--mist); border-radius: 10px; padding: 16px; }
        .dg-lbl  { font-size: 10.5px; font-weight: 700; text-transform: uppercase; letter-spacing: .8px; color: var(--slate); margin-bottom: 5px; }
        .dg-val  { font-size: 15px; font-weight: 700; color: var(--navy); }

        /* Amenities */
        .amenities-grid { display: grid; grid-template-columns: repeat(4,1fr); gap: 12px; }
        .am-item { display: flex; flex-direction: column; align-items: center; gap: 8px; padding: 16px 10px; background: var(--mist); border-radius: 12px; text-align: center; border: 1px solid transparent; transition: all .25s; }
        .am-item:hover { border-color: var(--ocean); background: #EFF6FF; transform: translateY(-2px); }
        .am-icon { font-size: 24px; }
        .am-name { font-size: 11.5px; font-weight: 600; color: var(--navy); }

        /* Map */
        .map-placeholder { height: 280px; border-radius: 12px; overflow: hidden; background: linear-gradient(135deg,#EFF6FF,#DBEAFE); display: flex; flex-direction: column; align-items: center; justify-content: center; color: var(--ocean); font-size: 14px; font-weight: 500; gap: 10px; border: 1px solid var(--border); position: relative; }
        .map-pin { position: absolute; top: 50%; left: 50%; transform: translate(-50%,-60%); background: var(--gold); width: 36px; height: 36px; border-radius: 50% 50% 50% 0; rotate: -45deg; display: flex; align-items: center; justify-content: center; box-shadow: 0 4px 12px rgba(232,160,32,.5); animation: pinBounce 2s ease-in-out infinite; }
        @keyframes pinBounce { 0%,100%{transform:translate(-50%,-60%) rotate(-45deg)} 50%{transform:translate(-50%,-72%) rotate(-45deg)} }
        .map-pin-inner { font-size: 16px; rotate: 45deg; }
        .map-address { position: absolute; bottom: 20px; left: 50%; transform: translateX(-50%); background: rgba(255,255,255,.95); padding: 8px 16px; border-radius: 100px; font-size: 12.5px; font-weight: 600; color: var(--navy); white-space: nowrap; box-shadow: var(--shadow); }

        /* Payment Table */
        .payment-table { width: 100%; border-collapse: collapse; }
        .payment-table th { background: var(--navy); color: #fff; padding: 12px 16px; font-size: 12px; font-weight: 600; text-align: left; text-transform: uppercase; letter-spacing: .6px; }
        .payment-table th:first-child { border-radius: 8px 0 0 0; }
        .payment-table th:last-child  { border-radius: 0 8px 0 0; }
        .payment-table td { padding: 12px 16px; font-size: 13.5px; color: var(--navy); border-bottom: 1px solid var(--border); }
        .payment-table tr:last-child td { border-bottom: none; }
        .payment-table tr:nth-child(even) td { background: var(--mist); }
        .pt-highlight { color: var(--ocean); font-weight: 700; }
        .no-payment { text-align: center; padding: 32px; color: var(--slate); font-size: 14px; }

        /* Similar Grid */
        .similar-grid { display: grid; grid-template-columns: repeat(3,1fr); gap: 20px; }
        .sim-card { background: var(--mist); border-radius: 12px; overflow: hidden; border: 1px solid var(--border); transition: all .3s; cursor: pointer; }
        .sim-card:hover { transform: translateY(-4px); box-shadow: var(--shadow-lg); }
        .sim-img  { height: 140px; display: flex; align-items: center; justify-content: center; font-size: 44px; }
        .sim-body { padding: 14px; }
        .sim-name  { font-family: 'Cormorant Garamond', serif; font-size: 16px; font-weight: 700; color: var(--navy); margin-bottom: 4px; }
        .sim-loc   { font-size: 12px; color: var(--slate); margin-bottom: 10px; }
        .sim-price { font-family: 'Cormorant Garamond', serif; font-size: 18px; font-weight: 700; color: var(--navy); }

        /* RIGHT SIDEBAR */
        .detail-right { position: sticky; top: 88px; display: flex; flex-direction: column; gap: 20px; }
        .highlights-card { background: linear-gradient(135deg,var(--navy),#1E3A8A); border-radius: var(--r); padding: 26px; color: #fff; }
        .hc-title { font-family: 'Cormorant Garamond', serif; font-size: 18px; font-weight: 700; margin-bottom: 18px; }
        .hc-item { display: flex; align-items: flex-start; gap: 10px; margin-bottom: 14px; }
        .hc-item:last-child { margin-bottom: 0; }
        .hc-dot  { width: 8px; height: 8px; background: var(--gold); border-radius: 50%; flex-shrink: 0; margin-top: 5px; }
        .hc-text { font-size: 13px; color: rgba(255,255,255,.8); line-height: 1.55; }
        .share-card { background: var(--white); border: 1px solid var(--border); border-radius: var(--r); padding: 22px; box-shadow: var(--shadow); }
        .sc-title { font-size: 14px; font-weight: 700; color: var(--navy); margin-bottom: 14px; }
        .sc-btns  { display: flex; gap: 10px; flex-wrap: wrap; }
        .sc-btn   { flex: 1; min-width: 70px; padding: 9px 10px; border-radius: 9px; border: 1.5px solid var(--border); background: var(--mist); font-size: 12.5px; font-weight: 600; color: var(--navy); cursor: pointer; text-align: center; transition: all .2s; font-family: 'Outfit', sans-serif; }
        .sc-btn:hover { background: var(--navy); color: #fff; border-color: var(--navy); }

        /* ── LIGHTBOX ── */
        .lightbox { display: none; position: fixed; inset: 0; background: rgba(0,0,0,.94); z-index: 9999; align-items: center; justify-content: center; }
        .lightbox.open { display: flex; }
        .lb-inner { position: relative; max-width: 900px; width: 90%; }
        .lb-img   { width: 100%; height: 520px; border-radius: var(--r); overflow: hidden; background: #111; position: relative; }
        .lb-img img { width: 100%; height: 100%; object-fit: contain; }
        .lb-caption { position: absolute; bottom: 0; left: 0; right: 0; background: rgba(0,0,0,.6); color: #fff; font-size: 12.5px; padding: 8px 16px; text-align: center; backdrop-filter: blur(4px); }
        .lb-close   { position: absolute; top: -14px; right: -14px; width: 36px; height: 36px; background: var(--gold); border-radius: 50%; border: none; color: #fff; font-size: 18px; cursor: pointer; display: flex; align-items: center; justify-content: center; transition: background .2s; z-index: 10; }
        .lb-close:hover { background: var(--red); }
        .lb-counter { position: absolute; top: -36px; left: 0; color: rgba(255,255,255,.7); font-size: 13px; font-weight: 600; }
        .lb-arrow   { position: absolute; top: 50%; transform: translateY(-50%); background: rgba(255,255,255,.15); border: none; color: #fff; font-size: 26px; width: 44px; height: 44px; border-radius: 50%; cursor: pointer; backdrop-filter: blur(4px); transition: background .2s; display: flex; align-items: center; justify-content: center; }
        .lb-arrow:hover { background: rgba(255,255,255,.3); }
        .lb-arrow-prev { left: -56px; }
        .lb-arrow-next { right: -56px; }
        .lb-nav  { display: flex; justify-content: center; gap: 8px; margin-top: 16px; flex-wrap: wrap; }
        .lb-dot  { width: 8px; height: 8px; border-radius: 50%; background: rgba(255,255,255,.3); cursor: pointer; transition: background .2s; flex-shrink: 0; }
        .lb-dot.active { background: var(--gold); }
        .lb-thumbs { display: flex; gap: 8px; margin-top: 12px; overflow-x: auto; padding-bottom: 4px; scroll-behavior: smooth; }
        .lb-thumbs::-webkit-scrollbar { height: 4px; }
        .lb-thumbs::-webkit-scrollbar-thumb { background: var(--gold); border-radius: 2px; }
        .lb-thumb-item { flex-shrink: 0; width: 72px; height: 52px; border-radius: 6px; overflow: hidden; cursor: pointer; border: 2px solid transparent; transition: border-color .2s, opacity .2s; opacity: .6; }
        .lb-thumb-item:hover { opacity: 1; }
        .lb-thumb-item.active { border-color: var(--gold); opacity: 1; }
        .lb-thumb-item img { width: 100%; height: 100%; object-fit: cover; }

        /* Footer */
        footer { background: #080F2A; padding: 56px 48px 24px; }
        .ft-grid { display: grid; grid-template-columns: 2fr 1fr 1fr 1fr; gap: 48px; margin-bottom: 40px; }
        .ft-logo { display: flex; align-items: center; gap: 10px; margin-bottom: 14px; }
        .ft-desc { font-size: 13px; color: rgba(255,255,255,.45); line-height: 1.75; max-width: 280px; margin-bottom: 18px; }
        .ft-socials { display: flex; gap: 10px; }
        .ft-social { width: 36px; height: 36px; border-radius: 9px; background: rgba(255,255,255,.07); border: 1px solid rgba(255,255,255,.1); display: flex; align-items: center; justify-content: center; color: rgba(255,255,255,.55); font-size: 14px; text-decoration: none; transition: all .2s; }
        .ft-social:hover { background: var(--gold); color: #fff; border-color: var(--gold); }
        .ft-col-title { font-family: 'Cormorant Garamond', serif; font-size: 16px; font-weight: 700; color: #fff; margin-bottom: 16px; }
        .ft-links { display: flex; flex-direction: column; gap: 9px; }
        .ft-links a { font-size: 13px; color: rgba(255,255,255,.45); text-decoration: none; transition: color .2s; }
        .ft-links a:hover { color: var(--gold); }
        .ft-contact-item { display: flex; align-items: flex-start; gap: 9px; margin-bottom: 10px; }
        .ft-ci { font-size: 15px; flex-shrink: 0; }
        .ft-ct { font-size: 12.5px; color: rgba(255,255,255,.45); line-height: 1.5; }
        .ft-bottom { border-top: 1px solid rgba(255,255,255,.07); padding-top: 22px; display: flex; justify-content: space-between; flex-wrap: wrap; gap: 10px; }
        .ft-copy   { font-size: 12.5px; color: rgba(255,255,255,.3); }
        .ft-blinks { display: flex; gap: 20px; }
        .ft-blinks a { font-size: 12.5px; color: rgba(255,255,255,.3); text-decoration: none; }
        .ft-blinks a:hover { color: var(--gold); }

        /* Animations */
        .fade-in { opacity: 0; transform: translateY(18px); transition: opacity .55s ease, transform .55s ease; }
        .fade-in.visible { opacity: 1; transform: none; }

        /* ── RESPONSIVE ── */
        @media (max-width: 1100px) {
            .detail-layout { grid-template-columns: 1fr; }
            .detail-right { position: static; }
            .breadcrumb-wrap, .gallery-inner { padding-left: 24px; padding-right: 24px; }
            .detail-body { padding: 36px 24px 60px; }
            .similar-grid { grid-template-columns: repeat(3,1fr); }
            .ft-grid { grid-template-columns: 1fr 1fr; gap: 32px; }
            footer { padding: 48px 24px 20px; }
        }
        @media (max-width: 900px) {
            .gallery-grid { grid-template-columns: 1fr 1fr; grid-template-rows: 220px; }
            .gallery-main { grid-row: span 1; }
            .gallery-thumb:nth-child(3) { display: none; }
            .qs-strip { grid-template-columns: repeat(2,1fr); }
            .qs-item:nth-child(2) { border-right: none; }
            .qs-item:nth-child(3), .qs-item:nth-child(4) { border-top: 1px solid var(--border); }
            .qs-item:nth-child(4) { border-right: none; }
            .details-grid { grid-template-columns: repeat(2,1fr); }
            .amenities-grid { grid-template-columns: repeat(3,1fr); }
            .similar-grid { grid-template-columns: repeat(2,1fr); }
            .lb-arrow-prev { left: -12px; }
            .lb-arrow-next { right: -12px; }
        }
        @media (max-width: 768px) {
            .breadcrumb-wrap { padding: 12px 18px; margin-top: 60px; }
            .gallery-inner { padding: 18px 18px 0; }
            .gallery-grid { grid-template-columns: 1fr; grid-template-rows: 240px; height: 240px; }
            .gallery-thumb { display: none; }
            .gallery-main { grid-row: span 1; }
            .prop-title-row { flex-direction: column; }
            .prop-title-right { align-items: flex-start; }
            .prop-price-big { text-align: left; }
            .detail-body { padding: 24px 18px 52px; }
            .qs-strip { grid-template-columns: repeat(2,1fr); }
            .qs-item:nth-child(2) { border-right: none; }
            .qs-item:nth-child(3), .qs-item:nth-child(4) { border-top: 1px solid var(--border); }
            .qs-item:nth-child(4) { border-right: none; }
            .details-grid { grid-template-columns: 1fr 1fr; }
            .amenities-grid { grid-template-columns: repeat(3,1fr); }
            .similar-grid { grid-template-columns: 1fr 1fr; }
            .payment-table th, .payment-table td { padding: 10px 12px; font-size: 12.5px; }
            .tab-btn { font-size: 12px; padding: 8px 6px; }
            .ft-grid { grid-template-columns: 1fr; gap: 24px; }
            footer { padding: 44px 18px 18px; }
            .ft-bottom { flex-direction: column; }
            .lb-img { height: 280px; }
            .lb-arrow-prev { left: 4px; width: 36px; height: 36px; font-size: 20px; }
            .lb-arrow-next { right: 4px; width: 36px; height: 36px; font-size: 20px; }
            .lb-thumbs { display: none; }
        }
        @media (max-width: 480px) {
            .amenities-grid { grid-template-columns: repeat(3,1fr); }
            .details-grid { grid-template-columns: 1fr; }
            .similar-grid { grid-template-columns: 1fr; }
            .prop-price-val { font-size: 28px; }
            .qs-val { font-size: 17px; }
            .tab-nav { flex-wrap: wrap; }
            .tab-btn { flex: none; width: calc(50% - 4px); }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <%-- ══════════════════════════════════════════════════════════
         Gallery images JSON — populated by LoadGallery() in code-behind
         galleryImages array is consumed by the lightbox JS below
    ══════════════════════════════════════════════════════════ --%>
    <script>
        var galleryImages = <asp:Literal ID="litGalleryJson" runat="server" Text="[]" />;
    </script>

    <!-- BREADCRUMB -->
    <div class="breadcrumb-wrap">
        <div class="breadcrumb">
            <a href="Index.aspx">🏠 Home</a>
            <span class="breadcrumb-sep">›</span>
            <a href="property-search.aspx">Properties</a>
            <span class="breadcrumb-sep">›</span>
            <a href='<%# "property-search.aspx?location=" + litCityName.Text %>'>
                <asp:Literal ID="litCityName" runat="server" /></a>
            <span class="breadcrumb-sep">›</span>
            <span class="breadcrumb-current"><asp:Literal ID="litPropertyName" runat="server" /></span>
        </div>
    </div>

    <!-- GALLERY + TITLE -->
    <div class="gallery-section">
        <div class="gallery-inner">

            <div class="prop-title-row">
                <div class="prop-title-left">
                    <div class="prop-badge-row">
                        <asp:Literal ID="litStatusBadge" runat="server" />
                        <span class="pbadge pbadge-type">🏘️ <asp:Literal ID="litTypeBadge" runat="server" /></span>
                    </div>
                    <h1 class="prop-main-title"><asp:Literal ID="litMainTitle" runat="server" /></h1>
                    <div class="prop-location">
                        📍
                        <span>
                            <asp:Literal ID="litLocation" runat="server" /> —
                            <a href="#location" style="color:var(--ocean);font-weight:600;text-decoration:none;">View on Map</a>
                        </span>
                    </div>
                </div>
                <div class="prop-title-right">
                    <div class="prop-price-big">
                        <div class="prop-price-lbl">Starting From</div>
                        <div class="prop-price-val"><asp:Literal ID="litMinPrice" runat="server" /></div>
                    </div>
                </div>
            </div>

            <!-- Gallery Grid (3 cells: 1 big cover + 2 thumbs) -->
            <div class="gallery-grid">

                <%-- ── COVER (index 0 from DB) ── --%>
                <div class="gallery-main" onclick="openLightbox(0)">
                    <div class="gallery-img">
                        <asp:Literal ID="litCoverImage" runat="server" />
                    </div>
                    <div class="gallery-overlay"></div>
                    <div class="gallery-count">
                        📷 <asp:Literal ID="litPhotoCount" runat="server" Text="View All Photos" />
                    </div>
                </div>

                <%-- ── THUMB 1 (index 1 from DB) ── --%>
                <div class="gallery-thumb" onclick="openLightbox(1)">
                    <div class="gallery-img" style="background:linear-gradient(135deg,#1756A9,#3B90F5)">
                        <%-- litThumb1 renders DB image; if empty, emoji below shows --%>
                        <asp:Literal ID="litThumb1" runat="server" />
                        <asp:Literal ID="litThumb1Fallback" runat="server" />
                    </div>
                    <div class="gallery-overlay"></div>
                </div>

                <%-- ── THUMB 2 (index 2 from DB) ── --%>
                <div class="gallery-thumb" onclick="openLightbox(2)">
                    <div class="gallery-img" style="background:linear-gradient(135deg,#0F766E,#14B8A6)">
                        <asp:Literal ID="litThumb2" runat="server" />
                        <asp:Literal ID="litThumb2Fallback" runat="server" />
                    </div>
                    <div class="gallery-overlay"></div>
                </div>

            </div>
        </div>
    </div>

    <!-- DETAIL BODY -->
    <div class="detail-body">
        <div class="detail-layout">

            <!-- LEFT -->
            <div class="detail-left">

                <!-- Quick Stats -->
                <div class="qs-strip fade-in">
                    <div class="qs-item">
                        <div class="qs-icon">📐</div>
                        <div class="qs-val"><asp:Literal ID="litTotalArea" runat="server" Text="—" /></div>
                        <div class="qs-lbl">Total Area</div>
                    </div>
                    <div class="qs-item">
                        <div class="qs-icon">🏘️</div>
                        <div class="qs-val"><asp:Literal ID="litTotalUnits" runat="server" Text="—" /></div>
                        <div class="qs-lbl">Total Units</div>
                    </div>
                    <div class="qs-item">
                        <div class="qs-icon">📅</div>
                        <div class="qs-val"><asp:Literal ID="litLaunchDate" runat="server" Text="—" /></div>
                        <div class="qs-lbl">Launch Date</div>
                    </div>
                    <div class="qs-item">
                        <div class="qs-icon">✅</div>
                        <div class="qs-val" style="color:var(--green)"><asp:Literal ID="litStatusVal" runat="server" Text="—" /></div>
                        <div class="qs-lbl">Status</div>
                    </div>
                </div>

                <!-- Tabs -->
                <div class="tab-nav" role="tablist">
                    <button type="button" class="tab-btn active" onclick="switchTab(this,'overview')">📋 Overview</button>
                    <button type="button" class="tab-btn" onclick="switchTab(this,'details')">🔍 Details</button>
                    <button type="button" class="tab-btn" onclick="switchTab(this,'amenities')">🌿 Amenities</button>
                  <%--  <button type="button" class="tab-btn" onclick="switchTab(this,'payment')">💳 Payment Plan</button>--%>
                    <button type="button" class="tab-btn" onclick="switchTab(this,'location')">📍 Location</button>
                </div>

                <!-- OVERVIEW -->
                <div class="tab-pane active" id="tab-overview">
                    <div class="detail-section fade-in">
                        <div class="ds-title">📋 Project Overview</div>
                        <div class="overview-text"><asp:Literal ID="litDescription" runat="server" /></div>
                    </div>
                </div>

                <!-- DETAILS -->
                <div class="tab-pane" id="tab-details">
                    <div class="detail-section fade-in">
                        <div class="ds-title">🔍 Property Details</div>
                        <div class="details-grid">
                            <div class="dg-item"><div class="dg-lbl">Project Type</div><div class="dg-val"><asp:Literal ID="litProjectType" runat="server" /></div></div>
                            <div class="dg-item"><div class="dg-lbl">Total Area</div><div class="dg-val"><asp:Literal ID="litAreaDetail" runat="server" /></div></div>
                            <div class="dg-item"><div class="dg-lbl">Total Units</div><div class="dg-val"><asp:Literal ID="litUnitsDetail" runat="server" /></div></div>
                            <div class="dg-item"><div class="dg-lbl">Plot Sizes</div><div class="dg-val"><asp:Literal ID="litPlotSizes" runat="server" /></div></div>
                            <div class="dg-item"><div class="dg-lbl">Launch Date</div><div class="dg-val"><asp:Literal ID="litLaunchDetail" runat="server" /></div></div>
                            <div class="dg-item"><div class="dg-lbl">Possession</div><div class="dg-val"><asp:Literal ID="litPossession" runat="server" Text="—" /></div></div>
                            <div class="dg-item"><div class="dg-lbl">Status</div><div class="dg-val" style="color:var(--green)"><asp:Literal ID="litStatusDetail" runat="server" /></div></div>
                            <div class="dg-item"><div class="dg-lbl">Location</div><div class="dg-val"><asp:Literal ID="litLocationDetail" runat="server" /></div></div>
                            <div class="dg-item"><div class="dg-lbl">Developer</div><div class="dg-val"><asp:Literal ID="litDeveloper" runat="server" /></div></div>
                            <div class="dg-item"><div class="dg-lbl">Approval</div><div class="dg-val"><asp:Literal ID="litApproval" runat="server" Text="—" /></div></div>
                            <div class="dg-item"><div class="dg-lbl">Road Width</div><div class="dg-val"><asp:Literal ID="litRoadWidth" runat="server" /></div></div>
                            <div class="dg-item"><div class="dg-lbl">Registry</div><div class="dg-val"><asp:Literal ID="litRegistry" runat="server" Text="—" /></div></div>
                        </div>
                    </div>
                </div>

                <!-- AMENITIES -->
                <div class="tab-pane" id="tab-amenities">
                    <div class="detail-section fade-in">
                        <div class="ds-title">🌿 World-Class Amenities</div>
                        <div class="amenities-grid">
                            <div class="am-item"><span class="am-icon">🔒</span><span class="am-name">Gated Security</span></div>
                            <div class="am-item"><span class="am-icon">🌳</span><span class="am-name">Parks & Gardens</span></div>
                            <div class="am-item"><span class="am-icon">🕌</span><span class="am-name">Mosque</span></div>
                            <div class="am-item"><span class="am-icon">🏫</span><span class="am-name">School Zone</span></div>
                            <div class="am-item"><span class="am-icon">🏥</span><span class="am-name">Medical Center</span></div>
                            <div class="am-item"><span class="am-icon">🛒</span><span class="am-name">Shopping Mall</span></div>
                            <div class="am-item"><span class="am-icon">💡</span><span class="am-name">Underground Electric</span></div>
                            <div class="am-item"><span class="am-icon">💧</span><span class="am-name">Water Supply</span></div>
                            <div class="am-item"><span class="am-icon">🏊</span><span class="am-name">Swimming Pool</span></div>
                            <div class="am-item"><span class="am-icon">🏃</span><span class="am-name">Jogging Track</span></div>
                            <div class="am-item"><span class="am-icon">⛽</span><span class="am-name">Natural Gas</span></div>
                            <div class="am-item"><span class="am-icon">🚗</span><span class="am-name">Wide Roads</span></div>
                            <div class="am-item"><span class="am-icon">📡</span><span class="am-name">Fibre Internet</span></div>
                            <div class="am-item"><span class="am-icon">🎠</span><span class="am-name">Kids Play Area</span></div>
                            <div class="am-item"><span class="am-icon">🏋️</span><span class="am-name">Gym & Fitness</span></div>
                            <div class="am-item"><span class="am-icon">🌙</span><span class="am-name">Street Lighting</span></div>
                        </div>
                    </div>
                </div>

                <!-- PAYMENT PLAN -->
                <div class="tab-pane" id="tab-payment">
                    <div class="detail-section fade-in">
                        <div class="ds-title">💳 Payment Plan</div>
                        <asp:Repeater ID="rptPayment" runat="server" OnItemDataBound="rptPayment_ItemDataBound">
                            <HeaderTemplate>
                                <table class="payment-table">
                                    <thead>
                                        <tr>
                                            <th>Plot Size</th>
                                            <th>Total Price</th>
                                            <th>Booking Amount</th>
                                            <th>Monthly Installment</th>
                                            <th>Duration</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("UnitTypeName") %></td>
                                    <td class="pt-highlight"><%# FormatPrice(Eval("TotalBasePrice")) %></td>
                                    <td><%# FormatPrice(Eval("BookingAmount")) %></td>
                                    <td><%# FormatPrice(Eval("MonthlyInstallment")) %></td>
                                    <td><%# Eval("InstallmentMonths") %> Months</td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                    </tbody>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                        <asp:Panel ID="pnlNoPayment" runat="server" Visible="false">
                            <div class="no-payment">💳 Payment plan details coming soon. Please contact our agent for pricing.</div>
                        </asp:Panel>
                        <p style="font-size:12px;color:var(--slate);margin-top:14px;line-height:1.6;">
                            * Prices are subject to change. Possession &amp; development charges may apply. Contact our agent for current pricing.
                        </p>
                    </div>
                </div>

                <!-- LOCATION -->
                <div class="tab-pane" id="tab-location">
                    <div class="detail-section fade-in" id="location">
                        <div class="ds-title">📍 Location & Connectivity</div>
                        <div class="map-placeholder">
                            <div class="map-pin"><span class="map-pin-inner">📍</span></div>
                            <div class="map-address"><asp:Literal ID="litMapAddress" runat="server" /></div>
                        </div>
                        <div class="details-grid" style="margin-top:20px">
                            <div class="dg-item"><div class="dg-lbl">Ring Road</div><div class="dg-val">5 min drive</div></div>
                            <div class="dg-item"><div class="dg-lbl">Airport</div><div class="dg-val"><asp:Literal ID="litAirportDist" runat="server" Text="25 min drive" /></div></div>
                            <div class="dg-item"><div class="dg-lbl">Metro Station</div><div class="dg-val"><asp:Literal ID="litMetroDist" runat="server" Text="3 km away" /></div></div>
                            <div class="dg-item"><div class="dg-lbl">City Center</div><div class="dg-val"><asp:Literal ID="litCityDist" runat="server" Text="18 km" /></div></div>
                            <div class="dg-item"><div class="dg-lbl">Top School</div><div class="dg-val"><asp:Literal ID="litSchoolDist" runat="server" Text="2 km away" /></div></div>
                            <div class="dg-item"><div class="dg-lbl">Hospital</div><div class="dg-val"><asp:Literal ID="litHospitalDist" runat="server" Text="4 km away" /></div></div>
                        </div>
                    </div>
                </div>

                <!-- Similar Properties -->
                <div class="detail-section fade-in">
                    <div class="ds-title">🏠 Similar Properties</div>
                    <div class="similar-grid">
                        <asp:Repeater ID="rptSimilar" runat="server">
                            <ItemTemplate>
                                <div class="sim-card" onclick="location.href='property-detail.aspx?id=<%# Eval("ProjectID") %>'">
                                    <div class="sim-img" style="background:linear-gradient(135deg,#0B1638,#1756A9)">
                                        <%# GetTypeEmoji(Eval("TypeCode")) %>
                                    </div>
                                    <div class="sim-body">
                                        <div class="sim-name"><%# Eval("ProjectName") %></div>
                                        <div class="sim-loc">📍 <%# Eval("City") %></div>
                                        <div class="sim-price"><%# FormatPrice(Eval("MinPrice")) %></div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>

            </div>
            <!-- /detail-left -->

            <!-- RIGHT SIDEBAR -->
            <div class="detail-right" id="contact-form">
                <div class="highlights-card fade-in">
                    <div class="hc-title">⭐ Why Choose This Project?</div>
                    <div class="hc-item"><div class="hc-dot"></div><div class="hc-text">NOC approved — 100% legal &amp; secure investment</div></div>
                    <div class="hc-item"><div class="hc-dot"></div><div class="hc-text">4-year easy installment plan with just 10% booking</div></div>
                    <div class="hc-item"><div class="hc-dot"></div><div class="hc-text">Located on India's fastest-growing real estate corridor</div></div>
                    <div class="hc-item"><div class="hc-dot"></div><div class="hc-text">Underground utilities — no aerial wires or cables</div></div>
                    <div class="hc-item"><div class="hc-dot"></div><div class="hc-text">On-track delivery — possession as scheduled</div></div>
                    <div class="hc-item"><div class="hc-dot"></div><div class="hc-text">30%+ capital appreciation expected in 3 years</div></div>
                </div>
                <div class="share-card fade-in">
                    <div class="sc-title">🔗 Share This Property</div>
                    <div class="sc-btns">
                        <button class="sc-btn" onclick="shareWhatsApp()">WhatsApp</button>
                        <button class="sc-btn" onclick="shareFacebook()">Facebook</button>
                        <button class="sc-btn" onclick="shareLinkedIn()">LinkedIn</button>
                        <button class="sc-btn" onclick="copyLink()">Copy Link</button>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <!-- ══════════════════════════════════════════════════════════
         LIGHTBOX — DB-powered, full gallery from ProjectGallery
    ══════════════════════════════════════════════════════════ -->
    <div class="lightbox" id="lightbox" onclick="closeLightboxOuter(event)">
        <div class="lb-inner">

            <button class="lb-close" onclick="closeLightbox()" title="Close">✕</button>
            <div class="lb-counter" id="lbCounter"></div>

            <div class="lb-img" id="lbImgBox">
                <img id="lbMainImg" src="" alt="" style="width:100%;height:100%;object-fit:contain;" />
                <div class="lb-caption" id="lbCaption" style="display:none;"></div>
            </div>

           <%-- <button  class="lb-arrow lb-arrow-prev" onclick="lbPrev()" title="Previous">&#8249;</button>
            <button class="lb-arrow lb-arrow-next" onclick="lbNext()" title="Next">&#8250;</button>--%>
               <button type="button" class="lb-arrow lb-arrow-prev" onclick="lbPrev()" title="Previous">&#8249;</button>
   <button type="button" class="lb-arrow lb-arrow-next" onclick="lbNext()" title="Next">&#8250;</button>

            <div class="lb-nav"    id="lbDots"></div>
            <div class="lb-thumbs" id="lbThumbs"></div>
        </div>
    </div>

    <!-- FOOTER -->
    <footer>
        <div style="max-width:1280px;margin:0 auto;">
            <div class="ft-grid">
                <div>
                    <div class="ft-logo">
                        <div style="width:38px;height:38px;border-radius:50%;background:linear-gradient(135deg,var(--navy),var(--ocean));display:flex;align-items:center;justify-content:center;font-family:'Cormorant Garamond',serif;font-size:16px;font-weight:700;color:var(--gold);">SI</div>
                        <div style="display:flex;flex-direction:column;line-height:1.1;">
                            <strong style="font-size:13px;color:#fff;">Sky Is Your Limit</strong>
                            <span style="font-size:9px;color:rgba(255,255,255,.4);letter-spacing:1.2px;text-transform:uppercase;">Premium Real Estate</span>
                        </div>
                    </div>
                    <p class="ft-desc">India's most trusted real estate platform connecting buyers with premium properties across 18 cities.</p>
                    <div class="ft-socials">
                        <a href="#" class="ft-social">f</a>
                        <a href="#" class="ft-social">in</a>
                        <a href="#" class="ft-social">tw</a>
                        <a href="#" class="ft-social">yt</a>
                    </div>
                </div>
                <div>
                    <div class="ft-col-title">Quick Links</div>
                    <div class="ft-links">
                        <a href="#">Home</a>
                        <a href="property-search.aspx">All Properties</a>
                        <a href="#">About Us</a>
                        <a href="#">Agents</a>
                    </div>
                </div>
                <div>
                    <div class="ft-col-title">Property Types</div>
                    <div class="ft-links">
                        <a href="#">Residential Plots</a>
                        <a href="#">Townships</a>
                        <a href="#">Commercial</a>
                        <a href="#">Houses &amp; Villas</a>
                    </div>
                </div>
                <div>
                    <div class="ft-col-title">Contact Us</div>
                    <div class="ft-contact-item"><span class="ft-ci">📍</span><span class="ft-ct">Sky Tower, Connaught Place, New Delhi 110001</span></div>
                    <div class="ft-contact-item"><span class="ft-ci">📞</span><span class="ft-ct">+91 300 1234567</span></div>
                    <div class="ft-contact-item"><span class="ft-ci">✉️</span><span class="ft-ct">info@skyisyourlimit.com</span></div>
                </div>
            </div>
            <div class="ft-bottom">
                <span class="ft-copy">© 2025 Sky Is Your Limit Group. All rights reserved.</span>
                <div class="ft-blinks">
                    <a href="#">Privacy Policy</a>
                    <a href="#">Terms of Use</a>
                    <a href="#">Disclaimer</a>
                </div>
            </div>
        </div>
    </footer>

    <script>
        // ══════════════════════════════════════
        //  TAB SWITCHING
        // ══════════════════════════════════════
        function switchTab(btn, id) {
            document.querySelectorAll('.tab-btn').forEach(function(b){ b.classList.remove('active'); });
            document.querySelectorAll('.tab-pane').forEach(function(p){ p.classList.remove('active'); });
            btn.classList.add('active');
            document.getElementById('tab-' + id).classList.add('active');
        }

        // ══════════════════════════════════════
        //  SHARE
        // ══════════════════════════════════════
        var pageUrl   = encodeURIComponent(window.location.href);
        var pageTitle = encodeURIComponent(document.title);
        function shareWhatsApp()  { window.open('https://wa.me/?text=' + pageTitle + ' ' + pageUrl, '_blank'); }
        function shareFacebook()  { window.open('https://www.facebook.com/sharer/sharer.php?u=' + pageUrl, '_blank'); }
        function shareLinkedIn()  { window.open('https://www.linkedin.com/sharing/share-offsite/?url=' + pageUrl, '_blank'); }
        function copyLink() {
            navigator.clipboard.writeText(window.location.href)
                .then(function(){ showToast('Link copied! 🔗'); })
                .catch(function(){ alert('Link: ' + window.location.href); });
        }
        function showToast(msg) {
            var t = document.createElement('div');
            t.textContent = msg;
            t.style.cssText = 'position:fixed;bottom:28px;left:50%;transform:translateX(-50%);background:#0B1638;color:#fff;padding:10px 22px;border-radius:100px;font-size:13px;font-weight:600;z-index:99999;box-shadow:0 4px 20px rgba(0,0,0,.3);transition:opacity .4s';
            document.body.appendChild(t);
            setTimeout(function(){ t.style.opacity = '0'; setTimeout(function(){ t.remove(); }, 400); }, 2500);
        }

        // ══════════════════════════════════════
        //  LIGHTBOX
        //  galleryImages[] is injected at top of page by litGalleryJson
        // ══════════════════════════════════════
        var currentLb = 0;

        function buildLbUI() {
            var dotsEl   = document.getElementById('lbDots');
            var thumbsEl = document.getElementById('lbThumbs');
            dotsEl.innerHTML = '';
            thumbsEl.innerHTML = '';

            galleryImages.forEach(function(img, i) {

                // Dot indicators (max 15 to avoid clutter)
                if (galleryImages.length <= 15) {
                    var d = document.createElement('div');
                    d.className = 'lb-dot' + (i === currentLb ? ' active' : '');
                    d.addEventListener('click', (function(idx){ return function(){ currentLb = idx; updateLb(); }; })(i));
                    dotsEl.appendChild(d);
                }

                // Thumbnail strip
                var th = document.createElement('div');
                th.className = 'lb-thumb-item' + (i === currentLb ? ' active' : '');
                th.id = 'lbThumb' + i;
                th.addEventListener('click', (function(idx){ return function(){ currentLb = idx; updateLb(); }; })(i));
                if (img.src) {
                    var tImg = document.createElement('img');
                    tImg.src = img.src;
                    tImg.alt = img.caption || '';
                    th.appendChild(tImg);
                } else {
                    th.innerHTML = "<div style='width:100%;height:100%;background:#1756A9;display:flex;align-items:center;justify-content:center;font-size:22px;'>🏠</div>";
                }
                thumbsEl.appendChild(th);
            });
        }

        function openLightbox(idx) {
            if (!galleryImages || galleryImages.length === 0) {
                showToast('No photos available for this property.');
                return;
            }
            currentLb = Math.min(Math.max(idx || 0, 0), galleryImages.length - 1);
            buildLbUI();
            updateLb();
            document.getElementById('lightbox').classList.add('open');
            document.body.style.overflow = 'hidden';
        }

        function closeLightbox() {
            document.getElementById('lightbox').classList.remove('open');
            document.body.style.overflow = '';
        }

        function closeLightboxOuter(e) {
            if (!e.target.closest('.lb-inner')) closeLightbox();
        }

        function lbNext() { currentLb = (currentLb + 1) % galleryImages.length; updateLb(); }
        function lbPrev() { currentLb = (currentLb - 1 + galleryImages.length) % galleryImages.length; updateLb(); }

        function updateLb() {
            var img = galleryImages[currentLb];

            document.getElementById('lbMainImg').src = img.src || '';
            document.getElementById('lbMainImg').alt = img.caption || '';

            var cap = document.getElementById('lbCaption');
            cap.textContent    = img.caption || '';
            cap.style.display  = img.caption ? '' : 'none';

            document.getElementById('lbCounter').textContent = (currentLb + 1) + ' / ' + galleryImages.length;

            document.querySelectorAll('.lb-dot').forEach(function(d, i){ d.classList.toggle('active', i === currentLb); });
            document.querySelectorAll('.lb-thumb-item').forEach(function(th, i){ th.classList.toggle('active', i === currentLb); });

            var activeThumb = document.getElementById('lbThumb' + currentLb);
            if (activeThumb) activeThumb.scrollIntoView({ behavior: 'smooth', block: 'nearest', inline: 'center' });
        }

        // Keyboard
        document.addEventListener('keydown', function(e) {
            if (!document.getElementById('lightbox').classList.contains('open')) return;
            if (e.key === 'Escape')     closeLightbox();
            if (e.key === 'ArrowRight') lbNext();
            if (e.key === 'ArrowLeft')  lbPrev();
        });

        // Touch / swipe
        (function(){
            var startX = 0;
            var lb = document.getElementById('lightbox');
            lb.addEventListener('touchstart', function(e){ startX = e.touches[0].clientX; }, { passive: true });
            lb.addEventListener('touchend',   function(e){
                var diff = startX - e.changedTouches[0].clientX;
                if (Math.abs(diff) > 50) { diff > 0 ? lbNext() : lbPrev(); }
            });
        })();

        // ══════════════════════════════════════
        //  SCROLL FADE-IN
        // ══════════════════════════════════════
        var obs = new IntersectionObserver(function(entries){
            entries.forEach(function(e, i){
                if (e.isIntersecting)
                    setTimeout(function(){ e.target.classList.add('visible'); }, i * 70);
            });
        }, { threshold: 0.08 });
        document.querySelectorAll('.fade-in').forEach(function(el){ obs.observe(el); });
    </script>

</asp:Content>
