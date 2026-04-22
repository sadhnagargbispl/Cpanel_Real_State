<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProjectDetail.aspx.cs" Inherits="ProjectDetail" ResponseEncoding="UTF-8" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title><%= Session["Title"] %></title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&family=Fraunces:ital,wght@0,700;0,800;1,700&display=swap" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />

    <style>
        :root {
            --brand:       #F97316;
            --brand-d:     #C2581A;
            --brand-pale:  #FFF7ED;
            --brand-mid:   #FFEDD5;
            --navy:        #0F172A;
            --navy-2:      #1E293B;
            --navy-3:      #334155;
            --slate:       #64748B;
            --slate-2:     #94A3B8;
            --slate-3:     #CBD5E1;
            --slate-4:     #E2E8F0;
            --slate-5:     #F1F5F9;
            --slate-6:     #F8FAFC;
            --white:       #FFFFFF;
            --green:       #16A34A;
            --green-pale:  #DCFCE7;
            --blue:        #2563EB;
            --blue-pale:   #DBEAFE;
            --red:         #DC2626;
            --red-pale:    #FEE2E2;
            --shadow-sm:   0 1px 3px rgba(0,0,0,.06);
            --shadow:      0 4px 16px rgba(0,0,0,.08);
            --shadow-lg:   0 12px 40px rgba(0,0,0,.12);
            --shadow-xl:   0 24px 60px rgba(0,0,0,.18);
            --r:           14px;
            --r-sm:        8px;
            --r-lg:        20px;
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Outfit', sans-serif;
            background: var(--slate-6);
            color: var(--navy);
            min-height: 100vh;
        }

        a { text-decoration: none; color: inherit; }
        button { font-family: 'Outfit', sans-serif; cursor: pointer; }

        /* TOP NAV */
        .top-nav {
            background: var(--navy);
            height: 58px;
            display: flex; align-items: center;
            padding: 0 20px;
            justify-content: space-between;
            position: sticky; top: 0; z-index: 300;
            gap: 12px;
        }
        .nav-brand { display: flex; align-items: center; gap: 10px; flex-shrink: 0; }
        .nav-logo {
            width: 34px; height: 34px; background: var(--brand);
            border-radius: 8px; display: flex; align-items: center;
            justify-content: center; font-weight: 800; color: #fff; font-size: .9rem;
        }
        .nav-name { font-size: .9rem; font-weight: 700; color: #fff; line-height: 1.2; }
        .nav-sub  { font-size: .58rem; color: rgba(255,255,255,.38); letter-spacing: .08em; text-transform: uppercase; }
        .nav-bread {
            font-size: .72rem; color: rgba(255,255,255,.4);
            display: flex; align-items: center; gap: 5px; overflow: hidden;
        }
        .nav-bread a { color: rgba(255,255,255,.4); transition: color .15s; }
        .nav-bread a:hover { color: #fff; }
        .nav-bread .sep { color: rgba(255,255,255,.2); }
        .nav-bread .cur { color: #fff; font-weight: 600; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 200px; }
        .nav-acts { display: flex; gap: 8px; flex-shrink: 0; }
        .nav-btn {
            height: 34px; padding: 0 14px; border-radius: 8px;
            border: 1px solid rgba(255,255,255,.15); background: transparent;
            color: rgba(255,255,255,.7); font-size: .75rem; font-family: 'Outfit', sans-serif;
            cursor: pointer; display: inline-flex; align-items: center; gap: 6px;
            transition: all .15s; white-space: nowrap;
        }
        .nav-btn:hover { border-color: var(--brand); color: var(--brand); }
        .nav-btn.primary { background: var(--brand); border-color: var(--brand); color: #fff; }
        .nav-btn.primary:hover { background: var(--brand-d); }

        /* LAYOUT */
        .pd-wrap {
            max-width: 1260px; margin: 0 auto;
            padding: 28px 20px 80px;
            display: grid;
            grid-template-columns: 1fr 360px;
            gap: 24px;
            align-items: start;
        }

        /* HERO */
        .hero-block {
            background: var(--white);
            border-radius: var(--r-lg);
            overflow: hidden;
            border: 1px solid var(--slate-4);
            box-shadow: var(--shadow);
            margin-bottom: 20px;
        }
        .hero-cover {
            position: relative; height: 400px;
            background: var(--navy-2); overflow: hidden;
        }
        .hero-cover img.main-img {
            width: 100%; height: 100%;
            object-fit: cover; display: block;
            transition: transform .5s cubic-bezier(.25,.46,.45,.94);
        }
        .hero-cover:hover img.main-img { transform: scale(1.04); }
        .hero-overlay {
            position: absolute; inset: 0;
            background: linear-gradient(to bottom, rgba(0,0,0,0) 40%, rgba(0,0,0,.75) 100%);
        }
        .hero-no-img {
            width: 100%; height: 100%;
            display: flex; flex-direction: column;
            align-items: center; justify-content: center;
            gap: 10px; color: var(--navy-3);
            background: linear-gradient(135deg, var(--navy-2) 0%, var(--navy-3) 100%);
        }
        .hero-no-img i   { font-size: 3rem; opacity: .25; }
        .hero-no-img span { font-size: .8rem; opacity: .35; font-weight: 500; }

        .hero-top {
            position: absolute; top: 16px; left: 16px; right: 16px;
            display: flex; justify-content: space-between; align-items: center;
        }
        .circle-btn {
            width: 40px; height: 40px; border-radius: 50%;
            background: rgba(255,255,255,.9); backdrop-filter: blur(8px);
            border: none; display: flex; align-items: center; justify-content: center;
            font-size: .85rem; color: var(--navy); cursor: pointer;
            transition: transform .15s, background .15s; flex-shrink: 0;
        }
        .circle-btn:hover { transform: scale(1.08); background: #fff; }
        .circle-btn.heart { color: #EF4444; }
        .hero-top-right { display: flex; gap: 8px; align-items: center; }
        .builder-badge {
            background: rgba(255,255,255,.92); backdrop-filter: blur(8px);
            border-radius: 50px; padding: 5px 12px;
            font-size: .6rem; font-weight: 700; color: var(--brand);
            letter-spacing: .3px; border: 1px solid rgba(249,115,22,.3);
            display: flex; align-items: center; gap: 4px;
        }
        .hero-status {
            position: absolute; bottom: 16px; left: 16px;
            padding: 6px 14px; border-radius: 20px;
            font-size: .65rem; font-weight: 800; letter-spacing: .6px;
            display: flex; align-items: center; gap: 6px;
        }
        .hero-status::before {
            content: ''; width: 6px; height: 6px;
            border-radius: 50%; background: currentColor;
            animation: pulse 2s infinite;
        }
        @keyframes pulse { 0%, 100% { opacity: 1; } 50% { opacity: .3; } }
        .hs-active   { background: #DCFCE7; color: #166534; }
        .hs-upcoming { background: #DBEAFE; color: #1E40AF; }
        .hs-draft    { background: #FEF3C7; color: #92400E; }
        .hero-views {
            position: absolute; bottom: 16px; right: 16px;
            background: rgba(0,0,0,.5); backdrop-filter: blur(6px);
            color: #fff; border-radius: 20px; padding: 5px 12px;
            font-size: .65rem; font-weight: 600;
            display: flex; align-items: center; gap: 5px;
        }

        /* Media tabs */
        .media-tabs {
            display: flex; border-bottom: 1px solid var(--slate-4);
            background: var(--white);
        }
        .media-tab {
            flex: 1; padding: 13px 8px;
            display: flex; flex-direction: column; align-items: center;
            gap: 4px; cursor: pointer; border: none; background: transparent;
            font-family: 'Outfit', sans-serif; font-size: .75rem;
            font-weight: 600; color: var(--slate); position: relative;
            transition: color .15s;
        }
        .media-tab.active { color: var(--navy); }
        .media-tab.active::after {
            content: ''; position: absolute; bottom: 0;
            left: 20%; right: 20%; height: 2.5px;
            background: var(--brand); border-radius: 2px;
        }
        .media-tab i { font-size: .85rem; }
        .tab-badge {
            position: absolute; top: 7px; right: calc(50% - 28px);
            background: var(--brand); color: #fff;
            min-width: 18px; height: 18px; border-radius: 9px;
            font-size: .54rem; font-weight: 800; padding: 0 4px;
            display: flex; align-items: center; justify-content: center;
        }

        /* Thumbnail strip */
        .thumb-strip {
            display: flex; gap: 8px; padding: 12px 16px;
            overflow-x: auto; background: var(--white); scrollbar-width: none;
        }
        .thumb-strip::-webkit-scrollbar { display: none; }
        .thumb {
            width: 76px; height: 56px; border-radius: 8px;
            object-fit: cover; flex-shrink: 0; cursor: pointer;
            border: 2.5px solid transparent;
            transition: border-color .15s, transform .12s;
        }
        .thumb:hover { transform: scale(1.05); }
        .thumb.active { border-color: var(--brand); }

        /* INFO CARD */
        .info-card {
            background: var(--white); border-radius: var(--r-lg);
            border: 1px solid var(--slate-4); box-shadow: var(--shadow);
            padding: 22px; margin-bottom: 20px;
        }
        .info-top {
            display: flex; align-items: center;
            justify-content: space-between; margin-bottom: 14px;
        }
        .pid-tag    { font-size: .65rem; color: var(--slate-2); font-weight: 600; letter-spacing: .3px; }
        .posted-on  { font-size: .65rem; color: var(--slate-2); }
        .price-ribbon {
            display: inline-flex; align-items: center; gap: 7px;
            background: linear-gradient(135deg, var(--brand) 0%, var(--brand-d) 100%);
            color: #fff; padding: 8px 18px; border-radius: 10px;
            font-size: .85rem; font-weight: 700; margin-bottom: 14px;
            box-shadow: 0 4px 12px rgba(249,115,22,.35);
        }
        .proj-name {
            font-family: 'Fraunces', serif;
            font-size: 1.75rem; font-weight: 800; color: var(--navy);
            line-height: 1.18; margin-bottom: 4px; letter-spacing: -.3px;
        }
        .proj-builder { font-size: .85rem; font-weight: 600; color: var(--slate); margin-bottom: 10px; }
        .proj-loc {
            font-size: .78rem; color: var(--slate);
            display: flex; align-items: flex-start; gap: 6px;
            margin-bottom: 16px; line-height: 1.5;
        }
        .proj-loc i { color: var(--brand); margin-top: 2px; font-size: .7rem; flex-shrink: 0; }
        .verify-row {
            display: flex; align-items: center; justify-content: space-between;
            padding: 11px 0; border-top: 1px solid var(--slate-4);
            border-bottom: 1px solid var(--slate-4); margin-bottom: 16px; gap: 10px;
        }
        .verified-badge {
            display: flex; align-items: center; gap: 6px;
            font-size: .75rem; font-weight: 700; color: var(--green);
        }
        .rera-badge {
            display: flex; align-items: center; gap: 5px;
            font-size: .72rem; color: var(--slate); font-weight: 600;
        }
        .rera-badge i { color: var(--blue); }
        .cta-row { display: flex; gap: 8px; }
        .cta-call {
            flex: 1; padding: 12px; border-radius: 10px;
            background: var(--blue); color: #fff; border: none;
            font-size: .82rem; font-weight: 700; cursor: pointer;
            display: flex; align-items: center; justify-content: center; gap: 7px;
            transition: background .12s;
        }
        .cta-call:hover { background: #1D4ED8; }
        .cta-icon {
            width: 44px; height: 44px; border-radius: 10px;
            border: none; font-size: 1rem; cursor: pointer;
            display: flex; align-items: center; justify-content: center;
            transition: filter .12s;
        }
        .cta-icon:hover { filter: brightness(1.1); }
        .cta-wa    { background: #25D366; color: #fff; }
        .cta-share { background: var(--slate-5); color: var(--slate); border: 1px solid var(--slate-4); }

        /* SECTION CARD */
        .sec-card {
            background: var(--white); border-radius: var(--r-lg);
            border: 1px solid var(--slate-4); box-shadow: var(--shadow);
            padding: 22px; margin-bottom: 20px;
            animation: fadeUp .35s ease both;
        }
        @keyframes fadeUp { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
        .sec-hd {
            display: flex; align-items: center; gap: 10px;
            margin-bottom: 18px; padding-bottom: 14px;
            border-bottom: 1px solid var(--slate-4);
        }
        .sec-ico {
            width: 34px; height: 34px; border-radius: 9px;
            display: flex; align-items: center; justify-content: center;
            font-size: .9rem; flex-shrink: 0;
        }
        .si-orange { background: var(--brand-mid); color: var(--brand); }
        .si-blue   { background: var(--blue-pale);  color: var(--blue);  }
        .si-green  { background: var(--green-pale);  color: var(--green); }
        .sec-ttl   { font-size: .95rem; font-weight: 800; color: var(--navy); }
        .sec-sub   { font-size: .7rem; color: var(--slate-2); margin-top: 1px; }

        /* OVERVIEW GRID */
        .ov-grid {
            display: grid; grid-template-columns: 1fr 1fr;
            gap: 0; border: 1px solid var(--slate-4);
            border-radius: var(--r); overflow: hidden;
            margin-bottom: 16px;
        }
        .ov-item {
            padding: 14px 16px;
            border-right: 1px solid var(--slate-4);
            border-bottom: 1px solid var(--slate-4);
        }
        .ov-item:nth-child(2n)          { border-right: none; }
        .ov-item:nth-last-child(-n+2)   { border-bottom: none; }
        .ov-lbl { font-size: .6rem; color: var(--slate-2); font-weight: 700; text-transform: uppercase; letter-spacing: .4px; margin-bottom: 4px; }
        .ov-val { font-size: .9rem; font-weight: 700; color: var(--navy); }
        .ov-val.green  { color: var(--green); }
        .ov-val.orange { color: var(--brand); }

        /* Specs strip */
        .specs-strip {
            display: grid; grid-template-columns: repeat(4, 1fr);
            background: var(--navy); border-radius: var(--r); overflow: hidden;
        }
        .spec-item {
            padding: 16px 8px; display: flex; flex-direction: column;
            align-items: center; gap: 6px;
            border-right: 1px solid rgba(255,255,255,.08);
        }
        .spec-item:last-child { border-right: none; }
        .spec-ico  { font-size: .9rem; color: var(--brand); }
        .spec-num  { font-size: .95rem; font-weight: 800; color: #fff; }
        .spec-lbl  { font-size: .58rem; color: rgba(255,255,255,.5); font-weight: 600; text-transform: uppercase; letter-spacing: .3px; }

        /* UNIT TYPES TABLE */
        .unit-table-wrap { overflow-x: auto; }
        .unit-table {
            width: 100%; border-collapse: collapse;
            font-size: .78rem;
        }
        .unit-table thead tr { background: var(--navy); }
        .unit-table thead th {
            padding: 10px 14px; text-align: left;
            color: rgba(255,255,255,.7); font-size: .62rem;
            font-weight: 700; text-transform: uppercase; letter-spacing: .4px;
            white-space: nowrap;
        }
        .unit-table tbody tr { border-bottom: 1px solid var(--slate-4); transition: background .12s; }
        .unit-table tbody tr:hover { background: var(--slate-6); }
        .unit-table tbody tr:last-child { border-bottom: none; }
        .unit-table tbody td { padding: 11px 14px; color: var(--navy); font-weight: 600; }
        .unit-table tbody td.orange { color: var(--brand); }
        .unit-table tbody td.green  { color: var(--green); }

        /* USPs */
        .usp-grid { display: flex; flex-direction: column; gap: 8px; }
        .usp-item {
            display: flex; align-items: center; gap: 10px;
            padding: 11px 14px; background: var(--slate-6);
            border-radius: 10px; border: 1px solid var(--slate-4);
            font-size: .8rem; font-weight: 600; color: var(--navy-3);
            transition: border-color .15s, background .15s;
        }
        .usp-item:hover { border-color: var(--green); background: var(--green-pale); }
        .usp-dot {
            width: 22px; height: 22px; border-radius: 50%;
            background: var(--green-pale); color: var(--green);
            display: flex; align-items: center; justify-content: center;
            font-size: .6rem; flex-shrink: 0;
        }

        /* AMENITIES */
        .amen-grid {
            display: grid; grid-template-columns: repeat(auto-fill, minmax(90px, 1fr));
            gap: 10px;
        }
        .amen-item {
            background: var(--slate-6); border: 1px solid var(--slate-4);
            border-radius: 12px; padding: 16px 8px;
            display: flex; flex-direction: column; align-items: center;
            gap: 8px; text-align: center;
            transition: border-color .15s, background .15s, transform .15s;
            cursor: default;
        }
        .amen-item:hover { border-color: var(--brand); background: var(--brand-pale); transform: translateY(-2px); }
        .amen-item i    { font-size: 1.1rem; color: var(--brand); }
        .amen-item span { font-size: .62rem; font-weight: 700; color: var(--slate); line-height: 1.3; }

        /* DESCRIPTION */
        .desc-txt { font-size: .82rem; color: var(--slate); line-height: 1.75; }
        .desc-txt.clamped {
            display: -webkit-box;
            -webkit-line-clamp: 4;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .read-more-btn {
            margin-top: 10px; border: none; background: none;
            color: var(--brand); font-size: .76rem; font-weight: 700;
            font-family: 'Outfit', sans-serif; cursor: pointer;
            display: inline-flex; align-items: center; gap: 5px; padding: 0;
        }

        /* BANKS */
        .bank-list { display: flex; flex-wrap: wrap; gap: 8px; }
        .bank-item {
            padding: 8px 16px; border-radius: 8px;
            background: var(--blue-pale); color: var(--blue);
            font-size: .72rem; font-weight: 700;
            border: 1px solid rgba(37,99,235,.2);
            display: flex; align-items: center; gap: 6px;
        }

        /* DOCUMENTS */
        .doc-list { display: flex; flex-direction: column; gap: 8px; }
        .doc-item {
            display: flex; align-items: center; justify-content: space-between;
            padding: 12px 14px; background: var(--slate-6);
            border: 1px solid var(--slate-4); border-radius: 10px;
            transition: border-color .15s;
        }
        .doc-item:hover { border-color: var(--brand); }
        .doc-name { font-size: .78rem; font-weight: 600; color: var(--navy); display: flex; align-items: center; gap: 8px; }
        .doc-name i { color: var(--brand); font-size: .85rem; }
        .doc-dl {
            font-size: .7rem; font-weight: 700; color: var(--blue);
            border: none; background: none; cursor: pointer;
            font-family: 'Outfit', sans-serif; display: flex;
            align-items: center; gap: 4px; padding: 0;
        }

        /* TAGS */
        .tag-list { display: flex; flex-wrap: wrap; gap: 7px; }
        .tag {
            padding: 5px 13px; border-radius: 20px;
            font-size: .67rem; font-weight: 700;
            background: var(--brand-pale); color: var(--brand);
            border: 1px solid rgba(249,115,22,.22);
        }

        /* SIDEBAR */
        .sidebar { display: flex; flex-direction: column; gap: 18px; }

        /* Price card */
        .price-card {
            background: linear-gradient(135deg, var(--navy) 0%, var(--navy-3) 100%);
            border-radius: var(--r-lg); padding: 20px;
            border: 1px solid rgba(255,255,255,.06);
        }
        .pc-label { font-size: .62rem; color: rgba(255,255,255,.45); font-weight: 700; text-transform: uppercase; letter-spacing: .5px; margin-bottom: 6px; }
        .pc-price { font-size: 1.6rem; font-weight: 800; color: #fff; font-family: 'Fraunces', serif; margin-bottom: 2px; }
        .pc-per   { font-size: .7rem; color: rgba(255,255,255,.5); font-weight: 500; margin-bottom: 16px; }
        .pc-range {
            display: grid; grid-template-columns: 1fr 1fr; gap: 10px;
            padding-top: 14px; border-top: 1px solid rgba(255,255,255,.1);
        }
        .pc-range-item .pcr-lbl { font-size: .58rem; color: rgba(255,255,255,.4); font-weight: 600; text-transform: uppercase; letter-spacing: .3px; }
        .pc-range-item .pcr-val { font-size: .82rem; font-weight: 700; color: #fff; margin-top: 3px; }

        /* Quick info */
        .qi-card {
            background: var(--white); border-radius: var(--r-lg);
            border: 1px solid var(--slate-4); box-shadow: var(--shadow);
            overflow: hidden;
        }
        .qi-head {
            background: var(--navy); padding: 16px 20px;
            display: flex; align-items: center; gap: 9px;
        }
        .qi-head-ico {
            width: 32px; height: 32px; border-radius: 8px;
            background: rgba(249,115,22,.2); color: var(--brand);
            display: flex; align-items: center; justify-content: center; font-size: .85rem;
        }
        .qi-head-title { font-size: .88rem; font-weight: 800; color: #fff; }
        .qi-head-sub   { font-size: .62rem; color: rgba(255,255,255,.4); margin-top: 1px; }
        .qi-body { padding: 4px 0; }
        .qi-row {
            display: flex; justify-content: space-between; align-items: center;
            padding: 12px 20px; border-bottom: 1px solid var(--slate-5); gap: 10px;
        }
        .qi-row:last-child { border-bottom: none; }
        .qi-lbl { font-size: .65rem; color: var(--slate-2); font-weight: 600; text-transform: uppercase; letter-spacing: .35px; }
        .qi-val { font-size: .82rem; font-weight: 700; color: var(--navy); text-align: right; }
        .qi-val.orange { color: var(--brand); }
        .qi-val.green  { color: var(--green); }

        /* Map card */
        .map-card {
            background: var(--white); border-radius: var(--r-lg);
            border: 1px solid var(--slate-4); box-shadow: var(--shadow); overflow: hidden;
        }
        .map-placeholder {
            height: 170px;
            background: linear-gradient(135deg, #E0E9F4 0%, #C8D8EC 100%);
            display: flex; flex-direction: column; align-items: center;
            justify-content: center; gap: 8px; color: var(--slate);
            cursor: pointer; transition: filter .15s;
        }
        .map-placeholder:hover { filter: brightness(.96); }
        .map-placeholder i     { font-size: 2.2rem; color: var(--brand); }
        .map-placeholder span  { font-size: .78rem; font-weight: 700; color: var(--navy-3); }
        .map-placeholder small { font-size: .65rem; color: var(--slate-2); }
        .map-foot {
            padding: 12px 16px; display: flex;
            align-items: center; justify-content: space-between; gap: 10px;
        }
        .map-addr { font-size: .72rem; color: var(--slate); flex: 1; line-height: 1.4; }
        .map-dir-btn {
            font-size: .7rem; font-weight: 700; color: var(--blue);
            border: none; background: none; cursor: pointer;
            font-family: 'Outfit', sans-serif; display: flex;
            align-items: center; gap: 4px; white-space: nowrap; flex-shrink: 0; padding: 0;
        }

        /* Enquiry card */
        .eq-card {
            background: var(--white); border-radius: var(--r-lg);
            border: 1px solid var(--slate-4); box-shadow: var(--shadow); overflow: hidden;
        }
        .eq-head {
            padding: 18px 20px;
            background: linear-gradient(135deg, var(--brand) 0%, var(--brand-d) 100%);
        }
        .eq-title { font-size: .95rem; font-weight: 800; color: #fff; }
        .eq-sub   { font-size: .67rem; color: rgba(255,255,255,.75); margin-top: 2px; }
        .eq-body  { padding: 18px 20px; display: flex; flex-direction: column; gap: 11px; }
        .eq-field label {
            font-size: .63rem; font-weight: 700; color: var(--slate);
            text-transform: uppercase; letter-spacing: .35px;
            display: block; margin-bottom: 5px;
        }
        .eq-field input, .eq-field select {
            width: 100%; padding: 10px 13px;
            border: 1.5px solid var(--slate-4); border-radius: 9px;
            font-size: .8rem; font-family: 'Outfit', sans-serif;
            color: var(--navy); background: var(--slate-6); outline: none;
            transition: border-color .15s, background .15s;
        }
        .eq-field input:focus, .eq-field select:focus {
            border-color: var(--brand); background: #fff;
            box-shadow: 0 0 0 3px rgba(249,115,22,.1);
        }
        .eq-submit {
            width: 100%; padding: 13px;
            background: var(--brand); color: #fff; border: none;
            border-radius: 10px; font-size: .85rem; font-weight: 800;
            font-family: 'Outfit', sans-serif; cursor: pointer;
            display: flex; align-items: center; justify-content: center; gap: 8px;
            transition: background .12s, transform .1s;
            box-shadow: 0 4px 12px rgba(249,115,22,.3);
        }
        .eq-submit:hover  { background: var(--brand-d); }
        .eq-submit:active { transform: scale(.98); }

        /* TOAST */
        .toast {
            position: fixed; bottom: 24px; right: 24px; z-index: 9999;
            background: var(--navy); color: #fff;
            padding: 12px 18px; border-radius: 10px;
            font-size: .78rem; display: flex; align-items: center; gap: 8px;
            opacity: 0; transform: translateY(16px);
            transition: all .28s cubic-bezier(.34,1.56,.64,1);
            pointer-events: none; box-shadow: var(--shadow-lg);
        }
        .toast.show { opacity: 1; transform: translateY(0); }

        /* RESPONSIVE */
        @media (max-width: 1020px) {
            .pd-wrap { grid-template-columns: 1fr; }
            .sidebar { order: -1; display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }
            .eq-card { grid-column: 1 / -1; }
        }
        @media (max-width: 700px) {
            .sidebar { grid-template-columns: 1fr; }
            .hero-cover { height: 240px; }
            .specs-strip { grid-template-columns: repeat(2, 1fr); }
            .ov-grid { grid-template-columns: 1fr 1fr; }
            .pd-wrap { padding: 14px 12px 60px; }
            .proj-name { font-size: 1.4rem; }
            .top-nav .nav-bread { display: none; }
        }
        @media (max-width: 480px) {
            .hero-cover { height: 200px; }
            .amen-grid { grid-template-columns: repeat(3, 1fr); }
        }
    </style>
</head>

<body>
<form id="form1" runat="server">

    <%-- TOP NAV --%>
    <nav class="top-nav">
        <div class="nav-brand">
            <div class="nav-logo"><%= Session["CompName"].ToString().Substring(0,1).ToUpper() %></div>
            <div>
                <div class="nav-name"><%= Session["CompName"] %></div>
                <div class="nav-sub">Management Portal</div>
            </div>
        </div>
        <div class="nav-bread">
            <a href="Home.aspx">Dashboard</a>
            <span class="sep">&rsaquo;</span>
            <a href="ProjectList.aspx">Projects</a>
            <span class="sep">&rsaquo;</span>
            <span class="cur" id="navProjectName">Project Detail</span>
        </div>
        <div class="nav-acts">
            <a href="ProjectList.aspx" class="nav-btn"><i class="fa-solid fa-arrow-left"></i> Back</a>
            <a href="#" class="nav-btn primary" id="editBtn"><i class="fa-solid fa-pen"></i> Edit</a>
        </div>
    </nav>

    <%-- MAIN LAYOUT --%>
    <div class="pd-wrap">

        <%-- LEFT COLUMN --%>
        <div class="left-col">

            <%-- HERO --%>
            <div class="hero-block">
                <div class="hero-cover" id="heroCover">
                    <img class="main-img" id="mainImg" src="" alt="Project Cover" style="display:none" />
                    <div class="hero-overlay"></div>
                    <div class="hero-top">
                        <a href="ProjectList.aspx" class="circle-btn">
                            <i class="fa-solid fa-arrow-left"></i>
                        </a>
                        <div class="hero-top-right">
                            <div class="builder-badge">
                                <i class="fa-solid fa-star"></i> POSTED BY BUILDER
                            </div>
                            <button type="button" class="circle-btn heart" id="heartBtn" onclick="toggleHeart()">
                                <i class="fa-regular fa-heart" id="heartIco"></i>
                            </button>
                        </div>
                    </div>
                    <span class="hero-status hs-draft" id="heroStatus">DRAFT</span>
                    <div class="hero-views">
                        <i class="fa-regular fa-eye"></i>
                        <span id="viewCount">0</span> views
                    </div>
                </div>

                <div class="media-tabs">
                    <button type="button" class="media-tab active" onclick="switchTab(this,'photos')">
                        <span class="tab-badge" id="photoBadge">0</span>
                        <i class="fa-regular fa-images"></i> Photos
                    </button>
                    <button type="button" class="media-tab" onclick="switchTab(this,'location')">
                        <i class="fa-solid fa-location-dot"></i> Location
                    </button>
                </div>

                <div class="thumb-strip" id="thumbStrip"></div>
            </div>

            <%-- INFO CARD --%>
            <div class="info-card">
                <div class="info-top">
                    <div class="pid-tag"  id="pidTag">PID# -</div>
                    <div class="posted-on" id="postedOn">-</div>
                </div>
                <div class="price-ribbon" id="priceRibbon">
                    <i class="fa-solid fa-tag"></i> Price on Request
                </div>
                <div class="proj-name"    id="projName">Loading...</div>
                <div class="proj-builder" id="projBuilder">-</div>
                <div class="proj-loc">
                    <i class="fa-solid fa-location-dot"></i>
                    <span id="projAddress">-</span>
                </div>
                <div class="verify-row">
                    <div class="verified-badge">
                        <i class="fa-solid fa-circle-check"></i> Verified Listing
                    </div>
                    <div class="rera-badge">
                        <i class="fa-solid fa-shield-halved"></i>
                        <span id="reraNum">Non RERA</span>
                    </div>
                </div>
                <div class="cta-row">
                    <button type="button" class="cta-call" id="callBtn">
                        <i class="fa-solid fa-phone"></i> Call Now
                    </button>
                    <button type="button" class="cta-icon cta-wa" id="waBtn" title="WhatsApp">
                        <i class="fa-brands fa-whatsapp"></i>
                    </button>
                    <button type="button" class="cta-icon cta-share" onclick="shareProject()" title="Share">
                        <i class="fa-solid fa-share-nodes"></i>
                    </button>
                </div>
            </div>

            <%-- OVERVIEW --%>
            <div class="sec-card">
                <div class="sec-hd">
                    <div class="sec-ico si-orange"><i class="fa-solid fa-chart-pie"></i></div>
                    <div>
                        <div class="sec-ttl">Overview</div>
                        <div class="sec-sub">Project highlights at a glance</div>
                    </div>
                </div>
                <div class="ov-grid">
                    <div class="ov-item">
                        <div class="ov-lbl">Project Type</div>
                        <div class="ov-val" id="ovType">-</div>
                    </div>
                    <div class="ov-item">
                        <div class="ov-lbl">Total Units</div>
                        <div class="ov-val" id="ovUnits">-</div>
                    </div>
                    <div class="ov-item">
                        <div class="ov-lbl">Possession Date</div>
                        <div class="ov-val green" id="ovPossession">-</div>
                    </div>
                    <div class="ov-item">
                        <div class="ov-lbl">Area Range</div>
                        <div class="ov-val" id="ovArea">-</div>
                    </div>
                    <div class="ov-item">
                        <div class="ov-lbl">BSP Rate</div>
                        <div class="ov-val orange" id="ovBSP">-</div>
                    </div>
                    <div class="ov-item">
                        <div class="ov-lbl">Total Floors</div>
                        <div class="ov-val" id="ovFloors">-</div>
                    </div>
                    <div class="ov-item">
                        <div class="ov-lbl">Parking Type</div>
                        <div class="ov-val" id="ovParking">-</div>
                    </div>
                    <div class="ov-item">
                        <div class="ov-lbl">Branch</div>
                        <div class="ov-val" id="ovBranch">-</div>
                    </div>
                </div>
                <div class="specs-strip">
                    <div class="spec-item">
                        <i class="fa-solid fa-building spec-ico"></i>
                        <div class="spec-num" id="specFloors">0</div>
                        <div class="spec-lbl">Floors</div>
                    </div>
                    <div class="spec-item">
                        <i class="fa-solid fa-door-open spec-ico"></i>
                        <div class="spec-num" id="specUnits">0</div>
                        <div class="spec-lbl">Units</div>
                    </div>
                    <div class="spec-item">
                        <i class="fa-solid fa-layer-group spec-ico"></i>
                        <div class="spec-num" id="specBlocks">0</div>
                        <div class="spec-lbl">Blocks</div>
                    </div>
                    <div class="spec-item">
                        <i class="fa-solid fa-square-parking spec-ico"></i>
                        <div class="spec-num" id="specPark">-</div>
                        <div class="spec-lbl">Parking</div>
                    </div>
                </div>
            </div>

            <%-- UNIT TYPES --%>
            <div class="sec-card" id="unitSection" style="display:none">
                <div class="sec-hd">
                    <div class="sec-ico si-blue"><i class="fa-solid fa-table-cells"></i></div>
                    <div>
                        <div class="sec-ttl">Unit Types</div>
                        <div class="sec-sub" id="unitSubtitle">Available configurations</div>
                    </div>
                </div>
                <div class="unit-table-wrap">
                    <table class="unit-table" id="unitTable">
                        <thead>
                            <tr>
                                <th>Unit Type</th>
                                <th>Super Area</th>
                                <th>Carpet Area</th>
                                <th>No. of Units</th>
                                <th>BSP/sqft</th>
                                <th>Total Price</th>
                            </tr>
                        </thead>
                        <tbody id="unitTableBody"></tbody>
                    </table>
                </div>
            </div>

            <%-- AMENITIES --%>
            <div class="sec-card" id="amenSection" style="display:none">
                <div class="sec-hd">
                    <div class="sec-ico si-orange"><i class="fa-solid fa-leaf"></i></div>
                    <div>
                        <div class="sec-ttl">Amenities</div>
                        <div class="sec-sub" id="amenCount">-</div>
                    </div>
                </div>
                <div class="amen-grid" id="amenGrid"></div>
            </div>

            <%-- DESCRIPTION --%>
            <div class="sec-card" id="descSection" style="display:none">
                <div class="sec-hd">
                    <div class="sec-ico si-blue"><i class="fa-solid fa-align-left"></i></div>
                    <div>
                        <div class="sec-ttl">Description</div>
                        <div class="sec-sub">About this project</div>
                    </div>
                </div>
                <div class="desc-txt clamped" id="descText"></div>
                <button type="button" class="read-more-btn" id="readMoreBtn" onclick="toggleDesc()">
                    Read More <i class="fa-solid fa-chevron-down"></i>
                </button>
            </div>

            <%-- BANKS --%>
            <div class="sec-card" id="bankSection" style="display:none">
                <div class="sec-hd">
                    <div class="sec-ico si-green"><i class="fa-solid fa-building-columns"></i></div>
                    <div>
                        <div class="sec-ttl">Approved Banks</div>
                        <div class="sec-sub">Home loan available from these banks</div>
                    </div>
                </div>
                <div class="bank-list" id="bankList"></div>
            </div>

            <%-- DOCUMENTS --%>
            <div class="sec-card" id="docSection" style="display:none">
                <div class="sec-hd">
                    <div class="sec-ico si-blue"><i class="fa-solid fa-file-lines"></i></div>
                    <div>
                        <div class="sec-ttl">Documents</div>
                        <div class="sec-sub" id="docCount">-</div>
                    </div>
                </div>
                <div class="doc-list" id="docList"></div>
            </div>

        </div><%-- end left-col --%>

        <%-- SIDEBAR --%>
        <div class="sidebar">

            <%-- Price card --%>
            <div class="price-card">
                <div class="pc-label">Starting Price</div>
                <div class="pc-price" id="pcPrice">Price on Request</div>
                <div class="pc-per"   id="pcPer">per sq.ft. (BSP)</div>
                <div class="pc-range">
                    <div class="pc-range-item">
                        <div class="pcr-lbl">Min Area</div>
                        <div class="pcr-val" id="pcMin">-</div>
                    </div>
                    <div class="pc-range-item">
                        <div class="pcr-lbl">Max Area</div>
                        <div class="pcr-val" id="pcMax">-</div>
                    </div>
                </div>
            </div>

            <%-- Quick Info --%>
            <div class="qi-card">
                <div class="qi-head">
                    <div class="qi-head-ico"><i class="fa-solid fa-circle-info"></i></div>
                    <div>
                        <div class="qi-head-title">Quick Info</div>
                        <div class="qi-head-sub">Project details summary</div>
                    </div>
                </div>
                <div class="qi-body">
                    <div class="qi-row">
                        <div class="qi-lbl">Project Code</div>
                        <div class="qi-val orange" id="qiCode">-</div>
                    </div>
                    <div class="qi-row">
                        <div class="qi-lbl">Launch Date</div>
                        <div class="qi-val" id="qiLaunch">-</div>
                    </div>
                    <div class="qi-row">
                        <div class="qi-lbl">Possession Date</div>
                        <div class="qi-val" id="qiPossession">-</div>
                    </div>
                    <div class="qi-row">
                        <div class="qi-lbl">RERA Number</div>
                        <div class="qi-val" id="qiRera">Non RERA</div>
                    </div>
                    <div class="qi-row">
                        <div class="qi-lbl">State</div>
                        <div class="qi-val" id="qiState">-</div>
                    </div>
                    <div class="qi-row">
                        <div class="qi-lbl">City</div>
                        <div class="qi-val" id="qiCity">-</div>
                    </div>
                    <div class="qi-row">
                        <div class="qi-lbl">GST Rate</div>
                        <div class="qi-val" id="qiGST">-</div>
                    </div>
                    <div class="qi-row">
                        <div class="qi-lbl">Status</div>
                        <div class="qi-val green" id="qiStatus">-</div>
                    </div>
                </div>
            </div>

            <%-- Map --%>
            <div class="map-card">
                <div class="map-placeholder" id="mapBox" onclick="openMap()">
                    <i class="fa-solid fa-map-location-dot"></i>
                    <span id="mapLocName">Location</span>
                    <small id="mapLocSub">Click to open in Maps</small>
                </div>
                <div class="map-foot">
                    <div class="map-addr" id="mapAddr">-</div>
                    <button type="button" class="map-dir-btn" onclick="openMap()">
                        <i class="fa-solid fa-diamond-turn-right"></i> Directions
                    </button>
                </div>
            </div>

        </div><%-- end sidebar --%>

    </div><%-- end pd-wrap --%>

    <%-- TOAST --%>
    <div class="toast" id="toast">
        <i class="fa-solid fa-circle-check" id="toastIco"></i>
        <span id="toastMsg">Done</span>
    </div>

    <asp:HiddenField ID="hdnProjectID" runat="server" />
    <asp:Literal ID="litProjectJSON" runat="server" />

    <script>
        var proj = null;

        /* ── Helpers ───────────────────────────────────────────── */

        // FIX: Safe number formatter — returns null for zero/empty, never garbled chars
        function fmtNum(n) {
            if (n == null || n === '' || n === 0 || n === '0') return null;
            var num = Number(n);
            if (isNaN(num) || num === 0) return null;
            return num.toLocaleString('en-IN');
        }

        // FIX: Safe date formatter — handles ISO strings from C# DateTime serialization
        function fmtDate(d) {
            if (!d || d === '' || d === null) return null;
            try {
                // Handle ISO format yyyy-MM-dd returned by fixed C# code
                var dt = new Date(d);
                if (isNaN(dt.getTime())) return String(d);
                return dt.toLocaleDateString('en-IN', { day: '2-digit', month: 'short', year: 'numeric' });
            } catch (e) { return String(d); }
        }

        // FIX: HTML escape — prevents XSS
        function esc(s) {
            if (s == null) return '';
            return String(s)
                .replace(/&/g, '&amp;')
                .replace(/</g, '&lt;')
                .replace(/>/g, '&gt;')
                .replace(/"/g, '&quot;');
        }

        // FIX: setText uses plain dash '-' instead of em dash to avoid encoding issues
        function setText(id, val) {
            var el = document.getElementById(id);
            if (!el) return;
            el.textContent = (val !== null && val !== undefined && val !== '') ? val : '-';
        }

        // FIX: cleanStr strips em-dashes and placeholder values from DB
        function cleanStr(v) {
            if (v == null) return null;
            var s = String(v).trim();
            // Strip common placeholder characters that show as garbled text
            if (s === '' || s === '-' || s === '--' || s === '\u2014' || s === '\u2013') return null;
            return s;
        }

        function val(v) {
            var s = cleanStr(v);
            return s && s.length > 0 ? s : null;
        }

        /* ── Main init ─────────────────────────────────────────── */
        function initDetail(data) {
            proj = data;
            if (!proj) return;

            // Field aliases
            proj.BuilderName  = val(proj.BuilderName)  || val(proj.DeveloperName) || '';
            proj.Address      = val(proj.Address)      || val(proj.FullAddress)   || '';
            proj.Description  = val(proj.Description)  || val(proj.ShortDescription) || '';
            proj.CreatedDate  = val(proj.CreatedDate)  || val(proj.CreatedAt)     || '';
            proj.ProjectType  = val(proj.ProjectType)  || '';
            proj.PublishMode  = (val(proj.PublishMode) || 'draft').toLowerCase();
            proj.ViewCount    = proj.ViewCount || 0;

            // Nav
            setText('navProjectName', proj.ProjectName);
            document.getElementById('editBtn').href = 'ProjectCreate.aspx?pid=' + proj.ProjectID;

            // Hero image
            var mi = document.getElementById('mainImg');
            if (proj.CoverImagePath) {
                mi.src = proj.CoverImagePath;
                mi.style.display = 'block';
                mi.onerror = function () { this.style.display = 'none'; showNoImg(); };
            } else {
                showNoImg();
            }

            // Status pill
            var sEl = document.getElementById('heroStatus');
            if (proj.PublishMode === 'active') {
                sEl.textContent = 'LIVE';     sEl.className = 'hero-status hs-active';
            } else if (proj.PublishMode === 'upcoming') {
                sEl.textContent = 'UPCOMING'; sEl.className = 'hero-status hs-upcoming';
            } else {
                sEl.textContent = 'DRAFT';    sEl.className = 'hero-status hs-draft';
            }
            setText('viewCount', proj.ViewCount);

            // Info card
            setText('pidTag',      'PID# ' + (val(proj.ProjectCode) || val(proj.ProjectID) || '-'));
            setText('postedOn',    proj.CreatedDate ? 'Posted: ' + fmtDate(proj.CreatedDate) : '');
            setText('projName',    proj.ProjectName);
            setText('projBuilder', proj.BuilderName);

            var loc = [proj.City, proj.District, proj.StateName]
                .filter(function (x) { return val(x); }).join(', ');
            setText('projAddress', loc || proj.Address);
            setText('reraNum', val(proj.RERANumber) || 'Non RERA');

            // Price ribbon
            if (val(proj.BSPRatePerSqFt) && Number(proj.BSPRatePerSqFt) > 0) {
                document.getElementById('priceRibbon').innerHTML =
                    '<i class="fa-solid fa-indian-rupee-sign"></i> ' +
                    fmtNum(proj.BSPRatePerSqFt) + ' / sq.ft.';
            }

            // Call / WhatsApp
            if (val(proj.SiteContactPhone)) {
                document.getElementById('callBtn').onclick = function () {
                    window.location.href = 'tel:' + proj.SiteContactPhone;
                };
                document.getElementById('waBtn').onclick = function () {
                    window.open('https://wa.me/91' + proj.SiteContactPhone.replace(/\D/g, ''), '_blank');
                };
            }

            // Overview
            setText('ovType',       val(proj.ProjectType) || val(proj.ProjectTypeID) || '-');
            setText('ovUnits',      fmtNum(proj.TotalUnits) || '-');
            setText('ovPossession', fmtDate(proj.PossessionDate) || '-');

            var areaRange = '-';
            if (proj.MinArea && proj.MaxArea && Number(proj.MinArea) > 0 && Number(proj.MaxArea) > 0) {
                areaRange = fmtNum(proj.MinArea) + ' - ' + fmtNum(proj.MaxArea) + ' sqft';
            } else if (proj.MinArea && Number(proj.MinArea) > 0) {
                areaRange = fmtNum(proj.MinArea) + '+ sqft';
            }
            setText('ovArea', areaRange);

            setText('ovBSP',    (proj.BSPRatePerSqFt && Number(proj.BSPRatePerSqFt) > 0)
                ? 'Rs ' + fmtNum(proj.BSPRatePerSqFt) + '/sqft' : '-');
            setText('ovFloors', val(proj.TotalFloors)    || '-');
            setText('ovParking',val(proj.ParkingType)    || '-');
            setText('ovBranch', val(proj.BranchName)     || '-');

            // Specs strip
            setText('specFloors', val(proj.TotalFloors)    || '-');
            setText('specUnits',  val(proj.TotalUnits)     || '-');
            setText('specBlocks', val(proj.NumberOfBlocks) || '-');
            setText('specPark',   val(proj.ParkingType)    || '-');

            // Sidebar price card
            if (proj.BSPRatePerSqFt && Number(proj.BSPRatePerSqFt) > 0) {
                setText('pcPrice', 'Rs ' + fmtNum(proj.BSPRatePerSqFt));
                setText('pcPer',   'per sq.ft. (BSP)');
            }
            setText('pcMin', (proj.MinArea && Number(proj.MinArea) > 0) ? fmtNum(proj.MinArea) + ' sqft' : '-');
            setText('pcMax', (proj.MaxArea && Number(proj.MaxArea) > 0) ? fmtNum(proj.MaxArea) + ' sqft' : '-');

            // Quick info
            setText('qiCode',       val(proj.ProjectCode)      || '-');
            setText('qiLaunch',     fmtDate(proj.LaunchDate)   || '-');
            setText('qiPossession', fmtDate(proj.PossessionDate) || '-');
            setText('qiRera',       val(proj.RERANumber)        || 'Non RERA');
            setText('qiState',      val(proj.StateName)         || '-');
            setText('qiCity',       val(proj.City)              || '-');
            setText('qiGST',        (proj.GSTRatePct && Number(proj.GSTRatePct) > 0)
                ? proj.GSTRatePct + '%' : '-');
            setText('qiStatus',     (proj.PublishMode || 'Draft').toUpperCase());

            // Map
            setText('mapLocName', val(proj.City) || val(proj.ProjectName) || 'Location');
            setText('mapLocSub',  val(proj.StateName) || '');
            var fullAddr = [proj.Address, proj.City, proj.StateName]
                .filter(function (x) { return val(x); }).join(', ');
            setText('mapAddr', fullAddr || '-');

            // Gallery
            buildThumbs(proj.Images || []);
            document.getElementById('photoBadge').textContent = (proj.Images || []).length;

            // Unit Types — FIX: use cleanStr on all text fields
            if (proj.UnitTypes && proj.UnitTypes.length) {
                document.getElementById('unitSection').style.display = 'block';
                setText('unitSubtitle', proj.UnitTypes.length + ' configurations available');
                var tbody = document.getElementById('unitTableBody');
                tbody.innerHTML = proj.UnitTypes.map(function (u) {
                    // FIX: Try multiple possible column name variants, then cleanStr
                    var UnitTypeID = cleanStr(u.UnitTypeName)
                        || cleanStr(u.TypeName)
                        || cleanStr(u.BHKType)
                        || cleanStr(u.ConfigName)
                        || cleanStr(u.UnitTypeID)
                        || null;

                    var superArea  = (u.SuperAreaSqFt  && Number(u.SuperAreaSqFt)  > 0) ? fmtNum(u.SuperAreaSqFt)  : null;
                    var carpetArea = (u.CarpetAreaSqFt && Number(u.CarpetAreaSqFt) > 0) ? fmtNum(u.CarpetAreaSqFt) : null;
                    var numUnits   = (u.NumberOfUnits  && Number(u.NumberOfUnits)  > 0) ? fmtNum(u.NumberOfUnits)  : null;
                    var bsp        = (u.BSPPerSqFt     && Number(u.BSPPerSqFt)     > 0) ? fmtNum(u.BSPPerSqFt)     : null;
                    var totalPrice = (u.TotalBasePrice && Number(u.TotalBasePrice) > 0) ? fmtNum(u.TotalBasePrice) : null;

                    return '<tr>' +
                        '<td>' + (UnitTypeID ? esc(UnitTypeID)           : '-')           + '</td>' +
                        '<td>'               + (superArea  ? superArea  + ' sqft'    : '-')           + '</td>' +
                        '<td>'               + (carpetArea ? carpetArea + ' sqft'    : '-')           + '</td>' +
                        '<td>'               + (numUnits   ? numUnits               : '-')           + '</td>' +
                        '<td class="orange">' + (bsp       ? 'Rs ' + bsp            : '-')           + '</td>' +
                        '<td class="green">'  + (totalPrice ? 'Rs ' + totalPrice    : '-')           + '</td>' +
                        '</tr>';
                }).join('');
            }

            // Amenities
            if (proj.Amenities && proj.Amenities.length) {
                document.getElementById('amenSection').style.display = 'block';
                setText('amenCount', proj.Amenities.length + ' amenities available');
                var amenIcons = {
                    'Swimming Pool': 'fa-water-ladder', 'Gym': 'fa-dumbbell',
                    'Gymnasium': 'fa-dumbbell',
                    'Clubhouse': 'fa-building-columns', 'Garden': 'fa-seedling',
                    'Landscaped Garden': 'fa-seedling',
                    'Security': 'fa-shield-halved', '24x7 Security': 'fa-shield-halved',
                    'Parking': 'fa-square-parking', 'Secure Parking': 'fa-square-parking',
                    'Power Backup': 'fa-bolt', 'CCTV': 'fa-video',
                    'CCTV Surveillance': 'fa-video',
                    'Lift': 'fa-elevator', 'High Speed Lifts': 'fa-elevator',
                    'Kids Play Area': 'fa-children',
                    'Jogging Track': 'fa-person-running', 'Cycling Track': 'fa-person-biking',
                    'Temple': 'fa-om',
                    'Cafeteria': 'fa-mug-hot', 'Cafe / Cafeteria': 'fa-mug-hot',
                    'Tennis Court': 'fa-baseball', 'Basketball Court': 'fa-basketball',
                    'Badminton Court': 'fa-circle',
                    'Library': 'fa-book-open', 'Indoor Games': 'fa-chess',
                    'Intercom': 'fa-phone', 'Video Door Phone': 'fa-phone',
                    'Rainwater Harvesting': 'fa-droplet', 'Rain Water Harvest': 'fa-droplet',
                    'Solar Panel': 'fa-sun', 'Solar Energy': 'fa-sun',
                    'Yoga Deck': 'fa-spa', 'Yoga / Meditation': 'fa-spa',
                    'Spa & Sauna': 'fa-hot-tub',
                    'Community Hall': 'fa-people-roof',
                    'Mini Theatre': 'fa-film',
                    'Shopping Zone': 'fa-bag-shopping',
                    'Gated Community': 'fa-fence',
                    'Fire Safety System': 'fa-fire-extinguisher',
                    'Emergency Response': 'fa-truck-medical',
                    'Panic Button': 'fa-bell',
                    'Mini Golf': 'fa-golf-ball-tee',
                    'Broadband Ready': 'fa-wifi',
                    'Sewage Treatment': 'fa-water',
                    '24x7 Water Supply': 'fa-faucet',
                    'Waste Management': 'fa-trash'
                };
                document.getElementById('amenGrid').innerHTML = proj.Amenities.map(function (a) {
                    var ico = amenIcons[a] || 'fa-star';
                    return '<div class="amen-item"><i class="fa-solid ' + ico + '"></i><span>' + esc(a) + '</span></div>';
                }).join('');
            }

            // Description
            if (val(proj.Description)) {
                document.getElementById('descSection').style.display = 'block';
                document.getElementById('descText').textContent = proj.Description;
            }

            // Banks
            if (proj.Banks && proj.Banks.length) {
                document.getElementById('bankSection').style.display = 'block';
                document.getElementById('bankList').innerHTML = proj.Banks.map(function (b) {
                    return '<div class="bank-item"><i class="fa-solid fa-building-columns"></i>' + esc(b) + '</div>';
                }).join('');
            }

            // Documents
            if (proj.Documents && proj.Documents.length) {
                document.getElementById('docSection').style.display = 'block';
                setText('docCount', proj.Documents.length + ' document(s) available');
                document.getElementById('docList').innerHTML = proj.Documents.map(function (d) {
                    var name = val(d.DocumentName) || val(d.filename) || 'Document';
                    var path = val(d.DocumentPath) || val(d.filePath) || '#';
                    return '<div class="doc-item">' +
                        '<div class="doc-name"><i class="fa-solid fa-file-pdf"></i>' + esc(name) + '</div>' +
                        '<a href="' + esc(path) + '" target="_blank" class="doc-dl">' +
                        '<i class="fa-solid fa-download"></i> Download</a>' +
                        '</div>';
                }).join('');
            }
        }

        /* ── Gallery ───────────────────────────────────────────── */
        function showNoImg() {
            var cover = document.getElementById('heroCover');
            var existing = cover.querySelector('.hero-no-img');
            if (existing) return;
            var noImg = document.createElement('div');
            noImg.className = 'hero-no-img';
            noImg.innerHTML = '<i class="fa-solid fa-image"></i><span>No Cover Image</span>';
            cover.insertBefore(noImg, cover.firstChild);
        }

        function buildThumbs(images) {
            var strip = document.getElementById('thumbStrip');
            if (!images.length) { strip.style.display = 'none'; return; }
            strip.innerHTML = images.map(function (src, i) {
                return '<img class="thumb' + (i === 0 ? ' active' : '') + '" src="' + esc(src) +
                    '" alt="" onerror="this.style.display=\'none\'" onclick="setMain(this,\'' + esc(src) + '\')" />';
            }).join('');
            var mi = document.getElementById('mainImg');
            if (images[0]) { mi.src = images[0]; mi.style.display = 'block'; }
        }

        function setMain(el, src) {
            document.getElementById('mainImg').src = src;
            document.querySelectorAll('.thumb').forEach(function (t) { t.classList.remove('active'); });
            el.classList.add('active');
        }

        function switchTab(btn, tab) {
            document.querySelectorAll('.media-tab').forEach(function (b) { b.classList.remove('active'); });
            btn.classList.add('active');
            if (tab === 'video' && proj && proj.WalkthroughVideoURL) {
                window.open(proj.WalkthroughVideoURL, '_blank');
            }
            if (tab === 'location') openMap();
        }

        /* ── Map ───────────────────────────────────────────────── */
        function openMap() {
            if (!proj) return;
            var q = '';
            if (proj.Latitude && proj.Longitude) {
                q = proj.Latitude + ',' + proj.Longitude;
            } else {
                q = encodeURIComponent([proj.Address, proj.City, proj.StateName]
                    .filter(function (x) { return val(x); }).join(', '));
            }
            window.open('https://www.google.com/maps/search/?api=1&query=' + q, '_blank');
        }

        /* ── Heart ─────────────────────────────────────────────── */
        function toggleHeart() {
            var ico = document.getElementById('heartIco');
            if (ico.classList.contains('fa-regular')) {
                ico.className = 'fa-solid fa-heart';
                showToast('Added to favourites', 'success');
            } else {
                ico.className = 'fa-regular fa-heart';
                showToast('Removed from favourites');
            }
        }

        /* ── Description toggle ────────────────────────────────── */
        function toggleDesc() {
            var d   = document.getElementById('descText');
            var btn = document.getElementById('readMoreBtn');
            if (d.classList.contains('clamped')) {
                d.classList.remove('clamped');
                btn.innerHTML = 'Read Less <i class="fa-solid fa-chevron-up"></i>';
            } else {
                d.classList.add('clamped');
                btn.innerHTML = 'Read More <i class="fa-solid fa-chevron-down"></i>';
            }
        }

        /* ── Share ─────────────────────────────────────────────── */
        function shareProject() {
            if (navigator.share) {
                navigator.share({ title: proj ? proj.ProjectName : 'Project', url: window.location.href });
            } else {
                navigator.clipboard.writeText(window.location.href).then(function () {
                    showToast('Link copied!', 'success');
                });
            }
        }

        /* ── Toast ─────────────────────────────────────────────── */
        function showToast(msg, type) {
            var t   = document.getElementById('toast');
            var ico = document.getElementById('toastIco');
            document.getElementById('toastMsg').textContent = msg;
            t.style.background =
                type === 'success' ? '#16A34A' :
                type === 'error'   ? '#DC2626' : '#0F172A';
            ico.className = type === 'error'
                ? 'fa-solid fa-circle-xmark'
                : 'fa-solid fa-circle-check';
            t.classList.add('show');
            setTimeout(function () { t.classList.remove('show'); }, 3000);
        }
    </script>

    <%-- ASP.NET injects initDetail({...}) here --%>
    <asp:Literal ID="litInitScript" runat="server" />

</form>
</body>
</html>
