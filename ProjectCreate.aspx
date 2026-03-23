<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProjectCreate.aspx.cs" Inherits="ProjectCreate" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Add New Project - Adarsh Realtors</title>
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

        .fa-check-done {
            color: var(--green);
        }

        /* ── VALIDATION STYLES ── */
        .field-error input, .field-error select, .field-error textarea {
            border-color: var(--red) !important;
            box-shadow: 0 0 0 3px rgba(220,38,38,0.12) !important;
            animation: shake 0.3s ease;
        }

        .field-error .input-suffix input, .field-error .input-prefix input {
            border-color: var(--red) !important;
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
                transform: translateX(0);
            }

            20% {
                transform: translateX(-6px);
            }

            60% {
                transform: translateX(6px);
            }
        }

        /* ── GALLERY STYLES ── */
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

        /* ── DOCUMENT SAVED BADGE ── */
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
        <%-- Cover aur Logo ka base64 — page reload ke baad preview restore karne ke liye --%>
        <asp:HiddenField ID="hdnNewCoverBase64" runat="server" />
        <asp:HiddenField ID="hdnNewLogoBase64" runat="server" />
        <asp:HiddenField ID="hdnDocsJSON" runat="server" />
        <%-- ▼ NEW: Current step server se set karega — postback ke baad sahi step pe land karo ▼ --%>
        <asp:HiddenField ID="hdnCurrentStep" runat="server" Value="1" />

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
                <span class="bc-hide">Dashboard</span>
                <span class="sep bc-hide">&rsaquo;</span>
                <span class="bc-hide">Projects</span>
                <span class="sep bc-hide">&rsaquo;</span>
                <span class="current">Add New Project</span>
            </div>
            <div class="header-actions">
                <asp:Button ID="btnSaveDraftTop" runat="server" Text="Save Draft"
                    CssClass="btn btn-ghost btn-sm" OnClick="btnSaveDraft_Click" />
                <button type="button" class="btn btn-primary btn-sm" onclick="goToStep(5)">Review</button>
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


            <%-- ══════════════ STEP 1 - BASIC INFORMATION ══════════════ --%>
            <div class="step-panel active" id="panel1">
                <div class="val-summary" id="valSummary1" style="display: none;">
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
                                <asp:TextBox ID="txtProjectName" runat="server"
                                    placeholder="e.g. Shiv Sarovar, Green Valley Heights" />
                            </div>
                            <div class="form-group">
                                <label>Project Code <span class="req">*</span> <span class="hint">(Auto-generated)</span></label>
                                <asp:TextBox ID="txtProjectCode" runat="server" placeholder="Auto-generated"
                                    ReadOnly="true"
                                    Style="background: #F4F6FA; color: var(--text-mid); cursor: not-allowed; font-weight: 600;" />
                            </div>
                            <div class="form-group">
                                <label>Developer / Builder Name <span class="req">*</span></label>
                                <asp:TextBox ID="txtDeveloperName" runat="server" Text="" />
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
                                <label>RERA Registration No. <span class="req">*</span></label>
                                <asp:TextBox ID="txtRERA" runat="server" placeholder="RAJ/P/2024/XXXXX" />
                            </div>
                            <div class="form-group full">
                                <label>Project Short Description <span class="req">*</span></label>
                                <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine"
                                    MaxLength="300" placeholder="Brief marketing description of the project"
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
                                <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine"
                                    placeholder="Complete postal address of the project site" Style="min-height: 66px" />
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
                                <asp:TextBox ID="txtLatitude" runat="server" placeholder="Pick on map"
                                    ReadOnly="true" Style="background: #F4F6FA; color: var(--text-mid); cursor: not-allowed;" />
                            </div>
                            <div class="form-group">
                                <label>Longitude <span class="hint">(Auto-filled from map)</span></label>
                                <asp:TextBox ID="txtLongitude" runat="server" placeholder="Pick on map"
                                    ReadOnly="true" Style="background: #F4F6FA; color: var(--text-mid); cursor: not-allowed;" />
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
                                <label>Launch Date</label>
                                <asp:TextBox ID="txtLaunchDate" runat="server" TextMode="Date" />
                            </div>
                            <div class="form-group">
                                <label>Construction Start</label>
                                <asp:TextBox ID="txtConstructionStart" runat="server" TextMode="Date" />
                            </div>
                            <div class="form-group">
                                <label>Expected Possession </label>
                                <asp:TextBox ID="txtPossessionDate" runat="server" TextMode="Date" />
                            </div>
                            <div class="form-group">
                                <label>Booking Open Date</label>
                                <asp:TextBox ID="txtBookingOpenDate" runat="server" TextMode="Date" />
                            </div>
                            <div class="form-group">
                                <label>Project Status <span class="req">*</span></label>
                                <asp:DropDownList ID="ddlStatus" runat="server" />
                            </div>
                            <div class="form-group">
                                <label>Approval Authority</label>
                                <asp:TextBox ID="txtApprovalAuthority" runat="server" placeholder="JDA / JDCA / UIT" />
                            </div>
                        </div>
                        <div style="margin-top: 14px">
                            <div class="info-box">
                                <i class="fa-solid fa-circle-info"></i>
                                &nbsp;Once published, customers will see the possession date on all booking communications. Please ensure accuracy.
                           
                            </div>
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
                                <label>Assigned Branch</label>
                                <asp:DropDownList ID="ddlBranch" runat="server" />
                            </div>
                            <div class="form-group">
                                <label>Project Manager</label>
                                <asp:TextBox ID="txtProjectManager" runat="server" placeholder="Assigned manager name" />
                            </div>
                            <div class="form-group">
                                <label>Sales Head</label>
                                <asp:TextBox ID="txtSalesHead" runat="server" placeholder="Sales manager name" />
                            </div>
                            <div class="form-group">
                                <label>Contact Number (Site)</label>
                                <asp:TextBox ID="txtSitePhone" runat="server" placeholder="+91 XXXXX XXXXX" />
                            </div>
                            <div class="form-group">
                                <label>Site Office Address</label>
                                <asp:TextBox ID="txtSiteAddress" runat="server" placeholder="On-site sales office location" />
                            </div>
                            <div class="form-group">
                                <label>Site Office Timings</label>
                                <asp:TextBox ID="txtSiteTimings" runat="server" placeholder="9:00 AM - 7:00 PM (Mon-Sat)" />
                            </div>
                        </div>
                    </div>
                </div>

                <div class="step-save-row">
                    <asp:Button ID="btnSaveStep1" runat="server" Text="Save &amp; Continue"
                        CssClass="btn btn-primary btn-lg" OnClick="btnSaveStep1_Click" />
                </div>
            </div>
            <%-- /panel1 --%>


            <%-- ══════════════ STEP 2 - CONFIGURATION ══════════════ --%>
            <div class="step-panel" id="panel2">
                <div class="val-summary" id="valSummary2" style="display: none;">
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
                        <div class="form-grid-3">
                            <div class="form-group">
                                <label>Total Land Area <span class="req">*</span></label>
                                <div class="input-suffix">
                                    <asp:TextBox ID="txtLandArea" runat="server" TextMode="Number" placeholder="0" />
                                    <span class="suffix-tag">Sq.Yd</span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Total Built-up Area</label>
                                <div class="input-suffix">
                                    <asp:TextBox ID="txtBuiltUp" runat="server" TextMode="Number" placeholder="0" />
                                    <span class="suffix-tag">Sq.Ft</span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>FAR / FSI Approved</label>
                                <asp:TextBox ID="txtFAR" runat="server" TextMode="Number" placeholder="1.5" />
                            </div>
                            <div class="form-group">
                                <label>Total Floors</label>
                                <asp:TextBox ID="txtTotalFloors" runat="server" TextMode="Number" placeholder="5" />
                            </div>
                            <div class="form-group">
                                <label>Units per Floor</label>
                                <asp:TextBox ID="txtUnitsPerFloor" runat="server" TextMode="Number" placeholder="4" />
                            </div>
                            <div class="form-group">
                                <label>Total Units <span class="req">*</span></label>
                                <asp:TextBox ID="txtTotalUnits" runat="server" TextMode="Number" placeholder="100"
                                    oninput="calcPricing()" />
                            </div>
                            <div class="form-group">
                                <label>Open / Green Area</label>
                                <div class="input-suffix">
                                    <asp:TextBox ID="txtGreenArea" runat="server" TextMode="Number" placeholder="0" />
                                    <span class="suffix-tag">%</span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Parking Type</label>
                                <asp:DropDownList ID="ddlParkingType" runat="server" />
                            </div>
                            <div class="form-group">
                                <label>No. of Towers / Blocks</label>
                                <asp:TextBox ID="txtNumBlocks" runat="server" TextMode="Number" placeholder="3"
                                    oninput="renderBlocks()" />
                            </div>
                        </div>
                    </div>
                </div>

                <div class="section-card">
                    <div class="section-head">
                        <div class="section-head-left">
                            <div class="section-icon si-blue"><i class="fa-solid fa-layer-group"></i></div>
                            <div>
                                <div class="section-title">Block / Tower Configuration</div>
                                <div class="section-desc">Configure each block with floors and units</div>
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
                                <div class="section-desc">Define BHK types, sizes and pricing</div>
                            </div>
                        </div>
                        <button type="button" class="btn btn-primary btn-sm" onclick="addUnitRow()">+ Add Type</button>
                    </div>
                    <div class="section-body">
                        <div class="unit-table-wrap">
                            <div class="unit-type-header">
                                <span>Type</span><span>Super (sq.ft)</span><span>Carpet (sq.ft)</span>
                                <span>Units</span><span>BSP (Rs/sqft)</span><span>PLC (Rs)</span>
                                <span>Total Price</span><span></span>
                            </div>
                            <div id="unitRowsContainer"></div>
                        </div>
                        <button type="button" class="btn btn-ghost btn-sm"
                            style="margin-top: 10px; width: 100%" onclick="addUnitRow()">
                            + Add Another Unit Type</button>

                        <div class="divider-label">Pricing Summary</div>
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px" class="pricing-cols">
                            <div class="form-grid">
                                <div class="form-group">
                                    <label>Base Selling Price (BSP) <span class="req">*</span></label>
                                    <div class="input-prefix">
                                        <span class="prefix-tag">Rs</span>
                                        <asp:TextBox ID="txtBSP" runat="server" TextMode="Number" placeholder="2430" oninput="calcPricing()" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>PLC - Preferred Location Charges</label>
                                    <div class="input-prefix">
                                        <span class="prefix-tag">Rs</span>
                                        <asp:TextBox ID="txtPLC" runat="server" TextMode="Number" placeholder="78000" oninput="calcPricing()" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>IFMS (Infrastructure Fund)</label>
                                    <div class="input-prefix">
                                        <span class="prefix-tag">Rs</span>
                                        <asp:TextBox ID="txtIFMS" runat="server" TextMode="Number" placeholder="25000" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>Club Membership</label>
                                    <div class="input-prefix">
                                        <span class="prefix-tag">Rs</span>
                                        <asp:TextBox ID="txtClubMembership" runat="server" TextMode="Number" placeholder="50000" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>Power Backup Charges</label>
                                    <div class="input-prefix">
                                        <span class="prefix-tag">Rs</span>
                                        <asp:TextBox ID="txtPowerBackup" runat="server" TextMode="Number" placeholder="30000" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>Maintenance Deposit</label>
                                    <div class="input-prefix">
                                        <span class="prefix-tag">Rs</span>
                                        <asp:TextBox ID="txtMaintDeposit" runat="server" TextMode="Number" placeholder="20000" />
                                    </div>
                                </div>
                            </div>
                            <div class="calc-box" id="calcBox">
                                <div class="calc-title">Price Calculation Preview</div>
                                <div class="calc-row"><span class="c-label">BSP (1510 sq.ft x Rs 2430)</span><span class="c-val" id="calcBSP">Rs 36,69,300</span></div>
                                <div class="calc-row"><span class="c-label">PLC Amount</span><span class="c-val" id="calcPLC">Rs 78,000</span></div>
                                <div class="calc-row"><span class="c-label">IFMS</span><span class="c-val">Rs 25,000</span></div>
                                <div class="calc-row"><span class="c-label">Club Membership</span><span class="c-val">Rs 50,000</span></div>
                                <div class="calc-row"><span class="c-label">Power Backup</span><span class="c-val">Rs 30,000</span></div>
                                <div class="calc-divider"></div>
                                <div class="calc-total">
                                    <span class="ct-label">Total Unit Price</span>
                                    <span class="ct-val" id="calcTotal">Rs 38.52L</span>
                                </div>
                            </div>
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
                                <asp:TextBox ID="txtBookingAmount" runat="server" TextMode="Number" placeholder="100000" />
                            </div>
                            <div class="form-group">
                                <label>On Agreement (%)</label>
                                <div class="input-suffix">
                                    <asp:TextBox ID="txtOnAgreement" runat="server" TextMode="Number" placeholder="10" />
                                    <span class="suffix-tag">%</span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>On Possession (%)</label>
                                <div class="input-suffix">
                                    <asp:TextBox ID="txtOnPossession" runat="server" TextMode="Number" placeholder="20" />
                                    <span class="suffix-tag">%</span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>No. of Installments</label>
                                <asp:TextBox ID="txtInstallments" runat="server" TextMode="Number" placeholder="12" />
                            </div>
                            <div class="form-group">
                                <label>GST Rate (%)</label>
                                <div class="input-suffix">
                                    <asp:TextBox ID="txtGST" runat="server" TextMode="Number" placeholder="5" />
                                    <span class="suffix-tag">%</span>
                                </div>
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
                                <label>Level 1 Commission</label>
                                <div class="input-suffix">
                                    <asp:TextBox ID="txtCommL1" runat="server" TextMode="Number" placeholder="2.5" />
                                    <span class="suffix-tag">%</span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Level 2 Commission</label>
                                <div class="input-suffix">
                                    <asp:TextBox ID="txtCommL2" runat="server" TextMode="Number" placeholder="1.5" />
                                    <span class="suffix-tag">%</span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Level 3 Commission</label>
                                <div class="input-suffix">
                                    <asp:TextBox ID="txtCommL3" runat="server" TextMode="Number" placeholder="0.5" />
                                    <span class="suffix-tag">%</span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Brokerage Commission</label>
                                <div class="input-suffix">
                                    <asp:TextBox ID="txtBrokerage" runat="server" TextMode="Number" placeholder="1.0" />
                                    <span class="suffix-tag">%</span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Commission Payout Trigger</label>
                                <asp:DropDownList ID="ddlCommPayout" runat="server" />
                            </div>
                            <div class="form-group">
                                <label>TDS on Commission</label>
                                <div class="input-suffix">
                                    <asp:TextBox ID="txtTDS" runat="server" TextMode="Number" placeholder="5" />
                                    <span class="suffix-tag">%</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="step-save-row">
                    <asp:Button ID="btnSaveStep2" runat="server" Text="Save &amp; Continue"
                        CssClass="btn btn-primary btn-lg" OnClick="btnSaveStep2_Click" />
                </div>
            </div>
            <%-- /panel2 --%>


            <%-- ══════════════ STEP 3 - AMENITIES ══════════════ --%>
            <div class="step-panel" id="panel3">
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
                                <label>Flooring</label>
                                <asp:DropDownList ID="ddlFlooring" runat="server" />
                            </div>
                            <div class="form-group">
                                <label>Kitchen Type</label>
                                <asp:DropDownList ID="ddlKitchen" runat="server" />
                            </div>
                            <div class="form-group">
                                <label>Bathroom Fixtures</label>
                                <asp:DropDownList ID="ddlBathroom" runat="server" />
                            </div>
                            <div class="form-group">
                                <label>Window Type</label>
                                <asp:DropDownList ID="ddlWindowType" runat="server" />
                            </div>
                            <div class="form-group full">
                                <label>Special Features / USP</label>
                                <asp:TextBox ID="txtSpecialFeatures" runat="server" TextMode="MultiLine"
                                    placeholder="Unique selling points, smart home features, vastu compliance" />
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
                    <asp:Button ID="btnSaveStep3" runat="server" Text="Save &amp; Continue"
                        CssClass="btn btn-primary btn-lg" OnClick="btnSaveStep3_Click" />
                </div>
            </div>
            <%-- /panel3 --%>


            <%-- ══════════════ STEP 4 - MEDIA & DOCUMENTS ══════════════ --%>
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
                        <input type="file" id="realGalleryInput" multiple accept="image/*"
                            style="display: none" onchange="handleGalleryFiles(this.files)" />
                        <asp:FileUpload ID="fuGallery" runat="server" AllowMultiple="true" accept="image/*" Style="display: none" />
                        <div id="galleryPreviewGrid" style="display: grid; grid-template-columns: repeat(auto-fill,minmax(120px,1fr)); gap: 10px; margin-top: 14px;"></div>
                        <div class="form-grid" style="margin-top: 14px">
                            <div class="form-group">
                                <label>Cover / Hero Image</label>
                                <asp:FileUpload ID="fuCoverImage" runat="server" accept="image/*"
                                    onchange="previewSingleImage(this,'coverPreview')" />
                                <div id="coverPreview" style="margin-top: 6px"></div>
                            </div>
                            <div class="form-group">
                                <label>Project Logo / Badge</label>
                                <asp:FileUpload ID="fuProjectLogo" runat="server" accept="image/*"
                                    onchange="previewSingleImage(this,'logoPreview')" />
                                <div id="logoPreview" style="margin-top: 6px"></div>
                            </div>
                            <div class="form-group">
                                <label>3D Render / Walkthrough Video URL</label>
                                <asp:TextBox ID="txtVideoURL" runat="server" placeholder="https://youtube.com/..." />
                            </div>
                            <div class="form-group">
                                <label>Virtual Tour Link</label>
                                <asp:TextBox ID="txtVirtualTour" runat="server" placeholder="https://..." />
                            </div>
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
                    <asp:Button ID="btnSaveStep4" runat="server" Text="Save &amp; Continue"
                        CssClass="btn btn-primary btn-lg" OnClick="btnSaveStep4_Click" />
                </div>
            </div>
            <%-- /panel4 --%>


            <%-- ══════════════ STEP 5 - REVIEW & PUBLISH ══════════════ --%>
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
                                <label>Total Units</label><span id="rv-units" class="highlight">-</span></div>
                            <div class="review-item">
                                <label>Total Floors</label><span id="rv-floors">-</span></div>
                            <div class="review-item">
                                <label>No. of Blocks</label><span id="rv-blocks">-</span></div>
                            <div class="review-item">
                                <label>Parking Type</label><span id="rv-parking">-</span></div>
                            <div class="review-item">
                                <label>BSP Rate</label><span id="rv-bsp">-</span></div>
                            <div class="review-item">
                                <label>PLC Amount</label><span id="rv-plc">-</span></div>
                            <div class="review-item">
                                <label>IFMS</label><span id="rv-ifms">-</span></div>
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
                        <div style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 12px; margin-bottom: 16px; display: none;" class="review-publish-grid">
                            <div style="padding: 14px; border: 2px solid var(--orange); background: var(--orange-pale); border-radius: 10px; cursor: pointer; text-align: center"
                                onclick="selectPublishMode(this,'draft')" id="pm-draft">
                                <i class="fa-solid fa-file-pen" style="font-size: 1.4rem; margin-bottom: 5px; display: block"></i>
                                <div style="font-weight: 700; font-size: .83rem">Save as Draft</div>
                                <div style="font-size: .68rem; color: var(--text-mid); margin-top: 3px">Not visible to public</div>
                            </div>
                            <div style="padding: 14px; border: 2px solid var(--border); border-radius: 10px; cursor: pointer; text-align: center"
                                onclick="selectPublishMode(this,'active')" id="pm-active">
                                <i class="fa-solid fa-rocket" style="font-size: 1.4rem; margin-bottom: 5px; display: block"></i>
                                <div style="font-weight: 700; font-size: .83rem">Publish Now</div>
                                <div style="font-size: .68rem; color: var(--text-mid); margin-top: 3px">Live for bookings</div>
                            </div>
                            <div style="padding: 14px; border: 2px solid var(--border); border-radius: 10px; cursor: pointer; text-align: center"
                                onclick="selectPublishMode(this,'upcoming')" id="pm-upcoming">
                                <i class="fa-solid fa-calendar-check" style="font-size: 1.4rem; margin-bottom: 5px; display: block"></i>
                                <div style="font-weight: 700; font-size: .83rem">Schedule Launch</div>
                                <div style="font-size: .68rem; color: var(--text-mid); margin-top: 3px">Set future date</div>
                            </div>
                        </div>
                        <div class="warning-box">
                            <i class="fa-solid fa-triangle-exclamation"></i>
                            &nbsp;Once published, the project becomes visible to all agents and customers. Ensure all details are accurate before publishing.
                       
                        </div>
                        <asp:Button ID="btnPublish" runat="server" Text="Publish Project"
                            CssClass="btn btn-primary btn-lg" OnClick="btnPublish_Click"
                            Style="display: none" />
                    </div>
                </div>

            </div>
            <%-- /panel5 --%>


            <%-- FOOTER ACTIONS --%>
            <div class="footer-actions">
                <div class="footer-left">
                    <asp:Button ID="prevBtn" runat="server" Text="Back"
                        CssClass="btn btn-ghost btn-sm"
                        OnClick="btnGoBack_Click"
                        OnClientClick="return prepareBackNav();"
                        Style="display: none" />
                    <asp:Button ID="btnSaveDraft" runat="server" Text="Save Draft"
                        CssClass="btn btn-ghost btn-sm" OnClick="btnSaveDraft_Click" Visible="false" />
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
        <%-- /page-wrap --%>

        <div class="toast" id="toast">
            <i id="toastIcon" class="fa-solid fa-check"></i>
            <span id="toastMsg">Saved successfully</span>
        </div>

        <script>
            // ══════════════════════════════════════════════
            //  STATE VARIABLES — server ke baad update hote hain
            // ══════════════════════════════════════════════
            var currentStep = 1;
            var totalSteps = 5;
            var lastSavedStep = 0;
            var currentProjectID = 0;
            var stepsCompleted = [false, false, false, false, false];

            var stepLabels = [
                'Step 1 of 5 - Basic Information',
                'Step 2 of 5 - Configuration',
                'Step 3 of 5 - Amenities & Features',
                'Step 4 of 5 - Media & Documents',
                'Step 5 of 5 - Review & Publish'
            ];
            var nextBtnLabels = ['Continue', 'Continue', 'Continue', 'Review & Publish', 'Publish Project'];

            // ══════════════════════════════════════════════
            //  ▼ KEY FIX: DDL safe value reader
            //  "--Select--" wali items ko blank return karo
            // ══════════════════════════════════════════════
            function v(id) {
                var el = document.getElementById(id);
                if (!el) return '';
                return (el.value || '').trim();
            }
            function t(id) {
                var el = document.getElementById(id);
                if (!el || !el.options || el.selectedIndex < 0) return '';
                var txt = el.options[el.selectedIndex].text || '';
                // "--Select..." wali options ko blank treat karo
                if (txt.indexOf('--') === 0) return '';
                return txt.trim();
            }
            function set(id, val) {
                var el = document.getElementById(id);
                if (!el) return;
                el.textContent = (val && val.toString().trim() && val !== '--') ? val : '-';
            }

            // ══════════════════════════════════════════════
            //  ▼ KEY FIX: syncReadOnlyToHidden
            //  ReadOnly textboxes postback pe value nahi bhejte
            //  yeh function hidden fields mein sync karta hai
            // ══════════════════════════════════════════════
            function syncReadOnlyToHidden() {
                var codeBox = document.getElementById('<%= txtProjectCode.ClientID %>');
                var hdnCode = document.getElementById('<%= hdnProjectCode.ClientID %>');
                if (codeBox && hdnCode && codeBox.value.trim()) {
                    hdnCode.value = codeBox.value.trim();
                }
                var latBox = document.getElementById('<%= txtLatitude.ClientID %>');
                var hdnLat = document.getElementById('<%= hdnLatitude.ClientID %>');
                if (latBox && hdnLat && latBox.value.trim()) {
                    hdnLat.value = latBox.value.trim();
                }
                var lngBox = document.getElementById('<%= txtLongitude.ClientID %>');
                var hdnLng = document.getElementById('<%= hdnLongitude.ClientID %>');
                if (lngBox && hdnLng && lngBox.value.trim()) {
                    hdnLng.value = lngBox.value.trim();
                }
            }

            // ══════════════════════════════════════════════
            //  VALIDATION ENGINE
            // ══════════════════════════════════════════════
            function validateStep(step) {
                clearAllErrors(step);
                var errors = [];
                if (step === 1) {
                    // ── Sirf * wale fields validate hote hain ──
                    chkReq('<%= txtProjectName.ClientID %>', 'Project Name', errors);
                    chkReq('<%= txtProjectCode.ClientID %>', 'Project Code', errors);
                    chkReq('<%= txtDeveloperName.ClientID %>', 'Developer Name', errors);
                    chkDDL('<%= ddlProjectType.ClientID %>', 'Project Type', errors);
                    chkDDL('<%= ddlCategory.ClientID %>', 'Project Category', errors);
                    chkReq('<%= txtRERA.ClientID %>', 'RERA Registration No.', errors);
                    chkReq('<%= txtDescription.ClientID %>', 'Project Short Description', errors);
                    chkReq('<%= txtAddress.ClientID %>', 'Full Project Address', errors);
                    chkReq('<%= txtCity.ClientID %>', 'City / Town', errors);
                    chkReq('<%= txtDistrict.ClientID %>', 'District', errors);
                    chkDDL('<%= ddlState.ClientID %>', 'State', errors);
                    chkReq('<%= txtPinCode.ClientID %>', 'Pin Code', errors);
                   <%-- chkReq('<%= txtLaunchDate.ClientID %>', 'Launch Date', errors);
                    chkReq('<%= txtPossessionDate.ClientID %>', 'Expected Possession Date', errors);--%>
                    chkDDL('<%= ddlStatus.ClientID %>', 'Project Status', errors);
                    // txtKhasra — optional, validate nahi
                    // ddlBranch  — optional, validate nahi
                }
                if (step === 2) {
                    chkReq('<%= txtLandArea.ClientID %>', 'Total Land Area', errors);
                    chkReq('<%= txtTotalUnits.ClientID %>', 'Total Units', errors);
                    chkReq('<%= txtBSP.ClientID %>', 'Base Selling Price (BSP)', errors);
                    chkReq('<%= txtBookingAmount.ClientID %>', 'Booking Amount', errors);
                    chkDDL('<%= ddlPaymentPlan.ClientID %>', 'Payment Plan Type', errors);
                }
                if (step === 3) {
                    var amenityVal = document.getElementById('<%= hdnAmenityIDs.ClientID %>').value;
                    if (!amenityVal || amenityVal.trim() === '') {
                        errors.push('Please select at least 1 Amenity');
                        var grids = document.querySelectorAll('#panel3 .amenity-grid');
                        for (var g = 0; g < grids.length; g++) grids[g].style.outline = '2px solid var(--red)';
                    }
                }
                // Step 4 — koi required validation nahi
                if (errors.length > 0) { showValSummary(step, errors); return false; }
                hideValSummary(step);
                return true;
            }

            function chkReq(cid, label, errors) {
                var el = document.getElementById(cid);
                if (!el) return;
                if (!el.value || el.value.trim() === '') { errors.push(label + ' is required'); markFieldError(el); }
                else clearFieldError(el);
            }
            function chkDDL(cid, label, errors) {
                var el = document.getElementById(cid);
                if (!el) return;
                if (!el.value || el.value === '0' || el.value === '') { errors.push(label + ' is required'); markFieldError(el); }
                else clearFieldError(el);
            }
            function markFieldError(el) {
                var grp = el.parentElement;
                while (grp && !grp.classList.contains('form-group')) grp = grp.parentElement;
                if (!grp) return;
                grp.classList.add('field-error');
                if (!grp.querySelector('.error-msg')) {
                    var msg = document.createElement('span');
                    msg.className = 'error-msg';
                    msg.innerHTML = '<i class="fa-solid fa-circle-exclamation"></i> This field is required';
                    grp.appendChild(msg);
                }
            }
            function clearFieldError(el) {
                var grp = el.parentElement;
                while (grp && !grp.classList.contains('form-group')) grp = grp.parentElement;
                if (!grp) return;
                grp.classList.remove('field-error');
                var msg = grp.querySelector('.error-msg');
                if (msg) msg.remove();
            }
            function clearAllErrors(step) {
                var panel = document.getElementById('panel' + step);
                if (!panel) return;
                var errs = panel.querySelectorAll('.field-error');
                for (var i = 0; i < errs.length; i++) {
                    errs[i].classList.remove('field-error');
                    var m = errs[i].querySelector('.error-msg');
                    if (m) m.remove();
                }
                var grids = panel.querySelectorAll('.amenity-grid');
                for (var i = 0; i < grids.length; i++) grids[i].style.outline = '';
                var docs = panel.querySelectorAll('.doc-upload-item');
                for (var i = 0; i < docs.length; i++) docs[i].style.border = '';
                hideValSummary(step);
            }
            function showValSummary(step, errors) {
                var box = document.getElementById('valSummary' + step);
                var list = document.getElementById('valList' + step);
                if (!box || !list) return;
                list.innerHTML = '';
                for (var i = 0; i < errors.length; i++) {
                    var li = document.createElement('li');
                    li.textContent = errors[i];
                    list.appendChild(li);
                }
                box.classList.add('show');
            }
            function hideValSummary(step) {
                var box = document.getElementById('valSummary' + step);
                if (box) box.classList.remove('show');
            }

            document.addEventListener('input', function (e) {
                if (e.target.value && e.target.value.trim()) clearFieldError(e.target);
            });
            document.addEventListener('change', function (e) {
                var el = e.target;
                if (el.tagName === 'SELECT' && el.value && el.value !== '0') clearFieldError(el);
                if (el.closest && el.closest('.amenity-item')) {
                    var grids = document.querySelectorAll('.amenity-grid');
                    for (var i = 0; i < grids.length; i++) grids[i].style.outline = '';
                }
            });

            // ══════════════════════════════════════════════
            //  AUTO-GENERATE PROJECT CODE
            // ══════════════════════════════════════════════
            function autoSuggestCode(el) {
                var codeBox = document.getElementById('<%= txtProjectCode.ClientID %>');
                var hdnCode = document.getElementById('<%= hdnProjectCode.ClientID %>');
                if (!codeBox) return;
                var words = el.value.trim().split(/\s+/);
                var initials = words.map(function (w) { return w[0] || ''; }).join('').toUpperCase().substring(0, 3);
                if (!initials) { codeBox.value = ''; if (hdnCode) hdnCode.value = ''; return; }
                var year = new Date().getFullYear();
                var rand = Math.floor(1000 + Math.random() * 9000);
                var code = initials + '-' + year + '-' + rand;
                codeBox.value = code;
                if (hdnCode) hdnCode.value = code;
            }

            // ══════════════════════════════════════════════
            //  BLOCKS
            // ══════════════════════════════════════════════
            var blockCount = 1;
            function renderBlocks() {
                var n = parseInt(document.getElementById('<%= txtNumBlocks.ClientID %>').value) || 1;
                blockCount = n;
                var existingJson = document.getElementById('<%= hdnBlocksJSON.ClientID %>').value;
                var existingBlocks = [];
                try { if (existingJson && existingJson !== '[]') existingBlocks = JSON.parse(existingJson); } catch (e) { }
                var names = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];
                var grid = document.getElementById('blocksGrid');
                if (!grid) return;
                grid.innerHTML = '';
                for (var i = 0; i < n; i++) {
                    var b = existingBlocks[i] || {};
                    var bName = b.BlockName || ('Block ' + (names[i] || (i + 1)));
                    var floors = b.Floors || 5;
                    var upf = b.UPF || 4;
                    var cat = b.Category || 'Standard';
                    var html = '<div class="block-card" id="block' + i + '">';
                    html += '<div class="block-card-head"><span class="block-name">' + bName + '</span>';
                    html += '<button type="button" onclick="removeBlock(' + i + ')" style="background:rgba(255,255,255,.15);border:none;color:#fff;border-radius:4px;width:22px;height:22px;cursor:pointer;font-size:.72rem">X</button></div>';
                    html += '<div class="block-card-body">';
                    html += '<div class="form-group"><label>Block Name</label><input type="text" value="' + bName + '" onchange="syncBlocksHidden()"></div>';
                    html += '<div class="form-group"><label>No. of Floors</label><input type="number" value="' + floors + '" onchange="syncBlocksHidden();updateBlockTotal(this)"></div>';
                    html += '<div class="form-group"><label>Units per Floor</label><input type="number" value="' + upf + '" onchange="syncBlocksHidden();updateBlockTotal(this)"></div>';
                    html += '<div class="form-group"><label>Total Units</label><input type="number" value="' + (floors * upf) + '" readonly style="background:#F9FAFB;font-weight:600"></div>';
                    html += '<div class="form-group"><label>Category</label><select onchange="syncBlocksHidden()">';
                    html += '<option' + (cat === 'Standard' ? ' selected' : '') + '>Standard</option>';
                    html += '<option' + (cat === 'Premium' ? ' selected' : '') + '>Premium</option>';
                    html += '<option' + (cat === 'Economy' ? ' selected' : '') + '>Economy</option>';
                    html += '</select></div></div></div>';
                    grid.innerHTML += html;
                }
                grid.innerHTML += '<div class="add-block-card" onclick="addBlock()"><span class="add-block-icon">+</span><span>Add Block</span></div>';
                syncBlocksHidden();
            }
            function buildBlocksGrid(n) {
                document.getElementById('<%= hdnBlocksJSON.ClientID %>').value = '[]';
                document.getElementById('<%= txtNumBlocks.ClientID %>').value = n;
                blockCount = n;
                renderBlocks();
            }
            function updateBlockTotal(input) {
                var card = input.closest ? input.closest('.block-card') : null;
                if (!card) return;
                var inputs = card.querySelectorAll('input');
                if (inputs.length >= 4) {
                    var f = parseInt(inputs[1].value) || 0;
                    var u = parseInt(inputs[2].value) || 0;
                    inputs[3].value = f * u;
                }
            }
            function syncBlocksHidden() {
                var blocks = [];
                var cards = document.querySelectorAll('.block-card');
                for (var i = 0; i < cards.length; i++) {
                    var inputs = cards[i].querySelectorAll('input');
                    var sel = cards[i].querySelector('select');
                    if (inputs.length >= 4)
                        blocks.push({ BlockName: inputs[0].value, Floors: parseInt(inputs[1].value) || 0, UPF: parseInt(inputs[2].value) || 0, Category: sel ? sel.value : 'Standard' });
                }
                document.getElementById('<%= hdnBlocksJSON.ClientID %>').value = JSON.stringify(blocks);
            }
            function addBlock() {
                blockCount++;
                document.getElementById('<%= txtNumBlocks.ClientID %>').value = blockCount;
                var hdn = document.getElementById('<%= hdnBlocksJSON.ClientID %>');
                var blocks = [];
                try { if (hdn.value && hdn.value !== '[]') blocks = JSON.parse(hdn.value); } catch (e) { }
                var names = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];
                blocks.push({ BlockName: 'Block ' + (names[blockCount - 1] || blockCount), Floors: 5, UPF: 4, Category: 'Standard' });
                hdn.value = JSON.stringify(blocks);
                renderBlocks();
                showToast('Block added', 'info');
            }
            function removeBlock(idx) {
                var hdn = document.getElementById('<%= hdnBlocksJSON.ClientID %>');
                var blocks = [];
                try { if (hdn.value && hdn.value !== '[]') blocks = JSON.parse(hdn.value); } catch (e) { }
                if (blocks.length > 1) { blocks.splice(idx, 1); blockCount = blocks.length; } else { blockCount = 1; }
                hdn.value = JSON.stringify(blocks);
                document.getElementById('<%= txtNumBlocks.ClientID %>').value = blockCount;
                renderBlocks();
                showToast('Block removed', 'info');
            }

            // ══════════════════════════════════════════════
            //  UNIT ROWS
            // ══════════════════════════════════════════════
            var unitRowCount = 0;
            var unitDefaults = [
                { typeID: 2, area: 1070, carpet: 890, count: 40 },
                { typeID: 3, area: 1510, carpet: 1250, count: 60 }
            ];
            function addUnitRow(d) {
                unitRowCount++;
                var bsp = parseInt(document.getElementById('<%= txtBSP.ClientID %>').value) || 2430;
                var plc = parseInt(document.getElementById('<%= txtPLC.ClientID %>').value) || 78000;
                var area = d ? d.area : 0;
                var total = d ? Math.round((area * bsp + plc) / 100000 * 100) / 100 : 0;
                var row = document.createElement('div');
                row.className = 'unit-row'; row.id = 'unitRow' + unitRowCount;
                row.innerHTML =
                    '<select onchange="syncUnitTypesHidden()" style="padding:6px 7px;font-size:.76rem">' +
                    '<option value="1">1 BHK</option>' +
                    '<option value="2"' + (d && d.typeID === 2 ? ' selected' : '') + '>2 BHK</option>' +
                    '<option value="3"' + (d && d.typeID === 3 ? ' selected' : '') + '>3 BHK</option>' +
                    '<option value="4">4 BHK</option><option value="5">Penthouse</option><option value="6">Studio</option></select>' +
                    '<input type="number" placeholder="sq.ft" value="' + (d ? d.area : '') + '" onchange="syncUnitTypesHidden()" style="padding:6px;font-size:.78rem">' +
                    '<input type="number" placeholder="sq.ft" value="' + (d ? d.carpet : '') + '" onchange="syncUnitTypesHidden()" style="padding:6px;font-size:.78rem">' +
                    '<input type="number" placeholder="0" value="' + (d ? d.count : '') + '" onchange="syncUnitTypesHidden()" style="padding:6px;font-size:.78rem">' +
                    '<input type="number" placeholder="Rs/sqft" value="' + bsp + '" onchange="syncUnitTypesHidden()" style="padding:6px;font-size:.78rem">' +
                    '<input type="number" placeholder="Rs" value="' + plc + '" onchange="syncUnitTypesHidden()" style="padding:6px;font-size:.78rem">' +
                    '<input type="text" value="' + (d ? 'Rs ' + total + 'L' : '') + '" readonly style="padding:6px;font-size:.78rem;background:#F9FAFB;font-weight:600;color:var(--orange)">' +
                    '<button type="button" onclick="document.getElementById(\'unitRow' + unitRowCount + '\').remove();syncUnitTypesHidden()" style="width:34px;height:34px;border-radius:6px;background:var(--red-pale);border:none;cursor:pointer;color:var(--red)">X</button>';
                document.getElementById('unitRowsContainer').appendChild(row);
                syncUnitTypesHidden();
            }
            function syncUnitTypesHidden() {
                var units = [];
                var rows = document.querySelectorAll('.unit-row');
                for (var i = 0; i < rows.length; i++) {
                    var sel = rows[i].querySelector('select');
                    var inputs = rows[i].querySelectorAll('input');
                    if (sel && inputs.length >= 5)
                        units.push({ UnitTypeID: parseInt(sel.value), Super: parseFloat(inputs[0].value) || 0, Carpet: parseFloat(inputs[1].value) || 0, Count: parseInt(inputs[2].value) || 0, BSP: parseFloat(inputs[3].value) || 0, PLC: parseFloat(inputs[4].value) || 0 });
                }
                document.getElementById('<%= hdnUnitTypesJSON.ClientID %>').value = JSON.stringify(units);
            }

            // ══════════════════════════════════════════════
            //  AMENITIES
            // ══════════════════════════════════════════════
            function toggleAmenity(el) {
                el.classList.toggle('selected');
                var items = document.querySelectorAll('.amenity-item.selected');
                var ids = [];
                for (var i = 0; i < items.length; i++) if (items[i].dataset.amenityid) ids.push(items[i].dataset.amenityid);
                document.getElementById('<%= hdnAmenityIDs.ClientID %>').value = ids.join(',');
                document.getElementById('amenityCount').textContent = ids.length + ' selected';
            }
            (function preSelectAmenities() {
                var saved = document.getElementById('<%= hdnAmenityIDs.ClientID %>').value;
                if (!saved) return;
                var ids = saved.split(',');
                for (var i = 0; i < ids.length; i++) {
                    var el = document.querySelector('.amenity-item[data-amenityid="' + ids[i] + '"]');
                    if (el) el.classList.add('selected');
                }
                document.getElementById('amenityCount').textContent = document.querySelectorAll('.amenity-item.selected').length + ' selected';
            })();

            // ══════════════════════════════════════════════
            //  BANK PILLS
            // ══════════════════════════════════════════════
            function toggleBankPill(el) {
                el.classList.toggle('checked');
                var pills = document.querySelectorAll('.check-pill.checked');
                var ids = [];
                for (var i = 0; i < pills.length; i++) if (pills[i].dataset.bankid) ids.push(pills[i].dataset.bankid);
                document.getElementById('<%= hdnBankIDs.ClientID %>').value = ids.join(',');
            }
            (function preSelectBanks() {
                var saved = document.getElementById('<%= hdnBankIDs.ClientID %>').value;
                if (!saved) return;
                var ids = saved.split(',');
                for (var i = 0; i < ids.length; i++) {
                    var el = document.querySelector('.check-pill[data-bankid="' + ids[i] + '"]');
                    if (el) el.classList.add('checked');
                }
            })();

            // ══════════════════════════════════════════════
            //  PRICING CALC
            // ══════════════════════════════════════════════
            function calcPricing() {
                var bsp = parseInt(document.getElementById('<%= txtBSP.ClientID %>').value) || 2430;
                var plc = parseInt(document.getElementById('<%= txtPLC.ClientID %>').value) || 78000;
                var bspAmt = 1510 * bsp;
                var total = bspAmt + plc + 25000 + 50000 + 30000;
                document.getElementById('calcBSP').textContent = 'Rs ' + bspAmt.toLocaleString('en-IN');
                document.getElementById('calcPLC').textContent = 'Rs ' + plc.toLocaleString('en-IN');
                document.getElementById('calcTotal').textContent = 'Rs ' + (total / 100000).toFixed(2) + 'L';
            }

            // ══════════════════════════════════════════════
            //  ▼ COMPLETE FIX: updateReview()
            //  Pehle ReadOnly sync, phir sab fields fill
            // ══════════════════════════════════════════════
            function updateReview() {
                // Step 1: ReadOnly hidden fields sync karo
                syncReadOnlyToHidden();

                // Step 1 fields
                set('rv-name', v('<%= txtProjectName.ClientID %>'));

                // Project Code — hidden field pehle check karo, phir readonly textbox
                var codeVal = v('<%= hdnProjectCode.ClientID %>');
                if (!codeVal) codeVal = v('<%= txtProjectCode.ClientID %>');
                set('rv-code', codeVal);

                set('rv-developer', v('<%= txtDeveloperName.ClientID %>'));

                // Dropdowns — "--Select--" ko blank treat karo (t() already handle karta hai)
                set('rv-type', t('<%= ddlProjectType.ClientID %>'));
                set('rv-category', t('<%= ddlCategory.ClientID %>'));
                set('rv-rera', v('<%= txtRERA.ClientID %>'));
                set('rv-status', t('<%= ddlStatus.ClientID %>'));
                set('rv-city', v('<%= txtCity.ClientID %>'));
                set('rv-state', t('<%= ddlState.ClientID %>'));
                set('rv-pincode', v('<%= txtPinCode.ClientID %>'));
                set('rv-launch', v('<%= txtLaunchDate.ClientID %>'));
                set('rv-possession', v('<%= txtPossessionDate.ClientID %>'));
                set('rv-branch', t('<%= ddlBranch.ClientID %>'));
                set('rv-manager', v('<%= txtProjectManager.ClientID %>'));
                set('rv-address', v('<%= txtAddress.ClientID %>'));
                set('rv-desc', v('<%= txtDescription.ClientID %>'));

                // Step 2 fields
                var land = v('<%= txtLandArea.ClientID %>');
                set('rv-land', land ? land + ' Sq.Yd' : '');
                set('rv-units', v('<%= txtTotalUnits.ClientID %>'));
                set('rv-floors', v('<%= txtTotalFloors.ClientID %>'));
                set('rv-blocks', v('<%= txtNumBlocks.ClientID %>'));
                set('rv-parking', t('<%= ddlParkingType.ClientID %>'));

                var bspVal = v('<%= txtBSP.ClientID %>');
                set('rv-bsp', bspVal ? 'Rs ' + parseInt(bspVal).toLocaleString('en-IN') + '/sq.ft' : '');

                var plcVal = v('<%= txtPLC.ClientID %>');
                set('rv-plc', plcVal ? 'Rs ' + parseInt(plcVal).toLocaleString('en-IN') : '');

                var ifmsVal = v('<%= txtIFMS.ClientID %>');
                set('rv-ifms', ifmsVal ? 'Rs ' + parseInt(ifmsVal).toLocaleString('en-IN') : '');

                var bookingVal = v('<%= txtBookingAmount.ClientID %>');
                set('rv-booking', bookingVal ? 'Rs ' + parseInt(bookingVal).toLocaleString('en-IN') : '');

                set('rv-payplan', t('<%= ddlPaymentPlan.ClientID %>'));

                var gstVal = v('<%= txtGST.ClientID %>');
                set('rv-gst', gstVal ? gstVal + '%' : '');

                var comm1Val = v('<%= txtCommL1.ClientID %>');
                set('rv-comm1', comm1Val ? comm1Val + '%' : '');

                // Step 3 — Amenities chips
                var amenList = document.getElementById('rv-amenities-list');
                if (amenList) {
                    amenList.innerHTML = '';
                    var amenItems = document.querySelectorAll('.amenity-item.selected');
                    if (amenItems.length > 0) {
                        for (var i = 0; i < amenItems.length; i++) {
                            var lbl = amenItems[i].querySelector('.a-label');
                            if (lbl) {
                                var chip = document.createElement('span');
                                chip.style.cssText = 'background:var(--orange-pale);color:var(--orange);border:1px solid #FED7AA;border-radius:20px;padding:3px 10px;font-size:.7rem;font-weight:600;white-space:nowrap';
                                chip.textContent = lbl.textContent;
                                amenList.appendChild(chip);
                            }
                        }
                    } else {
                        amenList.innerHTML = '<span style="color:var(--text-light);font-size:.75rem;font-style:italic">No amenities selected</span>';
                    }
                }
                set('rv-flooring', t('<%= ddlFlooring.ClientID %>'));
                set('rv-kitchen', t('<%= ddlKitchen.ClientID %>'));
                set('rv-bathroom', t('<%= ddlBathroom.ClientID %>'));
                set('rv-windows', t('<%= ddlWindowType.ClientID %>'));

                // Step 4 — Gallery thumbnails
                var galleryMini = document.getElementById('rv-gallery-mini');
                if (galleryMini) {
                    galleryMini.innerHTML = '';
                    if (galleryImages && galleryImages.length > 0) {
                        var show = Math.min(galleryImages.length, 10);
                        for (var j = 0; j < show; j++) {
                            var img = document.createElement('img');
                            img.src = galleryImages[j].dataURL;
                            img.title = galleryImages[j].name || '';
                            img.style.cssText = 'width:56px;height:56px;object-fit:cover;border-radius:6px;border:2px solid ' + (galleryImages[j].isCover ? 'var(--orange)' : 'var(--border)');
                            galleryMini.appendChild(img);
                        }
                        if (galleryImages.length > 10) {
                            var more = document.createElement('div');
                            more.style.cssText = 'width:56px;height:56px;border-radius:6px;background:#F1F5F9;display:flex;align-items:center;justify-content:center;font-size:.75rem;font-weight:700;color:var(--text-mid)';
                            more.textContent = '+' + (galleryImages.length - 10);
                            galleryMini.appendChild(more);
                        }
                    } else {
                        galleryMini.innerHTML = '<span style="color:var(--text-light);font-size:.75rem;font-style:italic">No gallery images</span>';
                    }
                }
                set('rv-video', v('<%= txtVideoURL.ClientID %>'));
                set('rv-tour', v('<%= txtVirtualTour.ClientID %>'));

                var docsJson = document.getElementById('<%= hdnDocsJSON.ClientID %>').value;
                var docCount = 0;
                try { if (docsJson) docCount = JSON.parse(docsJson).length; } catch (e) { }
                set('rv-docs', docCount > 0 ? docCount + ' document(s) uploaded' : 'No documents yet');
            }

            // ══════════════════════════════════════════════
            //  PUBLISH MODE
            // ══════════════════════════════════════════════
            function selectPublishMode(el, mode) {
                var ids = ['pm-active', 'pm-draft', 'pm-upcoming'];
                for (var i = 0; i < ids.length; i++) {
                    var p = document.getElementById(ids[i]);
                    if (p) { p.style.borderColor = 'var(--border)'; p.style.background = '#fff'; }
                }
                el.style.borderColor = 'var(--orange)';
                el.style.background = 'var(--orange-pale)';
                document.getElementById('<%= hdnPublishMode.ClientID %>').value = mode;
                var labels = { draft: 'Draft', active: 'Live', upcoming: 'Scheduled' };
                var classes = { draft: 'pill-draft', active: 'pill-active', upcoming: 'pill-upcoming' };
                document.getElementById('reviewStatusPill').innerHTML = '<span class="status-pill ' + classes[mode] + '">' + labels[mode] + '</span>';
            }

            // ══════════════════════════════════════════════
            //  TOAST
            // ══════════════════════════════════════════════
            function showToast(msg, type) {
                var t = document.getElementById('toast');
                var icon = document.getElementById('toastIcon');
                document.getElementById('toastMsg').textContent = msg;
                icon.className = 'fa-solid fa-check';
                t.style.background = 'var(--dark)';
                if (type === 'success') { icon.className = 'fa-solid fa-circle-check'; t.style.background = 'var(--green)'; }
                else if (type === 'info') { icon.className = 'fa-solid fa-floppy-disk'; t.style.background = '#1E40AF'; }
                else if (type === 'error') { icon.className = 'fa-solid fa-circle-xmark'; t.style.background = 'var(--red)'; }
                t.classList.add('show');
                setTimeout(function () { t.classList.remove('show'); }, 3500);
            }

            // ══════════════════════════════════════════════
            //  STEP BAR
            // ══════════════════════════════════════════════
            function updateStepBar() {
                var items = document.querySelectorAll('.step-item');
                for (var i = 0; i < items.length; i++) {
                    var sn = document.getElementById('sn' + (i + 1));
                    if (i + 1 <= lastSavedStep) items[i].classList.remove('locked');
                    else if (i > lastSavedStep) { if (i + 1 !== currentStep) items[i].classList.add('locked'); }
                }
            }

            // ══════════════════════════════════════════════
            //  NAVIGATION
            // ══════════════════════════════════════════════
            function goToStep(n) {
                if (n < currentStep) { goToStepDirect(n); return; }
                if (n > currentStep) {
                    for (var s = currentStep; s < n; s++) {
                        if (s > lastSavedStep) {
                            showToast('Please save Step ' + s + ' before going to Step ' + n + '.', 'error');
                            return;
                        }
                    }
                    goToStepDirect(n);
                }
            }

            function goToStepDirect(n) {
                var panels = document.querySelectorAll('.step-panel');
                for (var i = 0; i < panels.length; i++) panels[i].classList.remove('active');
                document.getElementById('panel' + n).classList.add('active');

                var items = document.querySelectorAll('.step-item');
                for (var i = 0; i < items.length; i++) {
                    items[i].classList.remove('active', 'done', 'locked');
                    var sn = document.getElementById('sn' + (i + 1));
                    if (i + 1 < n && i + 1 <= lastSavedStep) {
                        items[i].classList.add('done');
                        sn.innerHTML = '<i class="fa-solid fa-check"></i>';
                    } else if (i + 1 === n) {
                        items[i].classList.add('active');
                        sn.textContent = i + 1;
                    } else {
                        if (i + 1 > lastSavedStep + 1) items[i].classList.add('locked');
                        sn.textContent = i + 1;
                    }
                }
                currentStep = n;

                // ▼ Server ko bhi current step batao (postback ke liye)
                var hdnCurStep = document.getElementById('<%= hdnCurrentStep.ClientID %>');
                if (hdnCurStep) hdnCurStep.value = n.toString();

                document.getElementById('stepLabel').textContent = stepLabels[n - 1];
                document.getElementById('progressFill').style.width = (n / totalSteps * 100) + '%';
                document.getElementById('nextBtn').textContent = nextBtnLabels[n - 1];
                document.getElementById('<%= prevBtn.ClientID %>').style.display = n > 1 ? 'inline-flex' : 'none';

                // Restore dynamic grids
                if (n === 2) restoreStep2Grids();
                if (n === 3) restoreStep3Amenities();
                // ▼ FIX: Step 4 pe gallery+docs restore karo
                if (n === 4) restoreStep4Gallery();
                // ▼ FIX: Step 5 pe bhi docs badges restore karo (Review se Edit karke Step 4 pe aane ke liye)
                if (n === 5) { restoreDocsBadges(); updateReview(); }

                window.scrollTo({ top: 0, behavior: 'smooth' });
                var stepBar = document.getElementById('stepBar');
                var activeItem = document.getElementById('stepItem' + n);
                if (stepBar && activeItem) stepBar.scrollTo({ left: activeItem.offsetLeft - 20, behavior: 'smooth' });
            }

            // ══════════════════════════════════════════════
            //  NEXT / SAVE BUTTONS
            // ══════════════════════════════════════════════
            function nextStep() {
                if (currentStep < totalSteps) {
                    var ok = validateStep(currentStep);
                    if (ok) {
                        // ReadOnly sync before save
                        syncReadOnlyToHidden();
                        triggerSaveButton(currentStep);
                    } else {
                        showToast('Please fill all required fields before saving.', 'error');
                        var summary = document.getElementById('valSummary' + currentStep);
                        if (summary) summary.scrollIntoView({ behavior: 'smooth', block: 'start' });
                    }
                } else if (currentStep === totalSteps) {
                    var btn = document.getElementById('<%= btnPublish.ClientID %>');
                    if (btn) btn.click();
                }
            }

            function triggerSaveButton(step) {
                var btnMap = {
                    1: '<%= btnSaveStep1.ClientID %>',
                    2: '<%= btnSaveStep2.ClientID %>',
                    3: '<%= btnSaveStep3.ClientID %>',
                    4: '<%= btnSaveStep4.ClientID %>'
                };
                var btnID = btnMap[step];
                if (btnID) { var btn = document.getElementById(btnID); if (btn) btn.click(); }
            }

            // ══════════════════════════════════════════════
            //  SERVER SAVE SUCCESS CALLBACK
            // ══════════════════════════════════════════════
            function onServerSaveSuccess(savedStep) {
                lastSavedStep = savedStep;
                stepsCompleted[savedStep - 1] = true;
                updateStepBar();
                var nextS = savedStep + 1;
                if (nextS <= totalSteps) goToStepDirect(nextS);
            }

            // ══════════════════════════════════════════════
            //  BACK BUTTON
            // ══════════════════════════════════════════════
            function prepareBackNav() { return true; }

            function prevStep() {
                if (currentStep <= 1) return;
                var targetStep = currentStep - 1;
                var hdn = document.getElementById('<%= hdnGoBackToStep.ClientID %>');
                if (hdn) hdn.value = targetStep.toString();
                if (currentProjectID > 0) {
                    document.getElementById('<%= prevBtn.ClientID %>').click();
                } else {
                    if (hdn) hdn.value = '0';
                    goToStepDirect(targetStep);
                }
            }

            // ══════════════════════════════════════════════
            //  RESTORE GRIDS
            // ══════════════════════════════════════════════
            function restoreStep2Grids() {
                var blocksJson = document.getElementById('<%= hdnBlocksJSON.ClientID %>').value;
                var blocksRestored = false;
                if (blocksJson && blocksJson.trim() !== '' && blocksJson !== '[]') {
                    try {
                        var blocks = JSON.parse(blocksJson);
                        if (blocks && blocks.length > 0) {
                            blockCount = blocks.length;
                            document.getElementById('<%= txtNumBlocks.ClientID %>').value = blockCount;
                            var grid = document.getElementById('blocksGrid');
                            if (grid) {
                                grid.innerHTML = '';
                                var names = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];
                                for (var i = 0; i < blocks.length; i++) {
                                    var b = blocks[i];
                                    var bName = b.BlockName || ('Block ' + (names[i] || (i + 1)));
                                    var floors = b.Floors || b.NumberOfFloors || 5;
                                    var upf = b.UPF || b.UnitsPerFloor || 4;
                                    var cat = b.Category || b.BlockCategory || 'Standard';
                                    var html = '<div class="block-card" id="block' + i + '">';
                                    html += '<div class="block-card-head"><span class="block-name">' + bName + '</span>';
                                    html += '<button type="button" onclick="removeBlock(' + i + ')" style="background:rgba(255,255,255,.15);border:none;color:#fff;border-radius:4px;width:22px;height:22px;cursor:pointer;font-size:.72rem">X</button></div>';
                                    html += '<div class="block-card-body">';
                                    html += '<div class="form-group"><label>Block Name</label><input type="text" value="' + bName + '" onchange="syncBlocksHidden()"></div>';
                                    html += '<div class="form-group"><label>No. of Floors</label><input type="number" value="' + floors + '" onchange="syncBlocksHidden()"></div>';
                                    html += '<div class="form-group"><label>Units per Floor</label><input type="number" value="' + upf + '" onchange="syncBlocksHidden()"></div>';
                                    html += '<div class="form-group"><label>Total Units</label><input type="number" value="' + (floors * upf) + '" readonly style="background:#F9FAFB;font-weight:600"></div>';
                                    html += '<div class="form-group"><label>Category</label><select onchange="syncBlocksHidden()">';
                                    html += '<option' + (cat === 'Standard' ? ' selected' : '') + '>Standard</option>';
                                    html += '<option' + (cat === 'Premium' ? ' selected' : '') + '>Premium</option>';
                                    html += '<option' + (cat === 'Economy' ? ' selected' : '') + '>Economy</option>';
                                    html += '</select></div></div></div>';
                                    grid.innerHTML += html;
                                }
                                grid.innerHTML += '<div class="add-block-card" onclick="addBlock()"><span class="add-block-icon">+</span><span>Add Block</span></div>';
                                syncBlocksHidden();
                                blocksRestored = true;
                            }
                        }
                    } catch (ex) { console.log('Blocks restore error:', ex); }
                }
                if (!blocksRestored) buildBlocksGrid(blockCount);

                var unitsJson = document.getElementById('<%= hdnUnitTypesJSON.ClientID %>').value;
                var unitsRestored = false;
                if (unitsJson && unitsJson.trim() !== '' && unitsJson !== '[]') {
                    try {
                        var savedUnits = JSON.parse(unitsJson);
                        if (savedUnits && savedUnits.length > 0) {
                            document.getElementById('unitRowsContainer').innerHTML = '';
                            unitRowCount = 0;
                            for (var j = 0; j < savedUnits.length; j++) {
                                var u = savedUnits[j];
                                addUnitRow({ typeID: u.UnitTypeID || u.typeID, area: u.Super || u.area || 0, carpet: u.Carpet || u.carpet || 0, count: u.Count || u.count || 0 });
                            }
                            unitsRestored = true;
                        }
                    } catch (ex) { console.log('Units restore error:', ex); }
                }
                if (!unitsRestored) {
                    document.getElementById('unitRowsContainer').innerHTML = '';
                    unitRowCount = 0;
                    for (var k = 0; k < unitDefaults.length; k++) addUnitRow(unitDefaults[k]);
                }
                calcPricing();
            }

            function restoreStep3Amenities() {
                var saved = document.getElementById('<%= hdnAmenityIDs.ClientID %>').value;
                if (!saved) return;
                var ids = saved.split(',');
                for (var i = 0; i < ids.length; i++) {
                    var el = document.querySelector('.amenity-item[data-amenityid="' + ids[i].trim() + '"]');
                    if (el) el.classList.add('selected');
                }
                document.getElementById('amenityCount').textContent = document.querySelectorAll('.amenity-item.selected').length + ' selected';
            }

            // ══════════════════════════════════════════════
            //  DOCUMENT UPLOAD FEEDBACK
            // ══════════════════════════════════════════════
            function showDocSelected(input, itemId) {
                var numericID = itemId.replace('docItem_', '');
                var badge = document.getElementById('docBadge_' + numericID);
                var item = document.getElementById(itemId);
                if (!badge || !input.files || !input.files[0]) return;
                var fname = input.files[0].name;
                badge.innerHTML = '<span class="badge-new"><i class="fa-solid fa-file-arrow-up"></i> ' + truncateStr(fname, 22) + '</span>';
                if (item) item.classList.add('has-doc');
            }
            function restoreDocsBadges() {
                var docsJson = document.getElementById('<%= hdnDocsJSON.ClientID %>').value;
                if (!docsJson || docsJson === '[]') return;
                try {
                    var docs = JSON.parse(docsJson);
                    for (var i = 0; i < docs.length; i++) {
                        var d = docs[i];
                        var badge = document.getElementById('docBadge_' + d.docTypeID);
                        var item = document.getElementById('docItem_' + d.docTypeID);
                        if (badge) badge.innerHTML = '<span class="badge-uploaded"><i class="fa-solid fa-circle-check"></i> ' + truncateStr(d.fileName, 22) + '</span>';
                        if (item) item.classList.add('has-doc');
                    }
                } catch (ex) { console.log('Docs restore error:', ex); }
            }
            function truncateStr(str, maxLen) {
                if (!str) return '';
                return str.length > maxLen ? str.substring(0, maxLen - 2) + '..' : str;
            }

            // ══════════════════════════════════════════════
            //  GALLERY
            // ══════════════════════════════════════════════
            var galleryImages = [];
            var MAX_GALLERY = 20;

            function handleGalleryFiles(files) {
                for (var i = 0; i < files.length; i++) {
                    if (galleryImages.length >= MAX_GALLERY) { showToast('Maximum 20 images allowed.', 'error'); break; }
                    var file = files[i];
                    if (!file.type.startsWith('image/')) continue;
                    // ▼ FIX: Size check hataya — server pe compression hoti hai, koi bhi size chalega
                    (function (f) {
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            var isCover = galleryImages.length === 0;
                            galleryImages.push({ name: f.name, size: f.size, dataURL: e.target.result, isCover: isCover });
                            renderGalleryPreviews();
                        };
                        reader.readAsDataURL(f);
                    })(file);
                }
            }
            function handleGalleryDrop(files) { handleGalleryFiles(files); }
            function removeGalleryImage(idx) {
                var wasCover = galleryImages[idx] && galleryImages[idx].isCover;
                galleryImages.splice(idx, 1);
                if (wasCover && galleryImages.length > 0) galleryImages[0].isCover = true;
                renderGalleryPreviews();
            }
            function setGalleryCover(idx) {
                for (var i = 0; i < galleryImages.length; i++) galleryImages[i].isCover = false;
                galleryImages[idx].isCover = true;
                renderGalleryPreviews();
            }
            function renderGalleryPreviews() {
                var grid = document.getElementById('galleryPreviewGrid');
                var badge = document.getElementById('galleryCountBadge');
                if (!grid) return;
                grid.innerHTML = '';
                for (var i = 0; i < galleryImages.length; i++) {
                    var img = galleryImages[i];
                    var div = document.createElement('div');
                    div.className = 'gallery-thumb';
                    var imgEl = document.createElement('img');
                    imgEl.src = img.dataURL; imgEl.alt = img.name;
                    div.appendChild(imgEl);
                    var removeBtn = document.createElement('button');
                    removeBtn.type = 'button'; removeBtn.className = 'thumb-remove';
                    removeBtn.innerHTML = '<i class="fa-solid fa-xmark"></i>';
                    (function (idx) { removeBtn.onclick = function (e) { e.stopPropagation(); removeGalleryImage(idx); }; })(i);
                    div.appendChild(removeBtn);
                    if (img.isCover) {
                        var badge2 = document.createElement('span');
                        badge2.className = 'thumb-cover-badge'; badge2.textContent = 'COVER';
                        div.appendChild(badge2);
                    } else {
                        var setCoverBtn = document.createElement('button');
                        setCoverBtn.type = 'button'; setCoverBtn.className = 'thumb-set-cover'; setCoverBtn.textContent = 'Set Cover';
                        (function (idx) { setCoverBtn.onclick = function (e) { e.stopPropagation(); setGalleryCover(idx); }; })(i);
                        div.appendChild(setCoverBtn);
                    }
                    grid.appendChild(div);
                }
                if (galleryImages.length < MAX_GALLERY) {
                    var addBtn = document.createElement('div');
                    addBtn.className = 'gallery-add-btn';
                    addBtn.innerHTML = '<i class="fa-solid fa-plus" style="font-size:1.2rem"></i><span>Add More</span>';
                    addBtn.onclick = function () { document.getElementById('realGalleryInput').click(); };
                    grid.appendChild(addBtn);
                }
                if (badge) badge.textContent = galleryImages.length + ' / ' + MAX_GALLERY + ' images';
                var dropZone = document.getElementById('galleryDropZone');
                if (dropZone) {
                    var title = dropZone.querySelector('.photo-drop-title');
                    if (title) title.textContent = galleryImages.length > 0 ? 'Click to add more images' : 'Click or drag images here';
                }
                syncNewGalleryToHidden();
            }
            function syncNewGalleryToHidden() {
                var newImgs = [];
                for (var i = 0; i < galleryImages.length; i++) {
                    var img = galleryImages[i];
                    if (!img.fromDB) {
                        newImgs.push({ name: img.name, isCover: img.isCover, data: img.dataURL });
                    } else {
                        newImgs.push({ name: img.name, isCover: img.isCover, data: null, path: img.dataURL });
                    }
                }
                var hdn = document.getElementById('<%= hdnNewGalleryBase64.ClientID %>');
                if (hdn) hdn.value = JSON.stringify(newImgs);
            }
            function restoreStep4Gallery() {
                // ── 1. Docs badges hamesha restore karo ──
                restoreDocsBadges();

                // ── 2. Gallery ──
                var galleryJson = document.getElementById('<%= hdnGalleryJSON.ClientID %>').value;

                if (galleryJson && galleryJson.trim() !== '' && galleryJson !== '[]') {
                    // DB se saved images
                    try {
                        var dbImages = JSON.parse(galleryJson);
                        if (dbImages && dbImages.length > 0) {
                            // Sirf DB images reload karo agar galleryImages empty hai
                            // Agar user ne naye images add kiye hain toh woh preserve karo
                            if (galleryImages.length === 0) {
                                for (var i = 0; i < dbImages.length; i++) {
                                    galleryImages.push({
                                        name: dbImages[i].name || ('image_' + i),
                                        size: 0,
                                        dataURL: dbImages[i].path,
                                        isCover: dbImages[i].isCover,
                                        fromDB: true
                                    });
                                }
                            }
                            renderGalleryPreviews();
                        }
                    } catch (ex) { console.log('Gallery restore error:', ex); }
                } else {
                    // DB mein nahi — JS memory se render karo (session mein hain)
                    renderGalleryPreviews();
                }

                // ── 3. Cover Image preview ──
                var coverPrev = document.getElementById('coverPreview');
                if (coverPrev) {
                    // Pehle naya base64 check karo (user ne abhi select kiya)
                    var newCover = document.getElementById('<%= hdnNewCoverBase64.ClientID %>').value;
                    var coverSrc = newCover && newCover.trim() !== ''
                        ? newCover
                        : document.getElementById('<%= hdnCoverImage.ClientID %>').value;

                    if (coverSrc && coverSrc.trim() !== '') {
                        coverPrev.innerHTML =
                            '<div style="position:relative;display:inline-block;margin-top:6px">' +
                            '<img src="' + coverSrc + '" alt="Cover Image" style="height:90px;width:140px;object-fit:cover;border-radius:8px;border:2px solid var(--orange);display:block;"' +
                            ' onerror="this.parentElement.innerHTML=\'<div style=&quot;height:90px;width:140px;border-radius:8px;border:2px dashed var(--border);display:flex;align-items:center;justify-content:center;font-size:.7rem;color:var(--text-light)&quot;>Image not found</div>\'">' +
                            '<span style="position:absolute;bottom:5px;left:5px;background:var(--orange);color:#fff;font-size:.6rem;font-weight:700;padding:2px 6px;border-radius:4px;letter-spacing:.3px">COVER</span>' +
                            '</div>';
                    }
                }

                // ── 4. Logo preview ──
                var logoPrev = document.getElementById('logoPreview');
                if (logoPrev) {
                    var newLogo = document.getElementById('<%= hdnNewLogoBase64.ClientID %>').value;
                    var logoSrc = newLogo && newLogo.trim() !== ''
                        ? newLogo
                        : document.getElementById('<%= hdnLogoImage.ClientID %>').value;

                    if (logoSrc && logoSrc.trim() !== '') {
                        logoPrev.innerHTML =
                            '<div style="margin-top:6px;display:inline-block">' +
                            '<img src="' + logoSrc + '" alt="Project Logo" style="height:80px;width:80px;object-fit:contain;border-radius:8px;border:2px solid var(--border);padding:4px;background:#fff;display:block;"' +
                            ' onerror="this.src=\'\';this.alt=\'Logo not found\'">' +
                            '</div>';
                    }
                }
            }

            function previewSingleImage(input, previewDivId) {
                var prev = document.getElementById(previewDivId);
                if (!prev || !input.files || !input.files[0]) return;
                var file = input.files[0];
                if (!file.type.startsWith('image/')) return;
                var reader = new FileReader();
                reader.onload = function (e) {
                    var dataURL = e.target.result;
                    if (previewDivId === 'coverPreview') {
                        prev.innerHTML =
                            '<div style="position:relative;display:inline-block;margin-top:6px">' +
                            '<img src="' + dataURL + '" style="height:90px;width:140px;object-fit:cover;border-radius:8px;border:2px solid var(--orange);display:block;">' +
                            '<span style="position:absolute;bottom:5px;left:5px;background:var(--orange);color:#fff;font-size:.6rem;font-weight:700;padding:2px 6px;border-radius:4px">COVER</span>' +
                            '</div>';
                        // ▼ Hidden field mein save karo — postback/page-reload pe restore hoga
                        var hdnC = document.getElementById('<%= hdnNewCoverBase64.ClientID %>');
                        if (hdnC) hdnC.value = dataURL;
                    } else {
                        prev.innerHTML =
                            '<div style="margin-top:6px;display:inline-block">' +
                            '<img src="' + dataURL + '" style="height:80px;width:80px;object-fit:contain;border-radius:8px;border:2px solid var(--border);padding:4px;background:#fff;display:block;">' +
                            '</div>';
                        // ▼ Hidden field mein save karo
                        var hdnL = document.getElementById('<%= hdnNewLogoBase64.ClientID %>');
                        if (hdnL) hdnL.value = dataURL;
                    }
                };
                reader.readAsDataURL(file);
            }

            // ══════════════════════════════════════════════
            //  INIT GRIDS ON PAGE LOAD
            // ══════════════════════════════════════════════
            (function initGrids() {
                var blocksJson = document.getElementById('<%= hdnBlocksJSON.ClientID %>').value;
                var unitsJson = document.getElementById('<%= hdnUnitTypesJSON.ClientID %>').value;
                if (blocksJson && blocksJson.trim() !== '' && blocksJson !== '[]') {
                    restoreStep2Grids();
                } else {
                    var n = parseInt(document.getElementById('<%= txtNumBlocks.ClientID %>').value) || 0;
                    if (n > 0) { blockCount = n; buildBlocksGrid(n); }
                    else {
                        var grid = document.getElementById('blocksGrid');
                        if (grid) grid.innerHTML = '<div class="add-block-card" onclick="addBlock()"><span class="add-block-icon">+</span><span>Add Block</span></div>';
                    }
                    if (unitsJson && unitsJson.trim() !== '' && unitsJson !== '[]') {
                        try {
                            var savedUnits = JSON.parse(unitsJson);
                            if (savedUnits && savedUnits.length > 0) {
                                for (var j = 0; j < savedUnits.length; j++) {
                                    var u = savedUnits[j];
                                    addUnitRow({ typeID: u.UnitTypeID || u.typeID, area: u.Super || 0, carpet: u.Carpet || 0, count: u.Count || 0 });
                                }
                            } else { for (var k = 0; k < unitDefaults.length; k++) addUnitRow(unitDefaults[k]); }
                        } catch (e) { for (var k = 0; k < unitDefaults.length; k++) addUnitRow(unitDefaults[k]); }
                    } else { for (var k = 0; k < unitDefaults.length; k++) addUnitRow(unitDefaults[k]); }
                }
                calcPricing();
            })();

            // ══════════════════════════════════════════════
            //  PAGE LOAD — step bar restore + step jump
            // ══════════════════════════════════════════════
            window.addEventListener('load', function () {
                if (lastSavedStep > 0) {
                    for (var s = 1; s <= lastSavedStep; s++) stepsCompleted[s - 1] = true;
                    updateStepBar();
                }

                // ▼ KEY FIX 1: hdnNewGalleryBase64 se gallery restore karo
                // Yeh tab kaam karta hai jab Step 4 save ho chuki ho lekin page reload hua ho
                // (e.g. Save Draft top button se postback)
                if (galleryImages.length === 0) {
                    var hdnGJ = document.getElementById('<%= hdnGalleryJSON.ClientID %>').value;
                    var hdnNGB = document.getElementById('<%= hdnNewGalleryBase64.ClientID %>').value;

                    if (hdnGJ && hdnGJ.trim() !== '' && hdnGJ !== '[]') {
                        // DB se saved images restore karo
                        try {
                            var dbImgs = JSON.parse(hdnGJ);
                            for (var di = 0; di < dbImgs.length; di++) {
                                galleryImages.push({
                                    name: dbImgs[di].name || ('image_' + di),
                                    size: 0,
                                    dataURL: dbImgs[di].path,
                                    isCover: dbImgs[di].isCover,
                                    fromDB: true
                                });
                            }
                        } catch (ex) { }
                    } else if (hdnNGB && hdnNGB.trim() !== '' && hdnNGB !== '[]') {
                        // Naye uploaded images (base64) restore karo — page reload ke baad bhi
                        try {
                            var newImgs = JSON.parse(hdnNGB);
                            for (var ni = 0; ni < newImgs.length; ni++) {
                                var nim = newImgs[ni];
                                if (nim.data) {
                                    galleryImages.push({
                                        name: nim.name || ('image_' + ni),
                                        size: 0,
                                        dataURL: nim.data,
                                        isCover: nim.isCover,
                                        fromDB: false
                                    });
                                } else if (nim.path) {
                                    galleryImages.push({
                                        name: nim.name || ('image_' + ni),
                                        size: 0,
                                        dataURL: nim.path,
                                        isCover: nim.isCover,
                                        fromDB: true
                                    });
                                }
                            }
                        } catch (ex) { }
                    }
                }

                // ▼ KEY FIX: Cover aur Logo preview bhi restore karo (page reload ke baad)
                // Naya base64 pehle check karo, phir DB path
                var newCoverB64 = document.getElementById('<%= hdnNewCoverBase64.ClientID %>').value;
                var dbCoverPath = document.getElementById('<%= hdnCoverImage.ClientID %>').value;
                var coverSrcLoad = (newCoverB64 && newCoverB64.trim() !== '') ? newCoverB64
                    : (dbCoverPath && dbCoverPath.trim() !== '') ? dbCoverPath : '';
                if (coverSrcLoad) {
                    var cpEl = document.getElementById('coverPreview');
                    if (cpEl && cpEl.innerHTML.trim() === '') {
                        cpEl.innerHTML =
                            '<div style="position:relative;display:inline-block;margin-top:6px">' +
                            '<img src="' + coverSrcLoad + '" style="height:90px;width:140px;object-fit:cover;border-radius:8px;border:2px solid var(--orange);display:block;">' +
                            '<span style="position:absolute;bottom:5px;left:5px;background:var(--orange);color:#fff;font-size:.6rem;font-weight:700;padding:2px 6px;border-radius:4px">COVER</span>' +
                            '</div>';
                    }
                }

                var newLogoB64 = document.getElementById('<%= hdnNewLogoBase64.ClientID %>').value;
                var dbLogoPath = document.getElementById('<%= hdnLogoImage.ClientID %>').value;
                var logoSrcLoad = (newLogoB64 && newLogoB64.trim() !== '') ? newLogoB64
                    : (dbLogoPath && dbLogoPath.trim() !== '') ? dbLogoPath : '';
                if (logoSrcLoad) {
                    var lpEl = document.getElementById('logoPreview');
                    if (lpEl && lpEl.innerHTML.trim() === '') {
                        lpEl.innerHTML =
                            '<div style="margin-top:6px;display:inline-block">' +
                            '<img src="' + logoSrcLoad + '" style="height:80px;width:80px;object-fit:contain;border-radius:8px;border:2px solid var(--border);padding:4px;background:#fff;display:block;">' +
                            '</div>';
                    }
                }

                // ▼ KEY FIX 2: server ne hdnCurrentStep set kiya hoga — us step pe land karo
                var hdnCurStep = document.getElementById('<%= hdnCurrentStep.ClientID %>');
                var serverStep = hdnCurStep ? parseInt(hdnCurStep.value) : 1;
                if (serverStep > 1) {
                    goToStepDirect(serverStep);
                } else {
                    // Descr char count restore
                    var descEl = document.getElementById('<%= txtDescription.ClientID %>');
                    var descCount = document.getElementById('descCount');
                    if (descEl && descCount) descCount.textContent = descEl.value.length + '/300';
                }
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
        <script>
            var _map, _marker;
            function openMapPicker() {
                document.getElementById('mapModal').style.display = 'block';
                setTimeout(initLeafletMap, 300);
            }
            function closeMapPicker() { document.getElementById('mapModal').style.display = 'none'; }
            function initLeafletMap() {
                if (_map) { _map.invalidateSize(); return; }
                var lat = parseFloat(document.getElementById('<%= txtLatitude.ClientID %>').value) || 26.9124;
                var lng = parseFloat(document.getElementById('<%= txtLongitude.ClientID %>').value) || 75.7873;
                _map = L.map('map').setView([lat, lng], 13);
                L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                    attribution: '&copy; OpenStreetMap contributors'
                }).addTo(_map);
                if (navigator.geolocation) {
                    navigator.geolocation.getCurrentPosition(function (pos) {
                        _map.setView([pos.coords.latitude, pos.coords.longitude], 15);
                    });
                }
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
                    <div style="font-size: .75rem; color: var(--text-mid); margin-top: 3px">
                        Code: <strong id="pmProjCode">-</strong>
                        &nbsp;&nbsp;|&nbsp;&nbsp;
                        Status: <strong id="pmStatus">-</strong>
                    </div>
                </div>
                <div style="display: flex; gap: 12px; justify-content: center">
                    <button type="button" onclick="closePublishModal(true)" class="btn btn-primary btn-lg" style="flex: 1">
                        <i class="fa-solid fa-plus"></i>&nbsp; New Project
                   
                    </button>
                    <button type="button" onclick="closePublishModal(false)" class="btn btn-ghost btn-sm" style="padding: 10px 18px">
                        <i class="fa-solid fa-list"></i>&nbsp; View List
                   
                    </button>
                </div>
            </div>
        </div>

        <style>
            @keyframes popIn {
                0% {
                    transform: scale(.8);
                    opacity: 0;
                }

                100% {
                    transform: scale(1);
                    opacity: 1;
                }
            }
        </style>

        <script>
            function showPublishSuccess(projName, projCode, modeLabel, modeIcon, modeColor, modeMsg) {
                var modal = document.getElementById('publishModal');
                var iconWrap = document.getElementById('pmIconWrap');
                var icon = document.getElementById('pmIcon');
                iconWrap.style.background = modeColor;
                icon.className = 'fa-solid ' + modeIcon;
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
                if (createNew)
                    window.location.href = 'ProjectCreate.aspx';
                //resetFormForNewProject();
                else window.location.href = 'ProjectList.aspx';
            }

            function resetFormForNewProject() {
                var form = document.getElementById('form1');
                var inputs = form.querySelectorAll('input[type=text],input[type=number],input[type=date],textarea');
                for (var i = 0; i < inputs.length; i++) { if (!inputs[i].readOnly) inputs[i].value = ''; }
                var ddls = form.querySelectorAll('select');
                for (var i = 0; i < ddls.length; i++) ddls[i].selectedIndex = 0;

                var chks = ['<%= chkOnlineBooking.ClientID %>','<%= chkShowWebsite.ClientID %>',
                            '<%= chkEMICalc.ClientID %>','<%= chkAgentReferral.ClientID %>',
                            '<%= chkHoldUnit.ClientID %>'];
                for (var i = 0; i < chks.length; i++) {
                    var c = document.getElementById(chks[i]); if (c) c.checked = true;
                }
                var vastuChk = document.getElementById('<%= chkVastu.ClientID %>');
                if (vastuChk) vastuChk.checked = false;

                document.getElementById('<%= hdnAmenityIDs.ClientID %>').value = '';
                document.getElementById('<%= hdnBankIDs.ClientID %>').value = '';
                document.getElementById('<%= hdnBlocksJSON.ClientID %>').value = '[]';
                document.getElementById('<%= hdnUnitTypesJSON.ClientID %>').value = '[]';
                document.getElementById('<%= hdnProjectCode.ClientID %>').value = '';
                document.getElementById('<%= hdnLatitude.ClientID %>').value = '';
                document.getElementById('<%= hdnLongitude.ClientID %>').value = '';
                document.getElementById('<%= hdnPublishMode.ClientID %>').value = 'draft';
                document.getElementById('<%= hdnCurrentStep.ClientID %>').value = '1';

                var amenItems = document.querySelectorAll('.amenity-item.selected');
                for (var i = 0; i < amenItems.length; i++) amenItems[i].classList.remove('selected');
                document.getElementById('amenityCount').textContent = '0 selected';

                galleryImages = [];
                renderGalleryPreviews();

                var bankPills = document.querySelectorAll('.check-pill.checked');
                for (var i = 0; i < bankPills.length; i++) bankPills[i].classList.remove('checked');

                document.getElementById('unitRowsContainer').innerHTML = '';
                unitRowCount = 0;
                blockCount = 3;
                buildBlocksGrid(3);
                for (var i = 0; i < unitDefaults.length; i++) addUnitRow(unitDefaults[i]);
                calcPricing();

                lastSavedStep = 0;
                currentProjectID = 0;
                stepsCompleted = [false, false, false, false, false];

                selectPublishMode(document.getElementById('pm-active'), 'active');
                goToStepDirect(1);

                var descCount = document.getElementById('descCount');
                if (descCount) descCount.textContent = '0/300';
                showToast('Naya project shuru karein!', 'info');
            }
        </script>

    </form>
</body>
</html>
