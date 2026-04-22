<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProjectCreate.aspx.cs" Inherits="ProjectCreate" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title><%= Session["Title"] %></title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <link href="css/Project.css" rel="stylesheet" />
    <style>
        .section-icon i {
            font-size: 1rem;
        }

        .a-icon i {
            font-size: 1.2rem;
            display: block;
            margin-bottom: 4px;
        }

        .doc-icon i {
            font-size: 1.6rem;
            display: block;
            margin-bottom: 6px;
        }

        .step-save-row {
            text-align: right;
            margin-top: 16px;
            margin-bottom: 8px;
        }

        /* VALIDATION */
        .field-error input, .field-error select, .field-error textarea {
            border-color: var(--red) !important;
            box-shadow: 0 0 0 3px rgba(220,38,38,0.12) !important;
            animation: shake 0.3s ease;
        }

        .error-msg {
            font-size: .68rem;
            color: var(--red);
            margin-top: 3px;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .step-item.locked .step-num {
            background: var(--border);
            border-color: var(--border);
            color: var(--text-light);
            cursor: not-allowed;
        }

        .step-item.locked {
            cursor: not-allowed;
            opacity: .6;
        }

        .step-item.completed .step-num {
            background: var(--green) !important;
            border-color: var(--green) !important;
            color: #fff !important;
        }

        .step-item.completed .step-label {
            color: var(--green) !important;
        }

        .val-summary {
            background: var(--red-pale);
            border: 1.5px solid #FECACA;
            border-left: 4px solid var(--red);
            border-radius: var(--radius-sm);
            padding: 12px 16px;
            margin-bottom: 16px;
            display: none;
        }

            .val-summary.show {
                display: block;
            }

        .val-summary-title {
            font-size: .8rem;
            font-weight: 700;
            color: var(--red);
            margin-bottom: 6px;
        }

        .val-summary ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

            .val-summary ul li {
                font-size: .75rem;
                color: #7F1D1D;
                padding: 2px 0;
            }

                .val-summary ul li::before {
                    content: '- ';
                    font-weight: 700;
                }

        @keyframes shake {
            0%,100% {
                transform: translateX(0)
            }

            20% {
                transform: translateX(-6px)
            }

            60% {
                transform: translateX(6px)
            }
        }

        /* GALLERY */
        .photo-drop {
            cursor: pointer;
            transition: border-color .2s, background .2s;
        }

            .photo-drop.drag-over {
                border-color: var(--orange) !important;
                background: var(--orange-pale) !important;
            }

        .gallery-thumb {
            position: relative;
            border-radius: 8px;
            overflow: hidden;
            aspect-ratio: 1;
            background: #F1F5F9;
            border: 2px solid var(--border);
            transition: border-color .2s;
        }

            .gallery-thumb:hover {
                border-color: var(--orange);
            }

            .gallery-thumb img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                display: block;
            }

            .gallery-thumb .thumb-remove {
                position: absolute;
                top: 4px;
                right: 4px;
                width: 22px;
                height: 22px;
                border-radius: 50%;
                background: rgba(220,38,38,.85);
                border: none;
                color: #fff;
                font-size: .65rem;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                opacity: 0;
                transition: opacity .15s;
            }

            .gallery-thumb:hover .thumb-remove {
                opacity: 1;
            }

            .gallery-thumb .thumb-cover-badge {
                position: absolute;
                bottom: 4px;
                left: 4px;
                background: var(--orange);
                color: #fff;
                font-size: .55rem;
                font-weight: 700;
                padding: 2px 5px;
                border-radius: 4px;
                letter-spacing: .3px;
            }

            .gallery-thumb .thumb-set-cover {
                position: absolute;
                bottom: 4px;
                left: 4px;
                background: rgba(0,0,0,.5);
                color: #fff;
                font-size: .55rem;
                padding: 2px 5px;
                border-radius: 4px;
                cursor: pointer;
                opacity: 0;
                transition: opacity .15s;
                border: none;
            }

            .gallery-thumb:hover .thumb-set-cover {
                opacity: 1;
            }

        .gallery-add-btn {
            border: 2px dashed var(--border);
            border-radius: 8px;
            aspect-ratio: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            color: var(--text-light);
            font-size: .72rem;
            gap: 4px;
            transition: border-color .2s, color .2s;
        }

            .gallery-add-btn:hover {
                border-color: var(--orange);
                color: var(--orange);
            }

        /* DOCUMENT BADGE */
        .doc-saved-badge {
            margin-top: 5px;
            font-size: .68rem;
            min-height: 18px;
        }

            .doc-saved-badge .badge-uploaded {
                display: inline-flex;
                align-items: center;
                gap: 4px;
                background: #DCFCE7;
                color: #166534;
                border: 1px solid #86EFAC;
                border-radius: 5px;
                padding: 2px 7px;
                font-weight: 600;
                font-size: .65rem;
                max-width: 100%;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }

            .doc-saved-badge .badge-new {
                display: inline-flex;
                align-items: center;
                gap: 4px;
                background: #FFF7ED;
                color: #C2410C;
                border: 1px solid #FED7AA;
                border-radius: 5px;
                padding: 2px 7px;
                font-weight: 600;
                font-size: .65rem;
            }

        .doc-upload-item.has-doc .doc-icon i {
            color: var(--green) !important;
        }

        /* BLOCK CARDS */
        .block-card-head {
            background: linear-gradient(135deg,#F97316,#EA580C);
            padding: 12px 14px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .block-name-edit {
            background: rgba(255,255,255,.2);
            border: 1px solid rgba(255,255,255,.4);
            border-radius: 6px;
            color: #fff;
            font-size: .85rem;
            font-weight: 700;
            padding: 4px 10px;
            width: 145px;
            outline: none;
            font-family: inherit;
        }

            .block-name-edit::placeholder {
                color: rgba(255,255,255,.6);
            }

        .block-remove-btn {
            background: rgba(255,255,255,.15);
            border: none;
            color: #fff;
            border-radius: 6px;
            width: 26px;
            height: 26px;
            cursor: pointer;
            font-size: .7rem;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .block-card-body {
            padding: 14px;
        }
        /* ── 3-col grid inside block card so Floors + UPF + Total Units fit neatly ── */
        .bc-grid {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
            gap: 10px;
            margin-bottom: 12px;
        }

        .bc-field label {
            font-size: .68rem;
            font-weight: 700;
            color: var(--text-mid);
            text-transform: uppercase;
            letter-spacing: .4px;
            display: block;
            margin-bottom: 4px;
        }

        .bc-field input, .bc-field select {
            width: 100%;
            padding: 7px 10px;
            border: 1.5px solid var(--border);
            border-radius: 8px;
            font-size: .82rem;
            color: var(--text);
            outline: none;
            font-family: inherit;
            transition: border-color .15s;
        }

            .bc-field input:focus, .bc-field select:focus {
                border-color: var(--orange);
            }

            .bc-field input[readonly] {
                background: #F8FAFC;
                color: var(--orange);
                font-weight: 700;
                cursor: default;
                border-style: dashed;
            }
        /* Block Name spans full width */
        .bc-field-full {
            grid-column: 1 / -1;
        }

        .bhk-section {
            border-top: 1.5px solid var(--border);
            padding-top: 12px;
            margin-top: 2px;
        }

        .bhk-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .bhk-title {
            font-size: .72rem;
            font-weight: 700;
            color: var(--text);
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .add-type-btn {
            background: var(--orange);
            color: #fff;
            border: none;
            border-radius: 20px;
            padding: 5px 12px;
            font-size: .7rem;
            font-weight: 700;
            cursor: pointer;
            font-family: inherit;
            transition: background .15s;
        }

            .add-type-btn:hover {
                background: #EA580C;
            }

            .add-type-btn:disabled {
                background: #CBD5E1 !important;
                cursor: not-allowed;
            }

        .progress-bar-wrap {
            background: #F1F5F9;
            border-radius: 20px;
            height: 7px;
            margin-bottom: 8px;
            overflow: hidden;
        }

        .progress-bar-fill {
            height: 100%;
            border-radius: 20px;
            transition: width .3s, background .3s;
        }

        .assign-meta {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

            .assign-meta span {
                font-size: .68rem;
                font-weight: 600;
            }

        .bhk-row {
            display: flex;
            align-items: center;
            gap: 7px;
            background: #F8FAFC;
            border: 1.5px solid var(--border);
            border-radius: 8px;
            padding: 7px 10px;
            margin-bottom: 7px;
            flex-wrap: wrap;
            transition: border-color .2s, background .2s;
        }

            .bhk-row.over-limit {
                border-color: var(--red) !important;
                background: #FEF2F2;
            }

        .bhk-type-sel {
            border: 1.5px solid var(--border);
            border-radius: 6px;
            font-size: .72rem;
            padding: 3px 6px;
            outline: none;
            color: var(--text);
            background: #fff;
            font-family: inherit;
            min-width: 90px;
            appearance: auto;
        }

        .bhk-pct {
            font-size: .68rem;
            color: var(--text-mid);
            white-space: nowrap;
            min-width: 54px;
        }

        .bhk-count-input {
            width: 54px;
            padding: 4px 6px;
            border: 1.5px solid var(--border);
            border-radius: 6px;
            font-size: .78rem;
            text-align: center;
            outline: none;
            font-family: inherit;
            transition: border-color .15s, background .15s;
        }

            .bhk-count-input:focus {
                border-color: var(--orange);
            }

            .bhk-count-input.input-over {
                border-color: var(--red) !important;
                background: #FEF2F2;
            }

        .bhk-slash {
            font-size: .75rem;
            color: var(--text-light);
        }

        .bhk-max {
            font-size: .75rem;
            font-weight: 700;
            color: var(--text-mid);
        }

        .bhk-remove {
            background: #FEF2F2;
            border: none;
            color: var(--red);
            border-radius: 5px;
            width: 22px;
            height: 22px;
            cursor: pointer;
            font-size: .65rem;
            flex-shrink: 0;
            margin-left: auto;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .bhk-status-msg {
            border-radius: 7px;
            padding: 7px 10px;
            font-size: .68rem;
            display: flex;
            align-items: center;
            gap: 6px;
            margin-top: 6px;
        }

        .bhk-status-warn {
            background: #FFF7ED;
            border: 1px solid #FED7AA;
            color: #9A3412;
        }

        .bhk-status-success {
            background: #DCFCE7;
            border: 1px solid #86EFAC;
            color: #166534;
        }

        .bhk-status-error {
            background: #FEF2F2;
            border: 1px solid #FECACA;
            color: #991B1B;
        }

        .add-block-card {
            border: 2px dashed var(--border);
            border-radius: var(--radius-md,10px);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 8px;
            min-height: 120px;
            cursor: pointer;
            color: var(--text-light);
            font-size: .8rem;
            font-weight: 600;
            transition: border-color .2s, color .2s;
        }

            .add-block-card:hover {
                border-color: var(--orange);
                color: var(--orange);
            }

        .add-block-icon {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: var(--orange-pale,#FFF7ED);
            color: var(--orange);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            font-weight: 700;
        }

        /* ── Block field required highlight ── */
        .bc-field input.bc-required-error {
            border-color: var(--red) !important;
            background: #FEF2F2;
        }

        /* UNIT ROW LOCKED */
        .unit-row-locked-type {
            padding: 6px 10px;
            font-size: .78rem;
            font-weight: 600;
            color: var(--orange);
            background: #FFF7ED;
            border: 1.5px solid #FED7AA;
            border-radius: 8px;
            min-width: 90px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .unit-sync-info {
            display: flex;
            align-items: center;
            gap: 6px;
            padding: 8px 14px;
            background: #F0FDF4;
            border: 1px solid #86EFAC;
            border-radius: 8px;
            font-size: .72rem;
            color: #166534;
            margin-bottom: 10px;
        }

        /* ── Unit row required field error ── */
        .unit-row input.unit-req-error {
            border-color: var(--red) !important;
            background: #FEF2F2 !important;
            animation: shake 0.3s ease;
        }

        /* PUBLISH MODAL */
        .publish-modal-overlay {
            display: none;
            position: fixed;
            inset: 0;
            z-index: 99999;
            background: rgba(0,0,0,.55);
            backdrop-filter: blur(4px);
            align-items: center;
            justify-content: center;
        }

            .publish-modal-overlay.show {
                display: flex !important;
            }

        @keyframes popIn {
            0% {
                transform: scale(.8);
                opacity: 0
            }

            100% {
                transform: scale(1);
                opacity: 1
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <%-- HIDDEN FIELDS --%>
        <asp:HiddenField ID="hdnAmenityIDs" runat="server" />
        <asp:HiddenField ID="hdnBankIDs" runat="server" />
        <asp:HiddenField ID="hdnBlocksJSON" runat="server" />
        <asp:HiddenField ID="hdnUnitTypesJSON" runat="server" />
        <asp:HiddenField ID="hdnPublishMode" runat="server" Value="active" />
        <asp:HiddenField ID="hdnProjectCode" runat="server" />
        <asp:HiddenField ID="hdnLatitude" runat="server" />
        <asp:HiddenField ID="hdnLongitude" runat="server" />
        <asp:HiddenField ID="hdnGoBackToStep" runat="server" Value="0" EnableViewState="false" />
        <asp:HiddenField ID="hdnGalleryJSON" runat="server" />
        <asp:HiddenField ID="hdnNewGalleryBase64" runat="server" />
        <asp:HiddenField ID="hdnCoverImage" runat="server" />
        <asp:HiddenField ID="hdnLogoImage" runat="server" />
        <asp:HiddenField ID="hdnNewCoverBase64" runat="server" />
        <asp:HiddenField ID="hdnNewLogoBase64" runat="server" />
        <asp:HiddenField ID="hdnDocsJSON" runat="server" />
        <asp:HiddenField ID="hdnCurrentStep" runat="server" Value="1" />

        <%-- Pricing hidden fields - UI removed, values synced from unit rows via JS --%>
        <asp:TextBox ID="txtBSP" runat="server" Style="display: none" />
        <asp:TextBox ID="txtPLC" runat="server" Style="display: none" />
        <asp:TextBox ID="txtIFMS" runat="server" Style="display: none" />
        <asp:TextBox ID="txtClubMembership" runat="server" Style="display: none" />
        <asp:TextBox ID="txtPowerBackup" runat="server" Style="display: none" />
        <asp:TextBox ID="txtMaintDeposit" runat="server" Style="display: none" />

        <%-- ▼ txtTotalUnits, txtTotalFloors, txtUnitsPerFloor moved to hidden —
             Their values are now driven by Block cards via JS and synced on save --%>
        <asp:TextBox ID="txtTotalUnits" runat="server" Style="display: none" />
        <asp:TextBox ID="txtTotalFloors" runat="server" Style="display: none" />
        <asp:TextBox ID="txtUnitsPerFloor" runat="server" Style="display: none" />

        <%-- TOP HEADER --%>
        <div class="top-header">
            <div class="header-brand">
                <div class="logo-box"><%= Session["CompName"].ToString().Substring(0,1).ToUpper() %></div>
                <div>
                    <div class="brand-text"><%= Session["CompName"] %></div>
                    <div class="brand-sub">Management Portal</div>
                </div>
            </div>
            <div class="breadcrumb">
                <span class="bc-hide">Dashboard</span>
                <span class="sep bc-hide">&rsaquo;</span>
                <span class="bc-hide">Projects</span>
                <span class="sep bc-hide">&rsaquo;</span>
                <span class="current">Add New Project</span>
            </div>
            <div class="header-actions">
                <asp:Button ID="btnSaveDraftTop" runat="server" Text="Save Draft" CssClass="btn btn-ghost btn-sm" OnClick="btnSaveDraft_Click" />
                <button type="button" class="btn btn-primary btn-sm" onclick="goToStep(5)">Review</button>
                <asp:Button ID="BtnBackTDashboard" runat="server" Text="Back To Dashboard" CssClass="btn btn-primary btn-sm" OnClick="BtnBackTDashboard_Click" />
                <button type="button" class="mobile-menu-btn">&#9776;</button>
            </div>
        </div>

        <div class="page-wrap">

            <%-- STEP BAR --%>
            <div class="step-bar" id="stepBar">
                <div class="step-item active" id="stepItem1" onclick="goToStep(1)">
                    <div class="step-num" id="sn1">1</div>
                    <div>
                        <div class="step-label">Basic Info</div>
                        <div class="step-sub">Name, location</div>
                    </div>
                </div>
                <div class="step-item" id="stepItem2" onclick="goToStep(2)">
                    <div class="step-num" id="sn2">2</div>
                    <div>
                        <div class="step-label">Config</div>
                        <div class="step-sub">Blocks &amp; pricing</div>
                    </div>
                </div>
                <div class="step-item" id="stepItem3" onclick="goToStep(3)">
                    <div class="step-num" id="sn3">3</div>
                    <div>
                        <div class="step-label">Amenities</div>
                        <div class="step-sub">Features</div>
                    </div>
                </div>
                <div class="step-item" id="stepItem4" onclick="goToStep(4)">
                    <div class="step-num" id="sn4">4</div>
                    <div>
                        <div class="step-label">Media</div>
                        <div class="step-sub">Photos &amp; docs</div>
                    </div>
                </div>
                <div class="step-item" id="stepItem5" onclick="goToStep(5)">
                    <div class="step-num" id="sn5">5</div>
                    <div>
                        <div class="step-label">Review</div>
                        <div class="step-sub">Publish</div>
                    </div>
                </div>
            </div>

            <%-- STEP 1 — BASIC INFORMATION --%>
            <div class="step-panel active" id="panel1">
                <div class="val-summary" id="valSummary1">
                    <div class="val-summary-title"><i class="fa-solid fa-circle-xmark"></i>Please fill the following required fields:</div>
                    <ul id="valList1"></ul>
                </div>
                <div class="section-card">
                    <div class="section-head">
                        <div class="section-head-left">
                            <div class="section-icon si-orange"><i class="fa-solid fa-building-construction"></i></div>
                            <div>
                                <div class="section-title">Project Identity</div>
                                <div class="section-desc">Core project name, type and developer information</div>
                            </div>
                        </div>
                        <span class="section-badge">Step 1 of 5</span>
                    </div>
                    <div class="section-body">
                        <div class="form-grid">
                            <div class="form-group full">
                                <label>Project Name <span class="req">*</span></label>
                                <asp:TextBox ID="txtProjectName" runat="server" placeholder="e.g. Shiv Sarovar, Green Valley Heights" />
                            </div>
                            <div class="form-group">
                                <label>Project Code <span class="req">*</span> <span class="hint">(Auto-generated)</span></label>
                                <asp:TextBox ID="txtProjectCode" runat="server" placeholder="Auto-generated" ReadOnly="true" Style="background: #F4F6FA; color: var(--text-mid); cursor: not-allowed; font-weight: 600;" />
                            </div>
                            <div class="form-group">
                                <label>Developer / Builder Name <span class="req">*</span></label>
                                <asp:TextBox ID="txtDeveloperName" runat="server" />
                            </div>
                            <div class="form-group">
                                <label>Project Type <span class="req">*</span></label>
                                <asp:DropDownList ID="ddlProjectType" runat="server" />
                            </div>
                            <div class="form-group">
                                <label>Project Category <span class="req">*</span></label>
                                <asp:DropDownList ID="ddlCategory" runat="server" />
                            </div>
                            <div class="form-group">
                                <label>RERA Registration No.</label>
                                <asp:TextBox ID="txtRERA" runat="server" placeholder="RAJ/P/2024/XXXXX" />
                            </div>
                            <div class="form-group full">
                                <label>Project Short Description <span class="req">*</span></label>
                                <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" MaxLength="300"
                                    placeholder="Brief marketing description of the project"
                                    oninput="document.getElementById('descCount').textContent=this.value.length+'/300'" />
                                <div class="char-count" id="descCount">0/300</div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="section-card">
                    <div class="section-head">
                        <div class="section-head-left">
                            <div class="section-icon si-blue"><i class="fa-solid fa-location-dot"></i></div>
                            <div>
                                <div class="section-title">Location Details</div>
                                <div class="section-desc">Complete address, landmark and map coordinates</div>
                            </div>
                        </div>
                    </div>
                    <div class="section-body">
                        <div class="form-grid">
                            <div class="form-group full">
                                <label>Plot / Survey / Khasra No.</label>
                                <asp:TextBox ID="txtKhasra" runat="server" placeholder="e.g. Khasra No. 123/1, Plot No. 45" />
                            </div>
                            <div class="form-group full">
                                <label>Full Project Address <span class="req">*</span></label>
                                <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" placeholder="Complete postal address of the project site" Style="min-height: 66px" />
                            </div>
                            <div class="form-group">
                                <label>Landmark</label>
                                <asp:TextBox ID="txtLandmark" runat="server" placeholder="Near Durgapura Railway Station" />
                            </div>
                            <div class="form-group">
                                <label>City / Town <span class="req">*</span></label>
                                <asp:TextBox ID="txtCity" runat="server" placeholder="Jaipur" />
                            </div>
                            <div class="form-group">
                                <label>District <span class="req">*</span></label>
                                <asp:TextBox ID="txtDistrict" runat="server" placeholder="Jaipur District" />
                            </div>
                            <div class="form-group">
                                <label>State <span class="req">*</span></label>
                                <asp:DropDownList ID="ddlState" runat="server" />
                            </div>
                            <div class="form-group">
                                <label>Pin Code <span class="req">*</span></label>
                                <asp:TextBox ID="txtPinCode" runat="server" placeholder="302001" MaxLength="6" />
                            </div>
                            <div class="form-group">
                                <label>Zone / Sector</label>
                                <asp:TextBox ID="txtZone" runat="server" placeholder="Zone A, Sector 12" />
                            </div>
                        </div>
                        <div class="divider-label">Map Location</div>
                        <div class="form-grid">
                            <div class="form-group">
                                <label>Latitude <span class="hint">(Auto-filled from map)</span></label>
                                <asp:TextBox ID="txtLatitude" runat="server" placeholder="Pick on map" ReadOnly="true" Style="background: #F4F6FA; color: var(--text-mid); cursor: not-allowed;" />
                            </div>
                            <div class="form-group">
                                <label>Longitude <span class="hint">(Auto-filled from map)</span></label>
                                <asp:TextBox ID="txtLongitude" runat="server" placeholder="Pick on map" ReadOnly="true" Style="background: #F4F6FA; color: var(--text-mid); cursor: not-allowed;" />
                            </div>
                            <div class="form-group full">
                                <label>Google Maps Link</label>
                                <asp:TextBox ID="txtGoogleMaps" runat="server" placeholder="https://maps.google.com/..." />
                            </div>
                        </div>
                        <div class="map-preview" onclick="openMapPicker()">
                            <i class="fa-solid fa-map-location-dot" style="font-size: 2rem; margin-bottom: 8px"></i>
                            <span style="font-weight: 600">Click to pick location on map</span>
                            <span style="font-size: .7rem; opacity: .7">Drop pin on project site</span>
                        </div>
                    </div>
                </div>

                <div class="section-card">
                    <div class="section-head">
                        <div class="section-head-left">
                            <div class="section-icon si-yellow"><i class="fa-solid fa-calendar-days"></i></div>
                            <div>
                                <div class="section-title">Project Timeline</div>
                                <div class="section-desc">Launch, construction and possession dates</div>
                            </div>
                        </div>
                    </div>
                    <div class="section-body">
                        <div class="form-grid-3">
                            <div class="form-group">
                                <label>Launch Date</label><asp:TextBox ID="txtLaunchDate" runat="server" TextMode="Date" /></div>
                            <div class="form-group">
                                <label>Construction Start</label><asp:TextBox ID="txtConstructionStart" runat="server" TextMode="Date" /></div>
                            <div class="form-group">
                                <label>Expected Possession</label><asp:TextBox ID="txtPossessionDate" runat="server" TextMode="Date" /></div>
                            <div class="form-group">
                                <label>Booking Open Date</label><asp:TextBox ID="txtBookingOpenDate" runat="server" TextMode="Date" /></div>
                            <div class="form-group">
                                <label>Project Status <span class="req">*</span></label>
                                <asp:DropDownList ID="ddlStatus" runat="server" />
                            </div>
                            <div class="form-group">
                                <label>Approval Authority</label><asp:TextBox ID="txtApprovalAuthority" runat="server" placeholder="JDA / JDCA / UIT" /></div>
                        </div>
                        <div style="margin-top: 14px">
                            <div class="info-box"><i class="fa-solid fa-circle-info"></i>&nbsp;Once published, customers will see the possession date on all booking communications.</div>
                        </div>
                    </div>
                </div>

                <div class="section-card">
                    <div class="section-head">
                        <div class="section-head-left">
                            <div class="section-icon si-green"><i class="fa-solid fa-building"></i></div>
                            <div>
                                <div class="section-title">Branch &amp; Team Assignment</div>
                                <div class="section-desc">Assign managing branch and sales team</div>
                            </div>
                        </div>
                    </div>
                    <div class="section-body">
                        <div class="form-grid">
                            <div class="form-group">
                                <label>Assigned Branch</label><asp:DropDownList ID="ddlBranch" runat="server" /></div>
                            <div class="form-group">
                                <label>Project Manager</label><asp:TextBox ID="txtProjectManager" runat="server" placeholder="Assigned manager name" /></div>
                            <div class="form-group">
                                <label>Sales Head</label><asp:TextBox ID="txtSalesHead" runat="server" placeholder="Sales manager name" /></div>
                            <div class="form-group">
                                <label>Contact Number (Site)</label><asp:TextBox ID="txtSitePhone" runat="server" placeholder="+91 XXXXX XXXXX" /></div>
                            <div class="form-group">
                                <label>Site Office Address</label><asp:TextBox ID="txtSiteAddress" runat="server" placeholder="On-site sales office location" /></div>
                            <div class="form-group">
                                <label>Site Office Timings</label><asp:TextBox ID="txtSiteTimings" runat="server" placeholder="9:00 AM - 7:00 PM (Mon-Sat)" /></div>
                        </div>
                    </div>
                </div>

                <div class="step-save-row">
                    <asp:Button ID="btnSaveStep1" runat="server" Text="Save &amp; Continue" CssClass="btn btn-primary btn-lg" OnClick="btnSaveStep1_Click" />
                </div>
            </div>

            <%-- STEP 2 — CONFIGURATION --%>
            <div class="step-panel" id="panel2">
                <div class="val-summary" id="valSummary2">
                    <div class="val-summary-title"><i class="fa-solid fa-circle-xmark"></i>Please fill the following required fields:</div>
                    <ul id="valList2"></ul>
                </div>

                <div class="section-card">
                    <div class="section-head">
                        <div class="section-head-left">
                            <div class="section-icon si-orange"><i class="fa-solid fa-ruler-combined"></i></div>
                            <div>
                                <div class="section-title">Land &amp; Area Details</div>
                                <div class="section-desc">Total land, construction and open areas</div>
                            </div>
                        </div>
                    </div>
                    <div class="section-body">
                        <%-- ▼ CHANGED: Removed Total Floors, Units per Floor, Total Units from here.
                             Those are now inside each Block card (entered per-block by user).
                             No. of Towers / Blocks is now REQUIRED (*). --%>
                        <div class="form-grid-3">
                            <div class="form-group">
                                <label>Total Land Area <span class="req">*</span></label>
                                <div class="input-suffix">
                                    <asp:TextBox ID="txtLandArea" runat="server" TextMode="Number" placeholder="0" /><span class="suffix-tag">Sq.Yd</span></div>
                            </div>
                            <div class="form-group">
                                <label>Total Built-up Area</label>
                                <div class="input-suffix">
                                    <asp:TextBox ID="txtBuiltUp" runat="server" TextMode="Number" placeholder="0" /><span class="suffix-tag">Sq.Ft</span></div>
                            </div>
                            <div class="form-group">
                                <label>FAR / FSI Approved</label><asp:TextBox ID="txtFAR" runat="server" TextMode="Number" placeholder="1.5" /></div>
                            <div class="form-group">
                                <label>Open / Green Area</label>
                                <div class="input-suffix">
                                    <asp:TextBox ID="txtGreenArea" runat="server" TextMode="Number" placeholder="0" /><span class="suffix-tag">%</span></div>
                            </div>
                            <div class="form-group">
                                <label>Parking Type</label><asp:DropDownList ID="ddlParkingType" runat="server" /></div>
                            <div class="form-group">
                                <label>No. of Towers / Blocks <span class="req">*</span></label>
                                <asp:TextBox ID="txtNumBlocks" runat="server" TextMode="Number" placeholder="Enter no. of blocks" oninput="onNumBlocksChange(this.value)" />
                            </div>
                        </div>
                        <%-- Total Units summary — auto-calculated from blocks, shown read-only for info --%>
                        <div id="totalUnitsSummaryWrap" style="margin-top: 10px; padding: 10px 14px; background: #F0FDF4; border: 1px solid #86EFAC; border-radius: 8px; font-size: .78rem; color: #166534; display: none">
                            <i class="fa-solid fa-circle-check"></i>&nbsp;
                           
                            <strong>Total Units across all blocks: <span id="totalUnitsSummaryVal">0</span></strong>
                            &nbsp;<span style="opacity: .7">(calculated from block configuration below)</span>
                        </div>
                    </div>
                </div>

                <div class="section-card">
                    <div class="section-head">
                        <div class="section-head-left">
                            <div class="section-icon si-blue"><i class="fa-solid fa-layer-group"></i></div>
                            <div>
                                <div class="section-title">Block / Tower Configuration</div>
                                <div class="section-desc">Configure each block — enter floors, units per floor and BHK distribution</div>
                            </div>
                        </div>
                        <button type="button" class="btn btn-outline btn-sm" onclick="addBlock()">+ Add Block</button>
                    </div>
                    <div class="section-body">
                        <div class="blocks-grid" id="blocksGrid"></div>
                    </div>
                </div>

                <div class="section-card">
                    <div class="section-head">
                        <div class="section-head-left">
                            <div class="section-icon si-green"><i class="fa-solid fa-house"></i></div>
                            <div>
                                <div class="section-title">Unit Type Configuration</div>
                                <div class="section-desc">Define BHK types, sizes and pricing — all fields required</div>
                            </div>
                        </div>
                        <span style="font-size: .72rem; color: #166534; background: #F0FDF4; border: 1px solid #86EFAC; padding: 5px 12px; border-radius: 20px; display: flex; align-items: center; gap: 5px; font-weight: 600;">
                            <i class="fa-solid fa-link" style="color: #16A34A; font-size: .65rem"></i>Block se auto-sync
                        </span>
                    </div>
                    <div class="section-body">
                        <div class="unit-sync-info" id="unitSyncInfo">
                            <i class="fa-solid fa-circle-info"></i>
                            BHK types Block section se auto-sync hote hain. Super area, Carpet, BSP aur PLC <strong>required</strong> hain.
                       
                        </div>
                        <div class="unit-table-wrap">
                            <div class="unit-type-header">
                                <span>Type</span>
                                <span>Super (sq.ft) <span class="req">*</span></span>
                                <span>Carpet (sq.ft) <span class="req">*</span></span>
                                <span>Units</span>
                                <span>BSP (Rs/sqft) <span class="req">*</span></span>
                                <span>PLC (Rs) <span class="req">*</span></span>
                                <span>Total Price</span>
                                <span></span>
                            </div>
                            <div id="unitRowsContainer"></div>
                        </div>
                    </div>
                </div>

                <div class="section-card">
                    <div class="section-head">
                        <div class="section-head-left">
                            <div class="section-icon si-yellow"><i class="fa-solid fa-credit-card"></i></div>
                            <div>
                                <div class="section-title">Payment Plan</div>
                                <div class="section-desc">Define instalment structure and schedules</div>
                            </div>
                        </div>
                    </div>
                    <div class="section-body">
                        <div class="form-grid">
                            <div class="form-group">
                                <label>Payment Plan Type <span class="req">*</span></label>
                                <asp:DropDownList ID="ddlPaymentPlan" runat="server" />
                            </div>
                            <div class="form-group">
                                <label>Booking Amount (Rs) <span class="req">*</span></label>
                                <asp:TextBox ID="txtBookingAmount" runat="server" TextMode="Number" placeholder="0" />
                            </div>
                            <div class="form-group">
                                <label>On Agreement (%)</label>
                                <div class="input-suffix">
                                    <asp:TextBox ID="txtOnAgreement" runat="server" TextMode="Number" placeholder="10" /><span class="suffix-tag">%</span></div>
                            </div>
                            <div class="form-group">
                                <label>On Possession (%)</label>
                                <div class="input-suffix">
                                    <asp:TextBox ID="txtOnPossession" runat="server" TextMode="Number" placeholder="20" /><span class="suffix-tag">%</span></div>
                            </div>
                            <div class="form-group">
                                <label>No. of Installments</label><asp:TextBox ID="txtInstallments" runat="server" TextMode="Number" placeholder="12" /></div>
                            <div class="form-group">
                                <label>GST Rate (%)</label>
                                <div class="input-suffix">
                                    <asp:TextBox ID="txtGST" runat="server" TextMode="Number" placeholder="5" /><span class="suffix-tag">%</span></div>
                            </div>
                        </div>
                        <div style="margin-top: 14px">
                            <label style="font-size: .76rem; font-weight: 600; margin-bottom: 8px; display: block">Bank Loan Linkage</label>
                            <div class="check-group" id="bankGroup">
                                <asp:Repeater ID="rptBanks" runat="server">
                                    <ItemTemplate>
                                        <div class="check-pill" data-bankid='<%# Eval("BankID") %>' onclick="toggleBankPill(this)">
                                            <div class="pill-dot"></div>
                                            <%# Eval("BankName") %>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="section-card">
                    <div class="section-head">
                        <div class="section-head-left">
                            <div class="section-icon si-green"><i class="fa-solid fa-handshake"></i></div>
                            <div>
                                <div class="section-title">Agent Commission Structure</div>
                                <div class="section-desc">Set commission rates for sales associates</div>
                            </div>
                        </div>
                    </div>
                    <div class="section-body">
                        <div class="form-grid-3">
                            <div class="form-group">
                                <label>Level 1 Commission</label><div class="input-suffix">
                                    <asp:TextBox ID="txtCommL1" runat="server" TextMode="Number" placeholder="2.5" /><span class="suffix-tag">%</span></div>
                            </div>
                            <div class="form-group">
                                <label>Level 2 Commission</label><div class="input-suffix">
                                    <asp:TextBox ID="txtCommL2" runat="server" TextMode="Number" placeholder="1.5" /><span class="suffix-tag">%</span></div>
                            </div>
                            <div class="form-group">
                                <label>Level 3 Commission</label><div class="input-suffix">
                                    <asp:TextBox ID="txtCommL3" runat="server" TextMode="Number" placeholder="0.5" /><span class="suffix-tag">%</span></div>
                            </div>
                            <div class="form-group">
                                <label>Brokerage Commission</label><div class="input-suffix">
                                    <asp:TextBox ID="txtBrokerage" runat="server" TextMode="Number" placeholder="1.0" /><span class="suffix-tag">%</span></div>
                            </div>
                            <div class="form-group">
                                <label>Commission Payout Trigger</label><asp:DropDownList ID="ddlCommPayout" runat="server" /></div>
                            <div class="form-group">
                                <label>TDS on Commission</label><div class="input-suffix">
                                    <asp:TextBox ID="txtTDS" runat="server" TextMode="Number" placeholder="5" /><span class="suffix-tag">%</span></div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="step-save-row">
                    <asp:Button ID="btnSaveStep2" runat="server" Text="Save &amp; Continue" CssClass="btn btn-primary btn-lg" OnClick="btnSaveStep2_Click" />
                </div>
            </div>

            <%-- STEP 3 — AMENITIES --%>
            <div class="step-panel" id="panel3">
                <div class="val-summary" id="valSummary3">
                    <div class="val-summary-title"><i class="fa-solid fa-circle-xmark"></i>Please fill the following required fields:</div>
                    <ul id="valList3"></ul>
                </div>
                <div class="section-card">
                    <div class="section-head">
                        <div class="section-head-left">
                            <div class="section-icon si-green"><i class="fa-solid fa-star"></i></div>
                            <div>
                                <div class="section-title">Project Amenities &amp; Features</div>
                                <div class="section-desc">Select all available amenities and facilities</div>
                            </div>
                        </div>
                        <span id="amenityCount" style="font-size: .76rem; color: var(--orange); font-weight: 600; white-space: nowrap">0 selected</span>
                    </div>
                    <div class="section-body">
                        <div class="divider-label">Sports &amp; Recreation</div>
                        <div class="amenity-grid">
                            <div class="amenity-item" data-amenityid="1" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-person-swimming"></i></span><span class="a-label">Swimming Pool</span></div>
                            <div class="amenity-item" data-amenityid="2" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-dumbbell"></i></span><span class="a-label">Gymnasium</span></div>
                            <div class="amenity-item" data-amenityid="3" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-baseball-bat-ball"></i></span><span class="a-label">Tennis Court</span></div>
                            <div class="amenity-item" data-amenityid="4" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-shuttlecock"></i></span><span class="a-label">Badminton Court</span></div>
                            <div class="amenity-item" data-amenityid="5" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-golf-ball-tee"></i></span><span class="a-label">Mini Golf</span></div>
                            <div class="amenity-item" data-amenityid="6" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-bicycle"></i></span><span class="a-label">Cycling Track</span></div>
                            <div class="amenity-item" data-amenityid="7" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-person-running"></i></span><span class="a-label">Jogging Track</span></div>
                            <div class="amenity-item" data-amenityid="8" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-children"></i></span><span class="a-label">Kids Play Area</span></div>
                        </div>
                        <div class="divider-label">Comfort &amp; Wellness</div>
                        <div class="amenity-grid">
                            <div class="amenity-item" data-amenityid="9" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-seedling"></i></span><span class="a-label">Landscaped Garden</span></div>
                            <div class="amenity-item" data-amenityid="10" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-spa"></i></span><span class="a-label">Spa &amp; Sauna</span></div>
                            <div class="amenity-item" data-amenityid="11" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-peace"></i></span><span class="a-label">Yoga / Meditation</span></div>
                            <div class="amenity-item" data-amenityid="12" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-people-roof"></i></span><span class="a-label">Community Hall</span></div>
                            <div class="amenity-item" data-amenityid="13" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-book"></i></span><span class="a-label">Library</span></div>
                            <div class="amenity-item" data-amenityid="14" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-mug-hot"></i></span><span class="a-label">Cafe / Cafeteria</span></div>
                            <div class="amenity-item" data-amenityid="15" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-film"></i></span><span class="a-label">Mini Theatre</span></div>
                            <div class="amenity-item" data-amenityid="16" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-cart-shopping"></i></span><span class="a-label">Shopping Zone</span></div>
                        </div>
                        <div class="divider-label">Safety &amp; Security</div>
                        <div class="amenity-grid">
                            <div class="amenity-item" data-amenityid="17" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-video"></i></span><span class="a-label">CCTV Surveillance</span></div>
                            <div class="amenity-item" data-amenityid="18" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-shield-halved"></i></span><span class="a-label">24x7 Security</span></div>
                            <div class="amenity-item" data-amenityid="19" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-door-closed"></i></span><span class="a-label">Video Door Phone</span></div>
                            <div class="amenity-item" data-amenityid="20" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-fire-extinguisher"></i></span><span class="a-label">Fire Safety System</span></div>
                            <div class="amenity-item" data-amenityid="21" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-gate"></i></span><span class="a-label">Gated Community</span></div>
                            <div class="amenity-item" data-amenityid="22" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-truck-medical"></i></span><span class="a-label">Emergency Response</span></div>
                            <div class="amenity-item" data-amenityid="23" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-bell"></i></span><span class="a-label">Panic Button</span></div>
                            <div class="amenity-item" data-amenityid="24" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-square-parking"></i></span><span class="a-label">Secure Parking</span></div>
                        </div>
                        <div class="divider-label">Infrastructure &amp; Utilities</div>
                        <div class="amenity-grid">
                            <div class="amenity-item" data-amenityid="25" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-bolt"></i></span><span class="a-label">Power Backup</span></div>
                            <div class="amenity-item" data-amenityid="26" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-droplet"></i></span><span class="a-label">24x7 Water Supply</span></div>
                            <div class="amenity-item" data-amenityid="27" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-recycle"></i></span><span class="a-label">Sewage Treatment</span></div>
                            <div class="amenity-item" data-amenityid="28" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-solar-panel"></i></span><span class="a-label">Solar Energy</span></div>
                            <div class="amenity-item" data-amenityid="29" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-cloud-rain"></i></span><span class="a-label">Rain Water Harvest</span></div>
                            <div class="amenity-item" data-amenityid="30" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-elevator"></i></span><span class="a-label">High Speed Lifts</span></div>
                            <div class="amenity-item" data-amenityid="31" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-wifi"></i></span><span class="a-label">Broadband Ready</span></div>
                            <div class="amenity-item" data-amenityid="32" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-trash-can"></i></span><span class="a-label">Waste Management</span></div>
                        </div>
                        <div class="divider-label">Accessibility</div>
                        <div class="amenity-grid">
                            <div class="amenity-item" data-amenityid="33" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-wheelchair"></i></span><span class="a-label">Wheelchair Access</span></div>
                            <div class="amenity-item" data-amenityid="34" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-charging-station"></i></span><span class="a-label">EV Charging</span></div>
                            <div class="amenity-item" data-amenityid="35" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-bus"></i></span><span class="a-label">Shuttle Service</span></div>
                            <div class="amenity-item" data-amenityid="36" onclick="toggleAmenity(this)"><span class="a-icon"><i class="fa-solid fa-paw"></i></span><span class="a-label">Pet Friendly Zone</span></div>
                        </div>
                        <div class="divider-label">Additional Specifications</div>
                        <div class="form-grid">
                            <div class="form-group">
                                <label>Flooring</label><asp:DropDownList ID="ddlFlooring" runat="server" /></div>
                            <div class="form-group">
                                <label>Kitchen Type</label><asp:DropDownList ID="ddlKitchen" runat="server" /></div>
                            <div class="form-group">
                                <label>Bathroom Fixtures</label><asp:DropDownList ID="ddlBathroom" runat="server" /></div>
                            <div class="form-group">
                                <label>Window Type</label><asp:DropDownList ID="ddlWindowType" runat="server" /></div>
                            <div class="form-group full">
                                <label>Special Features / USP</label>
                                <asp:TextBox ID="txtSpecialFeatures" runat="server" TextMode="MultiLine" placeholder="Unique selling points, smart home features, vastu compliance" />
                            </div>
                        </div>
                    </div>
                </div>

                <div class="section-card">
                    <div class="section-head">
                        <div class="section-head-left">
                            <div class="section-icon si-orange"><i class="fa-solid fa-sliders"></i></div>
                            <div>
                                <div class="section-title">Project Feature Toggles</div>
                                <div class="section-desc">Enable or disable key project features</div>
                            </div>
                        </div>
                    </div>
                    <div class="section-body">
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px" class="toggle-grid">
                            <div class="toggle-row">
                                <div class="toggle-info">
                                    <div class="toggle-label">Online Booking</div>
                                    <div class="toggle-sub">Allow customers to book online</div>
                                </div>
                                <label class="toggle">
                                    <asp:CheckBox ID="chkOnlineBooking" runat="server" Checked="true" /><div class="toggle-track"></div>
                                </label>
                            </div>
                            <div class="toggle-row">
                                <div class="toggle-info">
                                    <div class="toggle-label">Show on Website</div>
                                    <div class="toggle-sub">Display on public website</div>
                                </div>
                                <label class="toggle">
                                    <asp:CheckBox ID="chkShowWebsite" runat="server" Checked="true" /><div class="toggle-track"></div>
                                </label>
                            </div>
                            <div class="toggle-row">
                                <div class="toggle-info">
                                    <div class="toggle-label">EMI Calculator</div>
                                    <div class="toggle-sub">Show EMI tool for this project</div>
                                </div>
                                <label class="toggle">
                                    <asp:CheckBox ID="chkEMICalc" runat="server" Checked="true" /><div class="toggle-track"></div>
                                </label>
                            </div>
                            <div class="toggle-row">
                                <div class="toggle-info">
                                    <div class="toggle-label">Agent Referral</div>
                                    <div class="toggle-sub">Allow agent commission</div>
                                </div>
                                <label class="toggle">
                                    <asp:CheckBox ID="chkAgentReferral" runat="server" Checked="true" /><div class="toggle-track"></div>
                                </label>
                            </div>
                            <div class="toggle-row">
                                <div class="toggle-info">
                                    <div class="toggle-label">Hold Unit (48 hrs)</div>
                                    <div class="toggle-sub">Hold without payment</div>
                                </div>
                                <label class="toggle">
                                    <asp:CheckBox ID="chkHoldUnit" runat="server" Checked="true" /><div class="toggle-track"></div>
                                </label>
                            </div>
                            <div class="toggle-row">
                                <div class="toggle-info">
                                    <div class="toggle-label">Vastu Compliant</div>
                                    <div class="toggle-sub">Mark project as vastu compliant</div>
                                </div>
                                <label class="toggle">
                                    <asp:CheckBox ID="chkVastu" runat="server" /><div class="toggle-track"></div>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="step-save-row">
                    <asp:Button ID="btnSaveStep3" runat="server" Text="Save &amp; Continue" CssClass="btn btn-primary btn-lg" OnClick="btnSaveStep3_Click" />
                </div>
            </div>

            <%-- STEP 4 — MEDIA --%>
            <div class="step-panel" id="panel4">
                <div class="section-card">
                    <div class="section-head">
                        <div class="section-head-left">
                            <div class="section-icon si-orange"><i class="fa-solid fa-images"></i></div>
                            <div>
                                <div class="section-title">Project Photos &amp; Gallery</div>
                                <div class="section-desc">Upload project images, renders and site photos</div>
                            </div>
                        </div>
                        <span class="section-badge" id="galleryCountBadge">0 / 20 images</span>
                    </div>
                    <div class="section-body">
                        <div class="photo-drop" id="galleryDropZone"
                            onclick="document.getElementById('realGalleryInput').click()"
                            ondragover="event.preventDefault();this.classList.add('drag-over')"
                            ondragleave="this.classList.remove('drag-over')"
                            ondrop="event.preventDefault();this.classList.remove('drag-over');handleGalleryDrop(event.dataTransfer.files)">
                            <i class="fa-solid fa-cloud-arrow-up" style="font-size: 2.2rem; margin-bottom: 8px; color: var(--text-light)"></i>
                            <div class="photo-drop-title">Click or drag images here</div>
                            <div class="photo-drop-sub">JPG, PNG, WEBP &middot; Any size (auto-compressed) &middot; Up to 20 images</div>
                        </div>
                        <input type="file" id="realGalleryInput" multiple accept="image/*" style="display: none" onchange="handleGalleryFiles(this.files)" />
                        <asp:FileUpload ID="fuGallery" runat="server" AllowMultiple="true" accept="image/*" Style="display: none" />
                        <div id="galleryPreviewGrid" style="display: grid; grid-template-columns: repeat(auto-fill,minmax(120px,1fr)); gap: 10px; margin-top: 14px;"></div>
                        <div class="form-grid" style="margin-top: 14px">
                            <div class="form-group">
                                <label>Cover / Hero Image</label>
                                <asp:FileUpload ID="fuCoverImage" runat="server" accept="image/*" onchange="previewSingleImage(this,'coverPreview')" />
                                <div id="coverPreview" style="margin-top: 6px"></div>
                            </div>
                            <div class="form-group">
                                <label>Project Logo / Badge</label>
                                <asp:FileUpload ID="fuProjectLogo" runat="server" accept="image/*" onchange="previewSingleImage(this,'logoPreview')" />
                                <div id="logoPreview" style="margin-top: 6px"></div>
                            </div>
                            <div class="form-group">
                                <label>3D Render / Walkthrough Video URL</label><asp:TextBox ID="txtVideoURL" runat="server" placeholder="https://youtube.com/..." /></div>
                            <div class="form-group">
                                <label>Virtual Tour Link</label><asp:TextBox ID="txtVirtualTour" runat="server" placeholder="https://..." /></div>
                        </div>
                    </div>
                </div>

                <div class="section-card">
                    <div class="section-head">
                        <div class="section-head-left">
                            <div class="section-icon si-blue"><i class="fa-solid fa-file-contract"></i></div>
                            <div>
                                <div class="section-title">Legal &amp; Approval Documents</div>
                                <div class="section-desc">Upload all required legal clearances</div>
                            </div>
                        </div>
                        <span class="section-badge">PDF/JPG &middot; 10MB</span>
                    </div>
                    <div class="section-body">
                        <div class="doc-upload-grid">
                            <div class="doc-upload-item" id="docItem_1"><span class="doc-icon"><i class="fa-solid fa-file-shield"></i></span>
                                <div class="doc-label">RERA Certificate</div>
                                <asp:FileUpload ID="fuRERA" runat="server" onchange="showDocSelected(this,'docItem_1')" /><div class="doc-saved-badge" id="docBadge_1"></div>
                            </div>
                            <div class="doc-upload-item" id="docItem_2"><span class="doc-icon"><i class="fa-solid fa-landmark"></i></span>
                                <div class="doc-label">Land Title Deed</div>
                                <asp:FileUpload ID="fuLandDeed" runat="server" onchange="showDocSelected(this,'docItem_2')" /><div class="doc-saved-badge" id="docBadge_2"></div>
                            </div>
                            <div class="doc-upload-item" id="docItem_3"><span class="doc-icon"><i class="fa-solid fa-map"></i></span>
                                <div class="doc-label">Approved Layout</div>
                                <asp:FileUpload ID="fuLayoutPlan" runat="server" onchange="showDocSelected(this,'docItem_3')" /><div class="doc-saved-badge" id="docBadge_3"></div>
                            </div>
                            <div class="doc-upload-item" id="docItem_4"><span class="doc-icon"><i class="fa-solid fa-helmet-safety"></i></span>
                                <div class="doc-label">Building Sanction</div>
                                <asp:FileUpload ID="fuBuildingSanc" runat="server" onchange="showDocSelected(this,'docItem_4')" /><div class="doc-saved-badge" id="docBadge_4"></div>
                            </div>
                            <div class="doc-upload-item" id="docItem_5"><span class="doc-icon"><i class="fa-solid fa-leaf"></i></span>
                                <div class="doc-label">Environmental NOC</div>
                                <asp:FileUpload ID="fuEnvNOC" runat="server" onchange="showDocSelected(this,'docItem_5')" /><div class="doc-saved-badge" id="docBadge_5"></div>
                            </div>
                            <div class="doc-upload-item" id="docItem_6"><span class="doc-icon"><i class="fa-solid fa-fire"></i></span>
                                <div class="doc-label">Fire Safety NOC</div>
                                <asp:FileUpload ID="fuFireNOC" runat="server" onchange="showDocSelected(this,'docItem_6')" /><div class="doc-saved-badge" id="docBadge_6"></div>
                            </div>
                            <div class="doc-upload-item" id="docItem_7"><span class="doc-icon"><i class="fa-solid fa-road"></i></span>
                                <div class="doc-label">Road / NH Clearance</div>
                                <asp:FileUpload ID="fuRoadClearance" runat="server" onchange="showDocSelected(this,'docItem_7')" /><div class="doc-saved-badge" id="docBadge_7"></div>
                            </div>
                            <div class="doc-upload-item" id="docItem_8"><span class="doc-icon"><i class="fa-solid fa-scroll"></i></span>
                                <div class="doc-label">Society Registration</div>
                                <asp:FileUpload ID="fuSocietyReg" runat="server" onchange="showDocSelected(this,'docItem_8')" /><div class="doc-saved-badge" id="docBadge_8"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="section-card">
                    <div class="section-head">
                        <div class="section-head-left">
                            <div class="section-icon si-green"><i class="fa-solid fa-bullhorn"></i></div>
                            <div>
                                <div class="section-title">Marketing Material</div>
                                <div class="section-desc">Brochures, floor plans and project circulars</div>
                            </div>
                        </div>
                    </div>
                    <div class="section-body">
                        <div class="doc-upload-grid">
                            <div class="doc-upload-item" id="docItem_9"><span class="doc-icon"><i class="fa-solid fa-newspaper"></i></span>
                                <div class="doc-label">Project Brochure</div>
                                <asp:FileUpload ID="fuBrochure" runat="server" accept=".pdf" onchange="showDocSelected(this,'docItem_9')" /><div class="doc-saved-badge" id="docBadge_9"></div>
                            </div>
                            <div class="doc-upload-item" id="docItem_10"><span class="doc-icon"><i class="fa-solid fa-drafting-compass"></i></span>
                                <div class="doc-label">Floor Plans</div>
                                <asp:FileUpload ID="fuFloorPlans" runat="server" onchange="showDocSelected(this,'docItem_10')" /><div class="doc-saved-badge" id="docBadge_10"></div>
                            </div>
                            <div class="doc-upload-item" id="docItem_11"><span class="doc-icon"><i class="fa-solid fa-map-location"></i></span>
                                <div class="doc-label">Site / Master Plan</div>
                                <asp:FileUpload ID="fuMasterPlan" runat="server" onchange="showDocSelected(this,'docItem_11')" /><div class="doc-saved-badge" id="docBadge_11"></div>
                            </div>
                            <div class="doc-upload-item" id="docItem_12"><span class="doc-icon"><i class="fa-solid fa-briefcase"></i></span>
                                <div class="doc-label">Project Circular</div>
                                <asp:FileUpload ID="fuCircular" runat="server" accept=".pdf" onchange="showDocSelected(this,'docItem_12')" /><div class="doc-saved-badge" id="docBadge_12"></div>
                            </div>
                            <div class="doc-upload-item" id="docItem_13"><span class="doc-icon"><i class="fa-solid fa-tags"></i></span>
                                <div class="doc-label">Price List</div>
                                <asp:FileUpload ID="fuPriceList" runat="server" onchange="showDocSelected(this,'docItem_13')" /><div class="doc-saved-badge" id="docBadge_13"></div>
                            </div>
                            <div class="doc-upload-item" id="docItem_14"><span class="doc-icon"><i class="fa-solid fa-list-check"></i></span>
                                <div class="doc-label">Specifications Sheet</div>
                                <asp:FileUpload ID="fuSpecSheet" runat="server" onchange="showDocSelected(this,'docItem_14')" /><div class="doc-saved-badge" id="docBadge_14"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="step-save-row">
                    <asp:Button ID="btnSaveStep4" runat="server" Text="Save &amp; Continue" CssClass="btn btn-primary btn-lg" OnClick="btnSaveStep4_Click" />
                </div>
            </div>

            <%-- STEP 5 — REVIEW & PUBLISH --%>
            <div class="step-panel" id="panel5">
                <div class="section-card">
                    <div class="section-head">
                        <div class="section-head-left">
                            <div class="section-icon si-orange"><i class="fa-solid fa-building-construction"></i></div>
                            <div>
                                <div class="section-title">Basic Information</div>
                                <div class="section-desc">Project identity, location &amp; timeline</div>
                            </div>
                        </div>
                        <button type="button" class="btn btn-outline btn-sm" onclick="goToStep(1)"><i class="fa-solid fa-pen"></i>Edit</button>
                    </div>
                    <div class="section-body">
                        <div class="review-grid">
                            <div class="review-item">
                                <label>Project Name</label><span id="rv-name" class="highlight">-</span></div>
                            <div class="review-item">
                                <label>Project Code</label><span id="rv-code">-</span></div>
                            <div class="review-item">
                                <label>Developer</label><span id="rv-developer">-</span></div>
                            <div class="review-item">
                                <label>Project Type</label><span id="rv-type">-</span></div>
                            <div class="review-item">
                                <label>Category</label><span id="rv-category">-</span></div>
                            <div class="review-item">
                                <label>RERA No.</label><span id="rv-rera">-</span></div>
                            <div class="review-item">
                                <label>Status</label><span id="rv-status">-</span></div>
                            <div class="review-item">
                                <label>City</label><span id="rv-city">-</span></div>
                            <div class="review-item">
                                <label>State</label><span id="rv-state">-</span></div>
                            <div class="review-item">
                                <label>Pin Code</label><span id="rv-pincode">-</span></div>
                            <div class="review-item">
                                <label>Launch Date</label><span id="rv-launch">-</span></div>
                            <div class="review-item">
                                <label>Possession Date</label><span id="rv-possession">-</span></div>
                            <div class="review-item">
                                <label>Branch</label><span id="rv-branch">-</span></div>
                            <div class="review-item">
                                <label>Project Manager</label><span id="rv-manager">-</span></div>
                            <div class="review-item full">
                                <label>Address</label><span id="rv-address">-</span></div>
                            <div class="review-item full">
                                <label>Description</label><span id="rv-desc" style="font-size: .75rem; color: var(--text-mid)">-</span></div>
                        </div>
                    </div>
                </div>
                <div class="section-card">
                    <div class="section-head">
                        <div class="section-head-left">
                            <div class="section-icon si-blue"><i class="fa-solid fa-ruler-combined"></i></div>
                            <div>
                                <div class="section-title">Configuration &amp; Pricing</div>
                                <div class="section-desc">Land, blocks, units &amp; payment</div>
                            </div>
                        </div>
                        <button type="button" class="btn btn-outline btn-sm" onclick="goToStep(2)"><i class="fa-solid fa-pen"></i>Edit</button>
                    </div>
                    <div class="section-body">
                        <div class="review-grid">
                            <div class="review-item">
                                <label>Total Land Area</label><span id="rv-land">-</span></div>
                            <div class="review-item">
                                <label>Total Units (all blocks)</label><span id="rv-units" class="highlight">-</span></div>
                            <div class="review-item">
                                <label>No. of Blocks</label><span id="rv-blocks">-</span></div>
                            <div class="review-item">
                                <label>Parking Type</label><span id="rv-parking">-</span></div>
                            <div class="review-item">
                                <label>BSP (per type)</label><span id="rv-bsp">-</span></div>
                            <div class="review-item">
                                <label>PLC (per type)</label><span id="rv-plc">-</span></div>
                            <div class="review-item">
                                <label>Booking Amount</label><span id="rv-booking">-</span></div>
                            <div class="review-item">
                                <label>Payment Plan</label><span id="rv-payplan">-</span></div>
                            <div class="review-item">
                                <label>GST Rate</label><span id="rv-gst">-</span></div>
                            <div class="review-item">
                                <label>Commission L1</label><span id="rv-comm1">-</span></div>
                        </div>
                    </div>
                </div>
                <div class="section-card">
                    <div class="section-head">
                        <div class="section-head-left">
                            <div class="section-icon si-green"><i class="fa-solid fa-star"></i></div>
                            <div>
                                <div class="section-title">Amenities &amp; Features</div>
                                <div class="section-desc">Selected amenities and specs</div>
                            </div>
                        </div>
                        <button type="button" class="btn btn-outline btn-sm" onclick="goToStep(3)"><i class="fa-solid fa-pen"></i>Edit</button>
                    </div>
                    <div class="section-body">
                        <div id="rv-amenities-list" style="display: flex; flex-wrap: wrap; gap: 6px; margin-bottom: 14px; min-height: 24px"></div>
                        <div class="review-grid">
                            <div class="review-item">
                                <label>Flooring</label><span id="rv-flooring">-</span></div>
                            <div class="review-item">
                                <label>Kitchen</label><span id="rv-kitchen">-</span></div>
                            <div class="review-item">
                                <label>Bathroom</label><span id="rv-bathroom">-</span></div>
                            <div class="review-item">
                                <label>Windows</label><span id="rv-windows">-</span></div>
                        </div>
                    </div>
                </div>
                <div class="section-card">
                    <div class="section-head">
                        <div class="section-head-left">
                            <div class="section-icon si-yellow"><i class="fa-solid fa-images"></i></div>
                            <div>
                                <div class="section-title">Media &amp; Documents</div>
                                <div class="section-desc">Gallery and uploaded files</div>
                            </div>
                        </div>
                        <button type="button" class="btn btn-outline btn-sm" onclick="goToStep(4)"><i class="fa-solid fa-pen"></i>Edit</button>
                    </div>
                    <div class="section-body">
                        <div id="rv-gallery-mini" style="display: flex; flex-wrap: wrap; gap: 8px; margin-bottom: 12px; min-height: 24px"></div>
                        <div class="review-grid">
                            <div class="review-item">
                                <label>Video URL</label><span id="rv-video">-</span></div>
                            <div class="review-item">
                                <label>Virtual Tour</label><span id="rv-tour">-</span></div>
                            <div class="review-item">
                                <label>Documents</label><span id="rv-docs">-</span></div>
                        </div>
                    </div>
                </div>
                <div class="section-card">
                    <div class="section-head">
                        <div class="section-head-left">
                            <div class="section-icon si-orange"><i class="fa-solid fa-rocket"></i></div>
                            <div>
                                <div class="section-title">Publish Settings</div>
                                <div class="section-desc">Choose how to publish this project</div>
                            </div>
                        </div>
                        <div id="reviewStatusPill"><span class="status-pill pill-draft">Draft</span></div>
                    </div>
                    <div class="section-body">
                        <div class="warning-box">
                            <i class="fa-solid fa-triangle-exclamation"></i>&nbsp;Once published, the project becomes visible to all agents and customers. Ensure all details are accurate before publishing.
                       
                        </div>
                        <asp:Button ID="btnPublish" runat="server" Text="Publish Project" CssClass="btn btn-primary btn-lg" OnClick="btnPublish_Click" Style="display: none" />
                    </div>
                </div>
            </div>

            <%-- FOOTER ACTIONS --%>
            <div class="footer-actions">
                <div class="footer-left">
                    <asp:Button ID="prevBtn" runat="server" Text="Back" CssClass="btn btn-ghost btn-sm" OnClick="btnGoBack_Click" OnClientClick="return prepareBackNav();" Style="display: none" />
                    <asp:Button ID="btnSaveDraft" runat="server" Text="Save Draft" CssClass="btn btn-ghost btn-sm" OnClick="btnSaveDraft_Click" Visible="false" />
                </div>
                <div class="footer-center">
                    <div class="progress-label" id="stepLabel">Step 1 of 5 - Basic Information</div>
                    <div class="progress-mini">
                        <div class="progress-mini-fill" id="progressFill" style="width: 20%"></div>
                    </div>
                </div>
                <div class="footer-right">
                    <button type="button" class="btn btn-primary btn-lg" id="nextBtn" onclick="nextStep()">Continue</button>
                </div>
            </div>
        </div>

        <div class="toast" id="toast">
            <i id="toastIcon" class="fa-solid fa-check"></i>
            <span id="toastMsg">Saved successfully</span>
        </div>

        <script type="text/javascript">
            var currentStep = 1, totalSteps = 5, lastSavedStep = 0;
            var stepsCompleted = [false, false, false, false, false];
            var stepLabels = ['Step 1 of 5 - Basic Information', 'Step 2 of 5 - Configuration', 'Step 3 of 5 - Amenities & Features', 'Step 4 of 5 - Media & Documents', 'Step 5 of 5 - Review & Publish'];
            var nextBtnLabels = ['Continue', 'Continue', 'Continue', 'Review & Publish', 'Publish Project'];

            function v(id) { var el = document.getElementById(id); return el ? (el.value || '').trim() : ''; }
            function t(id) { var el = document.getElementById(id); if (!el || !el.options || el.selectedIndex < 0) return ''; var txt = el.options[el.selectedIndex].text || ''; return txt.indexOf('--') === 0 ? '' : txt.trim(); }
            function set(id, val) { var el = document.getElementById(id); if (!el) return; el.textContent = (val && val.toString().trim() && val !== '--') ? val : '-'; }
            function escHtml(s) { return (s || '').replace(/&/g, '&amp;').replace(/"/g, '&quot;').replace(/'/g, '&#39;').replace(/</g, '&lt;').replace(/>/g, '&gt;'); }

            // ═══════════════════════════════════════════
            // FORMAT PRICE — dynamic L / Cr
            // ═══════════════════════════════════════════
            function formatPrice(amount) {
                if (!amount || amount <= 0) return '';
                if (amount >= 10000000)
                    return 'Rs ' + (amount / 10000000).toFixed(2) + ' Cr';
                else if (amount >= 100000)
                    return 'Rs ' + (amount / 100000).toFixed(2) + ' L';
                else
                    return 'Rs ' + amount.toLocaleString('en-IN');
            }

            // ═══════════════════════════════════════════
            // SYNC BSP/PLC HIDDEN FIELDS — .cs ke liye
            // ═══════════════════════════════════════════
            function syncBSPHidden() {
                var rows = document.querySelectorAll('.unit-row');
                var firstBSP = 0, firstPLC = 0;
                if (rows.length > 0) {
                    var inps = rows[0].querySelectorAll('input[type="number"]');
                    firstBSP = parseFloat(inps[3] ? inps[3].value : 0) || 0;
                    firstPLC = parseFloat(inps[4] ? inps[4].value : 0) || 0;
                }
                var hdnBSP = document.getElementById('<%= txtBSP.ClientID %>');
                var hdnPLC = document.getElementById('<%= txtPLC.ClientID %>');
                if (hdnBSP) hdnBSP.value = firstBSP;
                if (hdnPLC) hdnPLC.value = firstPLC;
            }

            // ═══════════════════════════════════════════
            // SYNC TOTAL UNITS from blocks → hidden txtTotalUnits
            // Also update summary banner in Land & Area section
            // ═══════════════════════════════════════════
           <%-- function syncTotalUnitsHidden() {
                var total = 0;
                for (var bi = 0; bi < blocksData.length; bi++) {
                    total += getTotalUnits(blocksData[bi]);
                }
                var hdnTU = document.getElementById('<%= txtTotalUnits.ClientID %>');
                if (hdnTU) hdnTU.value = total;
                // Update summary banner
                var wrap = document.getElementById('totalUnitsSummaryWrap');
                var val = document.getElementById('totalUnitsSummaryVal');
                if (wrap && val) {
                    val.textContent = total;
                    wrap.style.display = total > 0 ? 'block' : 'none';
                }
            }--%>

            function syncTotalUnitsHidden() {
                var total = 0;
                var maxFloors = 0;
                var maxUPF = 0;
                for (var bi = 0; bi < blocksData.length; bi++) {
                    total += getTotalUnits(blocksData[bi]);
                    var f = parseInt(blocksData[bi].floors) || 0;
                    var u = parseInt(blocksData[bi].upf) || 0;
                    if (f > maxFloors) maxFloors = f;
                    if (u > maxUPF) maxUPF = u;
                }
                var hdnTU = document.getElementById('<%= txtTotalUnits.ClientID %>');
                if (hdnTU) hdnTU.value = total;

                // ← YE DO LINES MISSING THI
                var hdnTF = document.getElementById('<%= txtTotalFloors.ClientID %>');
                if (hdnTF) hdnTF.value = maxFloors;
                var hdnUPF = document.getElementById('<%= txtUnitsPerFloor.ClientID %>');
                if (hdnUPF) hdnUPF.value = maxUPF;

                var wrap = document.getElementById('totalUnitsSummaryWrap');
                var val = document.getElementById('totalUnitsSummaryVal');
                if (wrap && val) {
                    val.textContent = total;
                    wrap.style.display = total > 0 ? 'block' : 'none';
                }
            }
            function syncReadOnlyToHidden() {
                var codeBox = document.getElementById('<%= txtProjectCode.ClientID %>'), hdnCode = document.getElementById('<%= hdnProjectCode.ClientID %>');
                if (codeBox && hdnCode && codeBox.value.trim()) hdnCode.value = codeBox.value.trim();
                var latBox = document.getElementById('<%= txtLatitude.ClientID %>'), hdnLat = document.getElementById('<%= hdnLatitude.ClientID %>');
                if (latBox && hdnLat && latBox.value.trim()) hdnLat.value = latBox.value.trim();
                var lngBox = document.getElementById('<%= txtLongitude.ClientID %>'), hdnLng = document.getElementById('<%= hdnLongitude.ClientID %>');
                if (lngBox && hdnLng && lngBox.value.trim()) hdnLng.value = lngBox.value.trim();
            }

            // TOAST
            function showToast(msg, type) {
                var toast = document.getElementById('toast'), icon = document.getElementById('toastIcon');
                if (!toast || !icon) return;
                document.getElementById('toastMsg').textContent = msg;
                icon.className = 'fa-solid fa-check'; toast.style.background = 'var(--dark)';
                if (type === 'success') { icon.className = 'fa-solid fa-circle-check'; toast.style.background = 'var(--green)'; }
                else if (type === 'info') { icon.className = 'fa-solid fa-floppy-disk'; toast.style.background = '#1E40AF'; }
                else if (type === 'error') { icon.className = 'fa-solid fa-circle-xmark'; toast.style.background = 'var(--red)'; }
                toast.classList.add('show');
                setTimeout(function () { toast.classList.remove('show'); }, 3500);
            }

            // ═══════════════════════════════════════════
            // VALIDATION
            // ═══════════════════════════════════════════
            function validateStep(step) {
                clearAllErrors(step); var errors = [];
                if (step === 1) {
                    chkReq('<%= txtProjectName.ClientID %>', 'Project Name', errors);
                    chkReq('<%= txtProjectCode.ClientID %>', 'Project Code', errors);
                    chkReq('<%= txtDeveloperName.ClientID %>', 'Developer Name', errors);
                    chkDDL('<%= ddlProjectType.ClientID %>', 'Project Type', errors);
                    chkDDL('<%= ddlCategory.ClientID %>', 'Project Category', errors);
                    chkReq('<%= txtDescription.ClientID %>', 'Project Short Description', errors);
                    chkReq('<%= txtAddress.ClientID %>', 'Full Project Address', errors);
                    chkReq('<%= txtCity.ClientID %>', 'City / Town', errors);
                    chkReq('<%= txtDistrict.ClientID %>', 'District', errors);
                    chkDDL('<%= ddlState.ClientID %>', 'State', errors);
                    chkReq('<%= txtPinCode.ClientID %>', 'Pin Code', errors);
                    chkDDL('<%= ddlStatus.ClientID %>', 'Project Status', errors);
                }
                if (step === 2) {
                    // ▼ No. of Blocks required
                    chkReq('<%= txtLandArea.ClientID %>', 'Total Land Area', errors);
                    var nbEl = document.getElementById('<%= txtNumBlocks.ClientID %>');
                    var nbVal = nbEl ? (parseInt(nbEl.value) || 0) : 0;
                    if (nbVal <= 0) {
                        errors.push('No. of Towers / Blocks is required');
                        if (nbEl) {
                            var grp = nbEl.parentElement;
                            while (grp && !grp.classList.contains('form-group')) grp = grp.parentElement;
                            if (grp) { grp.classList.add('field-error'); if (!grp.querySelector('.error-msg')) { var msg = document.createElement('span'); msg.className = 'error-msg'; msg.innerHTML = '<i class="fa-solid fa-circle-exclamation"></i> This field is required'; grp.appendChild(msg); } }
                        }
                    }
                    chkReq('<%= txtBookingAmount.ClientID %>', 'Booking Amount', errors);
                    chkDDL('<%= ddlPaymentPlan.ClientID %>', 'Payment Plan Type', errors);

                    // ▼ Block-level validation
                    for (var bi = 0; bi < blocksData.length; bi++) {
                        var b = blocksData[bi], total = getTotalUnits(b), assigned = getAssigned(b);
                        // Floors & UPF required in each block
                        if (!b.floors || b.floors <= 0) errors.push('Block "' + b.name + '": No. of Floors is required');
                        if (!b.upf || b.upf <= 0) errors.push('Block "' + b.name + '": Units per Floor is required');
                        if (total > 0) {
                            if (assigned === 0) errors.push('Block "' + b.name + '": please add at least 1 BHK type');
                            else if (assigned !== total) errors.push('Block "' + b.name + '": ' + assigned + '/' + total + ' units assigned — please assign all');
                            for (var ti = 0; ti < b.bhkTypes.length; ti++)
                                if ((parseInt(b.bhkTypes[ti].count) || 0) <= 0)
                                    errors.push('Block "' + b.name + '" — BHK row ' + (ti + 1) + ' count cannot be 0');
                        }
                    }

                    // ▼ Unit row fields required: Super, Carpet, BSP, PLC
                    var unitRows = document.querySelectorAll('.unit-row');
                    if (unitRows.length === 0) {
                        errors.push('Unit Type Configuration: Please add BHK types in blocks first');
                    } else {
                        for (var ui = 0; ui < unitRows.length; ui++) {
                            var inps = unitRows[ui].querySelectorAll('input[type="number"]');
                            var typeEl = unitRows[ui].querySelector('.unit-row-locked-type');
                            var rowLabel = typeEl ? typeEl.textContent.trim().replace(/\s+/g, ' ') : ('Unit Row ' + (ui + 1));
                            // inputs[0]=Super, inputs[1]=Carpet, inputs[3]=BSP, inputs[4]=PLC
                            var superVal = inps[0] ? (parseFloat(inps[0].value) || 0) : 0;
                            var carpetVal = inps[1] ? (parseFloat(inps[1].value) || 0) : 0;
                            var bspVal = inps[3] ? (parseFloat(inps[3].value) || 0) : 0;
                            var plcVal = inps[4] ? (parseFloat(inps[4].value) || 0) : 0; // PLC can be 0 — keep optional or mark req per business need

                            if (superVal <= 0) { errors.push(rowLabel + ': Super Area (sq.ft) is required'); if (inps[0]) inps[0].classList.add('unit-req-error'); }
                            else if (inps[0]) inps[0].classList.remove('unit-req-error');

                            if (carpetVal <= 0) { errors.push(rowLabel + ': Carpet Area (sq.ft) is required'); if (inps[1]) inps[1].classList.add('unit-req-error'); }
                            else if (inps[1]) inps[1].classList.remove('unit-req-error');

                            if (bspVal <= 0) { errors.push(rowLabel + ': BSP (Rs/sqft) is required'); if (inps[3]) inps[3].classList.add('unit-req-error'); }
                            else if (inps[3]) inps[3].classList.remove('unit-req-error');
                        }
                    }
                }
                if (step === 3) {
                    var hdnA = document.getElementById('<%= hdnAmenityIDs.ClientID %>');
                    if (!hdnA || !hdnA.value || hdnA.value.trim() === '') {
                        errors.push('Please select at least 1 Amenity');
                        var grids = document.querySelectorAll('#panel3 .amenity-grid');
                        for (var g = 0; g < grids.length; g++) grids[g].style.outline = '2px solid var(--red)';
                    }
                }
                if (errors.length > 0) { showValSummary(step, errors); return false; }
                hideValSummary(step); return true;
            }
            function chkReq(cid, label, errors) { var el = document.getElementById(cid); if (!el) return; if (!el.value || el.value.trim() === '') { errors.push(label + ' is required'); markFieldError(el); } else clearFieldError(el); }
            function chkDDL(cid, label, errors) { var el = document.getElementById(cid); if (!el) return; if (!el.value || el.value === '0' || el.value === '') { errors.push(label + ' is required'); markFieldError(el); } else clearFieldError(el); }
            function markFieldError(el) { var grp = el.parentElement; while (grp && !grp.classList.contains('form-group')) grp = grp.parentElement; if (!grp) return; grp.classList.add('field-error'); if (!grp.querySelector('.error-msg')) { var msg = document.createElement('span'); msg.className = 'error-msg'; msg.innerHTML = '<i class="fa-solid fa-circle-exclamation"></i> This field is required'; grp.appendChild(msg); } }
            function clearFieldError(el) { var grp = el.parentElement; while (grp && !grp.classList.contains('form-group')) grp = grp.parentElement; if (!grp) return; grp.classList.remove('field-error'); var msg = grp.querySelector('.error-msg'); if (msg) msg.remove(); }
            function clearAllErrors(step) {
                var panel = document.getElementById('panel' + step); if (!panel) return; var errs = panel.querySelectorAll('.field-error'); for (var i = 0; i < errs.length; i++) { errs[i].classList.remove('field-error'); var m = errs[i].querySelector('.error-msg'); if (m) m.remove(); } var grids = panel.querySelectorAll('.amenity-grid'); for (var i = 0; i < grids.length; i++) grids[i].style.outline = ''; // also clear unit req errors
                var ureqs = panel.querySelectorAll('.unit-req-error'); for (var i = 0; i < ureqs.length; i++) ureqs[i].classList.remove('unit-req-error'); hideValSummary(step);
            }
            function showValSummary(step, errors) { var box = document.getElementById('valSummary' + step), list = document.getElementById('valList' + step); if (!box || !list) return; list.innerHTML = ''; for (var i = 0; i < errors.length; i++) { var li = document.createElement('li'); li.textContent = errors[i]; list.appendChild(li); } box.classList.add('show'); }
            function hideValSummary(step) { var box = document.getElementById('valSummary' + step); if (box) box.classList.remove('show'); }
            document.addEventListener('input', function (e) { if (e.target.value && e.target.value.trim()) { clearFieldError(e.target); e.target.classList.remove('unit-req-error'); } });
            document.addEventListener('change', function (e) { var el = e.target; if (el.tagName === 'SELECT' && el.value && el.value !== '0') clearFieldError(el); });

            // ═══════════════════════════════════════════
            // BLOCKS
            // ═══════════════════════════════════════════
            var blockCount = 0, blocksData = [];
            var unitTypeOptions = [{ id: 1, label: '1 BHK' }, { id: 2, label: '2 BHK' }, { id: 3, label: '3 BHK' }, { id: 4, label: '4 BHK' }, { id: 5, label: 'Penthouse' }, { id: 6, label: 'Studio' }];

            function getTotalUnits(b) { return (parseInt(b.floors) || 0) * (parseInt(b.upf) || 0); }
            function getAssigned(b) { return b.bhkTypes.reduce(function (s, t) { return s + (parseInt(t.count) || 0); }, 0); }
            function getRemaining(b) { return getTotalUnits(b) - getAssigned(b); }

            function renderBlocks() {
                var grid = document.getElementById('blocksGrid'); if (!grid) return;
                grid.innerHTML = '';
                for (var i = 0; i < blocksData.length; i++) grid.appendChild(buildBlockCard(blocksData[i], i));
                var addCard = document.createElement('div'); addCard.className = 'add-block-card';
                addCard.innerHTML = '<span class="add-block-icon">+</span><span>Add Block</span>'; addCard.onclick = addBlock;
                grid.appendChild(addCard);
                syncBlocksHidden();
                syncUnitTypesFromBlocks();
                syncTotalUnitsHidden();
            }

            function buildBlockCard(b, bi) {
                var total = getTotalUnits(b), assigned = getAssigned(b), remaining = getRemaining(b);
                var isOver = assigned > total, isExact = (assigned === total && total > 0);
                var pct = total > 0 ? Math.min(100, Math.round(assigned / total * 100)) : 0;
                var barColor = isOver ? 'var(--red)' : isExact ? 'var(--green)' : 'var(--orange)';
                var card = document.createElement('div'); card.className = 'block-card'; card.id = 'block' + bi;
                var bhkRowsHTML = b.bhkTypes.map(function (btype, ti) {
                    var typePct = total > 0 ? Math.round((parseInt(btype.count) || 0) / total * 100) : 0;
                    var opts = unitTypeOptions.map(function (u) { return '<option value="' + u.id + '"' + (btype.typeID === u.id ? ' selected' : '') + '>' + u.label + '</option>'; }).join('');
                    return '<div class="bhk-row">' +
                        '<select class="bhk-type-sel" onchange="onBhkTypeChange(' + bi + ',' + ti + ',this.value)">' + opts + '</select>' +
                        '<span class="bhk-pct">' + typePct + '% of block</span>' +
                        '<input class="bhk-count-input" type="number" min="1" max="' + total + '" value="' + (btype.count || '') + '" placeholder="Req*" onchange="onBhkCountChange(' + bi + ',' + ti + ',this)">' +
                        '<span class="bhk-slash">/</span><span class="bhk-max">' + total + '</span>' +
                        '<button type="button" class="bhk-remove" onclick="removeBhkRow(' + bi + ',' + ti + ')">&#10005;</button>' +
                        '</div>';
                }).join('');
                var statusHTML = '';
                if (b.bhkTypes.length === 0) statusHTML = '<div class="bhk-status-msg bhk-status-warn"><i class="fa-solid fa-circle-info"></i>&nbsp;' + (total > 0 ? total + ' units available' : 'Enter floors &amp; units/floor first') + '</div>';
                else if (isOver) statusHTML = '<div class="bhk-status-msg bhk-status-error"><i class="fa-solid fa-triangle-exclamation"></i>&nbsp;Over limit! ' + (assigned - total) + ' extra</div>';
                else if (isExact) statusHTML = '<div class="bhk-status-msg bhk-status-success"><i class="fa-solid fa-circle-check"></i>&nbsp;All ' + total + ' units assigned!</div>';
                else statusHTML = '<div class="bhk-status-msg bhk-status-warn"><i class="fa-solid fa-circle-info"></i>&nbsp;' + remaining + ' units remaining</div>';
                var addTypeBtnDisabled = (assigned >= total && total > 0) ? ' disabled' : '';
                card.innerHTML =
                    '<div class="block-card-head">' +
                    '<input class="block-name-edit" type="text" value="' + escHtml(b.name) + '" placeholder="Block Name" oninput="onBlockNameEdit(' + bi + ',this)">' +
                    '<button type="button" class="block-remove-btn" onclick="removeBlock(' + bi + ')">&#10005;</button>' +
                    '</div>' +
                    '<div class="block-card-body">' +
                    // ▼ 3-column grid: No. of Floors | Units per Floor | Total Units (readonly auto-calc)
                    '<div class="bc-grid">' +
                    '<div class="bc-field bc-field-full"><label>Block Name</label><input type="text" value="' + escHtml(b.name) + '" oninput="onBlockField(' + bi + ',\'name\',this.value)"></div>' +
                    '<div class="bc-field"><label>No. of Floors <span style=\'color:var(--red)\'>*</span></label>' +
                    '<input type="number" min="1" value="' + (b.floors || '') + '" placeholder="Enter floors" oninput="onBlockField(' + bi + ',\'floors\',this.value)"></div>' +
                    '<div class="bc-field"><label>Units per Floor <span style=\'color:var(--red)\'>*</span></label>' +
                    '<input type="number" min="1" value="' + (b.upf || '') + '" placeholder="Enter units" oninput="onBlockField(' + bi + ',\'upf\',this.value)"></div>' +
                    '<div class="bc-field"><label>Total Units <span style=\'font-size:.6rem;color:var(--text-light);font-weight:400\'>(auto)</span></label>' +
                    '<input type="number" value="' + total + '" readonly></div>' +
                    '<div class="bc-field"><label>Category</label><select onchange="onBlockField(' + bi + ',\'category\',this.value)">' +
                    ['Standard', 'Premium', 'Economy'].map(function (c) { return '<option' + (b.category === c ? ' selected' : '') + '>' + c + '</option>'; }).join('') +
                    '</select></div>' +
                    '</div>' +
                    '<div class="bhk-section">' +
                    '<div class="bhk-header">' +
                    '<div class="bhk-title"><i class="fa-solid fa-house" style="color:var(--orange);font-size:.8rem"></i>&nbsp;BHK TYPE DISTRIBUTION</div>' +
                    '<button type="button" class="add-type-btn"' + addTypeBtnDisabled + ' onclick="addBhkRow(' + bi + ')">+ Add Type</button>' +
                    '</div>' +
                    '<div class="progress-bar-wrap"><div class="progress-bar-fill" style="width:' + pct + '%;background:' + barColor + '"></div></div>' +
                    '<div class="assign-meta">' +
                    '<span style="color:' + (isOver ? 'var(--red)' : isExact ? 'var(--green)' : 'var(--orange)') + '">' + assigned + ' / ' + total + ' assigned</span>' +
                    '<span style="color:' + (isOver ? 'var(--red)' : isExact ? 'var(--green)' : 'var(--text-mid)') + '">' +
                    (isOver ? '&#9888; ' + (assigned - total) + ' over!' : isExact ? '&#10003; Complete!' : remaining + ' remaining') + '</span>' +
                    '</div>' +
                    '<div>' + bhkRowsHTML + '</div>' + statusHTML +
                    '</div></div>';
                return card;
            }

            function onBlockNameEdit(bi, el) { blocksData[bi].name = el.value; var bodyInp = document.querySelector('#block' + bi + ' .bc-field-full input'); if (bodyInp) bodyInp.value = el.value; syncBlocksHidden(); }
            function onBlockField(bi, field, val) {
                if (field === 'name') blocksData[bi].name = val;
                else if (field === 'floors') blocksData[bi].floors = parseInt(val) || 0;
                else if (field === 'upf') blocksData[bi].upf = parseInt(val) || 0;
                else if (field === 'category') blocksData[bi].category = val;
                renderBlocks();
            }
            function onBhkTypeChange(bi, ti, val) { blocksData[bi].bhkTypes[ti].typeID = parseInt(val); renderBlocks(); }
            function onBhkCountChange(bi, ti, inp) {
                var b = blocksData[bi], total = getTotalUnits(b), newVal = parseInt(inp.value) || 0;
                var otherSum = b.bhkTypes.reduce(function (s, btype, i) { return i === ti ? s : s + (parseInt(btype.count) || 0); }, 0);
                var maxAllowed = Math.max(0, total - otherSum);
                if (newVal < 0) { inp.value = 0; newVal = 0; showToast('Value cannot be less than 0!', 'error'); }
                else if (newVal > maxAllowed) { inp.value = maxAllowed; newVal = maxAllowed; inp.classList.add('input-over'); showToast('Cannot exceed ' + total + ' total units! Max allowed here: ' + maxAllowed, 'error'); setTimeout(function () { inp.classList.remove('input-over'); }, 1500); }
                else inp.classList.remove('input-over');
                blocksData[bi].bhkTypes[ti].count = newVal; renderBlocks();
            }
            function addBhkRow(bi) { var b = blocksData[bi], total = getTotalUnits(b), assigned = getAssigned(b); if (total > 0 && assigned >= total) { showToast('All ' + total + ' units already assigned.', 'error'); return; } b.bhkTypes.push({ typeID: 1, count: 0 }); renderBlocks(); }
            function removeBhkRow(bi, ti) { blocksData[bi].bhkTypes.splice(ti, 1); renderBlocks(); }
            function addBlock() {
                var names = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'];
                // ▼ No default floors/upf — user enters manually
                blocksData.push({ name: 'Block ' + (names[blocksData.length] || (blocksData.length + 1)), floors: 0, upf: 0, category: 'Standard', bhkTypes: [] });
                blockCount = blocksData.length;
                var nb = document.getElementById('<%= txtNumBlocks.ClientID %>'); if (nb) nb.value = blockCount;
                renderBlocks(); showToast('Block added!', 'success');
            }
            function removeBlock(bi) {
                if (blocksData.length <= 1) { showToast('At least 1 block required!', 'error'); return; }
                blocksData.splice(bi, 1); blockCount = blocksData.length;
                var nb = document.getElementById('<%= txtNumBlocks.ClientID %>'); if (nb) nb.value = blockCount;
                renderBlocks(); showToast('Block removed', 'info');
            }
            function onNumBlocksChange(val) {
                var n = parseInt(val) || 0;
                if (n <= 0) { blocksData = []; blockCount = 0; renderBlocks(); return; }
                var names = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'];
                if (n > blocksData.length) {
                    while (blocksData.length < n)
                        // ▼ No default floors/upf — empty for user to fill
                        blocksData.push({ name: 'Block ' + (names[blocksData.length] || (blocksData.length + 1)), floors: 0, upf: 0, category: 'Standard', bhkTypes: [] });
                } else if (n < blocksData.length && n > 0) {
                    blocksData = blocksData.slice(0, n);
                }
                blockCount = blocksData.length; renderBlocks();
            }
            function buildBlocksGrid(n) {
                var names = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J']; blocksData = [];
                for (var i = 0; i < n; i++)
                    // ▼ No default floors/upf — user enters manually
                    blocksData.push({ name: 'Block ' + (names[i] || (i + 1)), floors: 0, upf: 0, category: 'Standard', bhkTypes: [] });
                blockCount = n; renderBlocks();
            }
            function syncBlocksHidden() {
                var hdn = document.getElementById('<%= hdnBlocksJSON.ClientID %>'); if (!hdn) return;
                hdn.value = JSON.stringify(blocksData.map(function (b) {
                    return {
                        BlockName: b.name || 'Block', Floors: b.floors || 0, UPF: b.upf || 0,
                        Category: b.category || 'Standard',
                        BhkTypes: (b.bhkTypes || []).filter(function (btype) { return (parseInt(btype.count) || 0) > 0; })
                            .map(function (btype) { return { typeID: parseInt(btype.typeID) || 0, count: parseInt(btype.count) || 0 }; })
                    };
                }));
            }

            // ═══════════════════════════════════════════
            // UNIT TYPES — BLOCK SE AUTO SYNC
            // ═══════════════════════════════════════════
            var unitRowCount = 0;

            function syncUnitTypesFromBlocks() {
                var typeMap = {};
                for (var bi = 0; bi < blocksData.length; bi++) {
                    var b = blocksData[bi];
                    for (var ti = 0; ti < b.bhkTypes.length; ti++) {
                        var btype = b.bhkTypes[ti];
                        var cnt = parseInt(btype.count) || 0;
                        if (cnt > 0) {
                            var key = btype.typeID;
                            if (!typeMap[key]) typeMap[key] = 0;
                            typeMap[key] += cnt;
                        }
                    }
                }
                var existingData = {};
                var existingRows = document.querySelectorAll('.unit-row');
                for (var i = 0; i < existingRows.length; i++) {
                    var tid = existingRows[i].getAttribute('data-typeid');
                    if (tid) {
                        var inps = existingRows[i].querySelectorAll('input[type="number"]');
                        existingData[parseInt(tid)] = {
                            area: inps[0] ? (parseFloat(inps[0].value) || 0) : 0,
                            carpet: inps[1] ? (parseFloat(inps[1].value) || 0) : 0,
                            bsp: inps[3] ? (parseFloat(inps[3].value) || 0) : 0,
                            plc: inps[4] ? (parseFloat(inps[4].value) || 0) : 0
                        };
                    }
                }
                var urc = document.getElementById('unitRowsContainer');
                if (!urc) return;
                urc.innerHTML = '';
                unitRowCount = 0;
                var hasTypes = false;
                var sortedKeys = Object.keys(typeMap).map(Number).sort(function (a, b) { return a - b; });
                for (var k = 0; k < sortedKeys.length; k++) {
                    var typeID = sortedKeys[k];
                    hasTypes = true;
                    var prev = existingData[typeID] || {};
                    addUnitRow({ typeID: typeID, area: prev.area || 0, carpet: prev.carpet || 0, count: typeMap[typeID], bsp: prev.bsp || 0, plc: prev.plc || 0 }, true);
                }
                if (!hasTypes) {
                    urc.innerHTML = '<div style="text-align:center;padding:24px 12px;font-size:.78rem;color:var(--text-light);border:2px dashed var(--border);border-radius:10px;">' +
                        '<i class="fa-solid fa-arrow-up" style="display:block;font-size:1.4rem;margin-bottom:8px;opacity:.4"></i>' +
                        'Block mein BHK types assign karo<br>yahan automatically aa jayenge</div>';
                }
                syncUnitTypesHidden();
                syncBSPHidden();
            }

            function addUnitRow(d, isLocked) {
                unitRowCount++;
                var bsp = (d && d.bsp > 0) ? d.bsp : 0;
                var plc = (d && d.plc > 0) ? d.plc : 0;
                var area = d ? (d.area || 0) : 0;
                var carpet = d ? (d.carpet || 0) : 0;
                var count = d ? (d.count || 0) : 0;
                var typeID = d ? (d.typeID || 1) : 1;

                var totalRs = area > 0 ? Math.round((area * bsp) + plc) : 0;
                var totalLabel = totalRs > 0 ? formatPrice(totalRs) : '';

                var typeLabel = '1 BHK';
                for (var i = 0; i < unitTypeOptions.length; i++) {
                    if (unitTypeOptions[i].id === typeID) { typeLabel = unitTypeOptions[i].label; break; }
                }

                var rowId = 'unitRow' + unitRowCount;
                var row = document.createElement('div');
                row.className = 'unit-row';
                row.id = rowId;
                row.setAttribute('data-typeid', typeID);

                var typeCell = isLocked
                    ? '<div class="unit-row-locked-type"><i class="fa-solid fa-link" style="font-size:.6rem;opacity:.5"></i>' + typeLabel + '</div>'
                    : '<select onchange="this.closest(\'.unit-row\').setAttribute(\'data-typeid\',this.value);recalcUnitRow(this);syncUnitTypesHidden()" style="padding:6px 7px;font-size:.76rem">' +
                    unitTypeOptions.map(function (u) { return '<option value="' + u.id + '"' + (u.id === typeID ? ' selected' : '') + '>' + u.label + '</option>'; }).join('') + '</select>';

                var deleteCell = isLocked
                    ? '<div style="width:34px;height:34px;display:flex;align-items:center;justify-content:center;color:var(--text-light);font-size:.65rem" title="Block se manage karo"><i class="fa-solid fa-lock"></i></div>'
                    : '<button type="button" onclick="document.getElementById(\'' + rowId + '\').remove();syncUnitTypesHidden();syncBSPHidden();" style="width:34px;height:34px;border-radius:6px;background:var(--red-pale);border:none;cursor:pointer;color:var(--red);font-weight:700">X</button>';

                row.innerHTML =
                    typeCell +
                    '<input type="number" placeholder="Required*" value="' + (area || '') + '" ' +
                    'oninput="recalcUnitRow(this);syncUnitTypesHidden()" style="padding:6px;font-size:.78rem">' +
                    '<input type="number" placeholder="Required*" value="' + (carpet || '') + '" ' +
                    'onchange="syncUnitTypesHidden()" style="padding:6px;font-size:.78rem">' +
                    '<input type="number" placeholder="0" value="' + (count || '') + '" ' +
                    (isLocked ? 'readonly style="padding:6px;font-size:.78rem;background:#F8FAFC;color:var(--orange);font-weight:700;cursor:default"'
                        : 'onchange="syncUnitTypesHidden()" style="padding:6px;font-size:.78rem"') + '>' +
                    '<input type="number" placeholder="Required*" value="' + (bsp || '') + '" ' +
                    'oninput="recalcUnitRow(this);syncUnitTypesHidden();syncBSPHidden()" style="padding:6px;font-size:.78rem">' +
                    '<input type="number" placeholder="0" value="' + (plc || '') + '" ' +
                    'oninput="recalcUnitRow(this);syncUnitTypesHidden();syncBSPHidden()" style="padding:6px;font-size:.78rem">' +
                    '<input type="text" value="' + totalLabel + '" readonly id="total_' + rowId + '" ' +
                    'style="padding:6px;font-size:.78rem;background:#F9FAFB;font-weight:600;color:var(--orange)">' +
                    deleteCell;

                var container = document.getElementById('unitRowsContainer');
                if (container) container.appendChild(row);
                syncUnitTypesHidden();
                syncBSPHidden();
            }

            function recalcUnitRow(changedInput) {
                var row = changedInput.parentElement;
                while (row && !row.classList.contains('unit-row')) row = row.parentElement;
                if (!row) return;
                var inputs = row.querySelectorAll('input[type="number"]');
                var superSqft = parseFloat(inputs[0] ? inputs[0].value : 0) || 0;
                var bsp = parseFloat(inputs[3] ? inputs[3].value : 0) || 0;
                var plc = parseFloat(inputs[4] ? inputs[4].value : 0) || 0;
                var total = Math.round((superSqft * bsp) + plc);
                var totalField = row.querySelector('input[type="text"]');
                if (totalField) totalField.value = total > 0 ? formatPrice(total) : '';
            }

            function calcPricing() {
                var rows = document.querySelectorAll('.unit-row');
                for (var i = 0; i < rows.length; i++) {
                    var inputs = rows[i].querySelectorAll('input[type="number"]');
                    if (inputs.length >= 5) {
                        var superSqft = parseFloat(inputs[0].value) || 0;
                        var bsp = parseFloat(inputs[3].value) || 0;
                        var plc = parseFloat(inputs[4].value) || 0;
                        var total = Math.round((superSqft * bsp) + plc);
                        var totalField = rows[i].querySelector('input[type="text"]');
                        if (totalField) totalField.value = total > 0 ? formatPrice(total) : '';
                    }
                }
                syncBSPHidden();
            }

            function syncUnitTypesHidden() {
                var units = [], rows = document.querySelectorAll('.unit-row');
                for (var i = 0; i < rows.length; i++) {
                    var inputs = rows[i].querySelectorAll('input[type="number"]');
                    var sel = rows[i].querySelector('select');
                    var typeID = sel ? parseInt(sel.value) : parseInt(rows[i].getAttribute('data-typeid') || '1');
                    if (inputs.length >= 5)
                        units.push({
                            UnitTypeID: typeID,
                            Super: parseFloat(inputs[0].value) || 0,
                            Carpet: parseFloat(inputs[1].value) || 0,
                            Count: parseInt(inputs[2].value) || 0,
                            BSP: parseFloat(inputs[3].value) || 0,
                            PLC: parseFloat(inputs[4].value) || 0
                        });
                }
                var hdn = document.getElementById('<%= hdnUnitTypesJSON.ClientID %>');
                if (hdn) hdn.value = JSON.stringify(units);
            }

            // AMENITIES
            function toggleAmenity(el) {
                el.classList.toggle('selected'); var items = document.querySelectorAll('.amenity-item.selected'), ids = [];
                for (var i = 0; i < items.length; i++) if (items[i].dataset.amenityid) ids.push(items[i].dataset.amenityid);
                var hdnA = document.getElementById('<%= hdnAmenityIDs.ClientID %>'); if (hdnA) hdnA.value = ids.join(',');
                var cnt = document.getElementById('amenityCount'); if (cnt) cnt.textContent = ids.length + ' selected';
            }
            (function preSelectAmenities() {
                var hdnA = document.getElementById('<%= hdnAmenityIDs.ClientID %>'); if (!hdnA || !hdnA.value) return;
                var ids = hdnA.value.split(','); for (var i = 0; i < ids.length; i++) { var el = document.querySelector('.amenity-item[data-amenityid="' + ids[i].trim() + '"]'); if (el) el.classList.add('selected'); }
                var cnt = document.getElementById('amenityCount'); if (cnt) cnt.textContent = document.querySelectorAll('.amenity-item.selected').length + ' selected';
            })();

            // BANK PILLS
            function toggleBankPill(el) {
                el.classList.toggle('checked'); var pills = document.querySelectorAll('.check-pill.checked'), ids = [];
                for (var i = 0; i < pills.length; i++) if (pills[i].dataset.bankid) ids.push(pills[i].dataset.bankid);
                var hdnB = document.getElementById('<%= hdnBankIDs.ClientID %>'); if (hdnB) hdnB.value = ids.join(',');
            }
            (function preSelectBanks() {
                var hdnB = document.getElementById('<%= hdnBankIDs.ClientID %>'); if (!hdnB || !hdnB.value) return;
                var ids = hdnB.value.split(','); for (var i = 0; i < ids.length; i++) { var el = document.querySelector('.check-pill[data-bankid="' + ids[i] + '"]'); if (el) el.classList.add('checked'); }
            })();

            // REVIEW
            function updateReview() {
                syncReadOnlyToHidden();
                set('rv-name', v('<%= txtProjectName.ClientID %>'));
                set('rv-code', v('<%= hdnProjectCode.ClientID %>') || v('<%= txtProjectCode.ClientID %>'));
                set('rv-developer', v('<%= txtDeveloperName.ClientID %>'));
                set('rv-type', t('<%= ddlProjectType.ClientID %>')); set('rv-category', t('<%= ddlCategory.ClientID %>'));
                set('rv-rera', v('<%= txtRERA.ClientID %>')); set('rv-status', t('<%= ddlStatus.ClientID %>'));
                set('rv-city', v('<%= txtCity.ClientID %>')); set('rv-state', t('<%= ddlState.ClientID %>'));
                set('rv-pincode', v('<%= txtPinCode.ClientID %>')); set('rv-launch', v('<%= txtLaunchDate.ClientID %>'));
                set('rv-possession', v('<%= txtPossessionDate.ClientID %>')); set('rv-branch', t('<%= ddlBranch.ClientID %>'));
                set('rv-manager', v('<%= txtProjectManager.ClientID %>')); set('rv-address', v('<%= txtAddress.ClientID %>')); set('rv-desc', v('<%= txtDescription.ClientID %>'));
                var land = v('<%= txtLandArea.ClientID %>'); set('rv-land', land ? land + ' Sq.Yd' : '');

                // Total Units from blocks
                var totalU = 0;
                for (var bi2 = 0; bi2 < blocksData.length; bi2++) totalU += getTotalUnits(blocksData[bi2]);
                set('rv-units', totalU > 0 ? totalU.toString() : '-');

                set('rv-blocks', v('<%= txtNumBlocks.ClientID %>'));
                set('rv-parking', t('<%= ddlParkingType.ClientID %>'));

                var rows = document.querySelectorAll('.unit-row');
                var bspVals = [], plcVals = [];
                for (var ri = 0; ri < rows.length; ri++) {
                    var inps = rows[ri].querySelectorAll('input[type="number"]');
                    var typeEl = rows[ri].querySelector('.unit-row-locked-type');
                    var typeLabel = typeEl ? typeEl.textContent.replace(/\s+/g, ' ').trim() : ('Row ' + (ri + 1));
                    var bspV = parseFloat(inps[3] ? inps[3].value : 0) || 0;
                    var plcV = parseFloat(inps[4] ? inps[4].value : 0) || 0;
                    if (bspV > 0) bspVals.push(typeLabel + ': Rs ' + bspV.toLocaleString('en-IN') + '/sqft');
                    if (plcV > 0) plcVals.push(typeLabel + ': Rs ' + plcV.toLocaleString('en-IN'));
                }
                set('rv-bsp', bspVals.length > 0 ? bspVals.join(' | ') : '-');
                set('rv-plc', plcVals.length > 0 ? plcVals.join(' | ') : '-');

                var bookingVal = v('<%= txtBookingAmount.ClientID %>'); set('rv-booking', bookingVal ? 'Rs ' + parseInt(bookingVal).toLocaleString('en-IN') : '');
                set('rv-payplan', t('<%= ddlPaymentPlan.ClientID %>'));
                var gstVal = v('<%= txtGST.ClientID %>'); set('rv-gst', gstVal ? gstVal + '%' : '');
                var comm1Val = v('<%= txtCommL1.ClientID %>'); set('rv-comm1', comm1Val ? comm1Val + '%' : '');

                var amenList = document.getElementById('rv-amenities-list');
                if (amenList) { amenList.innerHTML = ''; var amenItems = document.querySelectorAll('.amenity-item.selected'); if (amenItems.length > 0) { for (var i = 0; i < amenItems.length; i++) { var lbl = amenItems[i].querySelector('.a-label'); if (lbl) { var chip = document.createElement('span'); chip.style.cssText = 'background:var(--orange-pale);color:var(--orange);border:1px solid #FED7AA;border-radius:20px;padding:3px 10px;font-size:.7rem;font-weight:600;white-space:nowrap'; chip.textContent = lbl.textContent; amenList.appendChild(chip); } } } else amenList.innerHTML = '<span style="color:var(--text-light);font-size:.75rem;font-style:italic">No amenities selected</span>'; }
                set('rv-flooring', t('<%= ddlFlooring.ClientID %>')); set('rv-kitchen', t('<%= ddlKitchen.ClientID %>'));
                set('rv-bathroom', t('<%= ddlBathroom.ClientID %>')); set('rv-windows', t('<%= ddlWindowType.ClientID %>'));
                var galleryMini = document.getElementById('rv-gallery-mini');
                if (galleryMini) { galleryMini.innerHTML = ''; if (galleryImages && galleryImages.length > 0) { var show = Math.min(galleryImages.length, 10); for (var j = 0; j < show; j++) { var img = document.createElement('img'); img.src = galleryImages[j].dataURL; img.title = galleryImages[j].name || ''; img.style.cssText = 'width:56px;height:56px;object-fit:cover;border-radius:6px;border:2px solid ' + (galleryImages[j].isCover ? 'var(--orange)' : 'var(--border)'); galleryMini.appendChild(img); } if (galleryImages.length > 10) { var more = document.createElement('div'); more.style.cssText = 'width:56px;height:56px;border-radius:6px;background:#F1F5F9;display:flex;align-items:center;justify-content:center;font-size:.75rem;font-weight:700;color:var(--text-mid)'; more.textContent = '+' + (galleryImages.length - 10); galleryMini.appendChild(more); } } else galleryMini.innerHTML = '<span style="color:var(--text-light);font-size:.75rem;font-style:italic">No gallery images</span>'; }
                set('rv-video', v('<%= txtVideoURL.ClientID %>')); set('rv-tour', v('<%= txtVirtualTour.ClientID %>'));
                var docsJson = document.getElementById('<%= hdnDocsJSON.ClientID %>').value, docCount = 0;
                try { if (docsJson) docCount = JSON.parse(docsJson).length; } catch (e) { }
                set('rv-docs', docCount > 0 ? docCount + ' document(s) uploaded' : 'No documents yet');
            }

            // PUBLISH MODE
            function selectPublishMode(el, mode) {
                var ids = ['pm-active', 'pm-draft', 'pm-upcoming'];
                for (var i = 0; i < ids.length; i++) { var p = document.getElementById(ids[i]); if (p) { p.style.borderColor = 'var(--border)'; p.style.background = '#fff'; } }
                el.style.borderColor = 'var(--orange)'; el.style.background = 'var(--orange-pale)';
                var hdnPM = document.getElementById('<%= hdnPublishMode.ClientID %>'); if (hdnPM) hdnPM.value = mode;
                var labels = { draft: 'Draft', active: 'Live', upcoming: 'Scheduled' }, classes = { draft: 'pill-draft', active: 'pill-active', upcoming: 'pill-upcoming' };
                var pill = document.getElementById('reviewStatusPill'); if (pill) pill.innerHTML = '<span class="status-pill ' + classes[mode] + '">' + labels[mode] + '</span>';
            }

            // STEP BAR
            function updateStepBar() { var items = document.querySelectorAll('.step-item'); for (var i = 0; i < items.length; i++) { if (i + 1 <= lastSavedStep) items[i].classList.remove('locked'); else if (i > lastSavedStep && i + 1 !== currentStep) items[i].classList.add('locked'); } }

            // NAVIGATION
            function goToStep(n) {
                if (n < currentStep) { goToStepDirect(n); return; }
                if (n > currentStep) { for (var s = currentStep; s < n; s++) { if (s > lastSavedStep) { showToast('Please save Step ' + s + ' before going to Step ' + n + '.', 'error'); return; } } goToStepDirect(n); }
            }
            function goToStepDirect(n) {
                var panels = document.querySelectorAll('.step-panel'); for (var i = 0; i < panels.length; i++) panels[i].classList.remove('active');
                var targetPanel = document.getElementById('panel' + n); if (targetPanel) targetPanel.classList.add('active');
                var items = document.querySelectorAll('.step-item');
                for (var i = 0; i < items.length; i++) {
                    items[i].classList.remove('active', 'done', 'locked'); var sn = document.getElementById('sn' + (i + 1)); if (!sn) continue;
                    if (i + 1 < n && i + 1 <= lastSavedStep) { items[i].classList.add('done'); sn.innerHTML = '<i class="fa-solid fa-check"></i>'; }
                    else if (i + 1 === n) { items[i].classList.add('active'); sn.textContent = i + 1; }
                    else { if (i + 1 > lastSavedStep + 1) items[i].classList.add('locked'); sn.textContent = i + 1; }
                }
                currentStep = n;
                var hdnCurStep = document.getElementById('<%= hdnCurrentStep.ClientID %>'); if (hdnCurStep) hdnCurStep.value = n.toString();
                var stepLabelEl = document.getElementById('stepLabel'); if (stepLabelEl) stepLabelEl.textContent = stepLabels[n - 1];
                var progressFill = document.getElementById('progressFill'); if (progressFill) progressFill.style.width = (n / totalSteps * 100) + '%';
                var nextBtnEl = document.getElementById('nextBtn'); if (nextBtnEl) nextBtnEl.textContent = nextBtnLabels[n - 1];
                var prevBtnEl = document.getElementById('<%= prevBtn.ClientID %>'); if (prevBtnEl) prevBtnEl.style.display = n > 1 ? 'inline-flex' : 'none';
                if (n === 2) restoreStep2Grids(); if (n === 3) restoreStep3Amenities(); if (n === 4) restoreStep4Gallery(); if (n === 5) { restoreDocsBadges(); updateReview(); }
                window.scrollTo({ top: 0, behavior: 'smooth' });
                var stepBar = document.getElementById('stepBar'), activeItem = document.getElementById('stepItem' + n);
                if (stepBar && activeItem) stepBar.scrollTo({ left: activeItem.offsetLeft - 20, behavior: 'smooth' });
            }
            function nextStep() {
                if (currentStep < totalSteps) { var ok = validateStep(currentStep); if (ok) { syncReadOnlyToHidden(); triggerSaveButton(currentStep); } else { showToast('Please fill all required fields before saving.', 'error'); var summary = document.getElementById('valSummary' + currentStep); if (summary) summary.scrollIntoView({ behavior: 'smooth', block: 'start' }); } }
                else if (currentStep === totalSteps) { var btn = document.getElementById('<%= btnPublish.ClientID %>'); if (btn) btn.click(); }
            }
            function triggerSaveButton(step) { var btnMap = { 1: '<%= btnSaveStep1.ClientID %>', 2: '<%= btnSaveStep2.ClientID %>', 3: '<%= btnSaveStep3.ClientID %>', 4: '<%= btnSaveStep4.ClientID %>' }; var btnID = btnMap[step]; if (btnID) { var btn = document.getElementById(btnID); if (btn) btn.click(); } }
            function onServerSaveSuccess(savedStep) { lastSavedStep = savedStep; stepsCompleted[savedStep - 1] = true; updateStepBar(); var nextS = savedStep + 1; if (nextS <= totalSteps) goToStepDirect(nextS); }
            function prepareBackNav() { return true; }

            // RESTORE GRIDS
            function restoreStep2Grids() {
                var hdnBJ = document.getElementById('<%= hdnBlocksJSON.ClientID %>'), blocksJson = hdnBJ ? hdnBJ.value : '', blocksRestored = false;
                if (blocksJson && blocksJson.trim() !== '' && blocksJson !== '[]') {
                    try {
                        var parsed = JSON.parse(blocksJson);
                        if (parsed && parsed.length > 0) {
                            blocksData = parsed.map(function (b) {
                                return {
                                    name: b.BlockName || b.name || 'Block',
                                    floors: parseInt(b.Floors || b.floors) || 0,   // ▼ 0 not 5
                                    upf: parseInt(b.UPF || b.upf) || 0,             // ▼ 0 not 4
                                    category: b.Category || b.category || 'Standard',
                                    bhkTypes: (b.BhkTypes || b.bhkTypes || []).map(function (btype) {
                                        return { typeID: parseInt(btype.typeID || btype.TypeID) || 1, count: parseInt(btype.count || btype.Count) || 0 };
                                    })
                                };
                            });
                            blockCount = blocksData.length;
                            var nb = document.getElementById('<%= txtNumBlocks.ClientID %>'); if (nb) nb.value = blockCount;
                            renderBlocks(); blocksRestored = true;
                        }
                    } catch (ex) { console.warn('Blocks restore error:', ex); }
                }
                if (!blocksRestored) {
                    var nb2 = document.getElementById('<%= txtNumBlocks.ClientID %>'), n = nb2 ? (parseInt(nb2.value) || 0) : 0;
                    if (n > 0) buildBlocksGrid(n);
                    else { var grid = document.getElementById('blocksGrid'); if (grid) grid.innerHTML = '<div class="add-block-card" onclick="addBlock()"><span class="add-block-icon">+</span><span>Add Block</span></div>'; }
                }
                var hdnUJ = document.getElementById('<%= hdnUnitTypesJSON.ClientID %>'), unitsJson = hdnUJ ? hdnUJ.value : '';
                if (unitsJson && unitsJson.trim() !== '' && unitsJson !== '[]') {
                    try {
                        var savedUnits = JSON.parse(unitsJson);
                        if (savedUnits && savedUnits.length > 0) {
                            var urc = document.getElementById('unitRowsContainer');
                            if (urc) {
                                for (var j = 0; j < savedUnits.length; j++) {
                                    var u = savedUnits[j];
                                    var tempDiv = document.createElement('div');
                                    tempDiv.className = 'unit-row';
                                    tempDiv.setAttribute('data-typeid', (u.UnitTypeID || u.typeID || 1));
                                    for (var fi = 0; fi < 5; fi++) {
                                        var inp = document.createElement('input');
                                        inp.type = 'number';
                                        if (fi === 0) inp.value = u.Super || u.area || 0;
                                        else if (fi === 1) inp.value = u.Carpet || u.carpet || 0;
                                        else if (fi === 2) inp.value = u.Count || u.count || 0;
                                        else if (fi === 3) inp.value = u.BSP || u.bsp || 0;
                                        else if (fi === 4) inp.value = u.PLC || u.plc || 0;
                                        tempDiv.appendChild(inp);
                                    }
                                    urc.appendChild(tempDiv);
                                }
                            }
                        }
                    } catch (ex) { console.warn('Units restore error:', ex); }
                }
                syncUnitTypesFromBlocks();
                calcPricing();
                syncTotalUnitsHidden();
            }

            function restoreStep3Amenities() { var hdnA = document.getElementById('<%= hdnAmenityIDs.ClientID %>'); if (!hdnA || !hdnA.value) return; var ids = hdnA.value.split(','); for (var i = 0; i < ids.length; i++) { var el = document.querySelector('.amenity-item[data-amenityid="' + ids[i].trim() + '"]'); if (el) el.classList.add('selected'); } var cnt = document.getElementById('amenityCount'); if (cnt) cnt.textContent = document.querySelectorAll('.amenity-item.selected').length + ' selected'; }
            function showDocSelected(input, itemId) { var numericID = itemId.replace('docItem_', ''), badge = document.getElementById('docBadge_' + numericID), item = document.getElementById(itemId); if (!badge || !input.files || !input.files[0]) return; var fname = input.files[0].name; badge.innerHTML = '<span class="badge-new"><i class="fa-solid fa-file-arrow-up"></i> ' + truncateStr(fname, 22) + '</span>'; if (item) item.classList.add('has-doc'); }
            function restoreDocsBadges() { var hdnDJ = document.getElementById('<%= hdnDocsJSON.ClientID %>'), docsJson = hdnDJ ? hdnDJ.value : ''; if (!docsJson || docsJson === '[]') return; try { var docs = JSON.parse(docsJson); for (var i = 0; i < docs.length; i++) { var d = docs[i], badge = document.getElementById('docBadge_' + d.docTypeID), item = document.getElementById('docItem_' + d.docTypeID); if (badge) badge.innerHTML = '<span class="badge-uploaded"><i class="fa-solid fa-circle-check"></i> ' + truncateStr(d.fileName, 22) + '</span>'; if (item) item.classList.add('has-doc'); } } catch (ex) { console.warn('Docs restore error:', ex); } }
            function truncateStr(str, maxLen) { if (!str) return ''; return str.length > maxLen ? str.substring(0, maxLen - 2) + '..' : str; }

            // GALLERY
            var galleryImages = [], MAX_GALLERY = 20;
            function handleGalleryFiles(files) { for (var i = 0; i < files.length; i++) { if (galleryImages.length >= MAX_GALLERY) { showToast('Maximum 20 images allowed.', 'error'); break; } var file = files[i]; if (!file.type.startsWith('image/')) continue; (function (f) { var reader = new FileReader(); reader.onload = function (e) { var isCover = galleryImages.length === 0; galleryImages.push({ name: f.name, size: f.size, dataURL: e.target.result, isCover: isCover }); renderGalleryPreviews(); }; reader.readAsDataURL(f); })(file); } }
            function handleGalleryDrop(files) { handleGalleryFiles(files); }
            function removeGalleryImage(idx) { var wasCover = galleryImages[idx] && galleryImages[idx].isCover; galleryImages.splice(idx, 1); if (wasCover && galleryImages.length > 0) galleryImages[0].isCover = true; renderGalleryPreviews(); }
            function setGalleryCover(idx) { for (var i = 0; i < galleryImages.length; i++) galleryImages[i].isCover = false; galleryImages[idx].isCover = true; renderGalleryPreviews(); }
            function renderGalleryPreviews() {
                var grid = document.getElementById('galleryPreviewGrid'), badge = document.getElementById('galleryCountBadge'); if (!grid) return;
                grid.innerHTML = '';
                for (var i = 0; i < galleryImages.length; i++) { var img = galleryImages[i]; var div = document.createElement('div'); div.className = 'gallery-thumb'; var imgEl = document.createElement('img'); imgEl.src = img.dataURL; imgEl.alt = img.name || ''; div.appendChild(imgEl); var removeBtn = document.createElement('button'); removeBtn.type = 'button'; removeBtn.className = 'thumb-remove'; removeBtn.innerHTML = '<i class="fa-solid fa-xmark"></i>'; (function (idx) { removeBtn.onclick = function (e) { e.stopPropagation(); removeGalleryImage(idx); }; })(i); div.appendChild(removeBtn); if (img.isCover) { var cb = document.createElement('span'); cb.className = 'thumb-cover-badge'; cb.textContent = 'COVER'; div.appendChild(cb); } else { var scb = document.createElement('button'); scb.type = 'button'; scb.className = 'thumb-set-cover'; scb.textContent = 'Set Cover'; (function (idx) { scb.onclick = function (e) { e.stopPropagation(); setGalleryCover(idx); }; })(i); div.appendChild(scb); } grid.appendChild(div); }
                if (galleryImages.length < MAX_GALLERY) { var addBtn = document.createElement('div'); addBtn.className = 'gallery-add-btn'; addBtn.innerHTML = '<i class="fa-solid fa-plus" style="font-size:1.2rem"></i><span>Add More</span>'; addBtn.onclick = function () { var rgi = document.getElementById('realGalleryInput'); if (rgi) rgi.click(); }; grid.appendChild(addBtn); }
                if (badge) badge.textContent = galleryImages.length + ' / ' + MAX_GALLERY + ' images';
                var dropZone = document.getElementById('galleryDropZone'); if (dropZone) { var titleEl = dropZone.querySelector('.photo-drop-title'); if (titleEl) titleEl.textContent = galleryImages.length > 0 ? 'Click to add more images' : 'Click or drag images here'; }
                syncNewGalleryToHidden();
            }
            function syncNewGalleryToHidden() { var newImgs = []; for (var i = 0; i < galleryImages.length; i++) { var img = galleryImages[i]; if (!img.fromDB) newImgs.push({ name: img.name, isCover: img.isCover, data: img.dataURL }); else newImgs.push({ name: img.name, isCover: img.isCover, data: null, path: img.dataURL }); } var hdn = document.getElementById('<%= hdnNewGalleryBase64.ClientID %>'); if (hdn) hdn.value = JSON.stringify(newImgs); }
            function restoreStep4Gallery() {
                restoreDocsBadges();
                var hdnGJ = document.getElementById('<%= hdnGalleryJSON.ClientID %>'), galleryJson = hdnGJ ? hdnGJ.value : '';
                if (galleryJson && galleryJson.trim() !== '' && galleryJson !== '[]') { try { var dbImages = JSON.parse(galleryJson); if (dbImages && dbImages.length > 0 && galleryImages.length === 0) { for (var i = 0; i < dbImages.length; i++) galleryImages.push({ name: dbImages[i].name || ('image_' + i), size: 0, dataURL: dbImages[i].path, isCover: dbImages[i].isCover, fromDB: true }); } renderGalleryPreviews(); } catch (ex) { console.warn('Gallery restore error:', ex); } } else renderGalleryPreviews();
                var coverPrev = document.getElementById('coverPreview'); if (coverPrev) { var hdnNC = document.getElementById('<%= hdnNewCoverBase64.ClientID %>'), hdnCI = document.getElementById('<%= hdnCoverImage.ClientID %>'); var newCover = hdnNC ? hdnNC.value : '', coverSrc = (newCover && newCover.trim()) ? newCover : (hdnCI ? hdnCI.value : ''); if (coverSrc && coverSrc.trim()) coverPrev.innerHTML = '<div style="position:relative;display:inline-block;margin-top:6px"><img src="' + coverSrc + '" style="height:90px;width:140px;object-fit:cover;border-radius:8px;border:2px solid var(--orange);display:block;"><span style="position:absolute;bottom:5px;left:5px;background:var(--orange);color:#fff;font-size:.6rem;font-weight:700;padding:2px 6px;border-radius:4px">COVER</span></div>'; }
                var logoPrev = document.getElementById('logoPreview'); if (logoPrev) { var hdnNL = document.getElementById('<%= hdnNewLogoBase64.ClientID %>'), hdnLI = document.getElementById('<%= hdnLogoImage.ClientID %>'); var newLogo = hdnNL ? hdnNL.value : '', logoSrc = (newLogo && newLogo.trim()) ? newLogo : (hdnLI ? hdnLI.value : ''); if (logoSrc && logoSrc.trim()) logoPrev.innerHTML = '<div style="margin-top:6px;display:inline-block"><img src="' + logoSrc + '" style="height:80px;width:80px;object-fit:contain;border-radius:8px;border:2px solid var(--border);padding:4px;background:#fff;display:block;"></div>'; }
            }
            function previewSingleImage(input, previewDivId) {
                var prev = document.getElementById(previewDivId); if (!prev || !input.files || !input.files[0]) return;
                var file = input.files[0]; if (!file.type.startsWith('image/')) return;
                var reader = new FileReader(); reader.onload = function (e) { var dataURL = e.target.result; if (previewDivId === 'coverPreview') { prev.innerHTML = '<div style="position:relative;display:inline-block;margin-top:6px"><img src="' + dataURL + '" style="height:90px;width:140px;object-fit:cover;border-radius:8px;border:2px solid var(--orange);display:block;"><span style="position:absolute;bottom:5px;left:5px;background:var(--orange);color:#fff;font-size:.6rem;font-weight:700;padding:2px 6px;border-radius:4px">COVER</span></div>'; var hdnC = document.getElementById('<%= hdnNewCoverBase64.ClientID %>'); if (hdnC) hdnC.value = dataURL; } else { prev.innerHTML = '<div style="margin-top:6px;display:inline-block"><img src="' + dataURL + '" style="height:80px;width:80px;object-fit:contain;border-radius:8px;border:2px solid var(--border);padding:4px;background:#fff;display:block;"></div>'; var hdnL = document.getElementById('<%= hdnNewLogoBase64.ClientID %>'); if (hdnL) hdnL.value = dataURL; } }; reader.readAsDataURL(file);
            }

            // INIT
            (function initGrids() {
                var hdnBJ = document.getElementById('<%= hdnBlocksJSON.ClientID %>'), hdnUJ = document.getElementById('<%= hdnUnitTypesJSON.ClientID %>');
                var blocksJson = hdnBJ ? hdnBJ.value : '', unitsJson = hdnUJ ? hdnUJ.value : '';
                if (blocksJson && blocksJson.trim() !== '' && blocksJson !== '[]') {
                    try {
                        var parsed = JSON.parse(blocksJson);
                        if (parsed && parsed.length > 0) {
                            blocksData = parsed.map(function (b) {
                                return {
                                    name: b.BlockName || b.name || 'Block',
                                    floors: parseInt(b.Floors || b.floors) || 0,
                                    upf: parseInt(b.UPF || b.upf) || 0,
                                    category: b.Category || b.category || 'Standard',
                                    bhkTypes: (b.BhkTypes || b.bhkTypes || []).map(function (btype) {
                                        return { typeID: parseInt(btype.typeID || btype.TypeID) || 1, count: parseInt(btype.count || btype.Count) || 0 };
                                    })
                                };
                            });
                            blockCount = blocksData.length; renderBlocks();
                        } else { /* no blocks — show empty Add Block card */ var grid = document.getElementById('blocksGrid'); if (grid) grid.innerHTML = '<div class="add-block-card" onclick="addBlock()"><span class="add-block-icon">+</span><span>Add Block</span></div>'; }
                    } catch (e) { var grid = document.getElementById('blocksGrid'); if (grid) grid.innerHTML = '<div class="add-block-card" onclick="addBlock()"><span class="add-block-icon">+</span><span>Add Block</span></div>'; }
                } else {
                    var nb = document.getElementById('<%= txtNumBlocks.ClientID %>'), n = nb ? (parseInt(nb.value) || 0) : 0;
                    if (n > 0) buildBlocksGrid(n);
                    else { var grid = document.getElementById('blocksGrid'); if (grid) grid.innerHTML = '<div class="add-block-card" onclick="addBlock()"><span class="add-block-icon">+</span><span>Add Block</span></div>'; }
                }
                if (unitsJson && unitsJson.trim() !== '' && unitsJson !== '[]') {
                    try {
                        var savedUnits = JSON.parse(unitsJson);
                        if (savedUnits && savedUnits.length > 0) {
                            var urc = document.getElementById('unitRowsContainer');
                            if (urc) {
                                for (var j = 0; j < savedUnits.length; j++) {
                                    var u = savedUnits[j];
                                    var tempDiv = document.createElement('div');
                                    tempDiv.className = 'unit-row';
                                    tempDiv.setAttribute('data-typeid', (u.UnitTypeID || u.typeID || 1));
                                    for (var fi = 0; fi < 5; fi++) {
                                        var inp = document.createElement('input'); inp.type = 'number';
                                        if (fi === 0) inp.value = u.Super || 0;
                                        else if (fi === 1) inp.value = u.Carpet || 0;
                                        else if (fi === 2) inp.value = u.Count || 0;
                                        else if (fi === 3) inp.value = u.BSP || 0;
                                        else if (fi === 4) inp.value = u.PLC || 0;
                                        tempDiv.appendChild(inp);
                                    }
                                    urc.appendChild(tempDiv);
                                }
                            }
                        }
                    } catch (e) { }
                }
                syncUnitTypesFromBlocks();
                calcPricing();
                syncTotalUnitsHidden();
            })();

            window.addEventListener('load', function () {
                if (lastSavedStep > 0) { for (var s = 1; s <= lastSavedStep; s++) stepsCompleted[s - 1] = true; updateStepBar(); }
                if (galleryImages.length === 0) {
                    var hdnGJ = document.getElementById('<%= hdnGalleryJSON.ClientID %>'), hdnNGB = document.getElementById('<%= hdnNewGalleryBase64.ClientID %>');
                    var hdnGJV = hdnGJ ? hdnGJ.value : '', hdnNGV = hdnNGB ? hdnNGB.value : '';
                    if (hdnGJV && hdnGJV.trim() !== '' && hdnGJV !== '[]') { try { var dbImgs = JSON.parse(hdnGJV); for (var di = 0; di < dbImgs.length; di++) galleryImages.push({ name: dbImgs[di].name || ('image_' + di), size: 0, dataURL: dbImgs[di].path, isCover: dbImgs[di].isCover, fromDB: true }); } catch (ex) { } }
                    else if (hdnNGV && hdnNGV.trim() !== '' && hdnNGV !== '[]') { try { var newImgsArr = JSON.parse(hdnNGV); for (var ni = 0; ni < newImgsArr.length; ni++) { var nim = newImgsArr[ni]; if (nim.data) galleryImages.push({ name: nim.name || ('image_' + ni), size: 0, dataURL: nim.data, isCover: nim.isCover, fromDB: false }); else if (nim.path) galleryImages.push({ name: nim.name || ('image_' + ni), size: 0, dataURL: nim.path, isCover: nim.isCover, fromDB: true }); } } catch (ex) { } }
                }
                var hdnNC = document.getElementById('<%= hdnNewCoverBase64.ClientID %>'), hdnCI = document.getElementById('<%= hdnCoverImage.ClientID %>');
                var coverSrcLoad = (hdnNC && hdnNC.value.trim()) ? hdnNC.value : ((hdnCI && hdnCI.value.trim()) ? hdnCI.value : '');
                if (coverSrcLoad) { var cpEl = document.getElementById('coverPreview'); if (cpEl && cpEl.innerHTML.trim() === '') cpEl.innerHTML = '<div style="position:relative;display:inline-block;margin-top:6px"><img src="' + coverSrcLoad + '" style="height:90px;width:140px;object-fit:cover;border-radius:8px;border:2px solid var(--orange);display:block;"><span style="position:absolute;bottom:5px;left:5px;background:var(--orange);color:#fff;font-size:.6rem;font-weight:700;padding:2px 6px;border-radius:4px">COVER</span></div>'; }
                var hdnNL = document.getElementById('<%= hdnNewLogoBase64.ClientID %>'), hdnLI = document.getElementById('<%= hdnLogoImage.ClientID %>');
                var logoSrcLoad = (hdnNL && hdnNL.value.trim()) ? hdnNL.value : ((hdnLI && hdnLI.value.trim()) ? hdnLI.value : '');
                if (logoSrcLoad) { var lpEl = document.getElementById('logoPreview'); if (lpEl && lpEl.innerHTML.trim() === '') lpEl.innerHTML = '<div style="margin-top:6px;display:inline-block"><img src="' + logoSrcLoad + '" style="height:80px;width:80px;object-fit:contain;border-radius:8px;border:2px solid var(--border);padding:4px;background:#fff;display:block;"></div>'; }
                var hdnCurStep = document.getElementById('<%= hdnCurrentStep.ClientID %>'), serverStep = hdnCurStep ? parseInt(hdnCurStep.value) : 1;
                if (serverStep > 1) goToStepDirect(serverStep);
                else { var descEl = document.getElementById('<%= txtDescription.ClientID %>'), descCount = document.getElementById('descCount'); if (descEl && descCount) descCount.textContent = descEl.value.length + '/300'; }
            });
        </script>

        <%-- MAP MODAL --%>
        <div id="mapModal" style="display: none; position: fixed; top: 5%; left: 5%; width: 90%; height: 85%; background: #fff; z-index: 9999; border-radius: 12px; padding: 12px; box-shadow: 0 8px 40px rgba(0,0,0,.3);">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px">
                <strong style="font-size: .9rem">Pick Project Location</strong>
                <button type="button" onclick="closeMapPicker()" class="btn btn-ghost btn-sm">Close X</button>
            </div>
            <div id="map" style="height: calc(100% - 50px); width: 100%; border-radius: 8px;"></div>
        </div>
        <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
        <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
        <script type="text/javascript">
            var _map, _marker;
            function openMapPicker() { document.getElementById('mapModal').style.display = 'block'; setTimeout(initLeafletMap, 300); }
            function closeMapPicker() { document.getElementById('mapModal').style.display = 'none'; }
            function initLeafletMap() {
                if (_map) { _map.invalidateSize(); return; }
                var lat = parseFloat(document.getElementById('<%= txtLatitude.ClientID %>').value) || 26.9124;
                var lng = parseFloat(document.getElementById('<%= txtLongitude.ClientID %>').value) || 75.7873;
                _map = L.map('map').setView([lat, lng], 13);
                L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', { attribution: '&copy; OpenStreetMap contributors' }).addTo(_map);
                if (navigator.geolocation) navigator.geolocation.getCurrentPosition(function (pos) { _map.setView([pos.coords.latitude, pos.coords.longitude], 15); });
                _map.on('click', function (e) {
                    var lt = e.latlng.lat.toFixed(6), ln = e.latlng.lng.toFixed(6);
                    if (_marker) _map.removeLayer(_marker);
                    _marker = L.marker([lt, ln]).addTo(_map).bindPopup('Selected Location').openPopup();
                    document.getElementById('<%= txtLatitude.ClientID %>').value = lt;
                    document.getElementById('<%= txtLongitude.ClientID %>').value = ln;
                    document.getElementById('<%= hdnLatitude.ClientID %>').value = lt;
                    document.getElementById('<%= hdnLongitude.ClientID %>').value = ln;
                    document.getElementById('<%= txtGoogleMaps.ClientID %>').value = 'https://www.google.com/maps?q=' + lt + ',' + ln;
                    setTimeout(closeMapPicker, 800);
                });
            }
        </script>

        <%-- PUBLISH SUCCESS MODAL --%>
        <div id="publishModal" style="display: none; position: fixed; inset: 0; z-index: 99999; background: rgba(0,0,0,.55); backdrop-filter: blur(4px); align-items: center; justify-content: center;">
            <div style="background: #fff; border-radius: 20px; padding: 40px 36px; max-width: 460px; width: 90%; text-align: center; box-shadow: 0 20px 60px rgba(0,0,0,.3); animation: popIn .35s ease;">
                <div id="pmIconWrap" style="width: 72px; height: 72px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 18px; font-size: 2rem; color: #fff;">
                    <i id="pmIcon" class="fa-solid fa-rocket"></i>
                </div>
                <div style="font-size: 1.4rem; font-weight: 800; color: var(--dark); margin-bottom: 6px" id="pmTitle">Project Published!</div>
                <div style="font-size: .82rem; color: var(--text-mid); margin-bottom: 18px" id="pmMsg">Project ab live hai.</div>
                <div style="background: #F8FAFC; border-radius: 10px; padding: 14px 18px; margin-bottom: 24px; text-align: left">
                    <div style="font-size: .7rem; color: var(--text-light); margin-bottom: 4px">PROJECT DETAILS</div>
                    <div style="font-weight: 700; font-size: .95rem; color: var(--dark)" id="pmProjName">-</div>
                    <div style="font-size: .75rem; color: var(--text-mid); margin-top: 3px">Code: <strong id="pmProjCode">-</strong>&nbsp;&nbsp;|&nbsp;&nbsp;Status: <strong id="pmStatus">-</strong></div>
                </div>
                <div style="display: flex; gap: 12px; justify-content: center">
                    <button type="button" onclick="closePublishModal(true)" class="btn btn-primary btn-lg" style="flex: 1"><i class="fa-solid fa-plus"></i>&nbsp; New Project</button>
                    <button type="button" onclick="closePublishModal(false)" class="btn btn-ghost btn-sm" style="padding: 10px 18px"><i class="fa-solid fa-list"></i>&nbsp; View List</button>
                </div>
            </div>
        </div>
        <style>
            @keyframes popIn {
                0% {
                    transform: scale(.8);
                    opacity: 0
                }

                100% {
                    transform: scale(1);
                    opacity: 1
                }
            }
        </style>
        <script>
            function showPublishSuccess(projName, projCode, modeLabel, modeIcon, modeColor, modeMsg) {
                var modal = document.getElementById('publishModal');
                document.getElementById('pmIconWrap').style.background = modeColor;
                document.getElementById('pmIcon').className = 'fa-solid ' + modeIcon;
                document.getElementById('pmTitle').textContent = modeLabel + ' Successfully!';
                document.getElementById('pmMsg').textContent = modeMsg;
                document.getElementById('pmProjName').textContent = projName || '-';
                document.getElementById('pmProjCode').textContent = projCode || '-';
                document.getElementById('pmStatus').textContent = modeLabel;
                document.getElementById('pmStatus').style.color = modeColor;
                modal.style.display = 'flex';
                setTimeout(function () { closePublishModal(false); }, 8000);
            }
            function closePublishModal(createNew) {
                document.getElementById('publishModal').style.display = 'none';
                if (createNew) window.location.href = 'ProjectCreate.aspx';
                else window.location.href = 'ProjectList.aspx';
            }
        </script>

    </form>
</body>
</html>
