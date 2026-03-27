<%-- 
====================================================
  KYC.aspx  —  Responsive Half-Half Layout FIX
  Sirf <style> block replace karo apne HEAD section mein
  Baki .aspx ka structure same rahega
====================================================
--%>

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

        /* ══════════════════════════════════════════
           HALF-HALF SPLIT LAYOUT
        ══════════════════════════════════════════ */

        /* Main 2-column grid: Form (left, wider) | Status+Images (right) */
        .split {
            display: grid;
            grid-template-columns: minmax(0, 3fr) minmax(0, 2fr);
            gap: 24px;
            align-items: start;
        }

        /* ── Right column stacks vertically ── */
        .right-col {
            display: flex;
            flex-direction: column;
            gap: 14px;
        }

        /* ── Side cards (Verification Status, Uploaded Images) ── */
        .side-card {
            background: var(--bg);
            border: 0.5px solid var(--border);
            border-radius: var(--radius-lg);
            padding: 16px;
        }

        .side-card .sec-div {
            margin-top: 0;
        }

        /* ── Image grid inside right column ── */
        .img-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
        }

        .img-card {
            background: var(--bg2);
            border: 0.5px solid var(--border);
            border-radius: var(--radius);
            overflow: hidden;
        }

        .ic-label {
            font-size: 9px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: var(--txt2);
            padding: 6px 8px 4px;
        }

        .img-card img {
            display: block;
            width: 100%;
            aspect-ratio: 4/3;
            object-fit: cover;
            cursor: pointer;
        }

        /* ── Verification badge styles ── */
        .badge-due {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            background: var(--amber-light);
            border: 0.5px solid var(--amber-mid);
            border-radius: var(--radius);
            padding: 4px 10px;
            font-size: 11px;
            color: var(--amber);
            font-weight: 500;
        }

        .badge-ok {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            background: #EAF3DE;
            border: 0.5px solid #C0DD97;
            border-radius: var(--radius);
            padding: 4px 10px;
            font-size: 11px;
            color: var(--success-txt);
            font-weight: 500;
        }

        .status-dot {
            width: 6px;
            height: 6px;
            border-radius: 50%;
            display: inline-block;
            flex-shrink: 0;
        }

        /* ── Modal (full screen, ignores sidebar) ── */
        #profilePhotoModal {
            position: fixed !important;
            top: 0 !important;
            left: 0 !important;
            width: 100vw !important;
            height: 100vh !important;
            z-index: 99999 !important;
            background: rgba(0,0,0,0.5) !important;
            display: none;
            align-items: center !important;
            justify-content: center !important;
            margin-left: 0 !important;
            padding: 0 !important;
        }

        #profilePhotoModal.show {
            display: flex !important;
        }

        #profilePhotoModal .modal-dialog {
            margin: 0 auto !important;
            max-width: 700px !important;
            width: 90% !important;
            position: relative !important;
            left: auto !important;
            right: auto !important;
            transform: none !important;
            top: auto !important;
        }

        /* ══════════════════════════════════════════
           RESPONSIVE BREAKPOINTS
        ══════════════════════════════════════════ */

        /* Tablet: 860px se neeche stack ho jaayega */
        @media (max-width: 860px) {
            .split {
                grid-template-columns: 1fr;
            }

            /* Right column upar aa jaaye mobile pe */
            .right-col {
                order: -1;
            }

            /* 3-column grid 2 pe aa jaaye */
            .g3 {
                grid-template-columns: 1fr 1fr !important;
            }
        }

        /* Mobile: 520px se neeche sab single column */
        @media (max-width: 520px) {
            .g2,
            .g3 {
                grid-template-columns: 1fr !important;
            }

            .img-grid {
                grid-template-columns: 1fr 1fr;
            }

            .card-body {
                padding: 14px;
            }
        }

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="pc">

        <!-- ── Page Header ── -->
        <div class="page-header">
            <div class="ph-title">KYC Detail</div>
            <a href="Dashboard.aspx" class="btn-back">
                <svg width="14" height="14" viewBox="0 0 14 14" fill="none">
                    <path d="M9 11L5 7l4-4" stroke="currentColor" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round" />
                </svg>
                Back to Dashboard
            </a>
        </div>

        <div class="card">

            <!-- ── Card Header ── -->
            <div class="card-header">
                <div class="card-icon">
                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                        <rect x="2" y="4" width="16" height="12" rx="2" stroke="#854F0B" stroke-width="1.4" />
                        <circle cx="7" cy="9" r="2" stroke="#854F0B" stroke-width="1.3" />
                        <path d="M3 16c.5-2 2-3 4-3s3.5 1 4 3" stroke="#854F0B" stroke-width="1.3" stroke-linecap="round" />
                        <path d="M13 8h3M13 11h2" stroke="#854F0B" stroke-width="1.3" stroke-linecap="round" />
                    </svg>
                </div>
                <div>
                    <div class="card-title">KYC Detail</div>
                    <div class="card-subtitle">
                        Dear <%=Session["MemName"].ToString()%>
                        (<asp:Label ID="lblid" runat="server"></asp:Label>) &mdash; Update Your KYC
                        (<asp:Label ID="LblIdproofText" runat="server"></asp:Label>)
                    </div>
                </div>
            </div>

            <asp:HiddenField ID="HiddenField1" runat="server" />
            <asp:HiddenField ID="hdnSessn" runat="server" />

            <div class="card-body">
                <asp:Label ID="errMsg" runat="server" CssClass="f-err show"></asp:Label>

                <!-- ══════════════════════════════════════
                     SPLIT GRID  (Left=Form, Right=Status+Images)
                ══════════════════════════════════════ -->
                <div class="split">

                    <!-- ════════════════════════
                         LEFT — FORM
                    ════════════════════════ -->
                    <div class="form-col">

                        <!-- ADDRESS PROOF -->
                        <div class="sec-div">
                            Address Proof
                            <% if (Session["CompId"] != null && Session["CompId"].ToString() == "1074") { %>
                            <span style="font-weight:400;text-transform:none;letter-spacing:0;font-size:11px">(Same as document)</span>
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
                                <asp:DropDownList ID="ddlState" runat="server" CssClass="fs" OnSelectedIndexChanged="ddlState_SelectedIndexChanged"></asp:DropDownList>
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

                        <div class="g2" style="display:none;">
                            <div class="fg">
                                <label class="fl">Area</label>
                                <asp:DropDownList ID="DDlVillage" CssClass="fs" runat="server"
                                    ValidationGroup="eInformation" autocomplete="off"
                                    onchange="FnVillageChange(this.value);">
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="g2" id="divVillage" style="display:none;">
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
                                <label class="fl"><asp:Label ID="LblAddresProof" runat="server"></asp:Label></label>
                                <asp:TextBox ID="TxtIdProofNo" CssClass="fi validate[required]" runat="server" MaxLength="16"></asp:TextBox>
                            </div>
                        </div>

                        <div class="g2" style="margin-bottom:1.5rem">
                            <div class="fg">
                                <label class="fl">Front Address Proof Upload</label>
                                <div class="fu-row">
                                    <asp:FileUpload ID="Fuidentity" runat="server" CssClass="validate[required]" />
                                </div>
                                <asp:RequiredFieldValidator ID="rfvImage" runat="server"
                                    ErrorMessage="Please select front address proof."
                                    Enabled="false" ControlToValidate="Fuidentity"
                                    ValidationGroup="eInformation" ForeColor="Red" Font-Size="12px">
                                </asp:RequiredFieldValidator>
                                <asp:Label ID="lblimage" runat="server" Visible="false" Style="font-size:12px;color:var(--success-txt)"></asp:Label>
                            </div>
                            <div class="fg">
                                <label class="fl">Back Address Proof Upload</label>
                                <div class="fu-row">
                                    <asp:FileUpload ID="FileUpload1" runat="server" CssClass="validate[required]" />
                                </div>
                                <asp:RequiredFieldValidator ID="rfvImage1" runat="server"
                                    ErrorMessage="Please select back address proof."
                                    Enabled="false" ControlToValidate="FileUpload1"
                                    ValidationGroup="eInformation" ForeColor="Red" Font-Size="12px">
                                </asp:RequiredFieldValidator>
                                <asp:Label ID="LblBackImage" runat="server" Visible="false" Style="font-size:12px;color:var(--success-txt)"></asp:Label>
                            </div>
                        </div>

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
                        </div>

                        <asp:HiddenField ID="HdnCheckTrnns" runat="server" />

                        <div class="g2">
                            <div class="fg">
                                <label class="fl">Account No</label>
                                <asp:TextBox ID="Txtacno" runat="server" CssClass="fi validate[required,custom[onlyNumberSp]]" MaxLength="20"></asp:TextBox>
                            </div>
                            <div class="fg">
                                <label class="fl">Bank</label>
                                <asp:DropDownList ID="cmbbank" runat="server" CssClass="fs"></asp:DropDownList>
                            </div>
                        </div>

                        <div class="g2" id="divBank" runat="server" visible="false">
                            <div class="fg">
                                <label class="fl">Bank Name</label>
                                <asp:TextBox ID="Txtbank" CssClass="fi" runat="server"></asp:TextBox>
                            </div>
                        </div>

                        <div class="g2">
                            <div class="fg">
                                <label class="fl">Branch Name</label>
                                <asp:TextBox ID="Txtbranch" runat="server" CssClass="fi validate[required,custom[onlyLetterNumberChar]]"></asp:TextBox>
                            </div>
                            <div class="fg">
                                <label class="fl">IFSC Code</label>
                                <asp:TextBox ID="Txtcode" runat="server" CssClass="fi validate[required,custom[ifsccode]]"></asp:TextBox>
                            </div>
                        </div>

                        <div class="g2" style="margin-bottom:1.5rem">
                            <div class="fg">
                                <label class="fl">Bank KYC Upload</label>
                                <div class="fu-row">
                                    <asp:FileUpload ID="BankKYCFileUpload3" runat="server" CssClass="validate[required]" />
                                </div>
                                <asp:Label ID="LblBankImage" runat="server" Visible="false" Style="font-size:12px;color:var(--success-txt)"></asp:Label>
                            </div>
                        </div>

                        <!-- PAN CARD -->
                        <div class="sec-div">PAN Card Detail</div>

                        <div class="g2" style="margin-bottom:1.5rem">
                            <div class="fg">
                                <label class="fl">PAN Card No.</label>
                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                    <ContentTemplate>
                                        <asp:TextBox ID="txtpan" runat="server" CssClass="fi validate[required,custom[panno]]" Style="text-transform:uppercase"></asp:TextBox>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="txtpan" EventName="TextChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </div>
                            <div class="fg">
                                <label class="fl">PAN Card Upload</label>
                                <div class="fu-row">
                                    <asp:FileUpload ID="Pankyc" runat="server" CssClass="validate[required]" />
                                </div>
                                <asp:Label ID="LblPanImage" runat="server" Visible="false" Style="font-size:12px;color:var(--success-txt)"></asp:Label>
                            </div>
                        </div>

                        <!-- SUBMIT -->
                        <div class="submit-row">
                            <asp:Button ID="BtnIdentity" runat="server"
                                ValidationGroup="eInformation"
                                CssClass="btn-primary"
                                Text="Submit"
                                OnClientClick="return ValidateAllKycFields();"
                                OnClick="BtnIdentity_Click" />
                        </div>

                    </div>
                    <%-- /form-col --%>


                    <!-- ════════════════════════
                         RIGHT — STATUS + IMAGES
                    ════════════════════════ -->
                    <div class="right-col">

                        <!-- Verification Status -->
                        <div class="side-card" id="DivVerify" runat="server">
                            <div class="sec-div" id="LblVerification" runat="server">Verification Status</div>

                            <div class="g2">
                                <div class="fg">
                                    <span class="fl">Status</span>
                                    <asp:Label ID="lblverstatus" runat="server" CssClass="fi"
                                        Style="display:flex;align-items:center;height:34px;border:none;padding:0"></asp:Label>
                                </div>
                                <div class="fg">
                                    <asp:Label ID="VerifyDate" runat="server" Text="Verify / Reject Date" Visible="false" CssClass="fl"></asp:Label>
                                    <asp:Label ID="Lblverdate" runat="server" Style="font-size:12px;color:var(--txt);padding-top:6px"></asp:Label>
                                </div>
                            </div>

                            <div class="g2">
                                <div class="fg">
                                    <asp:Label ID="LblVerfRemark" Text="Reject Remark" Visible="false" runat="server" CssClass="fl"></asp:Label>
                                    <asp:Label ID="LblRemark" runat="server" Style="font-size:12px;color:var(--danger-txt)"></asp:Label>
                                </div>
                                <div class="fg">
                                    <asp:Label ID="LblVerfReason" Text="Reject Reason" Visible="false" runat="server" CssClass="fl"></asp:Label>
                                    <asp:Label ID="LbLrejectRemark" runat="server" Style="font-size:12px;color:var(--danger-txt)"></asp:Label>
                                </div>
                            </div>
                        </div>

                        <!-- Uploaded Images -->
                        <div class="side-card">
                            <div class="sec-div">Uploaded Images</div>

                            <div class="img-grid">
                                <div class="img-card">
                                    <div class="ic-label">Front Address Proof</div>
                                    <a id="FrontAddress" runat="server" onclick="return openPhotoModal('Front')">
                                        <asp:Image ID="ShowIdentity" runat="server" Width="100%"
                                            Style="display:block;width:100%;aspect-ratio:4/3;object-fit:cover" />
                                    </a>
                                </div>
                                <div class="img-card">
                                    <div class="ic-label">Back Address Proof</div>
                                    <a id="BackAddress" runat="server" onclick="return openPhotoModal('back')">
                                        <asp:Image ID="showBackImage" runat="server" Width="100%"
                                            Style="display:block;width:100%;aspect-ratio:4/3;object-fit:cover" />
                                    </a>
                                </div>
                                <div class="img-card">
                                    <div class="ic-label">Bank Address Proof</div>
                                    <a id="BankProof" runat="server" onclick="return openPhotoModal('bank')">
                                        <asp:Image ID="bANKiMAGE" runat="server" Width="100%"
                                            Style="display:block;width:100%;aspect-ratio:4/3;object-fit:cover" />
                                    </a>
                                </div>
                                <div class="img-card">
                                    <div class="ic-label">PAN Card</div>
                                    <a id="PanCard" runat="server" onclick="return openPhotoModal('pan')">
                                        <asp:Image ID="pANiMAGE" runat="server" Width="100%"
                                            Style="display:block;width:100%;aspect-ratio:4/3;object-fit:cover" />
                                    </a>
                                </div>
                            </div>
                        </div>

                    </div>
                    <%-- /right-col --%>

                </div>
                <%-- /split --%>

            </div>
            <%-- /card-body --%>
        </div>
        <%-- /card --%>
    </div>
    <%-- /pc --%>


    <!-- IMAGE PREVIEW MODAL -->
    <div class="modal fade" id="profilePhotoModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Image Preview</h5>
                    <button type="button" class="btn-close"></button>
                </div>
                <div class="modal-body text-center p-4">
                    <div id="imgLoader" style="display:none;">
                        <div class="spinner-border text-primary" role="status"></div>
                        <p class="mt-2">Loading...</p>
                    </div>
                    <img id="photoPreview" class="img-fluid" style="max-height:500px;display:none;" />
                    <p id="noImageMsg" style="display:none;color:gray;">No image found.</p>
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
                        } else { checkStateSelection(); }
                    },
                    error: function () { alert("Unable to verify Aadhaar right now."); }
                });
            });

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
                        } else { checkStateSelection(); }
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
            ddl.value = document.getElementById('<%= StateCode.ClientID %>').value;
            if (document.getElementById('<%= StateCode.ClientID %>').value === "0") {
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
            var img = document.getElementById("photoPreview");
            var loader = document.getElementById("imgLoader");
            var noMsg = document.getElementById("noImageMsg");
            var modalEl = document.getElementById('profilePhotoModal');
            img.src = ""; img.style.display = "none";
            loader.style.display = "block"; noMsg.style.display = "none";
            modalEl.style.left = '0'; modalEl.style.width = '100vw';
            document.body.style.overflow = '';
            modalEl.classList.add('show');
            document.body.style.overflow = 'hidden';
            var allowedTypes = ["front", "back", "bank", "pan"];
            var imgType = allowedTypes.includes(reqno.toLowerCase()) ? reqno.toLowerCase() : "Payment";
            var formNo = '<%= Session["FormNo"] ?? "" %>';
            var url = "Img.aspx?type=" + imgType + "&ID=" + formNo;
            img.onload = function () { loader.style.display = "none"; img.style.display = "block"; };
            img.onerror = function () { loader.style.display = "none"; noMsg.style.display = "block"; };
            img.src = url + "&t=" + new Date().getTime();
            return false;
        }

        document.addEventListener('DOMContentLoaded', function () {
            var modalEl = document.getElementById('profilePhotoModal');
            document.querySelector('#profilePhotoModal .btn-close')?.addEventListener('click', function () {
                modalEl.classList.remove('show'); document.body.style.overflow = '';
            });
            modalEl.addEventListener('click', function (e) {
                if (e.target === modalEl) { modalEl.classList.remove('show'); document.body.style.overflow = ''; }
            });
        });
    </script>

</asp:Content>
