<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProjectList.aspx.cs" Inherits="ProjectList" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title><%= Session["Title"] %></title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />

    <style>
        /* ═══════════════════════════════════════════
           RESET & BASE
        ═══════════════════════════════════════════ */
        *, *::before, *::after {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        :root {
            --brand: #F97316;
            --brand-dark: #C2581A;
            --brand-light: #FEF3EB;
            --navy: #0F172A;
            --navy-2: #1E293B;
            --navy-3: #334155;
            --slate: #64748B;
            --slate-2: #94A3B8;
            --slate-3: #CBD5E1;
            --slate-4: #E2E8F0;
            --slate-5: #F1F5F9;
            --slate-6: #F8FAFC;
            --white: #FFFFFF;
            --green: #16A34A;
            --green-bg: #DCFCE7;
            --blue: #2563EB;
            --blue-bg: #DBEAFE;
            --amber: #D97706;
            --amber-bg: #FEF3C7;
            --red: #DC2626;
            --red-bg: #FEE2E2;
            --radius-sm: 6px;
            --radius: 10px;
            --radius-lg: 14px;
            --radius-xl: 18px;
            --shadow-sm: 0 1px 3px rgba(0,0,0,.06), 0 1px 2px rgba(0,0,0,.04);
            --shadow: 0 4px 12px rgba(0,0,0,.07), 0 1px 3px rgba(0,0,0,.04);
            --shadow-lg: 0 10px 30px rgba(0,0,0,.10), 0 2px 8px rgba(0,0,0,.06);
            --font: 'Outfit', sans-serif;
            --sidebar-w: 0px;
        }

        html, body {
            height: 100%;
            font-family: var(--font);
            background: var(--slate-6);
            color: var(--navy);
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        button {
            font-family: var(--font);
            cursor: pointer;
        }

        input, select {
            font-family: var(--font);
        }

        /* ═══════════════════════════════════════════
           TOP HEADER  — matches Project.css / dark navy
        ═══════════════════════════════════════════ */
        .top-header {
            background: #1A1F2E;
            padding: 0 20px;
            height: 58px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: sticky;
            top: 0;
            z-index: 200;
            gap: 12px;
        }

        .header-brand {
            display: flex;
            align-items: center;
            gap: 10px;
            flex-shrink: 0;
        }

        .logo-box {
            width: 32px;
            height: 32px;
            background: var(--brand);
            border-radius: 7px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
            color: #fff;
            font-size: .95rem;
            flex-shrink: 0;
        }

        .brand-text {
            color: #fff;
            font-size: .95rem;
            font-weight: 700;
            line-height: 1.2;
        }

        .brand-sub {
            color: rgba(255,255,255,.4);
            font-size: .62rem;
            letter-spacing: .1em;
        }

        .breadcrumb {
            display: flex;
            align-items: center;
            gap: 5px;
            font-size: .75rem;
            color: rgba(255,255,255,.45);
            overflow: hidden;
        }

            .breadcrumb span {
                white-space: nowrap;
            }

            .breadcrumb .sep {
                font-size: .7rem;
            }

            .breadcrumb .current {
                color: #FF7A35;
                font-weight: 600;
                white-space: nowrap;
            }

        .header-actions {
            display: flex;
            gap: 8px;
            flex-shrink: 0;
        }

        @media (max-width: 640px) {
            .top-header {
                padding: 0 14px;
            }

            .brand-sub {
                display: none;
            }

            .breadcrumb {
                display: none;
            }
        }

        .btn-primary {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            background: var(--brand);
            color: var(--white);
            border: none;
            border-radius: var(--radius);
            padding: 9px 16px;
            font-size: 13px;
            font-weight: 600;
            transition: background .15s, transform .1s;
        }

            .btn-primary:hover {
                background: var(--brand-dark);
            }

            .btn-primary:active {
                transform: scale(.98);
            }

        /* ═══════════════════════════════════════════
           PAGE WRAPPER
        ═══════════════════════════════════════════ */
        .pl-wrap {
            max-width: 1400px;
            margin: 0 auto;
            padding: 28px 24px 60px;
        }

        /* ═══════════════════════════════════════════
           TITLE ROW
        ═══════════════════════════════════════════ */
        .pl-title-row {
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
            margin-bottom: 22px;
            gap: 16px;
            flex-wrap: wrap;
        }

        .pl-title {
            font-size: 26px;
            font-weight: 800;
            color: var(--navy);
            letter-spacing: -.4px;
        }

        .pl-subtitle {
            font-size: 13px;
            color: var(--slate);
            margin-top: 3px;
        }

        .pl-actions {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .view-toggle {
            display: flex;
            border: 1px solid var(--slate-4);
            border-radius: var(--radius);
            overflow: hidden;
            background: var(--slate-5);
        }

        .vt-btn {
            border: none;
            background: transparent;
            padding: 8px 13px;
            color: var(--slate);
            font-size: 14px;
            transition: background .15s, color .15s;
        }

            .vt-btn.active {
                background: var(--white);
                color: var(--brand);
                box-shadow: var(--shadow-sm);
            }

            .vt-btn:hover:not(.active) {
                background: var(--slate-4);
            }

        /* ═══════════════════════════════════════════
           STATS ROW
        ═══════════════════════════════════════════ */
        .stats-row {
            display: grid;
            grid-template-columns: repeat(4,1fr);
            gap: 14px;
            margin-bottom: 22px;
        }

        .stat-card {
            background: var(--white);
            border: 1px solid var(--slate-4);
            border-radius: var(--radius-lg);
            padding: 18px 20px;
            display: flex;
            align-items: center;
            gap: 14px;
            transition: box-shadow .2s;
        }

            .stat-card:hover {
                box-shadow: var(--shadow);
            }

        .stat-icon {
            width: 44px;
            height: 44px;
            border-radius: 11px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            flex-shrink: 0;
        }

        .si-o {
            background: var(--brand-light);
            color: var(--brand);
        }

        .si-g {
            background: var(--green-bg);
            color: var(--green);
        }

        .si-b {
            background: var(--blue-bg);
            color: var(--blue);
        }

        .si-y {
            background: var(--amber-bg);
            color: var(--amber);
        }

        .stat-val {
            font-size: 28px;
            font-weight: 800;
            color: var(--navy);
            line-height: 1;
            letter-spacing: -.5px;
        }

        .stat-lbl {
            font-size: 12px;
            color: var(--slate);
            margin-top: 4px;
            font-weight: 500;
        }

        /* ═══════════════════════════════════════════
           FILTER BAR
        ═══════════════════════════════════════════ */
        .filter-bar {
            display: flex;
            align-items: center;
            gap: 10px;
            background: var(--white);
            border: 1px solid var(--slate-4);
            border-radius: var(--radius-lg);
            padding: 12px 16px;
            margin-bottom: 24px;
            flex-wrap: wrap;
        }

        .search-box {
            display: flex;
            align-items: center;
            gap: 9px;
            flex: 1;
            min-width: 200px;
        }

            .search-box i {
                color: var(--slate-2);
                font-size: 14px;
            }

            .search-box input {
                border: none;
                outline: none;
                font-size: 14px;
                color: var(--navy);
                background: transparent;
                width: 100%;
            }

                .search-box input::placeholder {
                    color: var(--slate-2);
                }

        .filter-sep {
            width: 1px;
            height: 24px;
            background: var(--slate-4);
        }

        .filter-select {
            border: 1px solid var(--slate-4);
            border-radius: var(--radius);
            padding: 8px 12px;
            font-size: 13px;
            color: var(--navy);
            background: var(--slate-5);
            outline: none;
            cursor: pointer;
            font-weight: 500;
            transition: border-color .15s;
        }

            .filter-select:hover, .filter-select:focus {
                border-color: var(--brand);
            }

        .filter-clear {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            border: 1px solid var(--slate-4);
            border-radius: var(--radius);
            padding: 8px 12px;
            font-size: 13px;
            color: var(--slate);
            background: transparent;
            transition: all .15s;
        }

            .filter-clear:hover {
                border-color: var(--red);
                color: var(--red);
                background: var(--red-bg);
            }

        .result-count {
            font-size: 13px;
            color: var(--slate);
            margin-left: auto;
            white-space: nowrap;
        }

            .result-count strong {
                color: var(--navy);
                font-weight: 700;
            }

        /* ═══════════════════════════════════════════
           CARDS GRID
        ═══════════════════════════════════════════ */
        .cards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 18px;
        }

        /* ── Card ── */
        .proj-card {
            background: var(--white);
            border: 1px solid var(--slate-4);
            border-radius: var(--radius-xl);
            overflow: hidden;
            display: flex;
            flex-direction: column;
            transition: box-shadow .2s, transform .2s, border-color .2s;
        }

            .proj-card:hover {
                box-shadow: var(--shadow-lg);
                transform: translateY(-3px);
                border-color: var(--slate-3);
            }

        /* ── Cover wrapper (no overflow hidden — lets logo badge overflow) ── */
        .pc-cover-wrap {
            position: relative; /* logo is absolute to this */
        }

        /* ── Cover ── */
        .pc-cover {
            height: 170px;
            background: var(--navy-2);
            position: relative;
            overflow: hidden;
        }

            .pc-cover img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                display: block;
                transition: transform .4s ease;
            }

        .proj-card:hover .pc-cover img {
            transform: scale(1.05);
        }

        .pc-cover-placeholder {
            width: 100%;
            height: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 8px;
            color: var(--navy-3);
            background: linear-gradient(135deg, var(--navy-2) 0%, var(--navy-3) 100%);
        }

            .pc-cover-placeholder i {
                font-size: 32px;
                opacity: .3;
            }

            .pc-cover-placeholder span {
                font-size: 11px;
                opacity: .4;
                font-weight: 500;
            }

        .pc-cover-gradient {
            position: absolute;
            inset: 0;
            background: linear-gradient(to bottom, rgba(0,0,0,0) 35%, rgba(0,0,0,.6) 100%);
            pointer-events: none;
        }

        /* Status badge */
        .pc-status {
            position: absolute;
            top: 12px;
            left: 12px;
            font-size: 10px;
            font-weight: 700;
            letter-spacing: .6px;
            padding: 4px 10px;
            border-radius: 20px;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

            .pc-status::before {
                content: '';
                width: 6px;
                height: 6px;
                border-radius: 50%;
                background: currentColor;
            }

        .ps-active {
            background: var(--green-bg);
            color: var(--green);
        }

        .ps-draft {
            background: var(--slate-4);
            color: var(--slate);
        }

        .ps-upcoming {
            background: var(--blue-bg);
            color: var(--blue);
        }

        .ps-inactive {
            background: var(--slate-4);
            color: var(--slate);
        }

        /* Photo count */
        .pc-photo-count {
            position: absolute;
            top: 12px;
            right: 12px;
            background: rgba(0,0,0,.50);
            backdrop-filter: blur(6px);
            color: #fff;
            border-radius: 20px;
            padding: 4px 9px;
            font-size: 11px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        /* Price pill */
        .pc-price-cover {
            position: absolute;
            bottom: 12px;
            left: 12px;
            background: var(--brand);
            color: #fff;
            padding: 5px 10px;
            border-radius: var(--radius-sm);
            font-size: 11px;
            font-weight: 700;
        }

        /* Logo / Initials badge — straddles cover bottom edge */
        .pc-logo {
            position: absolute;
            bottom: -18px;
            right: 14px;
            width: 40px;
            height: 40px;
            border-radius: 10px;
            border: 2.5px solid var(--white);
            background: var(--white);
            box-shadow: var(--shadow);
            object-fit: contain;
            padding: 4px;
            z-index: 10;
        }

        .pc-logo-initials {
            position: absolute;
            bottom: -18px;
            right: 14px;
            width: 40px;
            height: 40px;
            border-radius: 10px;
            border: 2.5px solid var(--white);
            background: var(--brand);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            font-weight: 800;
            color: #fff;
            box-shadow: var(--shadow);
            z-index: 10;
        }

        /* ── Body ── */
        .pc-body {
            padding: 26px 16px 14px;
            flex: 1;
        }

        .pc-code {
            font-size: 10px;
            font-weight: 700;
            color: var(--brand);
            letter-spacing: .6px;
            text-transform: uppercase;
            margin-bottom: 4px;
        }

        .pc-name {
            font-size: 16px;
            font-weight: 700;
            color: var(--navy);
            line-height: 1.25;
            margin-bottom: 5px;
        }

        .pc-loc {
            font-size: 12px;
            color: var(--slate);
            display: flex;
            align-items: center;
            gap: 5px;
            margin-bottom: 14px;
        }

            .pc-loc i {
                font-size: 11px;
                color: var(--brand);
            }

        /* Overview grid */
        .pc-overview {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
            padding: 12px;
            background: var(--slate-6);
            border-radius: var(--radius);
            border: 1px solid var(--slate-4);
            margin-bottom: 12px;
        }

        .pco-lbl {
            font-size: 10px;
            color: var(--slate-2);
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: .4px;
        }

        .pco-val {
            font-size: 13px;
            font-weight: 700;
            color: var(--navy);
            margin-top: 3px;
        }

            .pco-val.green {
                color: var(--green);
            }

            .pco-val.blue {
                color: var(--blue);
            }

            .pco-val.orange {
                color: var(--brand);
            }

        /* Spec pills */
        .pc-specs {
            display: flex;
            gap: 6px;
            flex-wrap: wrap;
        }

        .spec-pill {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            background: var(--slate-5);
            border: 1px solid var(--slate-4);
            border-radius: 20px;
            padding: 5px 10px;
            font-size: 11px;
            font-weight: 600;
            color: var(--slate);
        }

            .spec-pill i {
                font-size: 10px;
                color: var(--slate-2);
            }

        /* ── Footer ── */
        .pc-footer {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 12px 16px;
            border-top: 1px solid var(--slate-4);
            background: var(--slate-6);
        }

        .pc-tags {
            font-size: 12px;
            color: var(--slate);
            display: flex;
            align-items: center;
            gap: 5px;
        }

            .pc-tags i {
                font-size: 11px;
            }

        .pc-btns {
            display: flex;
            gap: 6px;
        }

        .pc-btn {
            width: 32px;
            height: 32px;
            border-radius: var(--radius-sm);
            border: 1px solid var(--slate-4);
            background: var(--white);
            color: var(--slate);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 13px;
            transition: all .15s;
            cursor: pointer;
        }

            .pc-btn:hover {
                background: var(--slate-5);
                color: var(--navy);
                border-color: var(--slate-3);
            }

            .pc-btn.del {
                border-color: #FECACA;
                background: #FFF5F5;
                color: var(--red);
            }

                .pc-btn.del:hover {
                    background: var(--red);
                    color: #fff;
                    border-color: var(--red);
                }

        /* ═══════════════════════════════════════════
           TABLE VIEW
        ═══════════════════════════════════════════ */
        .tbl-wrap {
            background: var(--white);
            border: 1px solid var(--slate-4);
            border-radius: var(--radius-xl);
            overflow: hidden;
            display: none;
        }

        .proj-tbl {
            width: 100%;
            border-collapse: collapse;
            font-size: 13px;
        }

            .proj-tbl thead {
                background: var(--slate-5);
            }

            .proj-tbl th {
                padding: 13px 16px;
                text-align: left;
                font-size: 11px;
                font-weight: 700;
                color: var(--slate);
                text-transform: uppercase;
                letter-spacing: .5px;
                border-bottom: 1px solid var(--slate-4);
            }

            .proj-tbl td {
                padding: 14px 16px;
                color: var(--navy-2);
                border-bottom: 1px solid var(--slate-5);
                vertical-align: middle;
            }

            .proj-tbl tr:last-child td {
                border-bottom: none;
            }

            .proj-tbl tr:hover td {
                background: var(--slate-6);
            }

        .tbl-name {
            font-weight: 700;
            font-size: 14px;
            color: var(--navy);
        }

        .tbl-code {
            font-size: 11px;
            color: var(--slate);
            margin-top: 2px;
            font-weight: 500;
        }

        .spill {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            font-size: 10px;
            font-weight: 700;
            letter-spacing: .5px;
            padding: 4px 10px;
            border-radius: 20px;
        }

            .spill::before {
                content: '';
                width: 5px;
                height: 5px;
                border-radius: 50%;
                background: currentColor;
            }

        .spill-active {
            background: var(--green-bg);
            color: var(--green);
        }

        .spill-draft {
            background: var(--slate-4);
            color: var(--slate);
        }

        .spill-upcoming {
            background: var(--blue-bg);
            color: var(--blue);
        }

        .spill-inactive {
            background: var(--slate-4);
            color: var(--slate);
        }

        /* ═══════════════════════════════════════════
           EMPTY STATE
        ═══════════════════════════════════════════ */
        .empty-box {
            text-align: center;
            padding: 64px 24px;
            background: var(--white);
            border: 1px solid var(--slate-4);
            border-radius: var(--radius-xl);
        }

            .empty-box i {
                font-size: 48px;
                color: var(--slate-3);
                margin-bottom: 16px;
                display: block;
            }

        .empty-title {
            font-size: 18px;
            font-weight: 700;
            color: var(--navy);
            margin-bottom: 6px;
        }

        .empty-sub {
            font-size: 14px;
            color: var(--slate);
            margin-bottom: 20px;
        }

        /* ═══════════════════════════════════════════
           DELETE MODAL
        ═══════════════════════════════════════════ */
        .modal-bg {
            position: fixed;
            inset: 0;
            z-index: 1000;
            background: rgba(15,23,42,.55);
            backdrop-filter: blur(4px);
            display: none;
            align-items: center;
            justify-content: center;
        }

            .modal-bg.open {
                display: flex;
            }

        .modal-box {
            background: var(--white);
            border-radius: var(--radius-xl);
            padding: 36px 32px;
            width: 90%;
            max-width: 420px;
            box-shadow: var(--shadow-lg);
            text-align: center;
            animation: popIn .2s ease;
        }

        @keyframes popIn {
            from {
                transform: scale(.9);
                opacity: 0;
            }

            to {
                transform: scale(1);
                opacity: 1;
            }
        }

        .modal-ico {
            width: 56px;
            height: 56px;
            border-radius: 50%;
            background: var(--red-bg);
            color: var(--red);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            margin: 0 auto 16px;
        }

        .modal-title {
            font-size: 20px;
            font-weight: 800;
            color: var(--navy);
            margin-bottom: 8px;
        }

        .modal-msg {
            font-size: 14px;
            color: var(--slate);
            line-height: 1.5;
            margin-bottom: 24px;
        }

        .modal-btns {
            display: flex;
            gap: 10px;
            justify-content: center;
        }

        .btn-cancel {
            flex: 1;
            padding: 11px;
            border-radius: var(--radius);
            border: 1px solid var(--slate-4);
            background: var(--white);
            font-size: 14px;
            font-weight: 600;
            color: var(--slate);
            cursor: pointer;
            transition: all .15s;
        }

            .btn-cancel:hover {
                background: var(--slate-5);
            }

        .btn-delete {
            flex: 1;
            padding: 11px;
            border-radius: var(--radius);
            border: none;
            background: var(--red);
            font-size: 14px;
            font-weight: 700;
            color: #fff;
            cursor: pointer;
            transition: background .15s;
        }

            .btn-delete:hover {
                background: #B91C1C;
            }

        /* ═══════════════════════════════════════════
           TOAST
        ═══════════════════════════════════════════ */
        .toast {
            position: fixed;
            bottom: 24px;
            right: 24px;
            z-index: 2000;
            display: flex;
            align-items: center;
            gap: 10px;
            background: var(--navy);
            color: #fff;
            padding: 13px 18px;
            border-radius: var(--radius-lg);
            font-size: 14px;
            font-weight: 500;
            box-shadow: var(--shadow-lg);
            transform: translateY(80px);
            opacity: 0;
            transition: transform .3s cubic-bezier(.34,1.56,.64,1), opacity .3s;
            pointer-events: none;
        }

            .toast.show {
                transform: translateY(0);
                opacity: 1;
            }

        /* ═══════════════════════════════════════════
           RESPONSIVE
        ═══════════════════════════════════════════ */
        @media (max-width: 900px) {
            .stats-row {
                grid-template-columns: repeat(2,1fr);
            }

            .cards-grid {
                grid-template-columns: repeat(auto-fill, minmax(240px,1fr));
            }
        }

        @media (max-width: 600px) {
            .topbar {
                padding: 0 16px;
            }

            .pl-wrap {
                padding: 20px 14px 40px;
            }

            .stats-row {
                grid-template-columns: 1fr 1fr;
                gap: 10px;
            }

            .pl-title {
                font-size: 22px;
            }

            .filter-bar {
                padding: 10px 12px;
            }

            .cards-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">

        <%-- ══ TOP HEADER ══ --%>
        <div class="top-header">
            <div class="header-brand">
                <div class="logo-box"><%= Session["CompName"].ToString().Substring(0,1).ToUpper() %></div>
                <div>
                    <div class="brand-text"><%= Session["CompName"] %></div>
                    <div class="brand-sub">MANAGEMENT PORTAL</div>
                </div>
            </div>
            <div class="breadcrumb">
                <span>Dashboard</span>
                <span class="sep">&rsaquo;</span>
                <span class="current">Projects</span>
            </div>
            <div class="header-actions">
                <a href="ProjectCreate.aspx" class="btn-primary">
                    <i class="fa-solid fa-plus"></i>Add New Project
            </a>
                <a href="Home.aspx" class="btn-primary">
                    Back To Dashboard
</a>
            </div>
        </div>

        <div class="pl-wrap">

            <%-- ══ TITLE ROW ══ --%>
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
                        <i class="fa-solid fa-plus"></i>New Project
                </a>
                </div>
            </div>

            <%-- ══ STATS ROW ══ --%>
            <div class="stats-row">
                <div class="stat-card">
                    <div class="stat-icon si-o"><i class="fa-solid fa-building"></i></div>
                    <div>
                        <div class="stat-val" id="sTotal">0</div>
                        <div class="stat-lbl">Total Projects</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon si-g"><i class="fa-solid fa-rocket"></i></div>
                    <div>
                        <div class="stat-val" id="sActive">0</div>
                        <div class="stat-lbl">Live / Active</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon si-b"><i class="fa-solid fa-calendar-check"></i></div>
                    <div>
                        <div class="stat-val" id="sUpcoming">0</div>
                        <div class="stat-lbl">Upcoming</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon si-y"><i class="fa-solid fa-file-pen"></i></div>
                    <div>
                        <div class="stat-val" id="sDraft">0</div>
                        <div class="stat-lbl">Drafts</div>
                    </div>
                </div>
            </div>

            <%-- ══ FILTER BAR ══ --%>
            <div class="filter-bar">
                <div class="search-box">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    <input type="text" id="searchInput" placeholder="Search by name, code, city, RERA..." oninput="filterProjects()" />
                </div>
                <div class="filter-sep"></div>
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
                    <i class="fa-solid fa-xmark"></i>Clear
           
                </button>
                <div class="result-count">Showing <strong id="showCount">0</strong> projects</div>
            </div>

            <%-- ══ GRID VIEW ══ --%>
            <div id="viewGrid">
                <div class="cards-grid" id="cardsGrid"></div>
                <div class="empty-box" id="emptyGrid" style="display: none">
                    <i class="fa-solid fa-building-circle-xmark"></i>
                    <div class="empty-title">No projects found</div>
                    <div class="empty-sub">Try changing filters or add a new project</div>
                    <a href="ProjectCreate.aspx" class="btn-primary" style="display: inline-flex">
                        <i class="fa-solid fa-plus"></i>Add New Project
                </a>
                </div>
            </div>

            <%-- ══ TABLE VIEW ══ --%>
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
                <div class="empty-box" id="emptyTable" style="display: none; border: none; border-radius: 0">
                    <i class="fa-solid fa-building-circle-xmark"></i>
                    <div class="empty-title">No projects found</div>
                    <div class="empty-sub">Try changing filters</div>
                </div>
            </div>

        </div>
        <%-- /pl-wrap --%>

        <%-- ══ DELETE MODAL ══ --%>
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

        <%-- ══ TOAST ══ --%>
        <div class="toast" id="toast">
            <i id="toastIco" class="fa-solid fa-circle-check"></i>
            <span id="toastMsg">Done</span>
        </div>

        <script>
            var allProjects = [];
            var filteredList = [];
            var currentView = 'grid';

            /* ── helpers ── */
            function statusInfo(mode) {
                var m = (mode || 'draft').toLowerCase();
                if (m === 'active') return { cls: 'ps-active', spill: 'spill-active', lbl: 'LIVE' };
                if (m === 'upcoming') return { cls: 'ps-upcoming', spill: 'spill-upcoming', lbl: 'UPCOMING' };
                if (m === 'inactive') return { cls: 'ps-inactive', spill: 'spill-inactive', lbl: 'INACTIVE' };
                return { cls: 'ps-draft', spill: 'spill-draft', lbl: 'DRAFT' };
            }

            function fmtNum(n) {
                if (n == null || n === '') return '-';
                return Number(n).toLocaleString('en-IN');
            }

            function fmtDate(d) {
                if (!d || d === '') return '-';
                try {
                    var dt = new Date(d);
                    if (isNaN(dt)) return d;
                    return dt.toLocaleDateString('en-IN', { day: '2-digit', month: 'short', year: 'numeric' });
                } catch (e) { return d; }
            }

            function esc(s) {
                return (s || '').replace(/&/g, '&amp;').replace(/"/g, '&quot;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
            }

            /* ── make card ── */
            function makeCard(p) {
                var si = statusInfo(p.PublishMode);
                var loc = [p.City, p.StateName].filter(function (x) { return x && x.trim(); }).join(', ') || '-';

                /* Cover */
                var coverInner = p.CoverImagePath
                    ? '<img src="' + esc(p.CoverImagePath) + '" alt=""' +
                    ' onerror="this.style.display=\'none\';this.nextElementSibling.style.display=\'flex\'">' +
                    '<div class="pc-cover-placeholder" style="display:none"><i class="fa-solid fa-image"></i><span>No Image</span></div>'
                    : '<div class="pc-cover-placeholder"><i class="fa-solid fa-image"></i><span>No Image</span></div>';

                /* Price pill */
                var pricePill = p.BSPRatePerSqFt
                    ? '<div class="pc-price-cover">Rs ' + fmtNum(p.BSPRatePerSqFt) + '/sqft</div>'
                    : '<div class="pc-price-cover">Price on Request</div>';

                /* Photo badge */
                var photoBadge = (p.PhotoCount && p.PhotoCount > 0)
                    ? '<div class="pc-photo-count"><i class="fa-regular fa-images"></i> ' + p.PhotoCount + '</div>'
                    : '';

                /* Logo / initials */
                var logoEl;
                if (p.ProjectLogoBadge) {
                    var fbInitials = ((p.ProjectName || 'P').replace(/[^A-Za-z ]/g, '').trim()
                        .split(' ').filter(function (w) { return w; })
                        .slice(0, 2).map(function (w) { return w[0].toUpperCase(); }).join('')) || 'P';
                    logoEl = '<img class="pc-logo" src="' + esc(p.ProjectLogoBadge) + '" alt=""' +
                        ' onerror="this.outerHTML=\'<div class=&quot;pc-logo-initials&quot;>' + esc(fbInitials) + '</div>\'">';
                } else {
                    var initials = ((p.ProjectName || 'P').replace(/[^A-Za-z ]/g, '').trim()
                        .split(' ').filter(function (w) { return w; })
                        .slice(0, 2).map(function (w) { return w[0].toUpperCase(); }).join('')) || 'P';
                    logoEl = '<div class="pc-logo-initials">' + esc(initials) + '</div>';
                }

                /* Possession */
                var possVal = p.PossessionDate ? fmtDate(p.PossessionDate) : (p.PossessionStatus || '-');
                var possCls = (possVal === 'Ready' || possVal === 'Ready To Move') ? 'green' : 'blue';

                /* Spec pills */
                var specs = [];
                if (p.Bedrooms > 0) specs.push('<div class="spec-pill"><i class="fa-solid fa-bed"></i>' + p.Bedrooms + ' BHK</div>');
                if (p.ProjectType) specs.push('<div class="spec-pill"><i class="fa-solid fa-tag"></i>' + esc(p.ProjectType) + '</div>');
                if (p.Parking > 0) specs.push('<div class="spec-pill"><i class="fa-solid fa-square-parking"></i>' + p.Parking + ' Parking</div>');
                if (!specs.length && p.ProjectType) specs.push('<div class="spec-pill"><i class="fa-solid fa-building"></i>' + esc(p.ProjectType) + '</div>');

                var nameForJs = (p.ProjectName || '').replace(/\\/g, '\\\\').replace(/'/g, "\\'");

                return [
                    '<div class="proj-card">',
                    '<div class="pc-cover-wrap">',   /* wrapper — no overflow:hidden */
                    '<div class="pc-cover">',
                    coverInner,
                    '<div class="pc-cover-gradient"></div>',
                    '<span class="pc-status ' + si.cls + '">' + si.lbl + '</span>',
                    photoBadge,
                    pricePill,
                    '</div>',
                    logoEl,                       /* logo sits OUTSIDE pc-cover */
                    '</div>',
                    '<div class="pc-body">',
                    '<div class="pc-code">' + esc(p.ProjectCode || '') + '</div>',
                    '<div class="pc-name">' + esc(p.ProjectName || 'Unnamed Project') + '</div>',
                    '<div class="pc-loc"><i class="fa-solid fa-location-dot"></i>' + esc(loc) + '</div>',
                    '<div class="pc-overview">',
                    '<div><div class="pco-lbl">Total Units</div><div class="pco-val">' + fmtNum(p.TotalUnits) + '</div></div>',
                    '<div><div class="pco-lbl">Area</div><div class="pco-val">' +
                    (p.MinArea ? fmtNum(p.MinArea) + '&ndash;' + fmtNum(p.MaxArea) + ' sq.ft' : '-') +
                    '</div></div>',
                    '<div><div class="pco-lbl">Possession</div><div class="pco-val ' + possCls + '">' + esc(possVal) + '</div></div>',
                    '<div><div class="pco-lbl">Branch</div><div class="pco-val">' + esc(p.BranchName || '-') + '</div></div>',
                    '</div>',
                    specs.length ? '<div class="pc-specs">' + specs.join('') + '</div>' : '',
                    '</div>',
                    '<div class="pc-footer">',
                    '<div class="pc-tags">',
                    '<i class="fa-solid fa-star"></i> ' + (p.AmenityCount || 0) + ' amenities',
                    '&nbsp;&bull;&nbsp;',
                    '<i class="fa-regular fa-file"></i> ' + (p.DocumentCount || 0) + ' docs',
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

            /* ── make table row ── */
            function makeRow(p, i) {
                var si = statusInfo(p.PublishMode);
                var bsp = p.BSPRatePerSqFt ? 'Rs ' + fmtNum(p.BSPRatePerSqFt) : '-';
                var loc = [p.City, p.StateName].filter(function (x) { return x && x.trim(); }).join(', ') || '-';
                var nameForJs = (p.ProjectName || '').replace(/\\/g, '\\\\').replace(/'/g, "\\'");

                return [
                    '<tr>',
                    '<td style="color:var(--slate-2);font-size:.75rem;font-weight:600">' + (i + 1) + '</td>',
                    '<td><div class="tbl-name">' + esc(p.ProjectName || '-') + '</div><div class="tbl-code">' + esc(p.ProjectCode || '') + '</div></td>',
                    '<td>' + esc(p.ProjectType || '-') + '</td>',
                    '<td>' + esc(loc) + '</td>',
                    '<td>' + fmtNum(p.TotalUnits) + '</td>',
                    '<td style="font-weight:600">' + esc(bsp) + '</td>',
                    '<td>' + esc(fmtDate(p.PossessionDate)) + '</td>',
                    '<td><span class="spill ' + si.spill + '">' + si.lbl + '</span></td>',
                    '<td><div style="display:flex;gap:6px">',
                    '<a href="ProjectCreate.aspx?pid=' + p.ProjectID + '" class="pc-btn" title="Edit"><i class="fa-solid fa-pen"></i></a>',
                    '<a href="ProjectDetail.aspx?pid=' + p.ProjectID + '" class="pc-btn" title="View"><i class="fa-solid fa-eye"></i></a>',
                    '<button type="button" class="pc-btn del" title="Delete" onclick="openDelModal(' + p.ProjectID + ',\'' + nameForJs + '\')"><i class="fa-solid fa-trash"></i></button>',
                    '</div></td>',
                    '</tr>'
                ].join('');
            }

            /* ── filter ── */
            function filterProjects() {
                var q = (document.getElementById('searchInput').value || '').toLowerCase().trim();
                var status = (document.getElementById('filterStatus').value || '').toLowerCase();
                var type = (document.getElementById('filterType').value || '').toLowerCase();

                filteredList = allProjects.filter(function (p) {
                    var ms = !q || [p.ProjectName, p.ProjectCode, p.City, p.RERANumber]
                        .some(function (f) { return f && f.toLowerCase().indexOf(q) >= 0; });

                    // status filter — 'draft' matches both 'draft' and blank/null
                    var pm = (p.PublishMode || '').toLowerCase();
                    var mv = !status
                        || pm === status
                        || (status === 'draft' && (pm === '' || pm === 'draft'));

                    var mt = !type || (p.ProjectType || '').toLowerCase().indexOf(type) >= 0;
                    return ms && mv && mt;
                });

                render();
            }

            function clearFilters() {
                document.getElementById('searchInput').value = '';
                document.getElementById('filterStatus').value = '';
                document.getElementById('filterType').value = '';
                filterProjects();
            }

            /* ── render ── */
            function render() {
                document.getElementById('showCount').textContent = filteredList.length;
                if (currentView === 'grid') renderGrid();
                else renderTable();
            }

            function renderGrid() {
                var grid = document.getElementById('cardsGrid');
                var empty = document.getElementById('emptyGrid');
                if (filteredList.length === 0) {
                    grid.innerHTML = '';
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

            /* ── view toggle ── */
            function switchView(v) {
                currentView = v;
                document.getElementById('viewGrid').style.display = v === 'grid' ? 'block' : 'none';
                document.getElementById('viewTable').style.display = v === 'table' ? 'block' : 'none';
                document.getElementById('btnGrid').classList.toggle('active', v === 'grid');
                document.getElementById('btnTable').classList.toggle('active', v === 'table');
                render();
            }

            /* ── stats ── */
            function updateStats() {
                var a = allProjects;
                document.getElementById('sTotal').textContent = a.length;
                document.getElementById('sActive').textContent = a.filter(function (p) { return (p.PublishMode || '').toLowerCase() === 'active'; }).length;
                document.getElementById('sUpcoming').textContent = a.filter(function (p) { return (p.PublishMode || '').toLowerCase() === 'upcoming'; }).length;
                document.getElementById('sDraft').textContent = a.filter(function (p) { var m = (p.PublishMode || '').toLowerCase(); return m === 'draft' || m === ''; }).length;
            }

            /* ── delete modal ── */
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

            /* ── toast ── */
            function showToast(msg, type) {
                var t = document.getElementById('toast');
                var i = document.getElementById('toastIco');
                document.getElementById('toastMsg').textContent = msg;
                t.style.background = 'var(--navy)';
                i.className = 'fa-solid fa-circle-check';
                if (type === 'success') { t.style.background = 'var(--green)'; i.className = 'fa-solid fa-circle-check'; }
                if (type === 'error') { t.style.background = 'var(--red)'; i.className = 'fa-solid fa-circle-xmark'; }
                if (type === 'info') { t.style.background = 'var(--blue)'; i.className = 'fa-solid fa-floppy-disk'; }
                t.classList.add('show');
                setTimeout(function () { t.classList.remove('show'); }, 3500);
            }

            /* ── init (called from code-behind JSON inject) ── */
            function initProjects(data) {
                allProjects = data || [];
                filteredList = allProjects.slice();
                updateStats();
                render();   // uses render() so showCount also updates
            }
    </script>

        <%-- Data inject — litProjectsJSON outputs: <script>initProjects([...]);</script> --%>
        <asp:Literal ID="litProjectsJSON" runat="server" />

    </form>
</body>
</html>
