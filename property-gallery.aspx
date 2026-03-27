<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.master" AutoEventWireup="true" CodeFile="property-gallery.aspx.cs" Inherits="property_gallery" %>

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

        /* ── BREADCRUMB ── */
        .breadcrumb-wrap {
            margin-top: 68px;
            background: var(--white);
            border-bottom: 1px solid var(--border);
            padding: 14px 48px;
        }

        .breadcrumb {
            max-width: 1280px;
            margin: 0 auto;
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 13px;
            color: var(--slate);
            flex-wrap: wrap;
        }

            .breadcrumb a {
                color: var(--slate);
                text-decoration: none;
                transition: color .2s;
            }

                .breadcrumb a:hover {
                    color: var(--ocean);
                }

        .breadcrumb-sep {
            color: #ccd5e3;
        }

        .breadcrumb-current {
            color: var(--navy);
            font-weight: 600;
        }

        /* ── PAGE HEADER ── */
        .page-header {
            background: linear-gradient(135deg, var(--navy) 0%, #1E3A8A 60%, var(--ocean) 100%);
            padding: 52px 48px 44px;
            position: relative;
            overflow: hidden;
        }

            .page-header::before {
                content: '';
                position: absolute;
                inset: 0;
                background-image: linear-gradient(rgba(255,255,255,.03) 1px,transparent 1px), linear-gradient(90deg,rgba(255,255,255,.03) 1px,transparent 1px);
                background-size: 52px 52px;
            }

            .page-header::after {
                content: '';
                position: absolute;
                top: -80px;
                right: -80px;
                width: 360px;
                height: 360px;
                border-radius: 50%;
                background: radial-gradient(circle, rgba(232,160,32,.15) 0%, transparent 70%);
            }

        .ph-inner {
            max-width: 1280px;
            margin: 0 auto;
            position: relative;
            z-index: 1;
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            flex-wrap: wrap;
            gap: 20px;
        }

        .ph-left {
        }

        .ph-label {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            background: rgba(232,160,32,.15);
            border: 1px solid rgba(232,160,32,.35);
            color: var(--gold-lt);
            font-size: 10.5px;
            font-weight: 600;
            letter-spacing: 1.8px;
            text-transform: uppercase;
            padding: 5px 13px;
            border-radius: 100px;
            margin-bottom: 14px;
        }

        .ph-title {
            font-family: 'Cormorant Garamond', serif;
            font-size: clamp(26px,4vw,46px);
            font-weight: 700;
            color: #fff;
            line-height: 1.1;
            margin-bottom: 8px;
        }

        .ph-sub {
            font-size: 14px;
            color: rgba(255,255,255,.6);
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .ph-right {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            padding: 11px 22px;
            border: 1.5px solid rgba(255,255,255,.35);
            border-radius: 10px;
            background: transparent;
            color: #fff;
            font-size: 13.5px;
            font-weight: 600;
            cursor: pointer;
            transition: all .2s;
            text-decoration: none;
            font-family: 'Outfit', sans-serif;
        }

            .btn-back:hover {
                background: rgba(255,255,255,.12);
                border-color: rgba(255,255,255,.7);
            }

        .btn-slideshow {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            padding: 11px 22px;
            background: linear-gradient(135deg,var(--gold),#C97A10);
            border: none;
            border-radius: 10px;
            color: #fff;
            font-size: 13.5px;
            font-weight: 600;
            cursor: pointer;
            transition: all .2s;
            box-shadow: 0 4px 16px rgba(232,160,32,.4);
            font-family: 'Outfit', sans-serif;
        }

            .btn-slideshow:hover {
                transform: translateY(-1px);
                box-shadow: 0 7px 24px rgba(232,160,32,.5);
            }

        /* ── FILTER TABS ── */
        .filter-wrap {
            background: var(--white);
            border-bottom: 1px solid var(--border);
            padding: 0 48px;
            position: sticky;
            top: 68px;
            z-index: 900;
            box-shadow: 0 2px 12px rgba(11,22,56,.06);
        }

        .filter-inner {
            max-width: 1280px;
            margin: 0 auto;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            flex-wrap: wrap;
            padding: 0;
        }

        .filter-tabs {
            display: flex;
            gap: 0;
            overflow-x: auto;
            scrollbar-width: none;
        }

            .filter-tabs::-webkit-scrollbar {
                display: none;
            }

        .ftab {
            padding: 18px 22px;
            border: none;
            background: transparent;
            font-size: 13px;
            font-weight: 600;
            color: var(--slate);
            cursor: pointer;
            transition: all .2s;
            white-space: nowrap;
            border-bottom: 3px solid transparent;
            font-family: 'Outfit', sans-serif;
            position: relative;
        }

            .ftab:hover {
                color: var(--navy);
            }

            .ftab.active {
                color: var(--navy);
                border-bottom-color: var(--gold);
            }

        .filter-count {
            font-size: 12px;
            color: var(--slate);
            font-weight: 500;
            padding: 16px 0;
            white-space: nowrap;
        }

            .filter-count span {
                font-weight: 700;
                color: var(--navy);
            }

        /* ── GALLERY MAIN ── */
        .gallery-page {
            max-width: 1280px;
            margin: 0 auto;
            padding: 40px 48px 80px;
        }

        /* Masonry-style grid */
        .photo-grid {
            columns: 4;
            column-gap: 14px;
        }

        .photo-item {
            break-inside: avoid;
            margin-bottom: 14px;
            border-radius: 12px;
            overflow: hidden;
            cursor: pointer;
            position: relative;
            display: block;
        }

            .photo-item.tall {
            }

            .photo-item.wide {
            }

        .photo-img {
            width: 100%;
            display: block;
            transition: transform .4s cubic-bezier(.25,.46,.45,.94);
        }

        .photo-item:hover .photo-img {
            transform: scale(1.05);
        }

        .photo-overlay {
            position: absolute;
            inset: 0;
            background: linear-gradient(180deg, transparent 40%, rgba(0,0,0,.72) 100%);
            opacity: 0;
            transition: opacity .3s;
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
            padding: 16px;
        }

        .photo-item:hover .photo-overlay {
            opacity: 1;
        }

        .photo-label {
            color: #fff;
            font-size: 12.5px;
            font-weight: 600;
            margin-bottom: 4px;
        }

        .photo-tag {
            display: inline-block;
            background: var(--gold);
            color: #fff;
            font-size: 10px;
            font-weight: 700;
            padding: 3px 9px;
            border-radius: 100px;
            letter-spacing: .5px;
        }

        .photo-zoom {
            position: absolute;
            top: 12px;
            right: 12px;
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background: rgba(255,255,255,.9);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            opacity: 0;
            transition: opacity .3s;
            transform: scale(.8);
            transition: all .3s;
        }

        .photo-item:hover .photo-zoom {
            opacity: 1;
            transform: scale(1);
        }

        /* Photo placeholder visuals */
        .pimg {
            width: 100%;
            display: block;
        }

        /* ── LIGHTBOX ── */
        .lightbox {
            display: none;
            position: fixed;
            inset: 0;
            z-index: 9999;
            background: rgba(8,15,42,.96);
            backdrop-filter: blur(8px);
            flex-direction: column;
        }

            .lightbox.open {
                display: flex;
            }

        /* Top bar */
        .lb-topbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 16px 28px;
            flex-shrink: 0;
        }

        .lb-title-wrap {
            display: flex;
            flex-direction: column;
            gap: 2px;
        }

        .lb-prop-name {
            font-family: 'Cormorant Garamond', serif;
            font-size: 18px;
            font-weight: 700;
            color: #fff;
        }

        .lb-counter {
            font-size: 12.5px;
            color: rgba(255,255,255,.5);
        }

        .lb-topbar-actions {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .lb-action-btn {
            width: 38px;
            height: 38px;
            border-radius: 10px;
            background: rgba(255,255,255,.08);
            border: 1px solid rgba(255,255,255,.12);
            color: rgba(255,255,255,.7);
            font-size: 16px;
            cursor: pointer;
            transition: all .2s;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Outfit', sans-serif;
        }

            .lb-action-btn:hover {
                background: rgba(255,255,255,.18);
                color: #fff;
            }

        .lb-close-btn {
            background: rgba(239,68,68,.15);
            border-color: rgba(239,68,68,.3);
            color: #f87171;
        }

            .lb-close-btn:hover {
                background: var(--red);
                color: #fff;
                border-color: var(--red);
            }

        /* Main image area */
        .lb-main {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 0 80px;
            position: relative;
            min-height: 0;
        }

        .lb-img-wrap {
            max-width: 960px;
            width: 100%;
            height: 100%;
            max-height: 560px;
            border-radius: 16px;
            overflow: hidden;
            position: relative;
            box-shadow: 0 24px 80px rgba(0,0,0,.6);
        }

        .lb-img {
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 120px;
            transition: opacity .3s;
            position: relative;
        }

        .lb-img-info {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            background: linear-gradient(transparent, rgba(0,0,0,.75));
            padding: 32px 24px 20px;
            color: #fff;
        }

        .lb-img-name {
            font-family: 'Cormorant Garamond', serif;
            font-size: 20px;
            font-weight: 700;
            margin-bottom: 4px;
        }

        .lb-img-cat {
            font-size: 12px;
            color: rgba(255,255,255,.6);
        }

        /* Prev/Next arrows */
        .lb-arrow {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            width: 52px;
            height: 52px;
            border-radius: 50%;
            background: rgba(255,255,255,.1);
            border: 1.5px solid rgba(255,255,255,.2);
            color: #fff;
            font-size: 20px;
            cursor: pointer;
            transition: all .25s;
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 10;
            backdrop-filter: blur(4px);
        }

            .lb-arrow:hover {
                background: var(--gold);
                border-color: var(--gold);
                transform: translateY(-50%) scale(1.08);
            }

        .lb-prev {
            left: 16px;
        }

        .lb-next {
            right: 16px;
        }

        /* Thumbnail strip */
        .lb-strip {
            padding: 14px 28px 18px;
            flex-shrink: 0;
            overflow-x: auto;
            scrollbar-width: thin;
            scrollbar-color: rgba(255,255,255,.2) transparent;
        }

            .lb-strip::-webkit-scrollbar {
                height: 4px;
            }

            .lb-strip::-webkit-scrollbar-thumb {
                background: rgba(255,255,255,.2);
                border-radius: 4px;
            }

        .lb-thumbs {
            display: flex;
            gap: 10px;
            width: max-content;
        }

        .lb-thumb {
            width: 80px;
            height: 56px;
            border-radius: 8px;
            overflow: hidden;
            cursor: pointer;
            border: 2.5px solid transparent;
            transition: all .25s;
            flex-shrink: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            opacity: .55;
        }

            .lb-thumb:hover {
                opacity: .85;
                border-color: rgba(255,255,255,.4);
            }

            .lb-thumb.active {
                border-color: var(--gold);
                opacity: 1;
                box-shadow: 0 0 0 2px rgba(232,160,32,.4);
            }

        /* Category label bar */
        .lb-cat-bar {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 10px 28px 0;
            flex-shrink: 0;
            overflow-x: auto;
            scrollbar-width: none;
        }

            .lb-cat-bar::-webkit-scrollbar {
                display: none;
            }

        .lb-cat-pill {
            padding: 4px 14px;
            border-radius: 100px;
            font-size: 11.5px;
            font-weight: 600;
            border: 1.5px solid rgba(255,255,255,.12);
            color: rgba(255,255,255,.5);
            cursor: pointer;
            transition: all .2s;
            white-space: nowrap;
            background: transparent;
            font-family: 'Outfit', sans-serif;
        }

            .lb-cat-pill.active {
                background: var(--gold);
                border-color: var(--gold);
                color: #fff;
            }

            .lb-cat-pill:hover {
                border-color: rgba(255,255,255,.4);
                color: rgba(255,255,255,.8);
            }

        /* ── SECTION DIVIDERS ── */
        .section-divider {
            display: flex;
            align-items: center;
            gap: 16px;
            margin: 36px 0 20px;
        }

        .sd-line {
            flex: 1;
            height: 1px;
            background: var(--border);
        }

        .sd-label {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            color: var(--slate);
            background: var(--mist);
            padding: 6px 14px;
            border-radius: 100px;
            border: 1px solid var(--border);
            white-space: nowrap;
        }

        /* ── CTA STRIP ── */
        .cta-strip {
            background: linear-gradient(135deg, var(--gold) 0%, #C97A10 100%);
            border-radius: var(--r);
            padding: 32px 36px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            flex-wrap: wrap;
            margin-top: 48px;
            box-shadow: 0 8px 32px rgba(232,160,32,.35);
        }

        .cta-strip-text {
        }

        .cta-strip-title {
            font-family: 'Cormorant Garamond', serif;
            font-size: 24px;
            font-weight: 700;
            color: #fff;
            margin-bottom: 4px;
        }

        .cta-strip-sub {
            font-size: 14px;
            color: rgba(255,255,255,.8);
        }

        .cta-strip-btns {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        .btn-cta-white {
            padding: 12px 26px;
            background: #fff;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 700;
            color: var(--gold);
            text-decoration: none;
            transition: all .2s;
            display: inline-flex;
            align-items: center;
            gap: 7px;
        }

            .btn-cta-white:hover {
                transform: translateY(-1px);
                box-shadow: 0 6px 20px rgba(0,0,0,.15);
            }

        .btn-cta-outline {
            padding: 12px 26px;
            border: 2px solid rgba(255,255,255,.5);
            border-radius: 10px;
            font-size: 14px;
            font-weight: 700;
            color: #fff;
            text-decoration: none;
            transition: all .2s;
            display: inline-flex;
            align-items: center;
            gap: 7px;
        }

            .btn-cta-outline:hover {
                background: rgba(255,255,255,.15);
                border-color: #fff;
            }

        /* ── FOOTER ── */
        footer {
            background: #080F2A;
            padding: 56px 48px 24px;
        }

        .ft-grid {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr;
            gap: 48px;
            margin-bottom: 40px;
        }

        .ft-logo {
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
            margin-bottom: 18px;
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
            margin-bottom: 16px;
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

        .ft-bottom {
            border-top: 1px solid rgba(255,255,255,.07);
            padding-top: 22px;
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 10px;
        }

        .ft-copy {
            font-size: 12.5px;
            color: rgba(255,255,255,.3);
        }

        .ft-blinks {
            display: flex;
            gap: 20px;
        }

            .ft-blinks a {
                font-size: 12.5px;
                color: rgba(255,255,255,.3);
                text-decoration: none;
            }

                .ft-blinks a:hover {
                    color: var(--gold);
                }

        /* Fade in */
        .fade-in {
            opacity: 0;
            transform: translateY(18px);
            transition: opacity .5s ease, transform .5s ease;
        }

            .fade-in.visible {
                opacity: 1;
                transform: none;
            }

        /* ── RESPONSIVE ── */
        @media (max-width: 1100px) {
            .photo-grid {
                columns: 3;
            }

            nav {
                padding: 0 24px;
            }

            .breadcrumb-wrap, .filter-wrap {
                padding-left: 24px;
                padding-right: 24px;
            }

            .page-header {
                padding: 44px 24px 36px;
            }

            .gallery-page {
                padding: 32px 24px 64px;
            }

            .ft-grid {
                grid-template-columns: 1fr 1fr;
                gap: 32px;
            }

            footer {
                padding: 48px 24px 20px;
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
                }

                    .nav-cta.mob-open a {
                        width: 100%;
                        text-align: center;
                    }

            .hamburger {
                display: flex;
            }

            .breadcrumb-wrap {
                margin-top: 60px;
                padding: 12px 18px;
            }

            .filter-wrap {
                top: 60px;
                padding: 0 18px;
            }

            .page-header {
                padding: 36px 18px 28px;
            }

            .ph-inner {
                flex-direction: column;
                align-items: flex-start;
            }

            .ph-right {
                width: 100%;
            }

            .btn-back, .btn-slideshow {
                flex: 1;
                justify-content: center;
            }

            .gallery-page {
                padding: 24px 18px 52px;
            }

            .photo-grid {
                columns: 2;
                column-gap: 10px;
            }

            .photo-item {
                margin-bottom: 10px;
            }

            .lb-main {
                padding: 0 52px;
            }

            .lb-arrow {
                width: 40px;
                height: 40px;
                font-size: 16px;
            }

            .lb-prev {
                left: 8px;
            }

            .lb-next {
                right: 8px;
            }

            .lb-img-wrap {
                max-height: 380px;
            }

            .lb-img {
                font-size: 72px;
            }

            .lb-thumb {
                width: 64px;
                height: 46px;
                font-size: 18px;
            }

            .cta-strip {
                flex-direction: column;
                padding: 26px 24px;
            }

            .cta-strip-btns {
                width: 100%;
            }

            .btn-cta-white, .btn-cta-outline {
                flex: 1;
                justify-content: center;
            }

            .ft-grid {
                grid-template-columns: 1fr;
                gap: 24px;
            }

            footer {
                padding: 44px 18px 18px;
            }

            .ft-bottom {
                flex-direction: column;
            }
        }

        @media (max-width: 480px) {
            .photo-grid {
                columns: 2;
                column-gap: 8px;
            }

            .photo-item {
                margin-bottom: 8px;
                border-radius: 8px;
            }

            .lb-main {
                padding: 0 48px;
            }

            .lb-topbar {
                padding: 12px 16px;
            }

            .lb-strip {
                padding: 10px 16px 14px;
            }

            .lb-cat-bar {
                padding: 8px 16px 0;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!-- BREADCRUMB -->
    <div class="breadcrumb-wrap">
        <div class="breadcrumb">
            <a href="property-search.html">🏠 Home</a>
            <span class="breadcrumb-sep">›</span>
            <a href="property-search.html#search-page">Properties</a>
            <span class="breadcrumb-sep">›</span>
            <a href="property-detail.html">Sky Residencia Delhi</a>
            <span class="breadcrumb-sep">›</span>
            <span class="breadcrumb-current">📸 Photo Gallery</span>
        </div>
    </div>

    <!-- PAGE HEADER -->
    <div class="page-header">
        <div class="ph-inner">
            <div class="ph-left">
                <div class="ph-label">📷 Photo Gallery</div>
                <h1 class="ph-title">Sky Residencia Delhi</h1>
                <div class="ph-sub">📍 Raiwind Road, Delhi &nbsp;·&nbsp; 24 Photos &nbsp;·&nbsp; 6 Categories</div>
            </div>
            <div class="ph-right">
                <a href="property-detail.html" class="btn-back">← Back to Details</a>
                <button class="btn-slideshow" onclick="openLightbox(0)">▶ Start Slideshow</button>
            </div>
        </div>
    </div>

    <!-- FILTER TABS -->
    <div class="filter-wrap">
        <div class="filter-inner">
            <div class="filter-tabs">
                <button class="ftab active" onclick="filterGallery(this,'all')">All Photos</button>
                <button class="ftab" onclick="filterGallery(this,'exterior')">🏙️ Exterior</button>
                <button class="ftab" onclick="filterGallery(this,'amenities')">🏊 Amenities</button>
                <button class="ftab" onclick="filterGallery(this,'landscape')">🌳 Landscape</button>
                <button class="ftab" onclick="filterGallery(this,'interior')">🏠 Interior</button>
                <button class="ftab" onclick="filterGallery(this,'infrastructure')">🚗 Infrastructure</button>
                <button class="ftab" onclick="filterGallery(this,'aerial')">🚁 Aerial View</button>
            </div>
            <div class="filter-count">Showing <span id="visibleCount">24</span> of 24 photos</div>
        </div>
    </div>

    <!-- GALLERY GRID -->
    <div class="gallery-page">
        <div class="photo-grid" id="photoGrid">

            <!-- EXTERIOR -->
            <div class="photo-item fade-in" data-cat="exterior" data-idx="0" onclick="openLightbox(0)">
                <svg class="pimg" viewBox="0 0 400 300" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="g0" x1="0%" y1="0%" x2="100%" y2="100%">
                            <stop offset="0%" stop-color="#0D1B4B" />
                            <stop offset="50%" stop-color="#1E6FBF" />
                            <stop offset="100%" stop-color="#2a9fd6" />
                        </linearGradient>
                    </defs>
                    <rect width="400" height="300" fill="url(#g0)" />
                    <rect x="60" y="80" width="280" height="160" rx="4" fill="rgba(255,255,255,.12)" />
                    <rect x="80" y="100" width="60" height="80" rx="2" fill="rgba(255,255,255,.2)" />
                    <rect x="160" y="100" width="60" height="80" rx="2" fill="rgba(255,255,255,.2)" />
                    <rect x="240" y="100" width="60" height="80" rx="2" fill="rgba(255,255,255,.2)" />
                    <rect x="90" y="200" width="220" height="8" rx="2" fill="rgba(255,255,255,.15)" />
                    <rect x="0" y="240" width="400" height="60" fill="rgba(0,0,0,.3)" />
                    <circle cx="200" cy="40" r="20" fill="rgba(232,160,32,.4)" />
                    <text x="200" y="270" text-anchor="middle" fill="rgba(255,255,255,.7)" font-size="13" font-family="serif">Main Entrance Gate</text>
                </svg>
                <div class="photo-overlay">
                    <div class="photo-label">Main Entrance Gate</div>
                    <span class="photo-tag">Exterior</span>
                </div>
                <div class="photo-zoom">🔍</div>
            </div>

            <div class="photo-item fade-in" data-cat="aerial" data-idx="1" onclick="openLightbox(1)" style="margin-bottom: 14px;">
                <svg class="pimg" viewBox="0 0 400 500" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="g1" x1="0%" y1="0%" x2="100%" y2="100%">
                            <stop offset="0%" stop-color="#0B1638" />
                            <stop offset="100%" stop-color="#1756A9" />
                        </linearGradient>
                    </defs>
                    <rect width="400" height="500" fill="url(#g1)" />
                    <rect x="20" y="30" width="360" height="200" rx="3" fill="rgba(255,255,255,.06)" />
                    <rect x="40" y="50" width="80" height="60" rx="2" fill="rgba(255,255,255,.15)" />
                    <rect x="140" y="50" width="80" height="60" rx="2" fill="rgba(255,255,255,.15)" />
                    <rect x="240" y="50" width="80" height="60" rx="2" fill="rgba(255,255,255,.15)" />
                    <rect x="40" y="130" width="80" height="60" rx="2" fill="rgba(255,255,255,.12)" />
                    <rect x="140" y="130" width="80" height="60" rx="2" fill="rgba(255,255,255,.12)" />
                    <rect x="240" y="130" width="80" height="60" rx="2" fill="rgba(255,255,255,.12)" />
                    <rect x="20" y="260" width="100" height="100" rx="4" fill="rgba(34,197,94,.2)" />
                    <rect x="140" y="260" width="100" height="100" rx="4" fill="rgba(59,144,245,.2)" />
                    <rect x="260" y="260" width="100" height="100" rx="4" fill="rgba(232,160,32,.2)" />
                    <rect x="0" y="390" width="400" height="4" fill="rgba(255,255,255,.1)" />
                    <rect x="0" y="420" width="400" height="4" fill="rgba(255,255,255,.1)" />
                    <text x="200" y="468" text-anchor="middle" fill="rgba(255,255,255,.6)" font-size="12" font-family="serif">Aerial Overview</text>
                </svg>
                <div class="photo-overlay">
                    <div class="photo-label">Aerial Overview – Full Layout</div>
                    <span class="photo-tag">Aerial View</span>
                </div>
                <div class="photo-zoom">🔍</div>
            </div>

            <div class="photo-item fade-in" data-cat="amenities" data-idx="2" onclick="openLightbox(2)">
                <svg class="pimg" viewBox="0 0 400 280" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="g2" x1="0%" y1="0%" x2="100%" y2="100%">
                            <stop offset="0%" stop-color="#0F766E" />
                            <stop offset="100%" stop-color="#14B8A6" />
                        </linearGradient>
                    </defs>
                    <rect width="400" height="280" fill="url(#g2)" />
                    <ellipse cx="200" cy="160" rx="140" ry="70" fill="rgba(147,197,253,.35)" />
                    <ellipse cx="200" cy="160" rx="120" ry="55" fill="rgba(147,197,253,.25)" />
                    <rect x="60" y="155" width="280" height="20" rx="4" fill="rgba(255,255,255,.15)" />
                    <rect x="40" y="220" width="320" height="8" rx="2" fill="rgba(255,255,255,.12)" />
                    <circle cx="100" cy="100" r="20" fill="rgba(255,255,255,.2)" />
                    <circle cx="300" cy="90" r="15" fill="rgba(255,255,255,.15)" />
                    <text x="200" y="260" text-anchor="middle" fill="rgba(255,255,255,.7)" font-size="13" font-family="serif">Olympic Swimming Pool</text>
                </svg>
                <div class="photo-overlay">
                    <div class="photo-label">Olympic Swimming Pool</div>
                    <span class="photo-tag">Amenities</span>
                </div>
                <div class="photo-zoom">🔍</div>
            </div>

            <div class="photo-item fade-in" data-cat="landscape" data-idx="3" onclick="openLightbox(3)">
                <svg class="pimg" viewBox="0 0 400 260" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="g3" x1="0%" y1="0%" x2="100%" y2="100%">
                            <stop offset="0%" stop-color="#14532D" />
                            <stop offset="100%" stop-color="#22C55E" />
                        </linearGradient>
                    </defs>
                    <rect width="400" height="260" fill="url(#g3)" />
                    <ellipse cx="80" cy="200" rx="40" ry="60" fill="rgba(21,128,61,.6)" />
                    <ellipse cx="160" cy="190" rx="35" ry="55" fill="rgba(21,128,61,.5)" />
                    <ellipse cx="240" cy="205" rx="45" ry="65" fill="rgba(21,128,61,.6)" />
                    <ellipse cx="330" cy="195" rx="38" ry="58" fill="rgba(21,128,61,.5)" />
                    <rect x="0" y="210" width="400" height="50" fill="rgba(16,185,129,.3)" />
                    <path d="M0 180 Q100 140 200 160 Q300 180 400 150 L400 260 L0 260Z" fill="rgba(34,197,94,.25)" />
                    <circle cx="200" cy="50" r="35" fill="rgba(253,224,71,.3)" />
                    <text x="200" y="250" text-anchor="middle" fill="rgba(255,255,255,.8)" font-size="13" font-family="serif">Central Park & Gardens</text>
                </svg>
                <div class="photo-overlay">
                    <div class="photo-label">Central Park & Gardens</div>
                    <span class="photo-tag">Landscape</span>
                </div>
                <div class="photo-zoom">🔍</div>
            </div>

            <div class="photo-item fade-in" data-cat="exterior" data-idx="4" onclick="openLightbox(4)">
                <svg class="pimg" viewBox="0 0 400 320" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="g4" x1="0%" y1="0%" x2="100%" y2="100%">
                            <stop offset="0%" stop-color="#1E3A8A" />
                            <stop offset="100%" stop-color="#3B82F6" />
                        </linearGradient>
                    </defs>
                    <rect width="400" height="320" fill="url(#g4)" />
                    <rect x="100" y="60" width="200" height="180" rx="6" fill="rgba(255,255,255,.1)" />
                    <rect x="120" y="80" width="70" height="90" rx="3" fill="rgba(255,255,255,.2)" />
                    <rect x="210" y="80" width="70" height="90" rx="3" fill="rgba(255,255,255,.2)" />
                    <rect x="155" y="200" width="90" height="40" rx="2" fill="rgba(255,255,255,.18)" />
                    <rect x="60" y="240" width="280" height="10" rx="2" fill="rgba(255,255,255,.12)" />
                    <rect x="40" y="260" width="320" height="6" rx="2" fill="rgba(255,255,255,.08)" />
                    <circle cx="200" cy="40" r="15" fill="rgba(232,160,32,.5)" />
                    <text x="200" y="305" text-anchor="middle" fill="rgba(255,255,255,.7)" font-size="13" font-family="serif">Residential Block A</text>
                </svg>
                <div class="photo-overlay">
                    <div class="photo-label">Residential Block A</div>
                    <span class="photo-tag">Exterior</span>
                </div>
                <div class="photo-zoom">🔍</div>
            </div>

            <div class="photo-item fade-in" data-cat="infrastructure" data-idx="5" onclick="openLightbox(5)">
                <svg class="pimg" viewBox="0 0 400 250" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="g5" x1="0%" y1="0%" x2="100%" y2="100%">
                            <stop offset="0%" stop-color="#1C1917" />
                            <stop offset="100%" stop-color="#57534E" />
                        </linearGradient>
                    </defs>
                    <rect width="400" height="250" fill="url(#g5)" />
                    <rect x="0" y="120" width="400" height="80" fill="rgba(100,116,139,.3)" />
                    <rect x="180" y="110" width="40" height="90" fill="rgba(255,255,255,.08)" />
                    <rect x="0" y="140" width="400" height="6" fill="rgba(255,255,255,.15)" />
                    <rect x="0" y="175" width="400" height="4" fill="rgba(255,255,255,.1)" />
                    <rect x="30" y="60" width="8" height="60" fill="rgba(255,200,50,.4)" />
                    <circle cx="34" cy="56" r="8" fill="rgba(255,200,50,.6)" />
                    <rect x="120" y="50" width="8" height="70" fill="rgba(255,200,50,.4)" />
                    <circle cx="124" cy="46" r="8" fill="rgba(255,200,50,.6)" />
                    <rect x="240" y="55" width="8" height="65" fill="rgba(255,200,50,.4)" />
                    <circle cx="244" cy="51" r="8" fill="rgba(255,200,50,.6)" />
                    <rect x="360" y="60" width="8" height="60" fill="rgba(255,200,50,.4)" />
                    <circle cx="364" cy="56" r="8" fill="rgba(255,200,50,.6)" />
                    <text x="200" y="240" text-anchor="middle" fill="rgba(255,255,255,.65)" font-size="13" font-family="serif">40ft Wide Main Boulevard</text>
                </svg>
                <div class="photo-overlay">
                    <div class="photo-label">40ft Wide Main Boulevard</div>
                    <span class="photo-tag">Infrastructure</span>
                </div>
                <div class="photo-zoom">🔍</div>
            </div>

            <div class="photo-item fade-in" data-cat="amenities" data-idx="6" onclick="openLightbox(6)">
                <svg class="pimg" viewBox="0 0 400 340" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="g6" x1="0%" y1="0%" x2="100%" y2="100%">
                            <stop offset="0%" stop-color="#312E81" />
                            <stop offset="100%" stop-color="#7C3AED" />
                        </linearGradient>
                    </defs>
                    <rect width="400" height="340" fill="url(#g6)" />
                    <rect x="50" y="40" width="300" height="200" rx="8" fill="rgba(255,255,255,.08)" />
                    <rect x="70" y="60" width="80" height="60" rx="3" fill="rgba(255,255,255,.15)" />
                    <rect x="170" y="60" width="80" height="60" rx="3" fill="rgba(255,255,255,.15)" />
                    <rect x="270" y="60" width="60" height="60" rx="3" fill="rgba(255,255,255,.15)" />
                    <rect x="70" y="140" width="260" height="30" rx="3" fill="rgba(255,255,255,.1)" />
                    <rect x="70" y="185" width="260" height="10" rx="2" fill="rgba(255,255,255,.08)" />
                    <rect x="140" y="255" width="120" height="45" rx="6" fill="rgba(232,160,32,.4)" />
                    <text x="200" y="283" text-anchor="middle" fill="rgba(255,255,255,.9)" font-size="12" font-family="serif">Community Club</text>
                    <text x="200" y="325" text-anchor="middle" fill="rgba(255,255,255,.6)" font-size="13" font-family="serif">Community Club House</text>
                </svg>
                <div class="photo-overlay">
                    <div class="photo-label">Community Club House</div>
                    <span class="photo-tag">Amenities</span>
                </div>
                <div class="photo-zoom">🔍</div>
            </div>

            <div class="photo-item fade-in" data-cat="landscape" data-idx="7" onclick="openLightbox(7)">
                <svg class="pimg" viewBox="0 0 400 260" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="g7" x1="0%" y1="0%" x2="100%" y2="100%">
                            <stop offset="0%" stop-color="#164E63" />
                            <stop offset="100%" stop-color="#0EA5E9" />
                        </linearGradient>
                    </defs>
                    <rect width="400" height="260" fill="url(#g7)" />
                    <ellipse cx="200" cy="130" rx="90" ry="40" fill="rgba(147,197,253,.2)" />
                    <path d="M50 180 Q120 120 200 140 Q280 160 350 120 L350 220 Q280 240 200 230 Q120 220 50 240Z" fill="rgba(34,211,238,.2)" />
                    <circle cx="80" cy="100" r="18" fill="rgba(255,255,255,.15)" />
                    <circle cx="320" cy="80" r="14" fill="rgba(255,255,255,.12)" />
                    <rect x="160" y="80" width="80" height="5" rx="2" fill="rgba(255,255,255,.2)" />
                    <rect x="140" y="100" width="120" height="4" rx="2" fill="rgba(255,255,255,.15)" />
                    <text x="200" y="250" text-anchor="middle" fill="rgba(255,255,255,.7)" font-size="13" font-family="serif">Jogging Track & Lake View</text>
                </svg>
                <div class="photo-overlay">
                    <div class="photo-label">Jogging Track & Lake View</div>
                    <span class="photo-tag">Landscape</span>
                </div>
                <div class="photo-zoom">🔍</div>
            </div>

            <div class="photo-item fade-in" data-cat="interior" data-idx="8" onclick="openLightbox(8)">
                <svg class="pimg" viewBox="0 0 400 280" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="g8" x1="0%" y1="0%" x2="100%" y2="100%">
                            <stop offset="0%" stop-color="#FDF8F0" />
                            <stop offset="100%" stop-color="#E8D5B7" />
                        </linearGradient>
                    </defs>
                    <rect width="400" height="280" fill="url(#g8)" />
                    <rect x="0" y="0" width="400" height="180" fill="rgba(232,160,32,.08)" />
                    <rect x="40" y="30" width="140" height="100" rx="4" fill="rgba(11,22,56,.08)" />
                    <rect x="220" y="30" width="140" height="100" rx="4" fill="rgba(11,22,56,.08)" />
                    <rect x="60" y="50" width="100" height="60" rx="2" fill="rgba(11,22,56,.12)" />
                    <rect x="240" y="50" width="100" height="60" rx="2" fill="rgba(11,22,56,.12)" />
                    <rect x="0" y="190" width="400" height="8" fill="rgba(11,22,56,.1)" />
                    <rect x="80" y="210" width="240" height="40" rx="4" fill="rgba(11,22,56,.06)" />
                    <rect x="150" y="220" width="100" height="20" rx="2" fill="rgba(11,22,56,.08)" />
                    <text x="200" y="270" text-anchor="middle" fill="rgba(11,22,56,.5)" font-size="13" font-family="serif">Show Home – Living Room</text>
                </svg>
                <div class="photo-overlay">
                    <div class="photo-label">Show Home – Living Room</div>
                    <span class="photo-tag">Interior</span>
                </div>
                <div class="photo-zoom">🔍</div>
            </div>

            <div class="photo-item fade-in" data-cat="exterior" data-idx="9" onclick="openLightbox(9)">
                <svg class="pimg" viewBox="0 0 400 260" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="g9" x1="0%" y1="0%" x2="100%" y2="100%">
                            <stop offset="0%" stop-color="#1E40AF" />
                            <stop offset="100%" stop-color="#60A5FA" />
                        </linearGradient>
                    </defs>
                    <rect width="400" height="260" fill="url(#g9)" />
                    <rect x="30" y="50" width="160" height="140" rx="5" fill="rgba(255,255,255,.1)" />
                    <rect x="210" y="70" width="160" height="120" rx="5" fill="rgba(255,255,255,.1)" />
                    <rect x="50" y="70" width="50" height="70" rx="2" fill="rgba(255,255,255,.18)" />
                    <rect x="120" y="70" width="50" height="70" rx="2" fill="rgba(255,255,255,.18)" />
                    <rect x="230" y="90" width="50" height="60" rx="2" fill="rgba(255,255,255,.18)" />
                    <rect x="300" y="90" width="50" height="60" rx="2" fill="rgba(255,255,255,.18)" />
                    <rect x="0" y="200" width="400" height="60" fill="rgba(0,0,0,.2)" />
                    <text x="200" y="240" text-anchor="middle" fill="rgba(255,255,255,.7)" font-size="13" font-family="serif">Twin Tower Residences</text>
                </svg>
                <div class="photo-overlay">
                    <div class="photo-label">Twin Tower Residences</div>
                    <span class="photo-tag">Exterior</span>
                </div>
                <div class="photo-zoom">🔍</div>
            </div>

            <div class="photo-item fade-in" data-cat="amenities" data-idx="10" onclick="openLightbox(10)">
                <svg class="pimg" viewBox="0 0 400 300" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="g10" x1="0%" y1="0%" x2="100%" y2="100%">
                            <stop offset="0%" stop-color="#7C2D12" />
                            <stop offset="100%" stop-color="#F97316" />
                        </linearGradient>
                    </defs>
                    <rect width="400" height="300" fill="url(#g10)" />
                    <rect x="50" y="60" width="300" height="180" rx="6" fill="rgba(255,255,255,.1)" />
                    <rect x="70" y="80" width="260" height="8" rx="2" fill="rgba(255,255,255,.2)" />
                    <rect x="80" y="110" width="100" height="80" rx="4" fill="rgba(255,255,255,.15)" />
                    <rect x="200" y="110" width="100" height="80" rx="4" fill="rgba(255,255,255,.15)" />
                    <rect x="70" y="205" width="260" height="8" rx="2" fill="rgba(255,255,255,.15)" />
                    <text x="200" y="285" text-anchor="middle" fill="rgba(255,255,255,.7)" font-size="13" font-family="serif">Modern Gymnasium</text>
                </svg>
                <div class="photo-overlay">
                    <div class="photo-label">Modern Gymnasium</div>
                    <span class="photo-tag">Amenities</span>
                </div>
                <div class="photo-zoom">🔍</div>
            </div>

            <div class="photo-item fade-in" data-cat="aerial" data-idx="11" onclick="openLightbox(11)">
                <svg class="pimg" viewBox="0 0 400 380" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="g11" x1="0%" y1="0%" x2="100%" y2="100%">
                            <stop offset="0%" stop-color="#0C2340" />
                            <stop offset="100%" stop-color="#1456A0" />
                        </linearGradient>
                    </defs>
                    <rect width="400" height="380" fill="url(#g11)" />
                    <rect x="0" y="0" width="400" height="380" fill="url(#g11)" />
                    <rect x="20" y="20" width="170" height="100" rx="3" fill="rgba(255,255,255,.08)" />
                    <rect x="210" y="20" width="170" height="100" rx="3" fill="rgba(255,255,255,.08)" />
                    <rect x="20" y="140" width="170" height="100" rx="3" fill="rgba(255,255,255,.08)" />
                    <rect x="210" y="140" width="170" height="100" rx="3" fill="rgba(255,255,255,.08)" />
                    <rect x="20" y="260" width="360" height="80" rx="3" fill="rgba(34,197,94,.12)" />
                    <rect x="185" y="0" width="30" height="380" fill="rgba(255,255,255,.05)" />
                    <rect x="0" y="120" width="400" height="20" fill="rgba(255,255,255,.04)" />
                    <rect x="0" y="240" width="400" height="20" fill="rgba(255,255,255,.04)" />
                    <text x="200" y="370" text-anchor="middle" fill="rgba(255,255,255,.6)" font-size="12" font-family="serif">Master Plan – Phase 1</text>
                </svg>
                <div class="photo-overlay">
                    <div class="photo-label">Master Plan – Phase 1</div>
                    <span class="photo-tag">Aerial View</span>
                </div>
                <div class="photo-zoom">🔍</div>
            </div>

            <div class="photo-item fade-in" data-cat="infrastructure" data-idx="12" onclick="openLightbox(12)">
                <svg class="pimg" viewBox="0 0 400 270" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="g12" x1="0%" y1="0%" x2="100%" y2="100%">
                            <stop offset="0%" stop-color="#0F172A" />
                            <stop offset="100%" stop-color="#334155" />
                        </linearGradient>
                    </defs>
                    <rect width="400" height="270" fill="url(#g12)" />
                    <rect x="0" y="130" width="400" height="80" fill="rgba(148,163,184,.15)" />
                    <rect x="0" y="150" width="400" height="5" fill="rgba(255,255,255,.1)" />
                    <rect x="0" y="175" width="400" height="3" fill="rgba(255,255,255,.07)" />
                    <path d="M0 100 L60 80 L120 100 L180 80 L240 100 L300 80 L360 100 L400 85 L400 130 L0 130Z" fill="rgba(71,85,105,.4)" />
                    <circle cx="50" cy="70" r="6" fill="rgba(250,204,21,.6)" />
                    <circle cx="150" cy="60" r="6" fill="rgba(250,204,21,.6)" />
                    <circle cx="250" cy="70" r="6" fill="rgba(250,204,21,.6)" />
                    <circle cx="350" cy="65" r="6" fill="rgba(250,204,21,.6)" />
                    <text x="200" y="260" text-anchor="middle" fill="rgba(255,255,255,.6)" font-size="13" font-family="serif">Underground Utilities Network</text>
                </svg>
                <div class="photo-overlay">
                    <div class="photo-label">Underground Utilities Network</div>
                    <span class="photo-tag">Infrastructure</span>
                </div>
                <div class="photo-zoom">🔍</div>
            </div>

            <div class="photo-item fade-in" data-cat="interior" data-idx="13" onclick="openLightbox(13)">
                <svg class="pimg" viewBox="0 0 400 300" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="g13" x1="0%" y1="0%" x2="100%" y2="100%">
                            <stop offset="0%" stop-color="#F8EDD8" />
                            <stop offset="100%" stop-color="#DEB887" />
                        </linearGradient>
                    </defs>
                    <rect width="400" height="300" fill="url(#g13)" />
                    <rect x="0" y="0" width="400" height="180" fill="rgba(11,22,56,.05)" />
                    <rect x="30" y="30" width="160" height="110" rx="4" fill="rgba(11,22,56,.07)" />
                    <rect x="210" y="30" width="160" height="110" rx="4" fill="rgba(11,22,56,.07)" />
                    <rect x="0" y="185" width="400" height="6" fill="rgba(11,22,56,.08)" />
                    <rect x="60" y="205" width="100" height="60" rx="4" fill="rgba(11,22,56,.06)" />
                    <rect x="240" y="205" width="100" height="60" rx="4" fill="rgba(11,22,56,.06)" />
                    <rect x="175" y="210" width="50" height="55" rx="2" fill="rgba(11,22,56,.05)" />
                    <text x="200" y="290" text-anchor="middle" fill="rgba(11,22,56,.5)" font-size="13" font-family="serif">Show Kitchen – Modular Design</text>
                </svg>
                <div class="photo-overlay">
                    <div class="photo-label">Show Kitchen – Modular</div>
                    <span class="photo-tag">Interior</span>
                </div>
                <div class="photo-zoom">🔍</div>
            </div>

            <div class="photo-item fade-in" data-cat="landscape" data-idx="14" onclick="openLightbox(14)">
                <svg class="pimg" viewBox="0 0 400 240" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="g14" x1="0%" y1="0%" x2="100%" y2="100%">
                            <stop offset="0%" stop-color="#1A3A1A" />
                            <stop offset="100%" stop-color="#2D6A2D" />
                        </linearGradient>
                    </defs>
                    <rect width="400" height="240" fill="url(#g14)" />
                    <ellipse cx="60" cy="160" rx="35" ry="50" fill="rgba(21,128,61,.5)" />
                    <ellipse cx="130" cy="150" rx="30" ry="45" fill="rgba(21,128,61,.45)" />
                    <ellipse cx="220" cy="155" rx="38" ry="52" fill="rgba(21,128,61,.5)" />
                    <ellipse cx="310" cy="148" rx="32" ry="47" fill="rgba(21,128,61,.45)" />
                    <ellipse cx="380" cy="158" rx="28" ry="44" fill="rgba(21,128,61,.4)" />
                    <rect x="0" y="190" width="400" height="50" fill="rgba(101,163,13,.25)" />
                    <path d="M100 180 Q200 140 300 170" stroke="rgba(255,255,255,.2)" stroke-width="3" fill="none" stroke-dasharray="8,6" />
                    <text x="200" y="230" text-anchor="middle" fill="rgba(255,255,255,.7)" font-size="13" font-family="serif">Tree-Lined Avenue</text>
                </svg>
                <div class="photo-overlay">
                    <div class="photo-label">Tree-Lined Avenue</div>
                    <span class="photo-tag">Landscape</span>
                </div>
                <div class="photo-zoom">🔍</div>
            </div>

            <div class="photo-item fade-in" data-cat="amenities" data-idx="15" onclick="openLightbox(15)">
                <svg class="pimg" viewBox="0 0 400 260" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="g15" x1="0%" y1="0%" x2="100%" y2="100%">
                            <stop offset="0%" stop-color="#1E1B4B" />
                            <stop offset="100%" stop-color="#4F46E5" />
                        </linearGradient>
                    </defs>
                    <rect width="400" height="260" fill="url(#g15)" />
                    <rect x="60" y="50" width="280" height="150" rx="8" fill="rgba(255,255,255,.08)" />
                    <circle cx="200" cy="125" r="50" fill="rgba(255,255,255,.1)" />
                    <circle cx="200" cy="125" r="35" fill="rgba(232,160,32,.2)" />
                    <rect x="120" y="215" width="160" height="10" rx="3" fill="rgba(255,255,255,.12)" />
                    <text x="200" y="250" text-anchor="middle" fill="rgba(255,255,255,.7)" font-size="13" font-family="serif">Kids Play Zone</text>
                </svg>
                <div class="photo-overlay">
                    <div class="photo-label">Kids Play Zone</div>
                    <span class="photo-tag">Amenities</span>
                </div>
                <div class="photo-zoom">🔍</div>
            </div>

            <div class="photo-item fade-in" data-cat="infrastructure" data-idx="16" onclick="openLightbox(16)">
                <svg class="pimg" viewBox="0 0 400 250" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="g16" x1="0%" y1="0%" x2="100%" y2="100%">
                            <stop offset="0%" stop-color="#1C1917" />
                            <stop offset="100%" stop-color="#44403C" />
                        </linearGradient>
                    </defs>
                    <rect width="400" height="250" fill="url(#g16)" />
                    <rect x="130" y="30" width="140" height="160" rx="4" fill="rgba(255,255,255,.08)" />
                    <rect x="150" y="50" width="100" height="20" rx="2" fill="rgba(255,255,255,.15)" />
                    <rect x="150" y="85" width="100" height="20" rx="2" fill="rgba(255,255,255,.12)" />
                    <rect x="150" y="120" width="100" height="20" rx="2" fill="rgba(255,255,255,.12)" />
                    <rect x="170" y="155" width="60" height="35" rx="2" fill="rgba(232,160,32,.3)" />
                    <rect x="0" y="200" width="400" height="50" fill="rgba(0,0,0,.3)" />
                    <text x="200" y="235" text-anchor="middle" fill="rgba(255,255,255,.7)" font-size="13" font-family="serif">Security Guard Post</text>
                </svg>
                <div class="photo-overlay">
                    <div class="photo-label">Security Guard Post</div>
                    <span class="photo-tag">Infrastructure</span>
                </div>
                <div class="photo-zoom">🔍</div>
            </div>

            <div class="photo-item fade-in" data-cat="exterior" data-idx="17" onclick="openLightbox(17)">
                <svg class="pimg" viewBox="0 0 400 290" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="g17" x1="0%" y1="0%" x2="100%" y2="100%">
                            <stop offset="0%" stop-color="#0B1638" />
                            <stop offset="100%" stop-color="#1E6FBF" />
                        </linearGradient>
                    </defs>
                    <rect width="400" height="290" fill="url(#g17)" />
                    <rect x="20" y="40" width="360" height="180" rx="6" fill="rgba(255,255,255,.07)" />
                    <rect x="40" y="60" width="80" height="120" rx="3" fill="rgba(255,255,255,.12)" />
                    <rect x="140" y="60" width="80" height="120" rx="3" fill="rgba(255,255,255,.12)" />
                    <rect x="240" y="60" width="80" height="120" rx="3" fill="rgba(255,255,255,.12)" />
                    <rect x="160" y="160" width="80" height="20" rx="2" fill="rgba(232,160,32,.3)" />
                    <rect x="0" y="230" width="400" height="60" fill="rgba(0,0,0,.25)" />
                    <text x="200" y="268" text-anchor="middle" fill="rgba(255,255,255,.7)" font-size="13" font-family="serif">Row Houses – Evening View</text>
                </svg>
                <div class="photo-overlay">
                    <div class="photo-label">Row Houses – Evening View</div>
                    <span class="photo-tag">Exterior</span>
                </div>
                <div class="photo-zoom">🔍</div>
            </div>

            <div class="photo-item fade-in" data-cat="interior" data-idx="18" onclick="openLightbox(18)">
                <svg class="pimg" viewBox="0 0 400 320" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="g18" x1="0%" y1="0%" x2="100%" y2="100%">
                            <stop offset="0%" stop-color="#F5F0E8" />
                            <stop offset="100%" stop-color="#E5D5C0" />
                        </linearGradient>
                    </defs>
                    <rect width="400" height="320" fill="url(#g18)" />
                    <rect x="0" y="0" width="200" height="320" fill="rgba(11,22,56,.04)" />
                    <rect x="40" y="40" width="120" height="160" rx="3" fill="rgba(11,22,56,.06)" />
                    <rect x="220" y="40" width="140" height="200" rx="3" fill="rgba(11,22,56,.06)" />
                    <rect x="0" y="240" width="400" height="6" fill="rgba(11,22,56,.06)" />
                    <ellipse cx="100" cy="290" rx="60" ry="15" fill="rgba(11,22,56,.08)" />
                    <ellipse cx="300" cy="285" rx="60" ry="12" fill="rgba(11,22,56,.07)" />
                    <text x="200" y="312" text-anchor="middle" fill="rgba(11,22,56,.45)" font-size="13" font-family="serif">Master Bedroom Suite</text>
                </svg>
                <div class="photo-overlay">
                    <div class="photo-label">Master Bedroom Suite</div>
                    <span class="photo-tag">Interior</span>
                </div>
                <div class="photo-zoom">🔍</div>
            </div>

            <div class="photo-item fade-in" data-cat="landscape" data-idx="19" onclick="openLightbox(19)">
                <svg class="pimg" viewBox="0 0 400 260" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="g19" x1="0%" y1="100%" x2="100%" y2="0%">
                            <stop offset="0%" stop-color="#064E3B" />
                            <stop offset="100%" stop-color="#34D399" />
                        </linearGradient>
                    </defs>
                    <rect width="400" height="260" fill="url(#g19)" />
                    <circle cx="60" cy="80" r="30" fill="rgba(21,128,61,.4)" />
                    <circle cx="200" cy="70" r="38" fill="rgba(21,128,61,.45)" />
                    <circle cx="340" cy="85" r="28" fill="rgba(21,128,61,.4)" />
                    <circle cx="130" cy="110" r="22" fill="rgba(21,128,61,.35)" />
                    <circle cx="270" cy="115" r="25" fill="rgba(21,128,61,.38)" />
                    <rect x="0" y="200" width="400" height="60" fill="rgba(6,78,59,.5)" />
                    <path d="M0 170 Q50 140 100 155 Q150 170 200 150 Q250 130 300 148 Q350 165 400 145 L400 200 L0 200Z" fill="rgba(16,185,129,.3)" />
                    <text x="200" y="250" text-anchor="middle" fill="rgba(255,255,255,.75)" font-size="13" font-family="serif">Community Orchard Garden</text>
                </svg>
                <div class="photo-overlay">
                    <div class="photo-label">Community Orchard Garden</div>
                    <span class="photo-tag">Landscape</span>
                </div>
                <div class="photo-zoom">🔍</div>
            </div>

            <div class="photo-item fade-in" data-cat="aerial" data-idx="20" onclick="openLightbox(20)">
                <svg class="pimg" viewBox="0 0 400 300" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="g20" x1="0%" y1="0%" x2="100%" y2="100%">
                            <stop offset="0%" stop-color="#0A1628" />
                            <stop offset="100%" stop-color="#0E3A6E" />
                        </linearGradient>
                    </defs>
                    <rect width="400" height="300" fill="url(#g20)" />
                    <circle cx="200" cy="150" r="100" fill="rgba(255,255,255,.04)" />
                    <circle cx="200" cy="150" r="70" fill="rgba(255,255,255,.04)" />
                    <circle cx="200" cy="150" r="40" fill="rgba(232,160,32,.12)" />
                    <rect x="195" y="50" width="10" height="200" fill="rgba(255,255,255,.07)" />
                    <rect x="100" y="145" width="200" height="10" fill="rgba(255,255,255,.07)" />
                    <rect x="140" y="90" width="8" height="80" fill="rgba(255,200,50,.2)" transform="rotate(45,144,130)" />
                    <rect x="260" y="90" width="8" height="80" fill="rgba(255,200,50,.2)" transform="rotate(-45,264,130)" />
                    <text x="200" y="290" text-anchor="middle" fill="rgba(255,255,255,.6)" font-size="12" font-family="serif">Night Aerial – Light Pattern</text>
                </svg>
                <div class="photo-overlay">
                    <div class="photo-label">Night Aerial – Light Pattern</div>
                    <span class="photo-tag">Aerial View</span>
                </div>
                <div class="photo-zoom">🔍</div>
            </div>

            <div class="photo-item fade-in" data-cat="amenities" data-idx="21" onclick="openLightbox(21)">
                <svg class="pimg" viewBox="0 0 400 270" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="g21" x1="0%" y1="0%" x2="100%" y2="100%">
                            <stop offset="0%" stop-color="#065F46" />
                            <stop offset="100%" stop-color="#10B981" />
                        </linearGradient>
                    </defs>
                    <rect width="400" height="270" fill="url(#g21)" />
                    <rect x="40" y="40" width="320" height="160" rx="5" fill="rgba(255,255,255,.08)" />
                    <rect x="60" y="60" width="60" height="100" rx="3" fill="rgba(255,255,255,.15)" />
                    <rect x="140" y="60" width="60" height="100" rx="3" fill="rgba(255,255,255,.15)" />
                    <rect x="220" y="60" width="60" height="100" rx="3" fill="rgba(255,255,255,.15)" />
                    <rect x="300" y="60" width="40" height="100" rx="3" fill="rgba(255,255,255,.12)" />
                    <rect x="40" y="210" width="320" height="8" rx="2" fill="rgba(255,255,255,.1)" />
                    <text x="200" y="258" text-anchor="middle" fill="rgba(255,255,255,.7)" font-size="13" font-family="serif">Mosque – Grand Design</text>
                </svg>
                <div class="photo-overlay">
                    <div class="photo-label">Mosque – Grand Design</div>
                    <span class="photo-tag">Amenities</span>
                </div>
                <div class="photo-zoom">🔍</div>
            </div>

            <div class="photo-item fade-in" data-cat="infrastructure" data-idx="22" onclick="openLightbox(22)">
                <svg class="pimg" viewBox="0 0 400 260" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="g22" x1="0%" y1="0%" x2="100%" y2="100%">
                            <stop offset="0%" stop-color="#172554" />
                            <stop offset="100%" stop-color="#1D4ED8" />
                        </linearGradient>
                    </defs>
                    <rect width="400" height="260" fill="url(#g22)" />
                    <rect x="0" y="120" width="400" height="60" fill="rgba(255,255,255,.06)" />
                    <rect x="0" y="135" width="400" height="6" fill="rgba(255,255,255,.12)" />
                    <rect x="0" y="163" width="400" height="4" fill="rgba(255,255,255,.08)" />
                    <rect x="20" y="60" width="6" height="70" fill="rgba(255,200,50,.3)" />
                    <circle cx="23" cy="56" r="7" fill="rgba(255,200,50,.5)" />
                    <rect x="100" y="50" width="6" height="80" fill="rgba(255,200,50,.3)" />
                    <circle cx="103" cy="46" r="7" fill="rgba(255,200,50,.5)" />
                    <rect x="200" y="55" width="6" height="75" fill="rgba(255,200,50,.3)" />
                    <circle cx="203" cy="51" r="7" fill="rgba(255,200,50,.5)" />
                    <rect x="300" y="52" width="6" height="78" fill="rgba(255,200,50,.3)" />
                    <circle cx="303" cy="48" r="7" fill="rgba(255,200,50,.5)" />
                    <rect x="380" y="58" width="6" height="72" fill="rgba(255,200,50,.3)" />
                    <circle cx="383" cy="54" r="7" fill="rgba(255,200,50,.5)" />
                    <text x="200" y="250" text-anchor="middle" fill="rgba(255,255,255,.65)" font-size="13" font-family="serif">Street Lighting System</text>
                </svg>
                <div class="photo-overlay">
                    <div class="photo-label">Street Lighting System</div>
                    <span class="photo-tag">Infrastructure</span>
                </div>
                <div class="photo-zoom">🔍</div>
            </div>

            <div class="photo-item fade-in" data-cat="exterior" data-idx="23" onclick="openLightbox(23)">
                <svg class="pimg" viewBox="0 0 400 280" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="g23" x1="0%" y1="0%" x2="100%" y2="100%">
                            <stop offset="0%" stop-color="#0D1B4B" />
                            <stop offset="50%" stop-color="#1756A9" />
                            <stop offset="100%" stop-color="#E8A020" />
                        </linearGradient>
                    </defs>
                    <rect width="400" height="280" fill="url(#g23)" />
                    <rect x="50" y="40" width="300" height="160" rx="8" fill="rgba(255,255,255,.08)" />
                    <rect x="70" y="60" width="120" height="100" rx="4" fill="rgba(255,255,255,.12)" />
                    <rect x="210" y="60" width="120" height="100" rx="4" fill="rgba(255,255,255,.12)" />
                    <rect x="155" y="170" width="90" height="30" rx="3" fill="rgba(232,160,32,.4)" />
                    <rect x="0" y="215" width="400" height="65" fill="rgba(0,0,0,.3)" />
                    <text x="200" y="258" text-anchor="middle" fill="rgba(255,255,255,.8)" font-size="13" font-family="serif">Project Hoarding – Launch</text>
                </svg>
                <div class="photo-overlay">
                    <div class="photo-label">Project Hoarding – Launch Day</div>
                    <span class="photo-tag">Exterior</span>
                </div>
                <div class="photo-zoom">🔍</div>
            </div>

        </div>

        <!-- CTA Strip -->
        <div class="cta-strip fade-in">
            <div class="cta-strip-text">
                <div class="cta-strip-title">Love What You See?</div>
                <div class="cta-strip-sub">Schedule a site visit and see Sky Residencia Delhi in person.</div>
            </div>
            <div class="cta-strip-btns">
                <a href="property-detail.html" class="btn-cta-white">📋 View Full Details</a>
                <a href="property-detail.html#contact-form" class="btn-cta-outline">📞 Book Site Visit</a>
            </div>
        </div>

    </div>
    <!-- LIGHTBOX -->
    <div class="lightbox" id="lightbox">

        <!-- Top Bar -->
        <div class="lb-topbar">
            <div class="lb-title-wrap">
                <div class="lb-prop-name">Sky Residencia Delhi</div>
                <div class="lb-counter" id="lbCounter">Photo 1 of 24</div>
            </div>
            <div class="lb-topbar-actions">
                <button class="lb-action-btn" onclick="toggleSlideshow()" id="slideshowBtn" title="Slideshow">▶</button>
                <button class="lb-action-btn" onclick="downloadPhoto()" title="Download">⬇</button>
                <button class="lb-action-btn lb-close-btn" onclick="closeLightbox()" title="Close">✕</button>
            </div>
        </div>

        <!-- Category Pills -->
        <div class="lb-cat-bar">
            <button class="lb-cat-pill active" onclick="lbFilterCat(this,'all')">All</button>
            <button class="lb-cat-pill" onclick="lbFilterCat(this,'exterior')">🏙️ Exterior</button>
            <button class="lb-cat-pill" onclick="lbFilterCat(this,'amenities')">🏊 Amenities</button>
            <button class="lb-cat-pill" onclick="lbFilterCat(this,'landscape')">🌳 Landscape</button>
            <button class="lb-cat-pill" onclick="lbFilterCat(this,'interior')">🏠 Interior</button>
            <button class="lb-cat-pill" onclick="lbFilterCat(this,'infrastructure')">🚗 Infrastructure</button>
            <button class="lb-cat-pill" onclick="lbFilterCat(this,'aerial')">🚁 Aerial</button>
        </div>

        <!-- Main Image -->
        <div class="lb-main">
            <button class="lb-arrow lb-prev" onclick="lbNav(-1)">‹</button>
            <div class="lb-img-wrap">
                <div class="lb-img" id="lbMainImg"></div>
                <div class="lb-img-info">
                    <div class="lb-img-name" id="lbImgName">Main Entrance Gate</div>
                    <div class="lb-img-cat" id="lbImgCat">📍 Sky Residencia Delhi · Exterior</div>
                </div>
            </div>
            <button class="lb-arrow lb-next" onclick="lbNav(1)">›</button>
        </div>

        <!-- Thumbnail Strip -->
        <div class="lb-strip">
            <div class="lb-thumbs" id="lbThumbs"></div>
        </div>

    </div>

    <script>
        // ── PHOTO DATA ──
        const photos = [
            { bg: 'linear-gradient(135deg,#0D1B4B,#1E6FBF,#2a9fd6)', icon: '🏙️', name: 'Main Entrance Gate', cat: 'exterior' },
            { bg: 'linear-gradient(135deg,#0B1638,#1756A9)', icon: '🚁', name: 'Aerial Overview – Full Layout', cat: 'aerial' },
            { bg: 'linear-gradient(135deg,#0F766E,#14B8A6)', icon: '🏊', name: 'Olympic Swimming Pool', cat: 'amenities' },
            { bg: 'linear-gradient(135deg,#14532D,#22C55E)', icon: '🌳', name: 'Central Park & Gardens', cat: 'landscape' },
            { bg: 'linear-gradient(135deg,#1E3A8A,#3B82F6)', icon: '🏢', name: 'Residential Block A', cat: 'exterior' },
            { bg: 'linear-gradient(135deg,#1C1917,#57534E)', icon: '🛣️', name: '40ft Wide Main Boulevard', cat: 'infrastructure' },
            { bg: 'linear-gradient(135deg,#312E81,#7C3AED)', icon: '🏛️', name: 'Community Club House', cat: 'amenities' },
            { bg: 'linear-gradient(135deg,#164E63,#0EA5E9)', icon: '🏃', name: 'Jogging Track & Lake View', cat: 'landscape' },
            { bg: 'linear-gradient(135deg,#FDF8F0,#E8D5B7)', icon: '🛋️', name: 'Show Home – Living Room', cat: 'interior' },
            { bg: 'linear-gradient(135deg,#1E40AF,#60A5FA)', icon: '🏗️', name: 'Twin Tower Residences', cat: 'exterior' },
            { bg: 'linear-gradient(135deg,#7C2D12,#F97316)', icon: '🏋️', name: 'Modern Gymnasium', cat: 'amenities' },
            { bg: 'linear-gradient(135deg,#0C2340,#1456A0)', icon: '📐', name: 'Master Plan – Phase 1', cat: 'aerial' },
            { bg: 'linear-gradient(135deg,#0F172A,#334155)', icon: '⚡', name: 'Underground Utilities Network', cat: 'infrastructure' },
            { bg: 'linear-gradient(135deg,#F8EDD8,#DEB887)', icon: '🍳', name: 'Show Kitchen – Modular Design', cat: 'interior' },
            { bg: 'linear-gradient(135deg,#1A3A1A,#2D6A2D)', icon: '🌲', name: 'Tree-Lined Avenue', cat: 'landscape' },
            { bg: 'linear-gradient(135deg,#1E1B4B,#4F46E5)', icon: '🎠', name: 'Kids Play Zone', cat: 'amenities' },
            { bg: 'linear-gradient(135deg,#1C1917,#44403C)', icon: '🔒', name: 'Security Guard Post', cat: 'infrastructure' },
            { bg: 'linear-gradient(135deg,#0B1638,#1E6FBF)', icon: '🌇', name: 'Row Houses – Evening View', cat: 'exterior' },
            { bg: 'linear-gradient(135deg,#F5F0E8,#E5D5C0)', icon: '🛏️', name: 'Master Bedroom Suite', cat: 'interior' },
            { bg: 'linear-gradient(135deg,#064E3B,#10B981)', icon: '🌿', name: 'Community Orchard Garden', cat: 'landscape' },
            { bg: 'linear-gradient(135deg,#0A1628,#0E3A6E)', icon: '🌙', name: 'Night Aerial – Light Pattern', cat: 'aerial' },
            { bg: 'linear-gradient(135deg,#065F46,#10B981)', icon: '🕌', name: 'Mosque – Grand Design', cat: 'amenities' },
            { bg: 'linear-gradient(135deg,#172554,#1D4ED8)', icon: '💡', name: 'Street Lighting System', cat: 'infrastructure' },
            { bg: 'linear-gradient(135deg,#0D1B4B,#E8A020)', icon: '🎉', name: 'Project Hoarding – Launch Day', cat: 'exterior' },
        ];

        let currentIdx = 0;
        let slideshowTimer = null;
        let lbCatFilter = 'all';
        let filteredIndices = photos.map((_, i) => i);

        // Build thumbnail strip
        function buildThumbs() {
            const container = document.getElementById('lbThumbs');
            container.innerHTML = '';
            filteredIndices.forEach((realIdx, pos) => {
                const p = photos[realIdx];
                const div = document.createElement('div');
                div.className = 'lb-thumb';
                div.style.background = p.bg;
                div.textContent = p.icon;
                div.onclick = () => { currentIdx = pos; updateLightbox(); };
                container.appendChild(div);
            });
            updateThumbActive();
        }

        function updateThumbActive() {
            document.querySelectorAll('.lb-thumb').forEach((t, i) => t.classList.toggle('active', i === currentIdx));
            // Scroll active thumb into view
            const thumbs = document.querySelectorAll('.lb-thumb');
            if (thumbs[currentIdx]) {
                thumbs[currentIdx].scrollIntoView({ behavior: 'smooth', block: 'nearest', inline: 'center' });
            }
        }

        function updateLightbox() {
            const realIdx = filteredIndices[currentIdx];
            const p = photos[realIdx];
            const img = document.getElementById('lbMainImg');
            img.style.opacity = '0';
            setTimeout(() => {
                img.style.background = p.bg;
                img.style.fontSize = '96px';
                img.textContent = p.icon;
                img.style.opacity = '1';
                img.style.transition = 'opacity .25s';
            }, 150);
            document.getElementById('lbImgName').textContent = p.name;
            document.getElementById('lbImgCat').textContent = `📍 Sky Residencia Delhi · ${capitalize(p.cat)}`;
            document.getElementById('lbCounter').textContent = `Photo ${currentIdx + 1} of ${filteredIndices.length}`;
            updateThumbActive();
        }

        function capitalize(s) { return s.charAt(0).toUpperCase() + s.slice(1); }

        function openLightbox(gridIdx) {
            // Find position in current filtered list
            const realIdx = gridIdx; // gridIdx is the data-idx value
            const pos = filteredIndices.indexOf(realIdx);
            currentIdx = pos >= 0 ? pos : 0;
            document.getElementById('lightbox').classList.add('open');
            document.body.style.overflow = 'hidden';
            buildThumbs();
            updateLightbox();
        }

        function closeLightbox() {
            document.getElementById('lightbox').classList.remove('open');
            document.body.style.overflow = '';
            stopSlideshow();
        }

        function lbNav(dir) {
            currentIdx = (currentIdx + dir + filteredIndices.length) % filteredIndices.length;
            updateLightbox();
        }

        function lbFilterCat(btn, cat) {
            document.querySelectorAll('.lb-cat-pill').forEach(p => p.classList.remove('active'));
            btn.classList.add('active');
            lbCatFilter = cat;
            filteredIndices = cat === 'all' ? photos.map((_, i) => i) : photos.map((_, i) => i).filter(i => photos[i].cat === cat);
            currentIdx = 0;
            buildThumbs();
            updateLightbox();
        }

        function toggleSlideshow() {
            if (slideshowTimer) {
                stopSlideshow();
            } else {
                document.getElementById('slideshowBtn').textContent = '⏸';
                slideshowTimer = setInterval(() => { lbNav(1); }, 3000);
            }
        }
        function stopSlideshow() {
            if (slideshowTimer) { clearInterval(slideshowTimer); slideshowTimer = null; }
            document.getElementById('slideshowBtn').textContent = '▶';
        }
        function downloadPhoto() { alert('Download feature: photo would be saved as ' + photos[filteredIndices[currentIdx]].name + '.jpg'); }

        // ── GALLERY FILTER ──
        function filterGallery(btn, cat) {
            document.querySelectorAll('.ftab').forEach(t => t.classList.remove('active'));
            btn.classList.add('active');
            const items = document.querySelectorAll('.photo-item');
            let count = 0;
            items.forEach(item => {
                const show = cat === 'all' || item.dataset.cat === cat;
                item.style.display = show ? 'block' : 'none';
                if (show) count++;
            });
            document.getElementById('visibleCount').textContent = count;
        }

        // ── KEYBOARD ──
        document.addEventListener('keydown', e => {
            const lb = document.getElementById('lightbox');
            if (!lb.classList.contains('open')) return;
            if (e.key === 'Escape') closeLightbox();
            if (e.key === 'ArrowRight') lbNav(1);
            if (e.key === 'ArrowLeft') lbNav(-1);
        });

        // ── CLOSE ON BG CLICK ──
        document.getElementById('lightbox').addEventListener('click', function (e) {
            if (e.target === this) closeLightbox();
        });

        // ── HAMBURGER ──
        //const hamburger = document.getElementById('hamburger');
        //const navLinks = document.getElementById('navLinks');
        //const navCta = document.getElementById('navCta');
        //hamburger.addEventListener('click', () => {
        //    const open = navLinks.classList.contains('mob-open');
        //    if (open) {
        //        navLinks.classList.remove('mob-open'); navCta.classList.remove('mob-open');
        //        hamburger.classList.remove('open'); document.body.style.overflow = '';
        //    } else {
        //        navLinks.classList.add('mob-open'); hamburger.classList.add('open'); document.body.style.overflow = 'hidden';
        //        setTimeout(() => { navCta.style.top = navLinks.getBoundingClientRect().bottom + 'px'; navCta.classList.add('mob-open'); }, 10);
        //    }
        //});
        //document.addEventListener('click', e => {
        //    if (!e.target.closest('nav') && !e.target.closest('#lightbox')) {
        //        navLinks.classList.remove('mob-open'); navCta.classList.remove('mob-open');
        //        hamburger.classList.remove('open'); document.body.style.overflow = '';
        //    }
        //});

        // ── SCROLL ANIMATIONS ──
        const obs = new IntersectionObserver(entries => {
            entries.forEach((e, i) => { if (e.isIntersecting) setTimeout(() => e.target.classList.add('visible'), i * 60); });
        }, { threshold: 0.06 });
        document.querySelectorAll('.fade-in').forEach(el => obs.observe(el));
</script>
</asp:Content>

