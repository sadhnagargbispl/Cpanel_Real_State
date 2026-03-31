<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.master" AutoEventWireup="true" CodeFile="property-search.aspx.cs" Inherits="property_search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        :root {
            --navy: #0B1638;
            --deep: #101E4A;
            --ocean: #1756A9;
            --sky: #3B90F5;
            --gold: #E8A020;
            --gold-lt: #F5C96A;
            --cream: #FDF8F0;
            --white: #FFFFFF;
            --mist: #F1F5FB;
            --slate: #64748B;
            --border: #E2EAF5;
            --shadow: 0 4px 32px rgba(11,22,56,.10);
            --shadow-lg: 0 12px 56px rgba(11,22,56,.18);
            --r: 14px;
        }

        *, *::before, *::after {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            font-family: 'Outfit', sans-serif;
            background: var(--cream);
            color: var(--navy);
            overflow-x: hidden;
        }

        /* ── NAVBAR ── */
        nav {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            height: 68px;
            background: rgba(255,255,255,.96);
            backdrop-filter: blur(16px);
            border-bottom: 1px solid var(--border);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 48px;
            box-shadow: 0 2px 20px rgba(11,22,56,.06);
        }

        .nav-logo {
            display: flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
        }

        .nav-logo-mark {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--navy), var(--ocean));
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Cormorant Garamond', serif;
            font-size: 18px;
            font-weight: 700;
            color: var(--gold);
            letter-spacing: -1px;
        }

        .nav-logo-text {
            display: flex;
            flex-direction: column;
            line-height: 1.1;
        }

            .nav-logo-text strong {
                font-size: 14px;
                font-weight: 700;
                color: var(--navy);
            }

            .nav-logo-text span {
                font-size: 10px;
                font-weight: 400;
                color: var(--slate);
                letter-spacing: 1.2px;
                text-transform: uppercase;
            }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 32px;
        }

            .nav-links a {
                font-size: 13.5px;
                font-weight: 500;
                color: var(--slate);
                text-decoration: none;
                transition: color .2s;
                position: relative;
            }

                .nav-links a.active, .nav-links a:hover {
                    color: var(--navy);
                }

                    .nav-links a.active::after {
                        content: '';
                        position: absolute;
                        bottom: -4px;
                        left: 0;
                        right: 0;
                        height: 2px;
                        background: var(--gold);
                        border-radius: 2px;
                    }

        .nav-cta {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .btn-ghost {
            padding: 8px 20px;
            border: 1.5px solid var(--navy);
            border-radius: 8px;
            font-size: 13px;
            font-weight: 600;
            color: var(--navy);
            text-decoration: none;
            transition: all .2s;
            background: transparent;
        }

            .btn-ghost:hover {
                background: var(--navy);
                color: #fff;
            }

        .btn-gold {
            padding: 9px 22px;
            background: linear-gradient(135deg,var(--gold),#C97A10);
            border-radius: 8px;
            font-size: 13px;
            font-weight: 600;
            color: #fff;
            text-decoration: none;
            box-shadow: 0 3px 14px rgba(232,160,32,.35);
            transition: all .2s;
        }

            .btn-gold:hover {
                transform: translateY(-1px);
                box-shadow: 0 6px 20px rgba(232,160,32,.45);
            }

        .hamburger {
            display: none;
            flex-direction: column;
            gap: 5px;
            background: none;
            border: none;
            cursor: pointer;
            padding: 4px;
            z-index: 1100;
        }

            .hamburger span {
                display: block;
                width: 24px;
                height: 2px;
                background: var(--navy);
                border-radius: 2px;
                transition: all .3s;
            }

            .hamburger.open span:nth-child(1) {
                transform: translateY(7px) rotate(45deg);
            }

            .hamburger.open span:nth-child(2) {
                opacity: 0;
            }

            .hamburger.open span:nth-child(3) {
                transform: translateY(-7px) rotate(-45deg);
            }

        /* ── SEARCH PAGE ── */
        .search-page {
            max-width: 1280px;
            margin: 0 auto;
            padding: 100px 48px 80px;
        }

        .sp-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 40px;
            flex-wrap: wrap;
            gap: 20px;
        }

        .sp-label {
            display: inline-block;
            font-size: 10.5px;
            font-weight: 700;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: var(--gold);
            background: rgba(232,160,32,.08);
            border: 1px solid rgba(232,160,32,.2);
            padding: 4px 12px;
            border-radius: 100px;
            margin-bottom: 12px;
        }

        .sp-title {
            font-family: 'Cormorant Garamond', serif;
            font-size: clamp(26px,3.5vw,42px);
            font-weight: 700;
            color: var(--navy);
            line-height: 1.2;
        }

        .sp-sub {
            font-size: 14px;
            color: var(--slate);
            margin-top: 6px;
        }

        /* Filter Bar */
        .filter-bar {
            background: #fff;
            border: 1px solid var(--border);
            border-radius: var(--r);
            padding: 20px 24px;
            display: flex;
            gap: 14px;
            align-items: flex-end;
            flex-wrap: wrap;
            box-shadow: var(--shadow);
            margin-bottom: 36px;
        }

        .fb-group {
            display: flex;
            flex-direction: column;
            gap: 6px;
            flex: 1;
            min-width: 130px;
        }

            .fb-group label {
                font-size: 11px;
                font-weight: 600;
                color: var(--slate);
                text-transform: uppercase;
                letter-spacing: .8px;
            }

            .fb-group select, .fb-group input {
                padding: 10px 14px;
                border: 1.5px solid var(--border);
                border-radius: 8px;
                font-size: 13px;
                font-family: 'Outfit', sans-serif;
                color: var(--navy);
                background: var(--mist);
                outline: none;
                transition: border-color .2s;
                cursor: pointer;
            }

                .fb-group select:focus, .fb-group input:focus {
                    border-color: var(--ocean);
                }

        .fb-btn {
            padding: 11px 26px;
            background: var(--navy);
            color: #fff;
            border: none;
            border-radius: 9px;
            font-size: 13.5px;
            font-weight: 600;
            cursor: pointer;
            transition: background .2s;
            font-family: 'Outfit', sans-serif;
            white-space: nowrap;
            align-self: flex-end;
        }

            .fb-btn:hover {
                background: var(--ocean);
            }

        /* Results bar */
        .results-bar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 24px;
            flex-wrap: wrap;
            gap: 12px;
        }

        .results-count {
            font-size: 14px;
            color: var(--slate);
        }

            .results-count strong {
                color: var(--navy);
            }
        /* Sort */
        .sort-wrap {
            display: flex;
            align-items: center;
            gap: 10px;
        }

            .sort-wrap label {
                font-size: 13px;
                color: var(--slate);
                font-weight: 500;
            }

            .sort-wrap select {
                padding: 8px 12px;
                border: 1.5px solid var(--border);
                border-radius: 8px;
                font-size: 13px;
                background: #fff;
                color: var(--navy);
                font-family: 'Outfit', sans-serif;
                outline: none;
                cursor: pointer;
            }
        /* Layout */
        .sp-layout {
            display: grid;
            grid-template-columns: 260px 1fr;
            gap: 32px;
            align-items: start;
        }

        /* Sidebar */
        .sidebar {
            position: sticky;
            top: 88px;
        }

        .sidebar-card {
            background: #fff;
            border: 1px solid var(--border);
            border-radius: var(--r);
            padding: 24px;
            box-shadow: var(--shadow);
            margin-bottom: 20px;
        }

        .sidebar-title {
            font-family: 'Cormorant Garamond', serif;
            font-size: 18px;
            font-weight: 700;
            color: var(--navy);
            margin-bottom: 18px;
            padding-bottom: 12px;
            border-bottom: 1px solid var(--border);
        }

        .filter-group {
            margin-bottom: 20px;
        }

        .filter-group-title {
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: .9px;
            color: var(--slate);
            margin-bottom: 10px;
        }

        .checkbox-item {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 8px;
            cursor: pointer;
        }

            .checkbox-item input[type=checkbox] {
                accent-color: var(--ocean);
                width: 15px;
                height: 15px;
                cursor: pointer;
                flex-shrink: 0;
            }

            .checkbox-item span {
                font-size: 13px;
                color: var(--navy);
            }

            .checkbox-item .count {
                margin-left: auto;
                font-size: 11px;
                color: var(--slate);
                background: var(--mist);
                padding: 1px 7px;
                border-radius: 100px;
            }

        /* Budget slider */
        .range-wrap {
            padding: 8px 0;
        }

        .range-input {
            width: 100%;
            accent-color: var(--ocean);
            cursor: pointer;
        }

        .range-labels {
            display: flex;
            justify-content: space-between;
            font-size: 12px;
            color: var(--slate);
            margin-top: 6px;
        }

        .budget-current {
            text-align: center;
            font-size: 13px;
            font-weight: 700;
            color: var(--ocean);
            margin-top: 8px;
            background: rgba(23,86,169,.07);
            padding: 4px 10px;
            border-radius: 6px;
        }

        .clear-btn {
            width: 100%;
            padding: 10px;
            border: 1.5px solid var(--border);
            border-radius: 9px;
            background: transparent;
            color: var(--slate);
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: all .2s;
            font-family: 'Outfit', sans-serif;
        }

            .clear-btn:hover {
                border-color: var(--navy);
                color: var(--navy);
            }

        /* Properties Grid */
        .properties-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(290px, 1fr));
            gap: 24px;
        }

        /* Property Card */
        .prop-card {
            background: #fff;
            border-radius: var(--r);
            border: 1px solid var(--border);
            overflow: hidden;
            box-shadow: var(--shadow);
            transition: all .3s;
            cursor: pointer;
            display: flex;
            flex-direction: column;
        }

            .prop-card:hover {
                transform: translateY(-5px);
                box-shadow: var(--shadow-lg);
            }

        .prop-img {
            position: relative;
            height: 200px;
            overflow: hidden;
        }

        .prop-img-real {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform .4s;
            display: block;
        }

        .prop-card:hover .prop-img-real {
            transform: scale(1.07);
        }

        .prop-img-placeholder {
            width: 100%;
            height: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 10px;
            position: relative;
            overflow: hidden;
            transition: transform .4s;
        }

        .prop-card:hover .prop-img-placeholder {
            transform: scale(1.05);
        }

        .prop-img-placeholder::before {
            content: '';
            position: absolute;
            inset: 0;
            background-image: radial-gradient(circle, rgba(255,255,255,.12) 1px, transparent 1px);
            background-size: 22px 22px;
            pointer-events: none;
        }

        .prop-img-placeholder::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 70px;
            background: linear-gradient(to top, rgba(11,22,56,.55), transparent);
            pointer-events: none;
        }

        .ph-emoji {
            font-size: 46px;
            line-height: 1;
            position: relative;
            z-index: 1;
            filter: drop-shadow(0 4px 12px rgba(0,0,0,.3));
        }

        .ph-label {
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: rgba(255,255,255,.75);
            position: relative;
            z-index: 1;
            background: rgba(255,255,255,.1);
            padding: 4px 12px;
            border-radius: 100px;
            border: 1px solid rgba(255,255,255,.2);
            backdrop-filter: blur(4px);
        }

        .ph-plot {
            background: linear-gradient(145deg, #0B2A1A 0%, #145C30 60%, #1C7A40 100%);
        }

        .ph-house {
            background: linear-gradient(145deg, #1A0B2A 0%, #4A1580 60%, #6B2FA0 100%);
        }

        .ph-colony {
            background: linear-gradient(145deg, #0B1638 0%, #133380 55%, #1756A9 100%);
        }

        .ph-township {
            background: linear-gradient(145deg, #2A1A0B 0%, #7A4010 60%, #A05820 100%);
        }

        .ph-commercial {
            background: linear-gradient(145deg, #1A1A1A 0%, #2D2D2D 50%, #404040 100%);
        }

        .ph-default {
            background: linear-gradient(145deg, #0B1638 0%, #1756A9 100%);
        }

        .prop-badge {
            position: absolute;
            top: 14px;
            left: 14px;
            padding: 4px 11px;
            border-radius: 100px;
            font-size: 10.5px;
            font-weight: 700;
            letter-spacing: .4px;
            z-index: 2;
        }

        .badge-hot {
            background: #EF4444;
            color: #fff;
        }

        .badge-new {
            background: #22C55E;
            color: #fff;
        }

        .badge-up {
            background: var(--gold);
            color: #fff;
        }

        .badge-ft {
            background: var(--ocean);
            color: #fff;
        }

        .prop-save {
            position: absolute;
            top: 14px;
            right: 14px;
            width: 32px;
            height: 32px;
            background: rgba(255,255,255,.9);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            cursor: pointer;
            transition: background .2s;
            z-index: 2;
        }

            .prop-save:hover {
                background: #fff;
            }

        .prop-body {
            padding: 20px;
            flex: 1;
        }

        .prop-type {
            font-size: 11px;
            font-weight: 700;
            color: var(--ocean);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 6px;
        }

        .prop-name {
            font-family: 'Cormorant Garamond', serif;
            font-size: 19px;
            font-weight: 700;
            color: var(--navy);
            margin-bottom: 5px;
            line-height: 1.2;
        }

        .prop-loc {
            font-size: 12px;
            color: var(--slate);
            display: flex;
            align-items: center;
            gap: 5px;
            margin-bottom: 14px;
        }

        .prop-meta {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 10px;
            padding-top: 14px;
            border-top: 1px solid var(--border);
        }

        .pm-item {
            display: flex;
            flex-direction: column;
            gap: 2px;
        }

        .pm-lbl {
            font-size: 9.5px;
            font-weight: 600;
            color: var(--slate);
            text-transform: uppercase;
            letter-spacing: .6px;
        }

        .pm-val {
            font-size: 13px;
            font-weight: 700;
            color: var(--navy);
        }

        .prop-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 14px 20px;
            border-top: 1px solid var(--border);
            background: var(--mist);
        }

        .prop-price-lbl {
            font-size: 10.5px;
            color: var(--slate);
        }

        .prop-price {
            font-family: 'Cormorant Garamond', serif;
            font-size: 19px;
            font-weight: 700;
            color: var(--navy);
        }

        .btn-prop {
            padding: 8px 18px;
            background: var(--navy);
            color: #fff;
            border-radius: 8px;
            font-size: 12.5px;
            font-weight: 600;
            text-decoration: none;
            transition: background .2s;
            white-space: nowrap;
        }

            .btn-prop:hover {
                background: var(--ocean);
            }

        /* No results */
        .no-results {
            grid-column: 1 / -1;
            text-align: center;
            padding: 64px 24px;
            color: var(--slate);
        }

        .no-results-icon {
            font-size: 52px;
            margin-bottom: 16px;
        }

        .no-results h3 {
            font-family: 'Cormorant Garamond', serif;
            font-size: 24px;
            color: var(--navy);
            margin-bottom: 8px;
        }

        /* Pagination */
        .pagination {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            margin-top: 48px;
            flex-wrap: wrap;
        }

        .pg-btn {
            width: 38px;
            height: 38px;
            border-radius: 9px;
            border: 1.5px solid var(--border);
            background: #fff;
            font-size: 13px;
            font-weight: 600;
            color: var(--navy);
            cursor: pointer;
            transition: all .2s;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Outfit', sans-serif;
        }

            .pg-btn:hover, .pg-btn.active {
                background: var(--navy);
                color: #fff;
                border-color: var(--navy);
            }

            .pg-btn.prev-next {
                width: auto;
                padding: 0 14px;
                gap: 5px;
            }

        /* Stats band */
        .stats-band {
            background: linear-gradient(135deg, var(--navy) 0%, #1E3A8A 50%, var(--ocean) 100%);
            padding: 64px 48px;
        }

        .stats-inner {
            max-width: 1280px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(4,1fr);
            gap: 32px;
        }

        .stat-item {
            text-align: center;
        }

        .stat-icon {
            width: 56px;
            height: 56px;
            border-radius: 14px;
            background: rgba(232,160,32,.12);
            border: 1px solid rgba(232,160,32,.3);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 14px;
            font-size: 22px;
        }

        .stat-num {
            font-family: 'Cormorant Garamond', serif;
            font-size: 44px;
            font-weight: 700;
            color: var(--gold);
            line-height: 1;
        }

        .stat-lbl {
            font-size: 13px;
            color: rgba(255,255,255,.65);
            margin-top: 6px;
        }

        /* CTA */
        .cta-band {
            background: linear-gradient(135deg, var(--gold) 0%, #C97A10 100%);
            padding: 72px 48px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

            .cta-band::before {
                content: '';
                position: absolute;
                top: -60px;
                right: -60px;
                width: 280px;
                height: 280px;
                border-radius: 50%;
                background: rgba(255,255,255,.1);
            }

            .cta-band::after {
                content: '';
                position: absolute;
                bottom: -70px;
                left: -40px;
                width: 240px;
                height: 240px;
                border-radius: 50%;
                background: rgba(255,255,255,.08);
            }

        .cta-title {
            font-family: 'Cormorant Garamond', serif;
            font-size: clamp(26px,4vw,50px);
            font-weight: 700;
            color: #fff;
            margin-bottom: 14px;
            position: relative;
            z-index: 1;
        }

        .cta-sub {
            font-size: 16px;
            color: rgba(255,255,255,.85);
            margin-bottom: 32px;
            position: relative;
            z-index: 1;
        }

        .cta-btn {
            display: inline-block;
            padding: 14px 36px;
            background: #fff;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 700;
            color: var(--gold);
            text-decoration: none;
            box-shadow: 0 6px 24px rgba(0,0,0,.15);
            transition: all .2s;
            position: relative;
            z-index: 1;
        }

            .cta-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 32px rgba(0,0,0,.2);
            }

        /* Footer */
        footer {
            background: #080F2A;
            padding: 64px 48px 28px;
        }

        .ft-grid {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr;
            gap: 48px;
            margin-bottom: 48px;
        }

        .ft-brand-logo {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 14px;
        }

        .ft-desc {
            font-size: 13px;
            color: rgba(255,255,255,.45);
            line-height: 1.75;
            max-width: 280px;
            margin-bottom: 20px;
        }

        .ft-socials {
            display: flex;
            gap: 10px;
        }

        .ft-social {
            width: 36px;
            height: 36px;
            border-radius: 9px;
            background: rgba(255,255,255,.07);
            border: 1px solid rgba(255,255,255,.1);
            display: flex;
            align-items: center;
            justify-content: center;
            color: rgba(255,255,255,.55);
            font-size: 14px;
            text-decoration: none;
            transition: all .2s;
        }

            .ft-social:hover {
                background: var(--gold);
                color: #fff;
                border-color: var(--gold);
            }

        .ft-col-title {
            font-family: 'Cormorant Garamond', serif;
            font-size: 16px;
            font-weight: 700;
            color: #fff;
            margin-bottom: 18px;
        }

        .ft-links {
            display: flex;
            flex-direction: column;
            gap: 9px;
        }

            .ft-links a {
                font-size: 13px;
                color: rgba(255,255,255,.45);
                text-decoration: none;
                transition: color .2s;
            }

                .ft-links a:hover {
                    color: var(--gold);
                }

        .ft-contact-item {
            display: flex;
            align-items: flex-start;
            gap: 9px;
            margin-bottom: 10px;
        }

        .ft-contact-icon {
            font-size: 15px;
            flex-shrink: 0;
            margin-top: 1px;
        }

        .ft-contact-text {
            font-size: 12.5px;
            color: rgba(255,255,255,.45);
            line-height: 1.5;
        }

        .ft-bottom {
            border-top: 1px solid rgba(255,255,255,.07);
            padding-top: 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 12px;
        }

        .ft-copy {
            font-size: 12.5px;
            color: rgba(255,255,255,.3);
        }

        .ft-bottom-links {
            display: flex;
            gap: 20px;
        }

            .ft-bottom-links a {
                font-size: 12.5px;
                color: rgba(255,255,255,.3);
                text-decoration: none;
            }

                .ft-bottom-links a:hover {
                    color: var(--gold);
                }

        /* Animations */
        .fade-in {
            opacity: 0;
            transform: translateY(20px);
            transition: opacity .55s ease, transform .55s ease;
        }

            .fade-in.visible {
                opacity: 1;
                transform: none;
            }

        /* ══════════════════════════════════════
           MOBILE BOTTOM DRAWER
        ══════════════════════════════════════ */
        .mob-filter-fab {
            display: none;
        }

        .mob-drawer-overlay {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(8,15,42,.55);
            z-index: 800;
            backdrop-filter: blur(4px);
            -webkit-backdrop-filter: blur(4px);
            opacity: 0;
            transition: opacity .3s ease;
        }

            .mob-drawer-overlay.open {
                display: block;
                opacity: 1;
            }

        .mob-drawer {
            display: none;
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            z-index: 900;
            background: #fff;
            border-radius: 22px 22px 0 0;
            max-height: 82vh;
            overflow-y: auto;
            transform: translateY(100%);
            transition: transform .38s cubic-bezier(.32,1,.55,1);
            box-shadow: 0 -8px 56px rgba(11,22,56,.22);
        }

            .mob-drawer.open {
                transform: translateY(0);
            }

        .drawer-handle-bar {
            display: flex;
            justify-content: center;
            padding: 14px 0 6px;
        }

            .drawer-handle-bar::before {
                content: '';
                width: 44px;
                height: 5px;
                background: var(--border);
                border-radius: 10px;
            }

        .drawer-sticky-head {
            position: sticky;
            top: 0;
            background: #fff;
            z-index: 2;
            padding: 0 22px 14px;
            border-bottom: 1px solid var(--border);
        }

        .drawer-top-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .drawer-title {
            font-family: 'Cormorant Garamond', serif;
            font-size: 21px;
            font-weight: 700;
            color: var(--navy);
        }

        .drawer-close-btn {
            width: 34px;
            height: 34px;
            border-radius: 50%;
            background: var(--mist);
            border: 1.5px solid var(--border);
            font-size: 15px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--navy);
            transition: all .2s;
        }

            .drawer-close-btn:hover {
                background: var(--navy);
                color: #fff;
            }

        .drawer-body {
            padding: 20px 22px 0;
        }

        .drawer-apply-btn {
            display: block;
            margin: 20px 22px 28px;
            width: calc(100% - 44px);
            padding: 15px;
            background: linear-gradient(135deg, var(--navy), var(--ocean));
            color: #fff;
            border: none;
            border-radius: 12px;
            font-size: 15px;
            font-weight: 700;
            font-family: 'Outfit', sans-serif;
            cursor: pointer;
            letter-spacing: .3px;
            box-shadow: 0 4px 18px rgba(11,22,56,.25);
            transition: opacity .2s;
        }

            .drawer-apply-btn:active {
                opacity: .85;
            }

        .mob-inline-filter-btn {
            display: none;
        }

        /* ══ MOBILE SMART SEARCH BAR + FILTER POPUP ══ */
        .mob-search-bar {
            display: none;
        }

        .mob-filter-popup {
            display: none;
            position: absolute;
            top: calc(100% + 8px);
            left: 0;
            right: 0;
            background: #fff;
            border-radius: 18px;
            border: 1.5px solid var(--border);
            box-shadow: 0 16px 56px rgba(11,22,56,.20);
            z-index: 600;
            overflow: hidden;
            transform-origin: top center;
            transform: scaleY(.9) translateY(-10px);
            opacity: 0;
            transition: transform .28s cubic-bezier(.32,1,.55,1), opacity .22s ease;
            pointer-events: none;
        }

            .mob-filter-popup.pop-open {
                display: block;
                pointer-events: all;
                transform: scaleY(1) translateY(0);
                opacity: 1;
            }

        .pop-row {
            padding: 13px 16px;
            border-bottom: 1px solid var(--border);
        }

        .pop-label {
            font-size: 10px;
            font-weight: 700;
            color: var(--slate);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 6px;
        }

        .pop-select, .pop-input {
            width: 100%;
            padding: 10px 14px;
            border: 1.5px solid var(--border);
            border-radius: 10px;
            font-size: 13.5px;
            font-family: 'Outfit', sans-serif;
            color: var(--navy);
            background: var(--mist);
            outline: none;
            transition: border-color .2s;
            -webkit-appearance: none;
            appearance: none;
        }

            .pop-select:focus, .pop-input:focus {
                border-color: var(--ocean);
            }

        .pop-actions {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
            padding: 13px 16px 16px;
            background: var(--mist);
        }

        .pop-clear {
            padding: 11px;
            border: 1.5px solid var(--border);
            border-radius: 10px;
            background: #fff;
            font-size: 13px;
            font-weight: 600;
            color: var(--slate);
            cursor: pointer;
            font-family: 'Outfit', sans-serif;
        }

        .pop-apply {
            padding: 11px;
            border: none;
            border-radius: 10px;
            background: linear-gradient(135deg,var(--navy),var(--ocean));
            font-size: 13px;
            font-weight: 700;
            color: #fff;
            cursor: pointer;
            font-family: 'Outfit', sans-serif;
        }

        /* ── RESPONSIVE ── */
        @media (max-width: 1100px) {
            .sp-layout {
                grid-template-columns: 1fr;
            }

            .sidebar {
                position: static;
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 16px;
            }

            .sidebar-card:last-child {
                grid-column: span 2;
            }

            nav {
                padding: 0 24px;
            }

            .stats-inner {
                grid-template-columns: repeat(2,1fr);
            }

            .ft-grid {
                grid-template-columns: 1fr 1fr;
                gap: 32px;
            }

            .stats-band, .search-page, .cta-band {
                padding: 64px 24px;
            }

            footer {
                padding: 56px 24px 24px;
            }
        }

        @media (max-width: 900px) {
            .properties-grid {
                grid-template-columns: repeat(2,1fr);
            }

            .filter-bar {
                gap: 10px;
            }

            .fb-group {
                min-width: 110px;
            }
        }

        @media (max-width: 768px) {
            nav {
                padding: 0 18px;
                height: 60px;
            }

            .nav-links, .nav-cta {
                display: none;
            }

                .nav-links.mob-open {
                    display: flex;
                    flex-direction: column;
                    gap: 0;
                    position: fixed;
                    top: 60px;
                    left: 0;
                    right: 0;
                    background: rgba(255,255,255,.98);
                    backdrop-filter: blur(12px);
                    border-bottom: 1px solid var(--border);
                    z-index: 999;
                    padding: 8px 0;
                    box-shadow: 0 8px 28px rgba(11,22,56,.1);
                }

                    .nav-links.mob-open a {
                        padding: 14px 24px;
                        border-bottom: 1px solid var(--border);
                    }

            .hamburger {
                display: flex;
            }

            .search-page {
                padding: 76px 16px 40px;
            }

            .filter-bar {
                display: none !important;
            }

            .mob-filter-fab {
                display: none !important;
            }

            .sidebar {
                display: none !important;
            }

            .sp-layout {
                grid-template-columns: 1fr;
            }

            .properties-grid {
                grid-template-columns: 1fr;
            }

            /* Smart Search Bar — visible on mobile */
            .mob-search-bar {
                display: flex;
                align-items: center;
                background: #fff;
                border: 1.5px solid var(--border);
                border-radius: 14px;
                box-shadow: var(--shadow);
                margin-bottom: 20px;
                position: relative;
            }

                .mob-search-bar.bar-active {
                    border-color: var(--ocean);
                    box-shadow: 0 0 0 3px rgba(23,86,169,.10);
                }

            .mob-search-input {
                flex: 1;
                border: none;
                background: transparent;
                padding: 14px 12px 14px 16px;
                font-size: 14px;
                font-family: 'Outfit', sans-serif;
                color: var(--navy);
                outline: none;
                min-width: 0;
            }

                .mob-search-input::placeholder {
                    color: #aab4c8;
                }

            .mob-bar-divider {
                width: 1px;
                height: 26px;
                background: var(--border);
                flex-shrink: 0;
            }

            .mob-filter-icon-btn {
                display: flex;
                align-items: center;
                gap: 6px;
                padding: 10px 12px;
                background: transparent;
                border: none;
                cursor: pointer;
                color: var(--slate);
                font-family: 'Outfit', sans-serif;
                font-size: 13px;
                font-weight: 600;
                position: relative;
                flex-shrink: 0;
                transition: color .2s;
            }

                .mob-filter-icon-btn svg {
                    width: 17px;
                    height: 17px;
                    stroke: currentColor;
                    fill: none;
                    stroke-width: 2;
                    stroke-linecap: round;
                }

                .mob-filter-icon-btn.has-filters {
                    color: var(--ocean);
                }

            .mob-filter-dot {
                position: absolute;
                top: 7px;
                right: 7px;
                width: 7px;
                height: 7px;
                border-radius: 50%;
                background: var(--gold);
                border: 2px solid #fff;
                display: none;
            }

            .mob-filter-icon-btn.has-filters .mob-filter-dot {
                display: block;
            }

            .mob-search-go {
                margin: 5px 5px 5px 0;
                width: 40px;
                height: 40px;
                border-radius: 10px;
                background: var(--navy);
                border: none;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                flex-shrink: 0;
                transition: background .2s;
            }

                .mob-search-go:active {
                    background: var(--ocean);
                }

                .mob-search-go svg {
                    width: 16px;
                    height: 16px;
                    stroke: #fff;
                    fill: none;
                    stroke-width: 2.2;
                    stroke-linecap: round;
                }

            /* Drawer visible on mobile */
            .mob-drawer {
                display: block;
            }

            .mob-drawer-overlay {
                display: none;
            }

            .stats-inner {
                grid-template-columns: repeat(2,1fr);
                gap: 18px;
            }

            .stats-band {
                padding: 52px 18px;
            }

            .cta-band {
                padding: 56px 18px;
            }

            footer {
                padding: 48px 18px 20px;
            }

            .ft-grid {
                grid-template-columns: 1fr;
                gap: 28px;
            }

            .ft-bottom {
                flex-direction: column;
                align-items: flex-start;
            }
        }

        @media (max-width: 480px) {
            .stats-inner {
                grid-template-columns: repeat(2,1fr);
                gap: 14px;
            }

            .stat-num {
                font-size: 34px;
            }

            .pagination {
                gap: 6px;
            }

            .pg-btn {
                width: 34px;
                height: 34px;
                font-size: 12px;
            }

            .results-bar {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:HiddenField ID="hfPage" runat="server" Value="1" />
    <asp:HiddenField ID="hfSelectedTypes" runat="server" Value="" />
    <asp:HiddenField ID="hfSelectedStatuses" runat="server" Value="" />
    <asp:HiddenField ID="hfBudgetRange" runat="server" Value="0" />

    <%-- FIX 4: btnSearch is rendered off-screen so __doPostBack always works on mobile --%>
    <%--    <asp:Button ID="btnSearch" runat="server" Text="Search"
        OnClick="btnSearch_Click"
        style="position:absolute;left:-9999px;top:-9999px;width:1px;height:1px;overflow:hidden;opacity:0;pointer-events:none;" />--%>
    <asp:Button ID="btnSearch"
        runat="server"
        Text="Search"
        UseSubmitBehavior="false"
        OnClick="btnSearch_Click"
        Style="position: absolute; left: -9999px; top: -9999px; width: 1px; height: 1px; overflow: hidden; opacity: 0; pointer-events: none;" />
    <!-- MOBILE: Dark overlay behind drawer -->
    <div class="mob-drawer-overlay" id="drawerOverlay" onclick="closeDrawer()"></div>

    <!-- MOBILE: Bottom Slide-Up Drawer -->
    <div class="mob-drawer" id="filterDrawer">

        <div class="drawer-handle-bar"></div>

        <div class="drawer-sticky-head">
            <div class="drawer-top-row">
                <div class="drawer-title">🎯 Refine Search</div>
                <button type="button" class="drawer-close-btn" onclick="closeDrawer()">✕</button>
            </div>
        </div>

        <div class="drawer-body">

            <!-- Property Type (drawer) -->
            <div class="filter-group">
                <div class="filter-group-title">Property Type</div>
                <asp:Repeater ID="rptTypeFilterMob" runat="server">
                    <ItemTemplate>
                        <label class="checkbox-item">
                            <input type="checkbox"
                                class="type-check mob-check"
                                data-typeid="<%# Eval("ProjectTypeID") %>"
                                <%# IsTypeChecked(Eval("ProjectTypeID")) %> />
                            <span><%# Eval("TypeName") %></span>
                            <span class="count"><%# Eval("Count") %></span>
                        </label>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <!-- Budget (drawer) -->
            <div class="filter-group">
                <div class="filter-group-title">Budget Range</div>
                <div class="range-wrap">
                    <input type="range" class="range-input" id="rngBudgetMob"
                        min="0" max="4" value="0"
                        oninput="syncBudgetFromMob(this.value)" />
                    <div class="range-labels"><span>Any</span><span>₹3 Cr+</span></div>
                    <div class="budget-current" id="lblBudgetValMob">Any Budget</div>
                </div>
            </div>

            <!-- Status (drawer) -->
            <div class="filter-group">
                <div class="filter-group-title">Status</div>
                <asp:Repeater ID="rptStatusFilterMob" runat="server">
                    <ItemTemplate>
                        <label class="checkbox-item">
                            <input type="checkbox"
                                class="status-check mob-check"
                                data-statuslabel="<%# Eval("StatusLabel") %>"
                                <%# IsStatusChecked(Eval("StatusLabel")) %> />
                            <span><%# Eval("StatusLabel") %></span>
                            <span class="count"><%# Eval("Count") %></span>
                        </label>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <button type="button" class="clear-btn" onclick="clearFilters(); return false;">✕ Clear All Filters</button>

        </div>

        <button type="button" class="drawer-apply-btn" onclick="applyDrawerFilters()">
            ✅ Apply Filters
       
        </button>

    </div>

    <!-- ═══════════════════════════════════════ SEARCH PAGE -->
    <section id="search-page" class="search-page">

        <div class="sp-header">
            <div class="sp-title-wrap">
                <div class="sp-label">Property Search</div>
                <h2 class="sp-title">Explore Premium Properties</h2>
                <p class="sp-sub">Discover your ideal home across India's fastest-growing cities</p>
            </div>
        </div>

        <!-- MOBILE: Smart Search Bar with Filter Popup -->
        <div class="mob-search-bar" id="mobSearchBar">

            <input class="mob-search-input" id="mobLocInput"
                type="text" placeholder="🔍  Search city, area…"
                oninput="syncMobLocation(this.value)"
                onfocus="document.getElementById('mobSearchBar').classList.add('bar-active')"
                onblur="document.getElementById('mobSearchBar').classList.remove('bar-active')" />

            <div class="mob-bar-divider"></div>

            <button type="button" class="mob-filter-icon-btn" id="mobFilterBtn"
                onclick="toggleFilterPopup(event); return false;">
                <svg viewBox="0 0 24 24">
                    <line x1="4" y1="6" x2="20" y2="6" />
                    <line x1="8" y1="12" x2="16" y2="12" />
                    <line x1="11" y1="18" x2="13" y2="18" />
                </svg>
                <%-- Filters--%>
                <span id="filterLabel">Filters</span>
                <span class="mob-filter-dot"></span>
            </button>

            <button type="button" class="mob-search-go" onclick="doSearch(); return false;">
                <svg viewBox="0 0 24 24">
                    <circle cx="11" cy="11" r="7" />
                    <line x1="16.5" y1="16.5" x2="22" y2="22" />
                </svg>
            </button>

            <!-- Filter Popup -->
            <div class="mob-filter-popup" id="mobFilterPopup">

                <div class="pop-row">
                    <div class="pop-label">Property Type</div>
                    <select class="pop-select" id="popType" onchange="syncPopType(this.value)">
                        <option value="">All Types</option>
                    </select>
                </div>

                <div class="pop-row">
                    <div class="pop-label">Plot Size</div>
                    <select class="pop-select" id="popSize" onchange="syncPopSize(this.value)">
                        <option value="">All Sizes</option>
                    </select>
                </div>

                <div class="pop-row">
                    <div class="pop-label">Status</div>
                    <select class="pop-select" id="popStatus" onchange="syncPopStatus(this.value)">
                        <option value="">All Status</option>
                        <option value="2">Active</option>
                        <option value="3">Upcoming</option>
                        <option value="4">Sold Out</option>
                    </select>
                </div>

                <div class="pop-row">
                    <div class="pop-label">Budget Range</div>
                    <input type="range" class="range-input" id="rngBudgetPop"
                        min="0" max="4" value="0"
                        oninput="syncBudgetFromPop(this.value)" style="margin-bottom: 6px" />
                    <div class="range-labels"><span>Any</span><span>₹3 Cr+</span></div>
                    <div class="budget-current" id="lblBudgetValPop">Any Budget</div>
                </div>

                <div class="pop-actions">
                    <button type="button" class="pop-clear" onclick="clearPopFilters(); return false;">✕ Clear</button>
                    <button type="button" class="pop-apply" onclick="applyPopFilters(); return false;">✅ Apply</button>
                </div>

            </div>
        </div>
        <!-- /mob-search-bar -->

        <!-- Desktop Filter Bar — contains hidden fields only; actual button moved above -->
        <div class="filter-bar">
            <div class="fb-group">
                <label>Location</label>
                <asp:TextBox ID="txtLocation" runat="server" placeholder="Delhi, Jaipur…" />
            </div>
            <div class="fb-group">
                <label>Type</label>
                <asp:DropDownList ID="ddlProjectType" runat="server" ClientIDMode="Static" />
            </div>
            <div class="fb-group">
                <label>Size</label>
                <%-- FIX 1: ClientIDMode="Static" so JS can find it as 'ddlPlotSize' --%>
                <asp:DropDownList ID="ddlPlotSize" runat="server" ClientIDMode="Static" />
            </div>
            <div class="fb-group">
                <label>Status</label>
                <asp:DropDownList ID="ddlStatus" runat="server" ClientIDMode="Static">
                    <asp:ListItem Value="">All Status</asp:ListItem>
                    <asp:ListItem Value="2">Active</asp:ListItem>
                    <asp:ListItem Value="3">Upcoming</asp:ListItem>
                    <asp:ListItem Value="4">Sold Out</asp:ListItem>
                </asp:DropDownList>
            </div>
            <%-- Desktop search button inside filter-bar (visible only on desktop via CSS) --%>
            <button type="button" class="fb-btn" onclick="doSearch(); return false;">🔍 Search</button>
        </div>

        <!-- Results count bar -->
        <%-- <div class="results-bar">
            <div class="results-count">
                Showing <strong>
                    <asp:Label ID="lblResultCount" runat="server" Text="0" /></strong> properties
           
            </div>
        </div>--%>
        <div class="results-bar">
            <div class="results-count">
                Showing <strong>
                    <asp:Label ID="lblResultCount" runat="server" Text="0" /></strong> properties
          
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
        <!-- Layout: sidebar + grid -->
        <div class="sp-layout">

            <!-- DESKTOP SIDEBAR -->
            <aside class="sidebar">
                <div class="sidebar-card">
                    <div class="sidebar-title">🎯 Refine Search</div>

                    <div class="filter-group">
                        <div class="filter-group-title">Property Type</div>
                        <asp:Repeater ID="rptTypeFilter" runat="server">
                            <ItemTemplate>
                                <label class="checkbox-item">
                                    <input type="checkbox"
                                        class="type-check desk-check"
                                        data-typeid="<%# Eval("ProjectTypeID") %>"
                                        <%# IsTypeChecked(Eval("ProjectTypeID")) %> />
                                    <span><%# Eval("TypeName") %></span>
                                    <span class="count"><%# Eval("Count") %></span>
                                </label>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <div class="filter-group">
                        <div class="filter-group-title">Budget Range</div>
                        <div class="range-wrap">
                            <input type="range" class="range-input" id="rngBudget"
                                min="0" max="4" value="0"
                                oninput="updateBudgetLabel(this.value)" />
                            <div class="range-labels">
                                <span>Any</span>
                                <span>₹3 Cr+</span>
                            </div>
                            <div class="budget-current" id="lblBudgetVal">Any Budget</div>
                        </div>
                    </div>

                    <div class="filter-group">
                        <div class="filter-group-title">Status</div>
                        <asp:Repeater ID="rptStatusFilter" runat="server">
                            <ItemTemplate>
                                <label class="checkbox-item">
                                    <input type="checkbox"
                                        class="status-check desk-check"
                                        data-statuslabel="<%# Eval("StatusLabel") %>"
                                        <%# IsStatusChecked(Eval("StatusLabel")) %> />
                                    <span><%# Eval("StatusLabel") %></span>
                                    <span class="count"><%# Eval("Count") %></span>
                                </label>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <button type="button" class="clear-btn" onclick="clearFilters(); return false;">✕ Clear All Filters</button>
                </div>
            </aside>

            <!-- Properties Grid -->
            <div>
                <div class="properties-grid">

                    <asp:Panel ID="pnlNoResults" runat="server" Visible="false" CssClass="no-results">
                        <div class="no-results-icon">🔍</div>
                        <h3>No Properties Found</h3>
                        <p>Try adjusting your filters or search in a different city.</p>
                    </asp:Panel>

                    <asp:Repeater ID="rptProperties" runat="server">
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
                                            <div class="pm-lbl">Total Units</div>
                                            <div class="pm-val"><%# Eval("TotalUnits") %></div>
                                        </div>
                                        <div class="pm-item">
                                            <div class="pm-lbl">Status</div>
                                            <div class="pm-val" style="color: <%# GetStatusColor(Eval("StatusLabel")) %>">
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

                <div class="pagination">
                    <asp:Literal ID="litPagination" runat="server" />
                </div>
            </div>

        </div>
    </section>

    <!-- STATS BAND -->
    <div class="stats-band">
        <div class="stats-inner">
            <div class="stat-item fade-in">
                <div class="stat-icon">🏗️</div>
                <div class="stat-num">500+</div>
                <div class="stat-lbl">Projects Completed</div>
            </div>
            <div class="stat-item fade-in">
                <div class="stat-icon">👨‍👩‍👧</div>
                <div class="stat-num">12K+</div>
                <div class="stat-lbl">Happy Families</div>
            </div>
            <div class="stat-item fade-in">
                <div class="stat-icon">🏙️</div>
                <div class="stat-num">18</div>
                <div class="stat-lbl">Cities Covered</div>
            </div>
            <div class="stat-item fade-in">
                <div class="stat-icon">🤝</div>
                <div class="stat-num">200+</div>
                <div class="stat-lbl">Trusted Agents</div>
            </div>
        </div>
    </div>

    <!-- CTA -->
    <div class="cta-band" id="contact">
        <h2 class="cta-title">Ready to Find Your Dream Property?</h2>
        <p class="cta-sub">Talk to our expert agents today — zero commission, full guidance.</p>
        <a href="#" class="cta-btn">📞 Contact an Agent Now</a>
    </div>

    <!-- ═══════════════════════════════════════ SCRIPTS -->
    <script>
        var budgetLabels = ['Any Budget', 'Under ₹50 Lac', '₹50L – 1 Cr', '₹1 – 3 Cr', '₹3 Cr+'];

        /* ═══════════════════════════════════════════
           BUDGET HELPERS — all sliders stay in sync
        ═══════════════════════════════════════════ */
        function setBudget(v) {
            v = parseInt(v) || 0;
            document.getElementById('<%= hfBudgetRange.ClientID %>').value = v;
            ['lblBudgetVal', 'lblBudgetValMob', 'lblBudgetValPop'].forEach(function (id) {
                var el = document.getElementById(id); if (el) el.textContent = budgetLabels[v];
            });
            ['rngBudget', 'rngBudgetMob', 'rngBudgetPop'].forEach(function (id) {
                var el = document.getElementById(id); if (el) el.value = v;
            });
            updateFilterDot();
        }
        function updateBudgetLabel(v) { setBudget(v); }
        function syncBudgetFromMob(v) { setBudget(v); }
        function syncBudgetFromPop(v) { setBudget(v); }

        /* ═══════════════════════════════════════════
           MOBILE LOCATION SYNC → desktop TextBox
        ═══════════════════════════════════════════ */
        function syncMobLocation(val) {
            var el = document.getElementById('<%= txtLocation.ClientID %>');
            if (el) el.value = val;
            updateFilterDot();
        }

        /* ═══════════════════════════════════════════
           POPUP SELECT SYNC → desktop dropdowns
           ddlProjectType, ddlPlotSize, ddlStatus all have ClientIDMode=Static
        ═══════════════════════════════════════════ */
        function syncPopType(val) {
            var el = document.getElementById('ddlProjectType');
            if (el) el.value = val;
            updateFilterDot();
        }
        function syncPopSize(val) {
            var el = document.getElementById('ddlPlotSize');
            if (el) el.value = val;
            updateFilterDot();
        }
        function syncPopStatus(val) {
            var el = document.getElementById('ddlStatus');
            if (el) el.value = val;
            updateFilterDot();
        }

        /* ═══════════════════════════════════════════
           FIX 2: DRAWER CHECKBOXES ↔ DESKTOP SIDEBAR SYNC
           When a mob-check changes, mirror to matching desk-check & vice-versa
        ═══════════════════════════════════════════ */
        function syncPeerCheckboxes(changedCb) {
            var typeId = changedCb.getAttribute('data-typeid');
            var statusLbl = changedCb.getAttribute('data-statuslabel');
            var selector = typeId
                ? '.type-check[data-typeid="' + typeId + '"]'
                : '.status-check[data-statuslabel="' + statusLbl + '"]';
            document.querySelectorAll(selector).forEach(function (cb) {
                if (cb !== changedCb) cb.checked = changedCb.checked;
            });
            updateFilterDot();
        }

        /* ═══════════════════════════════════════════
           FILTER DOT — orange indicator on Filters btn
        ═══════════════════════════════════════════ */
    <%--    function updateFilterDot() {
            var dType = document.getElementById('ddlProjectType');
            var dSize = document.getElementById('ddlPlotSize');
            var dStatus = document.getElementById('ddlStatus');
            var budget = parseInt(document.getElementById('<%= hfBudgetRange.ClientID %>').value) || 0;
            var mobLoc = document.getElementById('mobLocInput');
            var deskLoc = document.getElementById('<%= txtLocation.ClientID %>');
            var hasLoc = (mobLoc && mobLoc.value.trim()) || (deskLoc && deskLoc.value.trim());
            var hasChk = document.querySelectorAll('.type-check:checked, .status-check:checked').length > 0;
            var has = !!((dType && dType.value) || (dSize && dSize.value) || (dStatus && dStatus.value) || budget > 0 || hasLoc || hasChk);
            var btn = document.getElementById('mobFilterBtn');
            if (btn) btn.classList.toggle('has-filters', has);
        }--%>
        function updateFilterDot() {

            var count = 0;

            var dType = document.getElementById('ddlProjectType');
            var dSize = document.getElementById('ddlPlotSize');
            var dStatus = document.getElementById('ddlStatus');

            var budget = parseInt(
                document.getElementById('<%= hfBudgetRange.ClientID %>').value
            ) || 0;

            var mobLoc = document.getElementById('mobLocInput');
            var deskLoc = document.getElementById('<%= txtLocation.ClientID %>');


            // ===============================
            // LOCATION FILTER
            // ===============================
            if (
                (mobLoc && mobLoc.value.trim() !== "") ||
                (deskLoc && deskLoc.value.trim() !== "")
            ) {
                count++;
            }


            // ===============================
            // DROPDOWN FILTERS (ignore "0")
            // ===============================
            if (dType && dType.value && dType.value !== "0")
                count++;

            if (dSize && dSize.value && dSize.value !== "0")
                count++;

            if (dStatus && dStatus.value && dStatus.value !== "0")
                count++;


            // ===============================
            // BUDGET FILTER
            // ===============================
            if (budget > 0)
                count++;


            // ===============================
            // PROPERTY TYPE CHECKBOXES
            // (avoid mobile + desktop duplicates)
            // ===============================
            var typeSet = {};

            document.querySelectorAll('.type-check:checked')
                .forEach(function (cb) {

                    var id = cb.getAttribute('data-typeid');

                    if (id)
                        typeSet[id] = true;
                });

            count += Object.keys(typeSet).length;


            // ===============================
            // STATUS CHECKBOXES
            // ===============================
            var statusSet = {};

            document.querySelectorAll('.status-check:checked')
                .forEach(function (cb) {

                    var lbl = cb.getAttribute('data-statuslabel');

                    if (lbl)
                        statusSet[lbl] = true;
                });

            count += Object.keys(statusSet).length;


            // ===============================
            // UPDATE BUTTON UI
            // ===============================
            var btn = document.getElementById('mobFilterBtn');
            var lbl = document.getElementById('filterLabel');

            if (btn)
                btn.classList.toggle('has-filters', count > 0);

            if (lbl)
                lbl.innerText = count > 0
                    ? "Filters (" + count + ")"
                    : "Filters";
        }
        /* ═══════════════════════════════════════════
           POPUP OPEN / CLOSE
        ═══════════════════════════════════════════ */
        function toggleFilterPopup(e) {
            if (e) e.stopPropagation();
            var popup = document.getElementById('mobFilterPopup');
            if (!popup) return;
            if (popup.classList.contains('pop-open')) {
                closeFilterPopup();
            } else {
                mirrorOptionsToPopup();
                mirrorDesktopToPopup();
                popup.classList.add('pop-open');
            }
        }
        function closeFilterPopup() {
            var popup = document.getElementById('mobFilterPopup');
            if (popup) popup.classList.remove('pop-open');
        }

        /* Copy <option> list from desktop dropdowns into popup selects */
        function mirrorOptionsToPopup() {
            [['ddlProjectType', 'popType'], ['ddlPlotSize', 'popSize']].forEach(function (pair) {
                var src = document.getElementById(pair[0]);
                var dst = document.getElementById(pair[1]);
                if (!src || !dst) return;
                while (dst.options.length > 1) dst.remove(1);
                Array.from(src.options).forEach(function (opt, i) {
                    if (i === 0) return;
                    var o = document.createElement('option');
                    o.value = opt.value; o.text = opt.text;
                    dst.appendChild(o);
                });
            });
        }

        /* Set popup selects to match current desktop values */
        function mirrorDesktopToPopup() {
            [['ddlProjectType', 'popType'], ['ddlPlotSize', 'popSize'], ['ddlStatus', 'popStatus']].forEach(function (pair) {
                var src = document.getElementById(pair[0]);
                var dst = document.getElementById(pair[1]);
                if (src && dst) dst.value = src.value;
            });
            var budget = parseInt(document.getElementById('<%= hfBudgetRange.ClientID %>').value) || 0;
            var rng = document.getElementById('rngBudgetPop');
            var lbl = document.getElementById('lblBudgetValPop');
            if (rng) rng.value = budget;
            if (lbl) lbl.textContent = budgetLabels[budget];
            var deskLoc = document.getElementById('<%= txtLocation.ClientID %>');
            var mobLoc = document.getElementById('mobLocInput');
            if (deskLoc && mobLoc && !mobLoc.value) mobLoc.value = deskLoc.value;
        }

        /* ═══════════════════════════════════════════
           POPUP CLEAR / APPLY
        ═══════════════════════════════════════════ */
        function clearPopFilters() {
            ['popType', 'popSize', 'popStatus'].forEach(function (id) { var el = document.getElementById(id); if (el) el.selectedIndex = 0; });
            ['ddlProjectType', 'ddlPlotSize', 'ddlStatus'].forEach(function (id) { var el = document.getElementById(id); if (el) el.selectedIndex = 0; });
            var mobLoc = document.getElementById('mobLocInput');
            var deskLoc = document.getElementById('<%= txtLocation.ClientID %>');
            if (mobLoc) mobLoc.value = '';
            if (deskLoc) deskLoc.value = '';
            setBudget(0);
            document.querySelectorAll('.type-check, .status-check').forEach(function (cb) { cb.checked = false; });
            document.getElementById('<%= hfSelectedTypes.ClientID %>').value = '';
            document.getElementById('<%= hfSelectedStatuses.ClientID %>').value = '';
            updateFilterDot();
        }

        function applyPopFilters() {
            // FIX 3: sync mob location → desktop before postback
            var mobLoc = document.getElementById('mobLocInput');
            var deskLoc = document.getElementById('<%= txtLocation.ClientID %>');
            if (mobLoc && deskLoc) deskLoc.value = mobLoc.value;
            closeFilterPopup();
            doSearch();
        }

        /* ═══════════════════════════════════════════
           CHECKBOXES → HIDDEN FIELDS
        ═══════════════════════════════════════════ */
        function syncCheckboxes() {
            var types = [];
            // De-duplicate: use a Set keyed by typeid so mob+desk dupes don't double-count
            var typeSet = {};
            document.querySelectorAll('.type-check:checked').forEach(function (cb) {
                var id = cb.getAttribute('data-typeid');
                if (id) typeSet[id] = true;
            });
            types = Object.keys(typeSet);
            document.getElementById('<%= hfSelectedTypes.ClientID %>').value = types.join(',');

            var statusSet = {};
            document.querySelectorAll('.status-check:checked').forEach(function (cb) {
                var lbl = cb.getAttribute('data-statuslabel');
                if (lbl) statusSet[lbl] = true;
            });
            document.getElementById('<%= hfSelectedStatuses.ClientID %>').value = Object.keys(statusSet).join(',');
        }

        /* ═══════════════════════════════════════════
           SEARCH TRIGGER
        ═══════════════════════════════════════════ */
        function doSearch() {
            // FIX 3: always sync mob location → desktop before postback
            var mobLoc = document.getElementById('mobLocInput');
            var deskLoc = document.getElementById('<%= txtLocation.ClientID %>');
            if (mobLoc && deskLoc) deskLoc.value = mobLoc.value;

            syncCheckboxes();
            document.getElementById('<%= hfPage.ClientID %>').value = '1';
            // FIX 4: trigger the off-screen btnSearch
            __doPostBack('<%= btnSearch.UniqueID %>', '');
        }

        function goPage(n) {
            var mobLoc = document.getElementById('mobLocInput');
            var deskLoc = document.getElementById('<%= txtLocation.ClientID %>');
            if (mobLoc && deskLoc) deskLoc.value = mobLoc.value;
            syncCheckboxes();
            document.getElementById('<%= hfPage.ClientID %>').value = n;
            __doPostBack('<%= btnSearch.UniqueID %>', '');
        }

        /* ═══════════════════════════════════════════
           CLEAR ALL
        ═══════════════════════════════════════════ */
        function clearFilters() {
            clearPopFilters();
            doSearch();
        }

        /* ═══════════════════════════════════════════
           DRAWER
        ═══════════════════════════════════════════ */
        function openDrawer() {
            var drawer = document.getElementById('filterDrawer');
            var overlay = document.getElementById('drawerOverlay');
            if (!drawer) return;
            drawer.classList.add('open');
            overlay.style.display = 'block';
            setTimeout(function () { overlay.classList.add('open'); }, 10);
            document.body.style.overflow = 'hidden';
        }
        function closeDrawer() {
            var drawer = document.getElementById('filterDrawer');
            var overlay = document.getElementById('drawerOverlay');
            if (!drawer) return;
            drawer.classList.remove('open');
            overlay.classList.remove('open');
            setTimeout(function () { overlay.style.display = 'none'; }, 320);
            document.body.style.overflow = '';
        }
        function applyDrawerFilters() {
            // FIX 3: sync location before postback
            var mobLoc = document.getElementById('mobLocInput');
            var deskLoc = document.getElementById('<%= txtLocation.ClientID %>');
            if (mobLoc && deskLoc) deskLoc.value = mobLoc.value;
            closeDrawer();
            setTimeout(doSearch, 60);
        }

        /* ═══════════════════════════════════════════
           DOM READY
        ═══════════════════════════════════════════ */
        document.addEventListener('DOMContentLoaded', function () {

            // 1. Restore budget from hidden field (postback safe)
            var savedBudget = parseInt(document.getElementById('<%= hfBudgetRange.ClientID %>').value) || 0;
            setBudget(savedBudget);

            // 2. Mirror desktop → popup
            mirrorOptionsToPopup();
            mirrorDesktopToPopup();
            updateFilterDot();

            // 3. Sync mob location from desktop (postback restore)
            var deskLoc = document.getElementById('<%= txtLocation.ClientID %>');
            var mobLoc = document.getElementById('mobLocInput');
            if (deskLoc && mobLoc) mobLoc.value = deskLoc.value;

            // 4. Desktop budget slider — search on release
            var rng = document.getElementById('rngBudget');
            if (rng) rng.addEventListener('change', function () { doSearch(); });

            // 5. Desktop sidebar checkboxes — search immediately on change
            document.querySelectorAll('.desk-check').forEach(function (cb) {
                cb.addEventListener('change', function () {
                    syncPeerCheckboxes(cb);   // FIX 2: mirror to drawer
                    doSearch();
                });
            });

            // 6. FIX 2: Drawer checkboxes — mirror to desktop, update dot only (search on Apply)
            document.querySelectorAll('.mob-check').forEach(function (cb) {
                cb.addEventListener('change', function () {
                    syncPeerCheckboxes(cb);
                });
            });

            // 7. Close popup when tapping outside search bar
            document.addEventListener('click', function (e) {
                var bar = document.getElementById('mobSearchBar');
                var popup = document.getElementById('mobFilterPopup');
                if (bar && popup && popup.classList.contains('pop-open') && !bar.contains(e.target)) {
                    closeFilterPopup();
                }
            });

            // 8. Swipe down to close drawer
            var drawer = document.getElementById('filterDrawer');
            if (drawer) {
                var touchY = 0;
                drawer.addEventListener('touchstart', function (e) { touchY = e.touches[0].clientY; }, { passive: true });
                drawer.addEventListener('touchend', function (e) {
                    if (e.changedTouches[0].clientY - touchY > 80) closeDrawer();
                }, { passive: true });
            }

            // 9. Fade-in observer
            var obs = new IntersectionObserver(function (entries) {
                entries.forEach(function (e, i) {
                    if (e.isIntersecting) setTimeout(function () { e.target.classList.add('visible'); }, i * 80);
                });
            }, { threshold: 0.08 });
            document.querySelectorAll('.fade-in').forEach(function (el) { obs.observe(el); });

            // 10. Wishlist heart toggle
            document.querySelectorAll('.prop-save').forEach(function (btn) {
                btn.addEventListener('click', function (e) {
                    e.stopPropagation();
                    btn.textContent = btn.textContent.trim() === '♡' ? '❤️' : '♡';
                });
            });
        });
    </script>

</asp:Content>
