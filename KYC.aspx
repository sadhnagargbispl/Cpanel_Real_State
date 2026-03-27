<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="KYC.aspx.cs" Inherits="KYC" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500&display=swap" rel="stylesheet" />
    <link href="css/AgentRegistration.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />

    <script>
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) return false;
            return true;
        }
    </script>

    <style>
        /* ── Two Cards Layout ── */
        .two-cards {
            display: grid;
            grid-template-columns: minmax(0, 3fr) minmax(0, 2fr);
            gap: 16px;
            align-items: start;
        }

        /* ── Shared card shell ── */
        .pcard {
            background: var(--bg);
            border: 0.5px solid var(--border);
            border-radius: var(--radius-lg);
            overflow: hidden;
        }

        /* ── Card header ── */
        .pcard-header {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 13px 18px;
            border-bottom: 0.5px solid var(--amber-mid);
            background: var(--amber-light);
        }

        .pcard-icon {
            width: 36px;
            height: 36px;
            border-radius: var(--radius);
            background: #fff;
            border: 0.5px solid var(--amber-mid);
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .pcard-title {
            font-size: 13px;
            font-weight: 500;
            color: var(--amber);
        }

        .pcard-sub {
            font-size: 11px;
            color: var(--txt2);
            margin-top: 2px;
            line-height: 1.5;
        }

        /* ── Card body ── */
        .pcard-body {
            padding: 18px;
        }

        /* ── Section gap ── */
        .sec-gap {
            height: 16px;
        }

        /* ── Verification Status ── */
        .ver-sec {
            margin-bottom: 18px;
        }

        .ver-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
        }

        .ver-val {
            height: 34px;
            display: flex;
            align-items: center;
            font-size: 12px;
        }

        /* ── Status badges ── */
        .badge-due {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            background: var(--amber-light);
            border: 0.5px solid var(--amber-mid);
            border-radius: var(--radius);
            padding: 3px 10px;
            font-size: 11px;
            color: var(--amber);
            font-weight: 500;
        }

        .badge-verified {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            background: #EAF3DE;
            border: 0.5px solid #C0DD97;
            border-radius: var(--radius);
            padding: 3px 10px;
            font-size: 11px;
            color: var(--success-txt);
            font-weight: 500;
        }

        .badge-rejected {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            background: #FCEBEB;
            border: 0.5px solid #F7C1C1;
            border-radius: var(--radius);
            padding: 3px 10px;
            font-size: 11px;
            color: var(--danger-txt);
            font-weight: 500;
        }

        .status-dot {
            width: 6px;
            height: 6px;
            border-radius: 50%;
            display: inline-block;
            flex-shrink: 0;
        }

        /* ── Uploaded Images Grid ── */
        .img-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 8px;
        }

        .img-card {
            background: #f8f9fb;
            border: 1px solid var(--border);
            border-radius: 10px;
            overflow: hidden;
            width: 100%;
            transition: box-shadow 0.2s;
        }

            .img-card:hover {
                box-shadow: 0 4px 16px rgba(27,43,107,0.10);
            }

        .ic-label {
            font-size: 9px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.06em;
            color: var(--txt2);
            padding: 6px 10px 5px;
            background: #fff;
            border-bottom: 1px solid var(--border);
        }

        .img-thumb-wrap {
            position: relative;
            width: 100%;
            height: 146px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f0f4fb;
            overflow: hidden;
        }

            .img-thumb-wrap img {
                width: 100%;
                height: 146px;
                object-fit: cover;
                cursor: pointer;
                display: block;
                transition: opacity 0.2s;
            }

                .img-thumb-wrap img:hover {
                    opacity: 0.88;
                }

        /* Placeholder jab image na ho */
        .img-placeholder {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 5px;
            height: 146px;
            color: #b0bec5;
        }

            .img-placeholder svg {
                opacity: 0.5;
            }

            .img-placeholder span {
                font-size: 9px;
                color: #b0bec5;
            }

        /* View overlay on hover */
        .img-thumb-wrap::after {
            content: 'View';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            background: rgba(27,43,107,0.55);
            color: #fff;
            font-size: 10px;
            font-weight: 600;
            text-align: center;
            padding: 4px;
            opacity: 0;
            transition: opacity 0.2s;
            letter-spacing: 0.05em;
            text-transform: uppercase;
        }

        .img-thumb-wrap:hover::after {
            opacity: 1;
        }

        .img-thumb-wrap a {
            display: block;
            width: 100%;
            height: 146px;
        }

        .img-thumb-wrap {
            position: relative;
            width: 100%;
            height: 146px;
            display: block; /* flex se block karo */
            overflow: hidden;
            background: #f0f4fb;
        }

            .img-thumb-wrap img {
                width: 100% !important;
                height: 146px !important;
                object-fit: cover;
                cursor: pointer;
                display: block;
                transition: opacity 0.2s;
            }
        /* ── Modal ── */
        #profilePhotoModal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            z-index: 99999;
            background: rgba(0, 0, 0, 0.75);
            display: none;
            align-items: center;
            justify-content: center;
        }

            #profilePhotoModal.show {
                display: flex;
            }

            #profilePhotoModal .modal-dialog {
                margin: 0 auto;
                max-width: 680px;
                width: 92%;
            }

            #profilePhotoModal .modal-content {
                border-radius: 14px;
                overflow: hidden;
                border: none;
                box-shadow: 0 24px 64px rgba(0, 0, 0, 0.45);
                background: #fff;
            }

            #profilePhotoModal .modal-header {
                background: #fff;
                border-bottom: 1px solid #eee;
                padding: 14px 20px;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            #profilePhotoModal .modal-title {
                font-size: 15px;
                font-weight: 600;
                color: #1B2B6B;
                margin: 0;
            }

            #profilePhotoModal .modal-body {
                background: #f4f6fb;
                padding: 20px;
                text-align: center;
                min-height: 120px;
            }

            #profilePhotoModal iframe {
                border-radius: 10px;
                border: none;
                background: #fff;
            }

        .modal-close-btn {
            background: #f0f0f0;
            border: none;
            border-radius: 8px;
            width: 32px;
            height: 32px;
            cursor: pointer;
            color: #555;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background 0.2s, color 0.2s;
            flex-shrink: 0;
        }

            .modal-close-btn:hover {
                background: #EF4444;
                color: #fff;
            }

        /* ── Responsive ── */
        @media (max-width: 900px) {
            .two-cards {
                grid-template-columns: 1fr;
            }

            .g3 {
                grid-template-columns: 1fr 1fr !important;
            }
        }

        @media (max-width: 520px) {
            .g2,
            .g3 {
                grid-template-columns: 1fr !important;
            }

            .img-grid {
                grid-template-columns: 1fr 1fr;
            }

            .pcard-body {
                padding: 14px;
            }

            .pc {
                padding: 10px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="pc">

        <!-- Page Header -->
        <div class="page-header">
            <div class="ph-left">
                <div class="ph-title">KYC Detail</div>
            </div>
            <div class="ph-actions">
                <a href="Dashboard.aspx" class="btn btn-outline btn-sm">Back to Dashboard</a>
            </div>
        </div>

        <asp:HiddenField ID="HiddenField1" runat="server" />
        <asp:HiddenField ID="hdnSessn" runat="server" />

        <asp:Label ID="errMsg" runat="server" CssClass="f-err show"
            Style="display: block; margin-bottom: 10px"></asp:Label>

        <!-- Two Cards Grid -->
        <div class="two-cards">

            <!-- CARD 1: KYC FORM -->
            <div class="pcard">
                <div class="pcard-header">
                    <div class="pcard-icon">
                        <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                            <rect x="2" y="4" width="16" height="12" rx="2" stroke="#854F0B" stroke-width="1.4" />
                            <circle cx="7" cy="9" r="2" stroke="#854F0B" stroke-width="1.3" />
                            <path d="M3 16c.5-2 2-3 4-3s3.5 1 4 3" stroke="#854F0B" stroke-width="1.3" stroke-linecap="round" />
                            <path d="M13 8h3M13 11h2" stroke="#854F0B" stroke-width="1.3" stroke-linecap="round" />
                        </svg>
                    </div>
                    <div>
                        <div class="pcard-title">KYC Form</div>
                        <div class="pcard-sub">
                            Dear <%=Session["MemName"].ToString()%>
                            (<asp:Label ID="lblid" runat="server"></asp:Label>) &mdash; Update Your KYC
                            (<asp:Label ID="LblIdproofText" runat="server"></asp:Label>)
                       
                        </div>
                    </div>
                </div>

                <div class="pcard-body">

                    <!-- ADDRESS PROOF -->
                    <div class="sec-div">
                        Address Proof
                       
                        <% if (Session["CompId"] != null && Session["CompId"].ToString() == "1074")
                            { %>
                        <span style="font-weight: 400; text-transform: none; letter-spacing: 0; font-size: 11px">(Same as document)</span>
                        <% } %>
                    </div>

                    <div class="g2">
                        <div class="fg">
                            <label class="fl">Address</label>
                            <asp:TextBox ID="txtaddrs" runat="server" CssClass="fi validate[required]"></asp:TextBox>
                        </div>
                        <div class="fg">
                            <label class="fl">Pincode</label>
                            <asp:TextBox ID="Txtpincode" runat="server" CssClass="fi validate[required,custom[pincode]]"></asp:TextBox>
                        </div>
                    </div>

                    <div class="g3">
                        <div class="fg">
                            <label class="fl">State</label>
                            <asp:DropDownList ID="ddlState" runat="server" CssClass="fs"
                                OnSelectedIndexChanged="ddlState_SelectedIndexChanged">
                                <asp:ListItem Text="-- Select State --" Value="0"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:HiddenField ID="StateCode" runat="server" />
                        </div>
                        <div class="fg">
                            <label class="fl">District</label>
                            <asp:HiddenField ID="HDistrictCode" runat="server" />
                            <asp:TextBox ID="Txtdistrict" runat="server" CssClass="fi validate[required]"></asp:TextBox>
                        </div>
                        <div class="fg">
                            <label class="fl">City</label>
                            <asp:TextBox ID="Txtcity" runat="server" CssClass="fi validate[required]"></asp:TextBox>
                            <asp:HiddenField ID="HCityCode" runat="server" />
                        </div>
                    </div>

                    <div class="g2" style="display: none;">
                        <div class="fg">
                            <label class="fl">Area</label>
                            <asp:DropDownList ID="DDlVillage" CssClass="fs" runat="server"
                                ValidationGroup="eInformation" autocomplete="off"
                                onchange="FnVillageChange(this.value);">
                            </asp:DropDownList>
                        </div>
                    </div>

                    <div class="g2" id="divVillage" style="display: none;">
                        <div class="fg">
                            <label class="fl">Area Name</label>
                            <asp:TextBox ID="TxtVillage" CssClass="fi" runat="server" autocomplete="off"></asp:TextBox>
                        </div>
                    </div>

                    <div class="g2">
                        <div class="fg">
                            <label class="fl">Address Proof Type</label>
                            <asp:DropDownList ID="DDLAddressProof" runat="server" CssClass="fs"></asp:DropDownList>
                        </div>
                        <div class="fg">
                            <label class="fl">
                                <asp:Label ID="LblAddresProof" runat="server">Address Proof</asp:Label>
                            </label>
                            <asp:TextBox ID="TxtIdProofNo" CssClass="fi validate[required]" runat="server" MaxLength="16"></asp:TextBox>
                        </div>
                    </div>

                    <div class="g2" style="margin-bottom: 0">
                        <div class="fg">
                            <label class="fl">Front Address Proof Upload</label>
                            <div class="fu-row">
                                <asp:FileUpload ID="Fuidentity" runat="server" CssClass="fi validate[required]" />
                            </div>
                            <asp:RequiredFieldValidator ID="rfvImage" runat="server"
                                ErrorMessage="Please select front address proof."
                                Enabled="false" ControlToValidate="Fuidentity"
                                ValidationGroup="eInformation" ForeColor="Red" Font-Size="12px">
                            </asp:RequiredFieldValidator>
                            <asp:Label ID="lblimage" runat="server" Visible="false"
                                Style="font-size: 12px; color: var(--success-txt)"></asp:Label>
                        </div>
                        <div class="fg">
                            <label class="fl">Back Address Proof Upload</label>
                            <div class="fu-row">
                                <asp:FileUpload ID="FileUpload1" runat="server" CssClass="fi validate[required]" />
                            </div>
                            <asp:RequiredFieldValidator ID="rfvImage1" runat="server"
                                ErrorMessage="Please select back address proof."
                                Enabled="false" ControlToValidate="FileUpload1"
                                ValidationGroup="eInformation" ForeColor="Red" Font-Size="12px">
                            </asp:RequiredFieldValidator>
                            <asp:Label ID="LblBackImage" runat="server" Visible="false"
                                Style="font-size: 12px; color: var(--success-txt)"></asp:Label>
                        </div>
                    </div>

                    <div class="sec-gap"></div>

                    <!-- BANK DETAIL -->
                    <div class="sec-div">Bank Detail</div>

                    <div class="g2" id="Accountype" runat="server" visible="false">
                        <div class="fg">
                            <label class="fl">Account Type</label>
                            <asp:DropDownList ID="DDLAccountType" runat="server" CssClass="fs">
                                <asp:ListItem Text="Choose Account Type" Value="0" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Saving Account" Value="SAVING ACCOUNT"></asp:ListItem>
                                <asp:ListItem Text="Current Account" Value="CURRENT ACCOUNT"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="fg">
                            <label class="fl">Account No</label>
                            <asp:TextBox ID="Txtacno" runat="server"
                                CssClass="fi validate[required,custom[onlyNumberSp]]" MaxLength="20"></asp:TextBox>
                        </div>
                    </div>

                    <asp:HiddenField ID="HdnCheckTrnns" runat="server" />

                    <div class="g2">
                        <div class="fg">
                            <label class="fl">Bank</label>
                            <asp:DropDownList ID="cmbbank" runat="server" CssClass="fs"></asp:DropDownList>
                        </div>
                        <div class="g2" id="divBank" runat="server" visible="false">
                            <div class="fg">
                                <label class="fl">Bank Name</label>
                                <asp:TextBox ID="Txtbank" CssClass="fi" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="fg">
                            <label class="fl">Branch Name</label>
                            <asp:TextBox ID="Txtbranch" runat="server"
                                CssClass="fi validate[required,custom[onlyLetterNumberChar]]"></asp:TextBox>
                        </div>
                    </div>

                    <div class="g2" style="margin-bottom: 0">
                        <div class="fg">
                            <label class="fl">IFSC Code</label>
                            <asp:TextBox ID="Txtcode" runat="server"
                                CssClass="fi validate[required,custom[ifsccode]]"></asp:TextBox>
                        </div>
                        <div class="fg">
                            <label class="fl">Bank KYC Upload</label>
                            <div class="fu-row">
                                <asp:FileUpload ID="BankKYCFileUpload3" runat="server" CssClass="fi validate[required]" />
                            </div>
                            <asp:Label ID="LblBankImage" runat="server" Visible="false"
                                Style="font-size: 12px; color: var(--success-txt)"></asp:Label>
                        </div>
                    </div>

                    <div class="sec-gap"></div>

                    <!-- PAN CARD -->
                    <div class="sec-div">PAN Card Detail</div>

                    <div class="g2" style="margin-bottom: 0">
                        <div class="fg">
                            <label class="fl">PAN Card No.</label>
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>
                                    <asp:TextBox ID="txtpan" runat="server"
                                        CssClass="fi validate[required,custom[panno]]"
                                        Style="text-transform: uppercase"></asp:TextBox>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="txtpan" EventName="TextChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
                        <div class="fg">
                            <label class="fl">PAN Card Upload</label>
                            <div class="fu-row">
                                <asp:FileUpload ID="Pankyc" runat="server" CssClass="fi validate[required]" />
                            </div>
                            <asp:Label ID="LblPanImage" runat="server" Visible="false"
                                Style="font-size: 12px; color: var(--success-txt)"></asp:Label>
                        </div>
                    </div>

                    <!-- SUBMIT -->
                    <div class="submit-row">
                        <asp:Button ID="BtnIdentity" runat="server"
                            ValidationGroup="eInformation"
                            CssClass="btn btn-primary"
                            Text="Submit"
                            OnClientClick="return ValidateAllKycFields();"
                            OnClick="BtnIdentity_Click" />
                    </div>

                </div>
            </div>
            <!-- /CARD 1 -->


            <!-- CARD 2: STATUS + IMAGES -->
            <div class="pcard">
                <div class="pcard-header">
                    <div class="pcard-icon">
                        <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                            <circle cx="10" cy="10" r="7" stroke="#854F0B" stroke-width="1.4" />
                            <path d="M7 10l2 2 4-4" stroke="#854F0B" stroke-width="1.3"
                                stroke-linecap="round" stroke-linejoin="round" />
                        </svg>
                    </div>
                    <div>
                        <div class="pcard-title">Status &amp; Documents</div>
                        <div class="pcard-sub">Verification status and uploaded KYC documents</div>
                    </div>
                </div>

                <div class="pcard-body">

                    <!-- VERIFICATION STATUS -->
                    <div class="ver-sec" id="DivVerify" runat="server">
                        <div class="sec-div" id="LblVerification" runat="server">Verification Status</div>

                        <div class="ver-grid">
                            <div class="fg">
                                <span class="fl">Status</span>
                                <div class="ver-val">
                                    <asp:Label ID="lblverstatus" runat="server"></asp:Label>
                                </div>
                            </div>
                            <div class="fg">
                                <asp:Label ID="VerifyDate" runat="server" Text="Verify / Reject Date"
                                    Visible="false" CssClass="fl"></asp:Label>
                                <div class="ver-val">
                                    <asp:Label ID="Lblverdate" runat="server"
                                        Style="font-size: 12px; color: var(--txt2)"></asp:Label>
                                </div>
                            </div>
                        </div>

                        <div class="ver-grid" style="margin-top: 8px">
                            <div class="fg">
                                <asp:Label ID="LblVerfRemark" Text="Reject Remark" Visible="false"
                                    runat="server" CssClass="fl"></asp:Label>
                                <asp:Label ID="LblRemark" runat="server"
                                    Style="font-size: 12px; color: var(--danger-txt)"></asp:Label>
                            </div>
                            <div class="fg">
                                <asp:Label ID="LblVerfReason" Text="Reject Reason" Visible="false"
                                    runat="server" CssClass="fl"></asp:Label>
                                <asp:Label ID="LbLrejectRemark" runat="server"
                                    Style="font-size: 12px; color: var(--danger-txt)"></asp:Label>
                            </div>
                        </div>
                    </div>

                    <!-- UPLOADED IMAGES -->
                    <div class="sec-div">Uploaded Images</div>

                    <div class="img-grid">
                        <div class="img-card">
                            <div class="ic-label">Front Address Proof</div>
                            <div class="img-thumb-wrap">
                                <a id="FrontAddress" runat="server" onclick="return openPhotoModal('front')"
                                    style="display: block; width: 100%; height: 146px;">
                                    <asp:Image ID="ShowIdentity" runat="server"
                                        Style="display: block; width: 100%; height: 146px; object-fit: cover; cursor: pointer" />
                                </a>
                            </div>
                        </div>
                        <div class="img-card">
                            <div class="ic-label">Back Address Proof</div>
                            <div class="img-thumb-wrap">
                                <a id="BackAddress" runat="server" onclick="return openPhotoModal('back')"
                                    style="display: block; width: 100%; height: 146px;">
                                    <asp:Image ID="showBackImage" runat="server"
                                        Style="display: block; width: 100%; height: 146px; object-fit: cover; cursor: pointer" />
                                </a>
                            </div>
                        </div>
                        <div class="img-card">
                            <div class="ic-label">Bank Address Proof</div>
                            <div class="img-thumb-wrap">
                                <a id="BankProof" runat="server" onclick="return openPhotoModal('bank')"
                                    style="display: block; width: 100%; height: 146px;">
                                    <asp:Image ID="bANKiMAGE" runat="server"
                                        Style="display: block; width: 100%; height: 146px; object-fit: cover; cursor: pointer" />
                                </a>
                            </div>
                        </div>
                        <div class="img-card">
                            <div class="ic-label">PAN Card</div>
                            <div class="img-thumb-wrap">
                                <a id="PanCard" runat="server" onclick="return openPhotoModal('pan')"
                                    style="display: block; width: 100%; height: 146px;">
                                    <asp:Image ID="pANiMAGE" runat="server"
                                        Style="display: block; width: 100%; height: 146px; object-fit: cover; cursor: pointer" />
                                </a>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <!-- /CARD 2 -->

        </div>
        <!-- /two-cards -->
    </div>
    <!-- /pc -->


    <!-- IMAGE PREVIEW MODAL -->
    <div id="profilePhotoModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Image Preview</h5>
                    <button type="button" class="modal-close-btn" onclick="closePhotoModal()">
                        <svg width="14" height="14" viewBox="0 0 14 14" fill="none">
                            <path d="M1 1l12 12M13 1L1 13" stroke="currentColor"
                                stroke-width="2" stroke-linecap="round" />
                        </svg>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="imgLoader" style="display: none; padding: 30px 0;">
                        <div class="spinner-border text-primary" role="status"></div>
                        <p style="color: #888; font-size: 13px; margin-top: 8px;">Loading image...</p>
                    </div>
                    <iframe id="photoPreviewFrame"
                        style="width: 100%; height: 460px; border: none; border-radius: 10px; display: none;"></iframe>
                    <p id="noImageMsg"
                        style="display: none; color: #999; font-size: 13px; padding: 40px 0;">
                        No image found.
                   
                    </p>
                </div>
            </div>
        </div>
    </div>


    <!-- Scripts -->
    <script src="popupassets/popper.min.js"></script>
    <script src="popupassets/lib.js"></script>
    <script src="popupassets/jquery.flagstrap.min.js"></script>
    <script type="text/javascript" src="popupassets/jquery.themepunch.tools.min.js"></script>
    <script type="text/javascript" src="popupassets/jquery.themepunch.revolution.min.js"></script>
    <script src="js/functions1.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
        $(document).ready(function () {

            /* Aadhaar verify */
            $('#<%= TxtIdProofNo.ClientID %>').on('blur', function () {
                var idNo = $(this).val().trim();
                if (idNo === '') return;
                $.ajax({
                    type: "POST", url: "KYC.aspx/VerifyAadhaar",
                    contentType: "application/json; charset=utf-8", dataType: "json",
                    data: JSON.stringify({ idProofNo: idNo }),
                    success: function (res) {
                        if (res.d === false) {
                            alert("Aadhaar Card already registered with another ID.");
                            $('#<%= TxtIdProofNo.ClientID %>').val('').focus();
                            $('#<%= BtnIdentity.ClientID %>').prop('disabled', true);
                        } else {
                            $('#<%= BtnIdentity.ClientID %>').prop('disabled', false);
                        }
                    },
                    error: function () { alert("Unable to verify Aadhaar right now."); }
                });
            });

            /* PAN verify */
            $('#<%= txtpan.ClientID %>').on('blur', function () {
                var idNo = $(this).val().trim();
                if (idNo === '') return;
                $.ajax({
                    type: "POST", url: "KYC.aspx/panverifyC",
                    contentType: "application/json; charset=utf-8", dataType: "json",
                    data: JSON.stringify({ txtpan: idNo }),
                    success: function (res) {
                        if (res.d === false) {
                            alert("PAN Card already registered with another ID.");
                            $('#<%= txtpan.ClientID %>').val('').focus();
                            $('#<%= BtnIdentity.ClientID %>').prop('disabled', true);
                        } else {
                            $('#<%= BtnIdentity.ClientID %>').prop('disabled', false);
                        }
                    },
                    error: function () { alert("Unable to verify PAN right now."); }
                });
            });

        });
    </script>

    <script>
        function ValidateIdProofNo() {
            var idNoCtrl = document.getElementById('<%= TxtIdProofNo.ClientID %>');
            if (idNoCtrl.value.trim() === "") {
                alert("Please enter Address Proof Number");
                idNoCtrl.focus(); return false;
            }
            return true;
        }

        function ValidateAllKycFields() {
            function isEmpty(id, msg) {
                var el = document.getElementById(id);
                if (!el || el.value.trim() === "") { alert(msg); if (el) el.focus(); return true; }
                return false;
            }

            if (isEmpty('<%= txtaddrs.ClientID %>', 'Please enter Address')) return false;

            var pin = document.getElementById('<%= Txtpincode.ClientID %>').value.trim();
            if (pin === "" || pin.length !== 6 || isNaN(pin)) {
                alert("Please enter a valid 6-digit Pincode");
                document.getElementById('<%= Txtpincode.ClientID %>').focus(); return false;
            }

            var ddl = document.getElementById('<%= ddlState.ClientID %>');
            if (ddl.options[ddl.selectedIndex].text === "--Choose State Name--") {
                alert("Please select State"); ddl.focus(); return false;
            }

            if (isEmpty('<%= Txtdistrict.ClientID %>', 'Please enter District')) return false;
            if (isEmpty('<%= Txtcity.ClientID %>', 'Please enter City')) return false;

            if (document.getElementById('<%= DDLAddressProof.ClientID %>').value === "0") {
                alert("Please select Address Proof Type");
                document.getElementById('<%= DDLAddressProof.ClientID %>').focus(); return false;
            }

            if (!ValidateIdProofNo()) return false;

            var front = document.getElementById('<%= Fuidentity.ClientID %>');
            if (!front.disabled && front.files.length === 0) {
                alert("Please upload Front Address Proof image"); front.focus(); return false;
            }

            var back = document.getElementById('<%= FileUpload1.ClientID %>');
            if (!back.disabled && back.files.length === 0) {
                alert("Please upload Back Address Proof image"); back.focus(); return false;
            }

            if (document.getElementById('<%= DDLAccountType.ClientID %>').value === "0") {
                alert("Please select Account Type"); return false;
            }

            var accNo = document.getElementById('<%= Txtacno.ClientID %>').value.trim();
            if (accNo === "" || accNo.length < 9) {
                alert("Please enter a valid Account Number"); return false;
            }

            var bankDDL = document.getElementById('<%= cmbbank.ClientID %>');
            if (bankDDL.value === "0" || bankDDL.selectedIndex === -1) {
                alert("Please select Bank"); return false;
            }

            var bankText = bankDDL.options[bankDDL.selectedIndex].text.toUpperCase();
            if (bankText === "OTHERS") {
                var bankName = document.getElementById('<%= Txtbank.ClientID %>').value.trim();
                if (bankName === "") {
                    alert("Please enter Bank Name");
                    document.getElementById('<%= Txtbank.ClientID %>').focus(); return false;
                }
            }

            if (document.getElementById('<%= Txtbranch.ClientID %>').value.trim() === "") {
                alert("Please enter Branch Name"); return false;
            }

            var ifsc = document.getElementById('<%= Txtcode.ClientID %>').value.trim().toUpperCase();
            if (!/^[A-Z]{4}0[A-Z0-9]{6}$/.test(ifsc)) {
                alert("Invalid IFSC Code (example: ABCD0123456)"); return false;
            }

            var bankImg = document.getElementById('<%= BankKYCFileUpload3.ClientID %>');
            if (!bankImg.disabled && bankImg.files.length === 0) {
                alert("Please upload Bank KYC Image"); return false;
            }

            var panCtrl = document.getElementById('<%= txtpan.ClientID %>');
            var pan = panCtrl.value.trim().toUpperCase();
            if (pan === "") { alert("Please enter PAN number"); panCtrl.focus(); return false; }
            if (!/^[A-Z]{5}[0-9]{4}[A-Z]{1}$/.test(pan)) {
                alert("Invalid PAN format (example: ABCDE1234F)");
                panCtrl.value = ""; panCtrl.focus(); return false;
            }

            var panImg = document.getElementById('<%= Pankyc.ClientID %>');
            if (panImg.files.length === 0) {
                alert("Please upload PAN image"); return false;
            }

            return true;
        }
    </script>

    <script>
        function openPhotoModal(reqno) {
            var frame = document.getElementById("photoPreviewFrame");
            var loader = document.getElementById("imgLoader");
            var noMsg = document.getElementById("noImageMsg");
            var modalEl = document.getElementById('profilePhotoModal');

            frame.style.display = "none";
            frame.src = "";
            loader.style.display = "block";
            noMsg.style.display = "none";

            modalEl.classList.add('show');
            document.body.style.overflow = 'hidden';

            var allowedTypes = ["front", "back", "bank", "pan"];
            var imgType = allowedTypes.includes(reqno.toLowerCase()) ? reqno.toLowerCase() : "payment";
            var formNo = '<%= Session["FormNo"] ?? "" %>';
            var url = "Img.aspx?type=" + imgType + "&ID=" + formNo + "&t=" + new Date().getTime();

            frame.onload = function () {
                loader.style.display = "none";
                frame.style.display = "block";
            };

            frame.src = url;
            return false;
        }

        function closePhotoModal() {
            var modalEl = document.getElementById('profilePhotoModal');
            modalEl.classList.remove('show');
            document.body.style.overflow = '';
            document.getElementById('photoPreviewFrame').src = "";
        }

        document.addEventListener('DOMContentLoaded', function () {
            var modalEl = document.getElementById('profilePhotoModal');

            modalEl.addEventListener('click', function (e) {
                if (e.target === modalEl) closePhotoModal();
            });

            document.addEventListener('keydown', function (e) {
                if (e.key === 'Escape') closePhotoModal();
            });
        });
        document.addEventListener('DOMContentLoaded', function () {
            // Image load fail hone par placeholder dikhao
            document.querySelectorAll('.img-thumb-wrap img').forEach(function (img) {
                img.addEventListener('error', function () {
                    this.style.display = 'none';
                    var wrap = this.closest('.img-thumb-wrap');
                    if (wrap) {
                        wrap.innerHTML = '<div class="img-placeholder">' +
                            '<svg width="28" height="28" viewBox="0 0 24 24" fill="none">' +
                            '<rect x="3" y="5" width="18" height="14" rx="2" stroke="#b0bec5" stroke-width="1.5"/>' +
                            '<circle cx="8.5" cy="10.5" r="1.5" stroke="#b0bec5" stroke-width="1.2"/>' +
                            '<path d="M3 16l4-4 3 3 3-3 5 5" stroke="#b0bec5" stroke-width="1.2" stroke-linecap="round"/>' +
                            '</svg><span>Not Uploaded</span></div>';
                    }
                });
            });
        });
    </script>

</asp:Content>
