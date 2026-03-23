<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProjectList.aspx.cs" Inherits="ProjectList" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Projects - Adarsh Realtors</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <link href="css/Project.css" rel="stylesheet" />
    <style>
        /* ══ BASE OVERRIDES ══════════════════════════ */
        * { box-sizing: border-box; }

        body {
            background: #F4F6FA;
            font-family: 'Outfit', sans-serif;
            margin: 0;
            color: #1E293B;
        }

        /* ══ HEADER ══════════════════════════════════ */
        .top-header {
            background: #1E293B;
            padding: 0 24px;
            height: 56px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: sticky;
            top: 0;
            z-index: 100;
        }
        .header-brand { display: flex; align-items: center; gap: 10px; }
        .logo-box {
            width: 34px; height: 34px; border-radius: 8px;
            background: #F97316; display: flex; align-items: center;
            justify-content: center; font-weight: 800; color: #fff; font-size: .9rem;
        }
        .brand-text  { font-size: .88rem; font-weight: 700; color: #fff; }
        .brand-sub   { font-size: .62rem; color: #94A3B8; }
        .breadcrumb  { font-size: .75rem; color: #94A3B8; }
        .breadcrumb .current { color: #fff; font-weight: 600; }
        .breadcrumb .sep { margin: 0 6px; }

        /* ══ PAGE WRAP ═══════════════════════════════ */
        .pl-wrap {
            max-width: 1280px;
            margin: 0 auto;
            padding: 24px 20px 40px;
        }

        /* ══ PAGE TITLE ROW ══════════════════════════ */
        .pl-title-row {
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
            margin-bottom: 20px;
            flex-wrap: wrap;
            gap: 12px;
        }
        .pl-title    { font-size: 1.4rem; font-weight: 800; color: #1E293B; line-height: 1; }
        .pl-subtitle { font-size: .75rem; color: #94A3B8; margin-top: 4px; }
        .pl-actions  { display: flex; align-items: center; gap: 8px; }

        /* View Toggle */
        .view-toggle {
            display: flex;
            background: #E2E8F0;
            border-radius: 8px;
            padding: 3px;
            gap: 2px;
        }
        .vt-btn {
            width: 30px; height: 28px; border: none; background: transparent;
            border-radius: 6px; cursor: pointer; color: #94A3B8;
            display: flex; align-items: center; justify-content: center;
            font-size: .75rem; transition: all .15s;
        }
        .vt-btn.active { background: #fff; color: #F97316; box-shadow: 0 1px 4px rgba(0,0,0,.1); }

        /* ══ STATS ROW ═══════════════════════════════ */
        .stats-row {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 12px;
            margin-bottom: 20px;
        }
        .stat-card {
            background: #fff;
            border-radius: 12px;
            padding: 16px;
            display: flex;
            align-items: center;
            gap: 12px;
            border: 1px solid #E2E8F0;
        }
        .stat-icon {
            width: 42px; height: 42px; border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            font-size: .95rem; flex-shrink: 0;
        }
        .si-o { background: #FFF7ED; color: #F97316; }
        .si-g { background: #F0FDF4; color: #16A34A; }
        .si-b { background: #EFF6FF; color: #2563EB; }
        .si-y { background: #FEFCE8; color: #CA8A04; }
        .stat-val { font-size: 1.6rem; font-weight: 800; color: #1E293B; line-height: 1; }
        .stat-lbl { font-size: .67rem; color: #94A3B8; margin-top: 3px; font-weight: 500; text-transform: uppercase; letter-spacing: .3px; }

        /* ══ FILTER BAR ══════════════════════════════ */
        .filter-bar {
            background: #fff;
            border: 1px solid #E2E8F0;
            border-radius: 12px;
            padding: 12px 16px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
        }
        .search-box {
            position: relative;
            flex: 1;
            min-width: 220px;
        }
        .search-box i {
            position: absolute; left: 11px; top: 50%;
            transform: translateY(-50%); color: #CBD5E1; font-size: .78rem;
        }
        .search-box input {
            width: 100%; padding: 9px 12px 9px 32px;
            border: 1px solid #E2E8F0; border-radius: 8px;
            font-size: .8rem; font-family: 'Outfit', sans-serif;
            color: #1E293B; background: #F8FAFC; outline: none;
            transition: border-color .15s;
        }
        .search-box input:focus { border-color: #F97316; background: #fff; }
        .filter-select {
            padding: 9px 12px; border: 1px solid #E2E8F0;
            border-radius: 8px; font-size: .78rem;
            font-family: 'Outfit', sans-serif; color: #1E293B;
            background: #F8FAFC; outline: none; cursor: pointer;
            min-width: 130px; transition: border-color .15s;
        }
        .filter-select:focus { border-color: #F97316; }
        .filter-clear {
            padding: 8px 14px; border: 1px solid #E2E8F0; border-radius: 8px;
            background: #fff; font-size: .75rem; font-family: 'Outfit', sans-serif;
            cursor: pointer; color: #64748B; display: flex; align-items: center;
            gap: 5px; white-space: nowrap; transition: all .15s;
        }
        .filter-clear:hover { border-color: #F97316; color: #F97316; }
        .result-count { font-size: .75rem; color: #94A3B8; white-space: nowrap; margin-left: auto; }
        .result-count strong { color: #F97316; }

        /* ══ CARD GRID ═══════════════════════════════ */
        .cards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 16px;
        }

        /* ══ PROJECT CARD ════════════════════════════ */
        .proj-card {
            background: #fff;
            border-radius: 14px;
            border: 1px solid #E2E8F0;
            overflow: hidden;
            transition: box-shadow .2s, transform .15s;
            display: flex;
            flex-direction: column;
        }
        .proj-card:hover {
            box-shadow: 0 10px 40px rgba(0,0,0,.09);
            transform: translateY(-2px);
        }

        /* Cover */
        .pc-cover {
            height: 150px;
            background: #F1F5F9;
            position: relative;
            overflow: hidden;
            flex-shrink: 0;
        }
        .pc-cover img {
            width: 100%; height: 100%;
            object-fit: cover; display: block;
        }
        .pc-cover-placeholder {
            width: 100%; height: 100%;
            display: flex; flex-direction: column;
            align-items: center; justify-content: center;
            color: #CBD5E1; gap: 6px; font-size: .72rem;
        }
        .pc-cover-placeholder i { font-size: 2rem; }

        /* Status badge on cover */
        .pc-status {
            position: absolute; top: 10px; left: 10px;
            padding: 4px 10px; border-radius: 20px;
            font-size: .6rem; font-weight: 700;
            letter-spacing: .4px; text-transform: uppercase;
        }
        .ps-active   { background: #DCFCE7; color: #166534; }
        .ps-draft    { background: #FEF3C7; color: #92400E; }
        .ps-upcoming { background: #DBEAFE; color: #1E40AF; }
        .ps-inactive { background: #F1F5F9; color: #475569; }

        /* Logo on cover */
        .pc-logo {
            position: absolute; bottom: -16px; right: 14px;
            width: 38px; height: 38px; border-radius: 8px;
            border: 2px solid #fff; background: #fff;
            box-shadow: 0 2px 8px rgba(0,0,0,.12);
            object-fit: contain; padding: 3px;
        }

        /* Body */
        .pc-body { padding: 20px 16px 14px; flex: 1; }
        .pc-code {
            font-size: .6rem; font-weight: 700; color: #F97316;
            letter-spacing: .5px; text-transform: uppercase; margin-bottom: 3px;
        }
        .pc-name {
            font-size: .95rem; font-weight: 700; color: #1E293B;
            margin-bottom: 5px; line-height: 1.3;
        }
        .pc-loc {
            font-size: .72rem; color: #94A3B8;
            display: flex; align-items: center; gap: 4px;
            margin-bottom: 14px;
        }
        .pc-loc i { color: #F97316; font-size: .62rem; }

        /* Meta grid */
        .pc-meta {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
            padding: 12px;
            background: #F8FAFC;
            border-radius: 8px;
        }
        .pm-lbl { font-size: .59rem; color: #94A3B8; font-weight: 600; text-transform: uppercase; letter-spacing: .3px; }
        .pm-val { font-size: .78rem; font-weight: 700; color: #1E293B; margin-top: 2px; }

        /* Footer */
        .pc-footer {
            padding: 10px 16px;
            border-top: 1px solid #F1F5F9;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .pc-tags { font-size: .67rem; color: #94A3B8; display: flex; align-items: center; gap: 6px; }
        .pc-tags i { color: #F97316; }
        .pc-btns { display: flex; gap: 5px; }
        .pc-btn {
            width: 30px; height: 30px; border-radius: 7px;
            border: 1px solid #E2E8F0; background: #fff;
            cursor: pointer; display: flex; align-items: center;
            justify-content: center; font-size: .7rem; color: #64748B;
            transition: all .12s; text-decoration: none;
        }
        .pc-btn:hover       { border-color: #F97316; color: #F97316; background: #FFF7ED; }
        .pc-btn.del:hover   { border-color: #EF4444; color: #EF4444; background: #FEF2F2; }

        /* ══ TABLE VIEW ══════════════════════════════ */
        .tbl-wrap { display: none; background: #fff; border-radius: 14px; border: 1px solid #E2E8F0; overflow: hidden; }
        .proj-tbl { width: 100%; border-collapse: collapse; }
        .proj-tbl th {
            background: #F8FAFC; padding: 11px 14px;
            font-size: .65rem; font-weight: 700; color: #94A3B8;
            text-align: left; text-transform: uppercase; letter-spacing: .4px;
            border-bottom: 1px solid #E2E8F0; white-space: nowrap;
        }
        .proj-tbl td {
            padding: 12px 14px; font-size: .78rem; color: #1E293B;
            border-bottom: 1px solid #F1F5F9; vertical-align: middle;
        }
        .proj-tbl tr:last-child td { border-bottom: none; }
        .proj-tbl tr:hover td { background: #FAFBFC; }
        .tbl-name { font-weight: 700; font-size: .82rem; }
        .tbl-code { font-size: .62rem; color: #F97316; font-weight: 700; margin-top: 1px; }

        /* ══ STATUS PILLS ════════════════════════════ */
        .spill {
            display: inline-flex; align-items: center; gap: 4px;
            padding: 3px 9px; border-radius: 20px;
            font-size: .62rem; font-weight: 700;
        }
        .spill-active   { background: #DCFCE7; color: #166534; }
        .spill-draft    { background: #FEF3C7; color: #92400E; }
        .spill-upcoming { background: #DBEAFE; color: #1E40AF; }
        .spill-inactive { background: #F1F5F9; color: #475569; }

        /* ══ EMPTY STATE ════════════════════════════ */
        .empty-box {
            text-align: center; padding: 64px 20px;
            background: #fff; border-radius: 14px; border: 1px solid #E2E8F0;
        }
        .empty-box i { font-size: 3rem; color: #E2E8F0; display: block; margin-bottom: 14px; }
        .empty-title { font-size: 1rem; font-weight: 700; color: #475569; margin-bottom: 6px; }
        .empty-sub   { font-size: .78rem; color: #94A3B8; margin-bottom: 20px; }

        /* ══ DELETE MODAL ════════════════════════════ */
        .modal-bg {
            display: none; position: fixed; inset: 0; z-index: 9999;
            background: rgba(0,0,0,.45); backdrop-filter: blur(3px);
            align-items: center; justify-content: center;
        }
        .modal-bg.open { display: flex; }
        .modal-box {
            background: #fff; border-radius: 16px; padding: 28px 24px 20px;
            max-width: 380px; width: 90%;
            box-shadow: 0 20px 60px rgba(0,0,0,.2); animation: popIn .22s ease;
        }
        .modal-ico {
            width: 50px; height: 50px; border-radius: 50%;
            background: #FEF2F2; display: flex; align-items: center;
            justify-content: center; margin: 0 auto 14px;
            font-size: 1.2rem; color: #EF4444;
        }
        .modal-title { font-size: .95rem; font-weight: 800; color: #1E293B; text-align: center; margin-bottom: 6px; }
        .modal-msg   { font-size: .75rem; color: #64748B; text-align: center; margin-bottom: 20px; line-height: 1.5; }
        .modal-btns  { display: flex; gap: 10px; justify-content: center; }
        .btn-cancel {
            padding: 9px 22px; border: 1px solid #E2E8F0; border-radius: 8px;
            background: #fff; font-size: .78rem; font-family: 'Outfit', sans-serif;
            cursor: pointer; color: #64748B; font-weight: 600; transition: all .12s;
        }
        .btn-cancel:hover { border-color: #CBD5E1; background: #F8FAFC; }
        .btn-delete {
            padding: 9px 22px; border: none; border-radius: 8px;
            background: #EF4444; font-size: .78rem; font-family: 'Outfit', sans-serif;
            cursor: pointer; color: #fff; font-weight: 600; transition: background .12s;
        }
        .btn-delete:hover { background: #DC2626; }

        /* ══ TOAST ═══════════════════════════════════ */
        .toast {
            position: fixed; bottom: 24px; right: 24px; z-index: 99999;
            background: #1E293B; color: #fff; padding: 12px 18px;
            border-radius: 10px; font-size: .8rem; font-family: 'Outfit', sans-serif;
            display: flex; align-items: center; gap: 8px;
            box-shadow: 0 8px 24px rgba(0,0,0,.2); font-weight: 500;
            opacity: 0; transform: translateY(12px);
            transition: opacity .25s, transform .25s; pointer-events: none;
        }
        .toast.show { opacity: 1; transform: translateY(0); }

        /* ══ BTN ══════════════════════════════════════ */
        .btn-primary {
            background: #F97316; color: #fff; border: none;
            padding: 9px 18px; border-radius: 9px; font-size: .78rem;
            font-family: 'Outfit', sans-serif; font-weight: 700; cursor: pointer;
            display: inline-flex; align-items: center; gap: 6px;
            text-decoration: none; transition: background .12s;
        }
        .btn-primary:hover { background: #EA6C0A; }

        @keyframes popIn {
            0%   { transform: scale(.85); opacity: 0; }
            100% { transform: scale(1);   opacity: 1; }
        }

        /* ══ RESPONSIVE ══════════════════════════════ */
        @media (max-width: 768px) {
            .stats-row { grid-template-columns: 1fr 1fr; }
            .cards-grid { grid-template-columns: 1fr; }
            .filter-bar { gap: 8px; }
            .search-box { min-width: 100%; }
            .filter-select { min-width: unset; flex: 1; }
            .pl-title-row { flex-direction: column; align-items: flex-start; }
        }
        @media (max-width: 480px) {
            .stats-row { grid-template-columns: 1fr 1fr; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <%-- TOP HEADER --%>
        <div class="top-header">
            <div class="header-brand">
                <div class="logo-box">A</div>
                <div>
                    <div class="brand-text">Adarsh Realtors</div>
                    <div class="brand-sub">Management Portal</div>
                </div>
            </div>
            <div class="breadcrumb">
                <span>Dashboard</span>
                <span class="sep">&rsaquo;</span>
                <span class="current">Projects</span>
            </div>
            <a href="ProjectCreate.aspx" class="btn-primary">
                <i class="fa-solid fa-plus"></i> Add New Project
            </a>
        </div>

        <div class="pl-wrap">

            <%-- TITLE ROW --%>
            <div class="pl-title-row">
                <div>
                    <div class="pl-title">All Projects</div>
                    <div class="pl-subtitle">Manage and track all real estate projects</div>
                </div>
                <div class="pl-actions">
                    <div class="view-toggle">
                        <button type="button" class="vt-btn active" id="btnGrid" onclick="switchView('grid')" title="Card View">
                            <i class="fa-solid fa-grip"></i>
                        </button>
                        <button type="button" class="vt-btn" id="btnTable" onclick="switchView('table')" title="Table View">
                            <i class="fa-solid fa-list"></i>
                        </button>
                    </div>
                    <a href="ProjectCreate.aspx" class="btn-primary">
                        <i class="fa-solid fa-plus"></i> New Project
                    </a>
                </div>
            </div>

            <%-- STATS --%>
            <div class="stats-row">
                <div class="stat-card">
                    <div class="stat-icon si-o"><i class="fa-solid fa-building"></i></div>
                    <div><div class="stat-val" id="sTotal">0</div><div class="stat-lbl">Total Projects</div></div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon si-g"><i class="fa-solid fa-rocket"></i></div>
                    <div><div class="stat-val" id="sActive">0</div><div class="stat-lbl">Live / Active</div></div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon si-b"><i class="fa-solid fa-calendar-check"></i></div>
                    <div><div class="stat-val" id="sUpcoming">0</div><div class="stat-lbl">Upcoming</div></div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon si-y"><i class="fa-solid fa-file-pen"></i></div>
                    <div><div class="stat-val" id="sDraft">0</div><div class="stat-lbl">Drafts</div></div>
                </div>
            </div>

            <%-- FILTER BAR --%>
            <div class="filter-bar">
                <div class="search-box">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    <input type="text" id="searchInput" placeholder="Search by name, code, city..." oninput="filterProjects()" />
                </div>
                <select class="filter-select" id="filterStatus" onchange="filterProjects()">
                    <option value="">All Status</option>
                    <option value="active">Live / Active</option>
                    <option value="draft">Draft</option>
                    <option value="upcoming">Upcoming</option>
                    <option value="inactive">Inactive</option>
                </select>
                <select class="filter-select" id="filterType" onchange="filterProjects()">
                    <option value="">All Types</option>
                    <option value="Residential">Residential</option>
                    <option value="Commercial">Commercial</option>
                    <option value="Affordable">Affordable Housing</option>
                    <option value="Plotted">Plotted</option>
                </select>
                <button type="button" class="filter-clear" onclick="clearFilters()">
                    <i class="fa-solid fa-xmark"></i> Clear
                </button>
                <div class="result-count">Showing <strong id="showCount">0</strong> projects</div>
            </div>

            <%-- GRID VIEW --%>
            <div id="viewGrid">
                <div class="cards-grid" id="cardsGrid"></div>
                <div class="empty-box" id="emptyGrid" style="display:none">
                    <i class="fa-solid fa-building-circle-xmark"></i>
                    <div class="empty-title">No projects found</div>
                    <div class="empty-sub">Try changing filters or add a new project</div>
                    <a href="ProjectCreate.aspx" class="btn-primary"><i class="fa-solid fa-plus"></i> Add New Project</a>
                </div>
            </div>

            <%-- TABLE VIEW --%>
            <div class="tbl-wrap" id="viewTable">
                <table class="proj-tbl">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Project</th>
                            <th>Type</th>
                            <th>Location</th>
                            <th>Units</th>
                            <th>BSP Rate</th>
                            <th>Possession</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="tblBody"></tbody>
                </table>
                <div class="empty-box" id="emptyTable" style="display:none;border:none;border-radius:0">
                    <i class="fa-solid fa-building-circle-xmark"></i>
                    <div class="empty-title">No projects found</div>
                    <div class="empty-sub">Try changing filters</div>
                </div>
            </div>

        </div>

        <%-- DELETE MODAL --%>
        <div class="modal-bg" id="delModal">
            <div class="modal-box">
                <div class="modal-ico"><i class="fa-solid fa-trash"></i></div>
                <div class="modal-title">Delete Project?</div>
                <div class="modal-msg" id="delMsg">Yeh project permanently delete ho jaayega.</div>
                <div class="modal-btns">
                    <button type="button" class="btn-cancel" onclick="closeDelModal()">Cancel</button>
                    <asp:Button ID="btnConfirmDelete" runat="server" Text="Delete"
                        CssClass="btn-delete" OnClick="btnConfirmDelete_Click" />
                </div>
            </div>
        </div>

        <asp:HiddenField ID="hdnDeleteID" runat="server" />

        <%-- TOAST --%>
        <div class="toast" id="toast">
            <i id="toastIco" class="fa-solid fa-check"></i>
            <span id="toastMsg">Done</span>
        </div>

        <script>
            var allProjects    = [];
            var filteredList   = [];
            var currentView    = 'grid';

            // ── Helpers ──────────────────────────────
            function statusInfo(mode) {
                var m = (mode || 'draft').toLowerCase();
                if (m === 'active')   return { cls: 'ps-active',   spill: 'spill-active',   lbl: 'LIVE',     dot: 'fa-circle-dot' };
                if (m === 'upcoming') return { cls: 'ps-upcoming', spill: 'spill-upcoming', lbl: 'UPCOMING', dot: 'fa-calendar-check' };
                if (m === 'inactive') return { cls: 'ps-inactive', spill: 'spill-inactive', lbl: 'INACTIVE', dot: 'fa-circle-pause' };
                return                         { cls: 'ps-draft',   spill: 'spill-draft',   lbl: 'DRAFT',    dot: 'fa-file-pen' };
            }

            function fmtNum(n) {
                if (n == null || n === '') return '-';
                return Number(n).toLocaleString('en-IN');
            }

            function fmtDate(d) {
                if (!d || d === '') return '-';
                try {
                    var dt = new Date(d);
                    if (isNaN(dt)) return '-';
                    return dt.toLocaleDateString('en-IN', { day: '2-digit', month: 'short', year: 'numeric' });
                } catch(e) { return '-'; }
            }

            function esc(s) {
                // Escape for use in HTML attribute values
                return (s || '').replace(/&/g,'&amp;').replace(/"/g,'&quot;').replace(/</g,'&lt;').replace(/>/g,'&gt;');
            }

            // ── Render Card ───────────────────────────
            function makeCard(p) {
                var si  = statusInfo(p.PublishMode);
                var bsp = p.BSPRatePerSqFt ? 'Rs ' + fmtNum(p.BSPRatePerSqFt) + '/sqft' : '-';
                var loc = [p.City, p.StateName].filter(function(x){ return x && x.trim(); }).join(', ') || '-';

                // Cover image — use createElement to avoid onerror escaping issues
                var cover = p.CoverImagePath
                    ? '<img src="' + esc(p.CoverImagePath) + '" alt="" style="width:100%;height:100%;object-fit:cover;display:block;" onerror="this.style.display=\'none\';this.parentNode.querySelector(\'.pc-cover-placeholder\').style.display=\'flex\'">' +
                      '<div class="pc-cover-placeholder" style="display:none"><i class="fa-solid fa-image"></i><span>No Image</span></div>'
                    : '<div class="pc-cover-placeholder"><i class="fa-solid fa-image"></i><span>No Image</span></div>';

                var logo = p.ProjectLogoBadge
                    ? '<img class="pc-logo" src="' + esc(p.ProjectLogoBadge) + '" alt="" onerror="this.style.display=\'none\'">'
                    : '';

                var safeName = esc(p.ProjectName || 'Unnamed Project');
                var nameForJs = (p.ProjectName || '').replace(/\\/g,'\\\\').replace(/'/g,"\\'");

                return [
                    '<div class="proj-card">',
                        '<div class="pc-cover">',
                            cover,
                            '<span class="pc-status ' + si.cls + '">' + si.lbl + '</span>',
                            logo,
                        '</div>',
                        '<div class="pc-body">',
                            '<div class="pc-code">' + esc(p.ProjectCode || '') + '</div>',
                            '<div class="pc-name">' + safeName + '</div>',
                            '<div class="pc-loc"><i class="fa-solid fa-location-dot"></i>' + esc(loc) + '</div>',
                            '<div class="pc-meta">',
                                '<div><div class="pm-lbl">Total Units</div><div class="pm-val">' + fmtNum(p.TotalUnits) + '</div></div>',
                                '<div><div class="pm-lbl">BSP Rate</div><div class="pm-val">' + esc(bsp) + '</div></div>',
                                '<div><div class="pm-lbl">Possession</div><div class="pm-val">' + esc(fmtDate(p.PossessionDate)) + '</div></div>',
                                '<div><div class="pm-lbl">Branch</div><div class="pm-val">' + esc(p.BranchName || '-') + '</div></div>',
                            '</div>',
                        '</div>',
                        '<div class="pc-footer">',
                            '<div class="pc-tags">',
                                '<i class="fa-solid fa-star"></i>' + (p.AmenityCount || 0) + ' amenities',
                                '&nbsp;|&nbsp;',
                                '<i class="fa-regular fa-file"></i>' + (p.DocumentCount || 0) + ' docs',
                            '</div>',
                            '<div class="pc-btns">',
                                '<a href="ProjectCreate.aspx?pid=' + p.ProjectID + '" class="pc-btn" title="Edit"><i class="fa-solid fa-pen"></i></a>',
                                '<a href="ProjectDetail.aspx?pid=' + p.ProjectID + '" class="pc-btn" title="View"><i class="fa-solid fa-eye"></i></a>',
                                '<button type="button" class="pc-btn del" title="Delete" onclick="openDelModal(' + p.ProjectID + ',\'' + nameForJs + '\')"><i class="fa-solid fa-trash"></i></button>',
                            '</div>',
                        '</div>',
                    '</div>'
                ].join('');
            }

            // ── Render Table Row ──────────────────────
            function makeRow(p, i) {
                var si  = statusInfo(p.PublishMode);
                var bsp = p.BSPRatePerSqFt ? 'Rs ' + fmtNum(p.BSPRatePerSqFt) : '-';
                var loc = [p.City, p.StateName].filter(function(x){ return x && x.trim(); }).join(', ') || '-';
                var nameForJs = (p.ProjectName || '').replace(/\\/g,'\\\\').replace(/'/g,"\\'");

                return [
                    '<tr>',
                    '<td style="color:#94A3B8;font-size:.7rem">' + (i + 1) + '</td>',
                    '<td><div class="tbl-name">' + esc(p.ProjectName||'-') + '</div><div class="tbl-code">' + esc(p.ProjectCode||'') + '</div></td>',
                    '<td>' + esc(p.ProjectType||'-') + '</td>',
                    '<td>' + esc(loc) + '</td>',
                    '<td>' + fmtNum(p.TotalUnits) + '</td>',
                    '<td>' + esc(bsp) + '</td>',
                    '<td>' + esc(fmtDate(p.PossessionDate)) + '</td>',
                    '<td><span class="spill ' + si.spill + '">' + si.lbl + '</span></td>',
                    '<td><div style="display:flex;gap:5px">',
                        '<a href="ProjectCreate.aspx?pid=' + p.ProjectID + '" class="pc-btn" title="Edit"><i class="fa-solid fa-pen"></i></a>',
                        '<a href="ProjectDetail.aspx?pid=' + p.ProjectID + '" class="pc-btn" title="View"><i class="fa-solid fa-eye"></i></a>',
                        '<button type="button" class="pc-btn del" title="Delete" onclick="openDelModal(' + p.ProjectID + ',\'' + nameForJs + '\')"><i class="fa-solid fa-trash"></i></button>',
                    '</div></td>',
                    '</tr>'
                ].join('');
            }

            // ── Filter ────────────────────────────────
            function filterProjects() {
                var q      = (document.getElementById('searchInput').value   || '').toLowerCase().trim();
                var status = (document.getElementById('filterStatus').value  || '').toLowerCase();
                var type   = (document.getElementById('filterType').value    || '').toLowerCase();

                filteredList = allProjects.filter(function(p) {
                    var ms = !q || [p.ProjectName, p.ProjectCode, p.City, p.RERANumber]
                        .some(function(f){ return f && f.toLowerCase().indexOf(q) >= 0; });
                    var mv = !status || (p.PublishMode || '').toLowerCase() === status;
                    var mt = !type   || (p.ProjectType || '').toLowerCase().indexOf(type) >= 0;
                    return ms && mv && mt;
                });

                render();
            }

            function clearFilters() {
                document.getElementById('searchInput').value  = '';
                document.getElementById('filterStatus').value = '';
                document.getElementById('filterType').value   = '';
                filterProjects();
            }

            // ── Render ────────────────────────────────
            function render() {
                document.getElementById('showCount').textContent = filteredList.length;
                if (currentView === 'grid') renderGrid();
                else renderTable();
            }

            function renderGrid() {
                var grid  = document.getElementById('cardsGrid');
                var empty = document.getElementById('emptyGrid');
                if (filteredList.length === 0) {
                    grid.innerHTML  = '';
                    empty.style.display = 'block';
                } else {
                    empty.style.display = 'none';
                    grid.innerHTML = filteredList.map(makeCard).join('');
                }
            }

            function renderTable() {
                var tbody = document.getElementById('tblBody');
                var empty = document.getElementById('emptyTable');
                if (filteredList.length === 0) {
                    tbody.innerHTML = '';
                    empty.style.display = 'block';
                } else {
                    empty.style.display = 'none';
                    tbody.innerHTML = filteredList.map(makeRow).join('');
                }
            }

            // ── View toggle ───────────────────────────
            function switchView(v) {
                currentView = v;
                document.getElementById('viewGrid').style.display  = v === 'grid'  ? 'block' : 'none';
                document.getElementById('viewTable').style.display = v === 'table' ? 'block' : 'none';
                document.getElementById('btnGrid').classList.toggle('active',  v === 'grid');
                document.getElementById('btnTable').classList.toggle('active', v === 'table');
                render();
            }

            // ── Stats ─────────────────────────────────
            function updateStats() {
                var a = allProjects, n = a.length;
                document.getElementById('sTotal').textContent    = n;
                document.getElementById('sActive').textContent   = a.filter(function(p){ return (p.PublishMode||'').toLowerCase() === 'active';   }).length;
                document.getElementById('sUpcoming').textContent = a.filter(function(p){ return (p.PublishMode||'').toLowerCase() === 'upcoming'; }).length;
                document.getElementById('sDraft').textContent    = a.filter(function(p){ var m = (p.PublishMode||'').toLowerCase(); return m === 'draft' || m === ''; }).length;
            }

            // ── Delete modal ──────────────────────────
            function openDelModal(id, name) {
                document.getElementById('delMsg').textContent =
                    '"' + name + '" permanently delete ho jaayega. Kya aap sure hain?';
                document.getElementById('<%= hdnDeleteID.ClientID %>').value = id;
                document.getElementById('delModal').classList.add('open');
            }
            function closeDelModal() {
                document.getElementById('delModal').classList.remove('open');
                document.getElementById('<%= hdnDeleteID.ClientID %>').value = '';
            }

            // ── Toast ─────────────────────────────────
            function showToast(msg, type) {
                var t = document.getElementById('toast');
                var i = document.getElementById('toastIco');
                document.getElementById('toastMsg').textContent = msg;
                t.style.background = '#1E293B';
                i.className = 'fa-solid fa-check';
                if (type === 'success') { t.style.background = '#16A34A'; i.className = 'fa-solid fa-circle-check'; }
                if (type === 'error')   { t.style.background = '#DC2626'; i.className = 'fa-solid fa-circle-xmark'; }
                if (type === 'info')    { t.style.background = '#2563EB'; i.className = 'fa-solid fa-floppy-disk';  }
                t.classList.add('show');
                setTimeout(function(){ t.classList.remove('show'); }, 3500);
            }

            // ── Init ──────────────────────────────────
            function initProjects(data) {
                allProjects  = data || [];
                filteredList = allProjects.slice();
                updateStats();
                renderGrid();
            }
        </script>

        <%-- DATA INJECT — script ke baad --%>
        <asp:Literal ID="litProjectsJSON" runat="server" />

    </form>
</body>
</html>
