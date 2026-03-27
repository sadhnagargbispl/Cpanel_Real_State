<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.master" AutoEventWireup="true" CodeFile="property-search.aspx.cs" Inherits="property_search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
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

        /* ── HERO ── */
        .hero {
            min-height: 100vh;
            padding-top: 68px;
            background: linear-gradient(155deg, #0B1638 0%, #133380 55%, #1756A9 100%);
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
        }

        .hero-pattern {
            position: absolute;
            inset: 0;
            pointer-events: none;
            background-image: radial-gradient(circle at 20% 50%, rgba(232,160,32,.12) 0%, transparent 50%), radial-gradient(circle at 80% 20%, rgba(59,144,245,.15) 0%, transparent 50%), linear-gradient(rgba(255,255,255,.03) 1px,transparent 1px), linear-gradient(90deg,rgba(255,255,255,.03) 1px,transparent 1px);
            background-size: 100% 100%, 100% 100%, 56px 56px, 56px 56px;
        }

        .hero-inner {
            position: relative;
            z-index: 2;
            max-width: 1280px;
            margin: 0 auto;
            padding: 72px 48px;
            display: grid;
            grid-template-columns: 1fr 420px;
            gap: 72px;
            align-items: center;
        }

        .hero-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: rgba(232,160,32,.15);
            border: 1px solid rgba(232,160,32,.4);
            color: var(--gold-lt);
            font-size: 11px;
            font-weight: 600;
            letter-spacing: 1.8px;
            text-transform: uppercase;
            padding: 6px 14px;
            border-radius: 100px;
            margin-bottom: 24px;
        }

        .hero-badge-dot {
            width: 6px;
            height: 6px;
            background: var(--gold);
            border-radius: 50%;
            animation: blink 2s infinite;
        }

        @keyframes blink {
            0%,100% {
                opacity: 1;
                transform: scale(1)
            }

            50% {
                opacity: .4;
                transform: scale(1.5)
            }
        }

        .hero-title {
            font-family: 'Cormorant Garamond', serif;
            font-size: clamp(40px, 5.5vw, 72px);
            font-weight: 700;
            line-height: 1.05;
            color: #fff;
            margin-bottom: 22px;
        }

            .hero-title em {
                font-style: italic;
                color: var(--gold);
            }

        .hero-sub {
            font-size: 16px;
            color: rgba(255,255,255,.65);
            line-height: 1.75;
            max-width: 480px;
            margin-bottom: 44px;
        }

        .hero-actions {
            display: flex;
            gap: 14px;
            flex-wrap: wrap;
            margin-bottom: 52px;
        }

        .btn-hero-primary {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 15px 32px;
            background: linear-gradient(135deg,var(--gold),#C97A10);
            border-radius: 10px;
            font-size: 15px;
            font-weight: 600;
            color: #fff;
            text-decoration: none;
            box-shadow: 0 6px 24px rgba(232,160,32,.45);
            transition: all .25s;
        }

            .btn-hero-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 32px rgba(232,160,32,.55);
            }

        .btn-hero-outline {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 15px 32px;
            border: 2px solid rgba(255,255,255,.35);
            border-radius: 10px;
            font-size: 15px;
            font-weight: 600;
            color: #fff;
            text-decoration: none;
            backdrop-filter: blur(4px);
            transition: all .25s;
        }

            .btn-hero-outline:hover {
                background: rgba(255,255,255,.12);
                border-color: rgba(255,255,255,.7);
            }

        .hero-stats {
            display: flex;
            gap: 40px;
            flex-wrap: wrap;
        }

        .hero-stat-num {
            font-family: 'Cormorant Garamond', serif;
            font-size: 34px;
            font-weight: 700;
            color: var(--gold);
            line-height: 1;
        }

        .hero-stat-lbl {
            font-size: 11px;
            color: rgba(255,255,255,.55);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-top: 4px;
        }

        /* Search Card */
        .search-card {
            background: rgba(255,255,255,.10);
            backdrop-filter: blur(24px);
            border: 1px solid rgba(255,255,255,.18);
            border-radius: 22px;
            padding: 32px;
            animation: slideUp .7s ease .2s both;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(28px)
            }

            to {
                opacity: 1;
                transform: translateY(0)
            }
        }

        .search-card-title {
            font-family: 'Cormorant Garamond', serif;
            font-size: 22px;
            font-weight: 700;
            color: #fff;
            margin-bottom: 22px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .search-tabs {
            display: flex;
            gap: 4px;
            background: rgba(0,0,0,.2);
            border-radius: 10px;
            padding: 4px;
            margin-bottom: 22px;
        }

        .stab {
            flex: 1;
            padding: 8px 6px;
            border: none;
            border-radius: 7px;
            background: transparent;
            color: rgba(255,255,255,.55);
            font-size: 12.5px;
            font-weight: 500;
            cursor: pointer;
            transition: all .2s;
            font-family: 'Outfit', sans-serif;
        }

            .stab.active {
                background: #fff;
                color: var(--navy);
                font-weight: 700;
            }

        .fg {
            margin-bottom: 14px;
        }

            .fg label {
                display: block;
                font-size: 11px;
                font-weight: 600;
                color: rgba(255,255,255,.6);
                text-transform: uppercase;
                letter-spacing: .9px;
                margin-bottom: 7px;
            }

            .fg input, .fg select {
                width: 100%;
                padding: 11px 14px;
                background: rgba(255,255,255,.11);
                border: 1px solid rgba(255,255,255,.2);
                border-radius: 9px;
                color: #fff;
                font-size: 13.5px;
                outline: none;
                transition: border-color .2s;
                font-family: 'Outfit', sans-serif;
            }

                .fg input::placeholder {
                    color: white;
                }

                .fg input:focus, .fg select:focus {
                    border-color: var(--gold);
                }

                .fg select option {
                    background: var(--navy);
                    color: #fff;
                }

        .frow {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
        }

        .btn-search {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg,var(--gold),#C97A10);
            border: none;
            border-radius: 10px;
            color: #fff;
            font-size: 14.5px;
            font-weight: 700;
            cursor: pointer;
            box-shadow: 0 4px 18px rgba(232,160,32,.4);
            transition: all .2s;
            margin-top: 6px;
            font-family: 'Outfit', sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

            .btn-search:hover {
                transform: translateY(-1px);
                box-shadow: 0 8px 26px rgba(232,160,32,.5);
            }

        /* ── MARQUEE ── */
        .marquee-wrap {
            background: var(--navy);
            padding: 14px 0;
            overflow: hidden;
        }

        .marquee-track {
            display: flex;
            gap: 56px;
            animation: marquee 26s linear infinite;
            white-space: nowrap;
        }

        @keyframes marquee {
            from {
                transform: translateX(0)
            }

            to {
                transform: translateX(-50%)
            }
        }

        .marquee-item {
            display: flex;
            align-items: center;
            gap: 10px;
            color: rgba(255,255,255,.6);
            font-size: 12.5px;
            font-weight: 500;
            letter-spacing: .4px;
        }

        .marquee-dot {
            width: 5px;
            height: 5px;
            background: var(--gold);
            border-radius: 50%;
            flex-shrink: 0;
        }

        /* ── SEARCH RESULTS PAGE ── */
        .search-page {
            max-width: 1280px;
            margin: 0 auto;
            padding: 80px 48px;
        }

        .sp-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 40px;
            flex-wrap: wrap;
            gap: 20px;
        }

        .sp-title-wrap {
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

        /* Sort + Results count bar */
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

        /* Layout: sidebar + grid */
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

        .prop-img-bg {
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 52px;
            transition: transform .4s;
        }

        .prop-card:hover .prop-img-bg {
            transform: scale(1.07);
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

        /* Featured card - spans 2 cols */
        .prop-card.featured {
            grid-column: span 2;
        }

            .prop-card.featured .prop-img {
                height: 260px;
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

        /* ── STATS BAND ── */
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

        /* ── CTA ── */
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

        /* ── FOOTER ── */
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

        /* ── ANIMATIONS ── */
        .fade-in {
            opacity: 0;
            transform: translateY(20px);
            transition: opacity .55s ease, transform .55s ease;
        }

            .fade-in.visible {
                opacity: 1;
                transform: none;
            }

        /* ═══════════════ RESPONSIVE ═══════════════ */
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

            .hero-inner {
                padding: 60px 24px;
                gap: 40px;
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
            .hero-inner {
                grid-template-columns: 1fr;
            }

            .search-card {
                max-width: 540px;
            }

            .properties-grid {
                grid-template-columns: repeat(2,1fr);
            }

            .prop-card.featured {
                grid-column: span 1;
            }

                .prop-card.featured .prop-img {
                    height: 200px;
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

                .nav-cta.mob-open {
                    display: flex;
                    flex-direction: column;
                    position: fixed;
                    left: 0;
                    right: 0;
                    background: rgba(255,255,255,.98);
                    padding: 14px 18px 18px;
                    border-bottom: 2px solid var(--border);
                    z-index: 998;
                    box-shadow: 0 8px 28px rgba(11,22,56,.1);
                }

                    .nav-cta.mob-open a {
                        width: 100%;
                        text-align: center;
                        justify-content: center;
                    }

            .hamburger {
                display: flex;
            }

            .hero {
                padding-top: 60px;
            }

            .hero-inner {
                grid-template-columns: 1fr;
                padding: 44px 18px;
                gap: 32px;
            }

            .hero-title {
                font-size: clamp(32px,9vw,48px);
            }

            .hero-actions {
                flex-direction: column;
                gap: 10px;
            }

            .btn-hero-primary, .btn-hero-outline {
                width: 100%;
                justify-content: center;
            }

            .hero-stats {
                gap: 24px;
            }

            .hero-stat-num {
                font-size: 28px;
            }

            .search-card {
                padding: 22px 18px;
            }

            .frow {
                grid-template-columns: 1fr;
            }

            .search-page {
                padding: 52px 18px;
            }

            .filter-bar {
                flex-direction: column;
                align-items: stretch;
            }

            .fb-group {
                min-width: 100%;
            }

            .fb-btn {
                width: 100%;
                text-align: center;
            }

            .sp-layout {
                grid-template-columns: 1fr;
            }

            .sidebar {
                display: block;
            }

            .sidebar-card {
                display: none;
            }

                .sidebar-card.mob-show {
                    display: block;
                }

            .properties-grid {
                grid-template-columns: 1fr;
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
            .hero-badge {
                font-size: 9.5px;
            }

            .stats-inner {
                grid-template-columns: repeat(2,1fr);
                gap: 14px;
            }

            .stat-num {
                font-size: 34px;
            }

            .prop-meta {
                grid-template-columns: repeat(3,1fr);
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
    <!-- HERO -->


    <!-- MARQUEE -->


    <!-- SEARCH RESULTS PAGE -->
    <section id="search-page" class="search-page">
        <div class="sp-header">
            <div class="sp-title-wrap">
                <div class="sp-label">Property Search</div>
                <h2 class="sp-title">Explore Premium Properties</h2>
                <p class="sp-sub">Discover your ideal home across India's fastest-growing cities</p>
            </div>
        </div>

        <!-- Quick Filter Bar -->
        <div class="filter-bar">
            <div class="fb-group">
                <label>Location</label>
                <input type="text" placeholder="Delhi, Jaipur…">
            </div>
            <div class="fb-group">
                <label>Type</label>
                <asp:DropDownList ID="ddlProjectType" runat="server"
                    ClientIDMode="Static">
                    <%--     <asp:ListItem Value="">All Types</asp:ListItem>
     <asp:ListItem Value="Plot">Plot</asp:ListItem>
     <asp:ListItem Value="House">House</asp:ListItem>
     <asp:ListItem Value="Colony">Colony</asp:ListItem>
     <asp:ListItem Value="Township">Township</asp:ListItem>--%>
                </asp:DropDownList>
                <%--   <select>
                    <option>All Types</option>
                    <option>Plot</option>
                    <option>House</option>
                    <option>Colony</option>
                    <option>Township</option>
                </select>--%>
            </div>
            <div class="fb-group">
                <label>Budget</label>
                <select>
                    <option>Any Budget</option>
                    <option>Under ₹50 Lac</option>
                    <option>₹50L – 1 Cr</option>
                    <option>₹1–3 Crore</option>
                    <option>₹3 Crore+</option>
                </select>
            </div>
            <div class="fb-group">
                <label>Size</label>
                <asp:DropDownList ID="ddlPlotSize" runat="server"
                    ClientIDMode="Static">
                    <%--       <asp:ListItem Value="">Any Size</asp:ListItem>
       <asp:ListItem Value="3 Marla">3 Marla</asp:ListItem>
       <asp:ListItem Value="5 Marla">5 Marla</asp:ListItem>
       <asp:ListItem Value="10 Marla">10 Marla</asp:ListItem>
       <asp:ListItem Value="1 Kanal">1 Kanal</asp:ListItem>
       <asp:ListItem Value="2 Kanal+">2 Kanal+</asp:ListItem>--%>
                </asp:DropDownList>
                <%--    <select>
                    <option>Any Size</option>
                    <option>3 Marla</option>
                    <option>5 Marla</option>
                    <option>10 Marla</option>
                    <option>1 Kanal</option>
                </select>--%>
            </div>
            <div class="fb-group">
                <label>Status</label>
                <select>
                    <option>All Status</option>
                    <option>Active</option>
                    <option>Upcoming</option>
                    <option>Sold Out</option>
                </select>
            </div>
            <button class="fb-btn">🔍 Search</button>
        </div>

        <!-- Results bar -->
        <div class="results-bar">
            <div class="results-count">Showing <strong>24 properties</strong> out of 248 results</div>
          <%--  <div class="sort-wrap">
                <label>Sort by:</label>
                <select>
                    <option>Newest First</option>
                    <option>Price: Low to High</option>
                    <option>Price: High to Low</option>
                    <option>Most Popular</option>
                </select>
            </div>--%>
        </div>

        <!-- Layout -->
        <div class="sp-layout">

            <!-- SIDEBAR -->
            <aside class="sidebar">
                <div class="sidebar-card mob-show">
                    <div class="sidebar-title">🎯 Refine Search</div>

                    <div class="filter-group">
                        <div class="filter-group-title">Property Type</div>
                        <label class="checkbox-item">
                            <input type="checkbox" checked><span>Plots</span><span class="count">248</span></label>
                        <label class="checkbox-item">
                            <input type="checkbox"><span>Houses</span><span class="count">132</span></label>
                        <label class="checkbox-item">
                            <input type="checkbox"><span>Colonies</span><span class="count">56</span></label>
                        <label class="checkbox-item">
                            <input type="checkbox"><span>Townships</span><span class="count">18</span></label>
                        <label class="checkbox-item">
                            <input type="checkbox"><span>Commercial</span><span class="count">44</span></label>
                    </div>

                    <div class="filter-group">
                        <div class="filter-group-title">Budget Range</div>
                        <div class="range-wrap">
                            <input type="range" class="range-input" min="0" max="100" value="60">
                            <div class="range-labels"><span>₹10 Lac</span><span>₹3 Cr+</span></div>
                        </div>
                    </div>

                    <%--<div class="filter-group">
                        <div class="filter-group-title">City</div>
                        <label class="checkbox-item">
                            <input type="checkbox" checked><span>Delhi</span><span class="count">89</span></label>
                        <label class="checkbox-item">
                            <input type="checkbox"><span>Jaipur</span><span class="count">67</span></label>
                        <label class="checkbox-item">
                            <input type="checkbox"><span>Noida</span><span class="count">54</span></label>
                        <label class="checkbox-item">
                            <input type="checkbox"><span>Lucknow</span><span class="count">38</span></label>
                        <label class="checkbox-item">
                            <input type="checkbox"><span>Chandigarh</span><span class="count">29</span></label>
                    </div>--%>

                    <div class="filter-group">
                        <div class="filter-group-title">Status</div>
                        <label class="checkbox-item">
                            <input type="checkbox" checked><span>Active</span><span class="count">156</span></label>
                        <label class="checkbox-item">
                            <input type="checkbox"><span>Upcoming</span><span class="count">72</span></label>
                        <label class="checkbox-item">
                            <input type="checkbox"><span>Pre-Launch</span><span class="count">20</span></label>
                    </div>

                    <button class="clear-btn">✕ Clear All Filters</button>
                </div>
            </aside>

            <!-- PROPERTIES GRID -->
            <div>
                <div class="properties-grid">

                    <!-- Card 1 — Featured -->
                    <div class="prop-card featured fade-in">
                        <div class="prop-img">
                            <div class="prop-img-bg" style="background: linear-gradient(135deg,#0D1B4B,#1E6FBF,#2a9fd6)">🏙️</div>
                            <span class="prop-badge badge-hot">🔥 Hot Deal</span>
                            <div class="prop-save">♡</div>
                        </div>
                        <div class="prop-body">
                            <div class="prop-type">🏘️ Colony / Township</div>
                            <div class="prop-name">Sky Residencia Delhi</div>
                            <div class="prop-loc">📍 Raiwind Road, Delhi</div>
                            <div class="prop-meta">
                                <div class="pm-item">
                                    <div class="pm-lbl">Total Area</div>
                                    <div class="pm-val">500 Kanal</div>
                                </div>
                                <div class="pm-item">
                                    <div class="pm-lbl">Total Plots</div>
                                    <div class="pm-val">1,200</div>
                                </div>
                                <div class="pm-item">
                                    <div class="pm-lbl">Status</div>
                                    <div class="pm-val" style="color: #22C55E">Active</div>
                                </div>
                            </div>
                        </div>
                        <div class="prop-footer">
                            <div>
                                <div class="prop-price-lbl">Starting From</div>
                                <div class="prop-price">₹ 45 Lac</div>
                            </div>
                            <a href="property-detail.aspx" class="btn-prop">View Details</a>
                        </div>
                    </div>

                    <!-- Card 2 -->
                    <div class="prop-card fade-in">
                        <div class="prop-img">
                            <div class="prop-img-bg" style="background: linear-gradient(135deg,#6B2D8B,#9333EA)">🏠</div>
                            <span class="prop-badge badge-up">Upcoming</span>
                            <div class="prop-save">♡</div>
                        </div>
                        <div class="prop-body">
                            <div class="prop-type">🏠 Housing Project</div>
                            <div class="prop-name">Sky Villas Delhi</div>
                            <div class="prop-loc">📍 B-17, Delhi</div>
                            <div class="prop-meta">
                                <div class="pm-item">
                                    <div class="pm-lbl">Area</div>
                                    <div class="pm-val">200 Kanal</div>
                                </div>
                                <div class="pm-item">
                                    <div class="pm-lbl">Units</div>
                                    <div class="pm-val">480</div>
                                </div>
                                <div class="pm-item">
                                    <div class="pm-lbl">Launch</div>
                                    <div class="pm-val">Apr 2025</div>
                                </div>
                            </div>
                        </div>
                        <div class="prop-footer">
                            <div>
                                <div class="prop-price-lbl">Starting From</div>
                                <div class="prop-price">₹ 85 Lac</div>
                            </div>
                            <a href="property-detail.aspx" class="btn-prop">View Details</a>
                        </div>
                    </div>

                    <!-- Card 3 -->
                    <div class="prop-card fade-in">
                        <div class="prop-img">
                            <div class="prop-img-bg" style="background: linear-gradient(135deg,#0F766E,#14B8A6)">📐</div>
                            <span class="prop-badge badge-new">Active</span>
                            <div class="prop-save">♡</div>
                        </div>
                        <div class="prop-body">
                            <div class="prop-type">📐 Plot Scheme</div>
                            <div class="prop-name">Sky Gardens Noida</div>
                            <div class="prop-loc">📍 Canal Road, Noida</div>
                            <div class="prop-meta">
                                <div class="pm-item">
                                    <div class="pm-lbl">Area</div>
                                    <div class="pm-val">320 Kanal</div>
                                </div>
                                <div class="pm-item">
                                    <div class="pm-lbl">Plots</div>
                                    <div class="pm-val">750</div>
                                </div>
                                <div class="pm-item">
                                    <div class="pm-lbl">Status</div>
                                    <div class="pm-val" style="color: #22C55E">Active</div>
                                </div>
                            </div>
                        </div>
                        <div class="prop-footer">
                            <div>
                                <div class="prop-price-lbl">Starting From</div>
                                <div class="prop-price">₹ 28 Lac</div>
                            </div>
                            <a href="property-detail.aspx" class="btn-prop">View Details</a>
                        </div>
                    </div>

                    <!-- Card 4 -->
                    <div class="prop-card fade-in">
                        <div class="prop-img">
                            <div class="prop-img-bg" style="background: linear-gradient(135deg,#B45309,#F59E0B)">🌆</div>
                            <span class="prop-badge badge-ft">Featured</span>
                            <div class="prop-save">♡</div>
                        </div>
                        <div class="prop-body">
                            <div class="prop-type">🌆 Township</div>
                            <div class="prop-name">Golden Heights Jaipur</div>
                            <div class="prop-loc">📍 Ajmer Road, Jaipur</div>
                            <div class="prop-meta">
                                <div class="pm-item">
                                    <div class="pm-lbl">Area</div>
                                    <div class="pm-val">800 Kanal</div>
                                </div>
                                <div class="pm-item">
                                    <div class="pm-lbl">Plots</div>
                                    <div class="pm-val">2,100</div>
                                </div>
                                <div class="pm-item">
                                    <div class="pm-lbl">Launch</div>
                                    <div class="pm-val">2024</div>
                                </div>
                            </div>
                        </div>
                        <div class="prop-footer">
                            <div>
                                <div class="prop-price-lbl">Starting From</div>
                                <div class="prop-price">₹ 35 Lac</div>
                            </div>
                            <a href="property-detail.aspx" class="btn-prop">View Details</a>
                        </div>
                    </div>

                    <!-- Card 5 -->
                    <div class="prop-card fade-in">
                        <div class="prop-img">
                            <div class="prop-img-bg" style="background: linear-gradient(135deg,#065F46,#10B981)">🏡</div>
                            <span class="prop-badge badge-new">Active</span>
                            <div class="prop-save">♡</div>
                        </div>
                        <div class="prop-body">
                            <div class="prop-type">🏡 Residential Plot</div>
                            <div class="prop-name">Green Valley Lucknow</div>
                            <div class="prop-loc">📍 Gomti Nagar, Lucknow</div>
                            <div class="prop-meta">
                                <div class="pm-item">
                                    <div class="pm-lbl">Area</div>
                                    <div class="pm-val">180 Kanal</div>
                                </div>
                                <div class="pm-item">
                                    <div class="pm-lbl">Plots</div>
                                    <div class="pm-val">420</div>
                                </div>
                                <div class="pm-item">
                                    <div class="pm-lbl">Size</div>
                                    <div class="pm-val">5–10 Marla</div>
                                </div>
                            </div>
                        </div>
                        <div class="prop-footer">
                            <div>
                                <div class="prop-price-lbl">Starting From</div>
                                <div class="prop-price">₹ 22 Lac</div>
                            </div>
                            <a href="property-detail.aspx" class="btn-prop">View Details</a>
                        </div>
                    </div>

                    <!-- Card 6 -->
                    <div class="prop-card fade-in">
                        <div class="prop-img">
                            <div class="prop-img-bg" style="background: linear-gradient(135deg,#1E1B4B,#4F46E5)">🏢</div>
                            <span class="prop-badge badge-up">Pre-Launch</span>
                            <div class="prop-save">♡</div>
                        </div>
                        <div class="prop-body">
                            <div class="prop-type">🏢 Commercial Plot</div>
                            <div class="prop-name">Sky Business Park</div>
                            <div class="prop-loc">📍 Sector 62, Noida</div>
                            <div class="prop-meta">
                                <div class="pm-item">
                                    <div class="pm-lbl">Area</div>
                                    <div class="pm-val">120 Kanal</div>
                                </div>
                                <div class="pm-item">
                                    <div class="pm-lbl">Units</div>
                                    <div class="pm-val">280</div>
                                </div>
                                <div class="pm-item">
                                    <div class="pm-lbl">Launch</div>
                                    <div class="pm-val">Q3 2025</div>
                                </div>
                            </div>
                        </div>
                        <div class="prop-footer">
                            <div>
                                <div class="prop-price-lbl">Starting From</div>
                                <div class="prop-price">₹ 1.2 Cr</div>
                            </div>
                            <a href="property-detail.aspx" class="btn-prop">View Details</a>
                        </div>
                    </div>

                </div>

                <!-- Pagination -->
                <div class="pagination">
                    <button class="pg-btn prev-next">← Prev</button>
                    <button class="pg-btn active">1</button>
                    <button class="pg-btn">2</button>
                    <button class="pg-btn">3</button>
                    <button class="pg-btn">4</button>
                    <span style="color: var(--slate); font-size: 13px; align-self: center;">…</span>
                    <button class="pg-btn">12</button>
                    <button class="pg-btn prev-next">Next →</button>
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

    <script>
        window.onload = function () {
            var params = new URLSearchParams(window.location.search);

            var loc = params.get('location');
            var type = params.get('type');
            var budget = params.get('budget');
            var size = params.get('size');

            if (loc) document.querySelector('.fb-group input').value = loc;

            var selects = document.querySelectorAll('.fb-group select');
            if (type) setSelectValue(selects[0], type);
            if (budget) setSelectValue(selects[1], budget);
            if (size) setSelectValue(selects[2], size);
        };

        function setSelectValue(select, value) {
            for (var i = 0; i < select.options.length; i++) {
                if (select.options[i].value === value || select.options[i].text === value) {
                    select.selectedIndex = i;
                    break;
                }
            }
        }
        //// Tab switcher
        //function setTab(el) {
        //    el.closest('.search-tabs').querySelectorAll('.stab').forEach(t => t.classList.remove('active'));
        //    el.classList.add('active');
        //}

        //// Hamburger
        //const hamburger = document.getElementById('hamburger');
        //const navLinks = document.getElementById('navLinks');
        //const navCta = document.getElementById('navCta');

        //hamburger.addEventListener('click', function () {
        //    const isOpen = navLinks.classList.contains('mob-open');
        //    if (isOpen) {
        //        navLinks.classList.remove('mob-open');
        //        navCta.classList.remove('mob-open');
        //        hamburger.classList.remove('open');
        //        document.body.style.overflow = '';
        //    } else {
        //        navLinks.classList.add('mob-open');
        //        hamburger.classList.add('open');
        //        document.body.style.overflow = 'hidden';
        //        setTimeout(() => {
        //            const bottom = navLinks.getBoundingClientRect().bottom;
        //            navCta.style.top = bottom + 'px';
        //            navCta.classList.add('mob-open');
        //        }, 10);
        //    }
        //});

        //navLinks.querySelectorAll('a').forEach(a => a.addEventListener('click', () => {
        //    navLinks.classList.remove('mob-open');
        //    navCta.classList.remove('mob-open');
        //    hamburger.classList.remove('open');
        //    document.body.style.overflow = '';
        //}));

        //document.addEventListener('click', e => {
        //    if (!e.target.closest('nav')) {
        //        navLinks.classList.remove('mob-open');
        //        navCta.classList.remove('mob-open');
        //        hamburger.classList.remove('open');
        //        document.body.style.overflow = '';
        //    }
        //});

        // Scroll animations
        const observer = new IntersectionObserver(entries => {
            entries.forEach((e, i) => {
                if (e.isIntersecting) setTimeout(() => e.target.classList.add('visible'), i * 80);
            });
        }, { threshold: 0.08 });
        document.querySelectorAll('.fade-in').forEach(el => observer.observe(el));

        // Save / wishlist toggle
        document.querySelectorAll('.prop-save').forEach(btn => {
            btn.addEventListener('click', e => {
                e.stopPropagation();
                btn.textContent = btn.textContent === '♡' ? '❤️' : '♡';
            });
        });

        // Pagination active state
        document.querySelectorAll('.pg-btn:not(.prev-next)').forEach(btn => {
            btn.addEventListener('click', () => {
                document.querySelectorAll('.pg-btn:not(.prev-next)').forEach(b => b.classList.remove('active'));
                btn.classList.add('active');
            });
        });
</script>


</asp:Content>

