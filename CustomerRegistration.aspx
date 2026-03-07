<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="CustomerRegistration.aspx.cs" Inherits="CustomerRegistration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/AgentRegistration.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="pc">

        <div class="page-header">
            <div class="ph-left">
                <div class="ph-title">Add Customer</div>
                <div class="ph-sub">Register a new agent under your team</div>
            </div>
            <div class="ph-actions">
                <a href="agent_customers.aspx" class="btn btn-outline btn-sm">← Back to My Customer</a>
            </div>
        </div>

        <div class="card">
            <div class="card-header">
                <div style="width: 42px; height: 42px; border-radius: 12px; background: rgba(245,166,35,.1); display: flex; align-items: center; justify-content: center; font-size: 19px; flex-shrink: 0;">📋</div>
                <div>
                    <div class="card-title">Customer Registration Form</div>
                    <div class="card-subtitle">Fill in all required fields marked with *</div>
                </div>
            </div>

            <div class="card-body">
                <div class="basic-form">
                    <div class="row">
                        <div class="col-md-12">

                            <%-- ── REFERRAL & PLACEMENT ── --%>
                            <div class="g2" style="margin-bottom: 16px;">

                                <div id="Div1" class="fg" runat="server" visible="true">
                                    <label class="fl">Referral ID <span style="color: var(--red)"></span></label>
                                    <asp:TextBox ID="txtRefralId" CssClass="fi" TabIndex="1" runat="server"
                                        AutoPostBack="True" ValidationGroup="eInformation" autocomplete="off"
                                        OnTextChanged="txtRefralId_TextChanged" placeholder="Enter referral ID"></asp:TextBox>
                                    <asp:Label ID="lblRefralNm" runat="server" Style="font-size: 12px; color: #D11F7B; margin-top: 4px; display: block;"></asp:Label>
                                    <asp:HiddenField ID="HdnCheckTrnns" runat="server" />
                                </div>

                                <div class="fg" id="rwSpnsr" runat="server" visible="false">
                                    <label class="fl">Placement ID <span style="color: var(--red)">*</span></label>
                                    <asp:TextBox ID="txtUplinerId" CssClass="fi" TabIndex="2" runat="server"
                                        AutoPostBack="True" ValidationGroup="eSponsor" autocomplete="off"
                                        OnTextChanged="txtUplinerId_TextChanged" placeholder="Enter placement ID"></asp:TextBox>
                                    <asp:Label ID="lblUplnrNm" runat="server" Style="font-size: 12px; color: #D11F7B; margin-top: 4px; display: block;"></asp:Label>
                                </div>
                                <div class="fg">
                                    <label class="fl">
                                        <asp:Label ID="LblName" runat="server"></asp:Label>Name <span style="color: var(--red)">*</span>
                                    </label>
                                    <asp:TextBox ID="txtFrstNm" CssClass="fi" runat="server" TabIndex="6"
                                        ValidationGroup="eInformation" autocomplete="off"
                                        placeholder="Enter full name"></asp:TextBox>
                                </div>
                            </div>

                            <%-- ── LEG SELECTION ── --%>
                            <div class="fg" id="DivLeg1" runat="server" visible="false">
                                <label class="fl">Leg <span style="color: var(--red)">*</span></label>
                                <asp:RadioButtonList ID="RbtnLegNo" runat="server" TabIndex="3"
                                    RepeatDirection="Horizontal" AutoPostBack="true"
                                    OnSelectedIndexChanged="RbtnLegNo_SelectedIndexChanged"
                                    RepeatLayout="Flow" CssClass="radio-group" />
                            </div>

                            <%-- ── REGISTRATION TYPE ── --%>
                            <div id="dvreg" runat="server" visible="false">
                                <div class="g2" style="margin-bottom: 16px;">
                                    <div class="fg">
                                        <label class="fl">Registration As <span style="color: var(--red)">*</span></label>
                                        <asp:RadioButtonList ID="RbCategory" runat="server" RepeatDirection="Horizontal"
                                            TabIndex="4" onchange="return GetRegistrationAs()"
                                            RepeatLayout="Flow" CssClass="radio-group">
                                            <asp:ListItem Text="Individual" Value="IN" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="Company" Value="C"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </div>
                                    <div class="fg" id="RegType" style="display: none">
                                        <label class="fl">
                                            <asp:Label ID="LblRegType" Text="Registration Type" runat="server"></asp:Label>
                                            <span style="color: var(--red)">*</span>
                                        </label>
                                        <asp:RadioButtonList ID="CbSubCategory" runat="server" TabIndex="5"
                                            RepeatDirection="Horizontal" onchange="return GetRegistrationType()"
                                            RepeatLayout="Flow" CssClass="radio-group">
                                            <asp:ListItem Text="ProprietorShip" Value="SP" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="Partnership Firm" Value="PF"></asp:ListItem>
                                            <asp:ListItem Text="Private Limited Company" Value="PL"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </div>
                                </div>
                            </div>

                            <%-- ── SECTION DIVIDER: PERSONAL ── --%>
                            <%--<div class="sec-div"><span>Personal Details</span></div>--%>

                            <div class="g2">
                                <%-- NAME --%>


                                <%-- FATHER NAME --%>
                                <div class="fg" id="divFName" runat="server" visible="false">
                                    <label class="fl">Father / Husband's Name <span style="color: var(--red)">*</span></label>
                                    <div style="display: flex; gap: 8px;">
                                        <asp:DropDownList CssClass="fs" ID="CmbType" runat="server" TabIndex="7"
                                            Style="width: 90px; flex-shrink: 0; padding-left: 8px;">
                                            <asp:ListItem Value="S/O" Text="S/O"></asp:ListItem>
                                            <asp:ListItem Value="D/O" Text="D/O"></asp:ListItem>
                                            <asp:ListItem Value="W/O" Text="W/O"></asp:ListItem>
                                            <asp:ListItem Value="H/O" Text="H/O"></asp:ListItem>
                                            <asp:ListItem Value="C/O" Text="C/O"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:TextBox ID="txtFNm" runat="server" TabIndex="8" CssClass="fi"
                                            autocomplete="off" placeholder="Father / Husband name" Style="flex: 1;"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <%-- PARTNER NAME --%>
                            <div class="fg" id="TrPrtnrCap" style="display: none">
                                <label class="fl">
                                    <asp:Label ID="LblPartnerName" runat="server" Text="Partner Names (Separated by Comma)"></asp:Label>
                                </label>
                                <asp:TextBox ID="TxtPartnerNames" runat="server" CssClass="fi" placeholder="Partner 1, Partner 2..."></asp:TextBox>
                            </div>

                            <%-- COMPANY FIELDS --%>
                            <div class="g2">
                                <div class="fg" id="CompName" style="display: none">
                                    <label class="fl">Company Name <span style="color: var(--red)">*</span></label>
                                    <asp:TextBox ID="TxtCompanyName" runat="server" CssClass="fi" TabIndex="16"
                                        placeholder="Enter company name"></asp:TextBox>
                                </div>
                                <div class="fg" id="CompRegistrationNo" style="display: none">
                                    <label class="fl">Company Registration No <span style="color: var(--red)">*</span></label>
                                    <asp:TextBox ID="TxtRegistrationNo" runat="server" CssClass="fi" TabIndex="17"
                                        placeholder="Enter registration number"></asp:TextBox>
                                </div>
                            </div>

                            <%-- DOB + MARITAL STATUS --%>
                            <div class="g2">
                                <div id="Div2" class="fg" visible="false" runat="server">
                                    <label class="fl">
                                        <asp:Label ID="LblRegistDate" runat="server" Text="Date of Birth"></asp:Label>
                                        <span style="color: var(--red)">*</span>
                                    </label>
                                    <div style="display: flex; gap: 7px;">
                                        <asp:DropDownList ID="ddlDOBdt" runat="server" CssClass="fs" TabIndex="9"
                                            autocomplete="off" Style="flex: 1;">
                                        </asp:DropDownList>
                                        <asp:DropDownList ID="ddlDOBmnth" runat="server" CssClass="fs" TabIndex="10"
                                            autocomplete="off" Style="flex: 1.6;">
                                        </asp:DropDownList>
                                        <asp:DropDownList ID="ddlDOBYr" runat="server" CssClass="fs" TabIndex="11"
                                            autocomplete="off" Style="flex: 1.3;">
                                        </asp:DropDownList>
                                    </div>
                                </div>

                                <div class="fg" id="Div3" visible="false" runat="server">
                                    <label class="fl">Marital Status <span style="color: var(--red)">*</span></label>
                                    <asp:RadioButtonList ID="RbtMarried" runat="server" RepeatColumns="2"
                                        RepeatDirection="Horizontal" RepeatLayout="Flow" TabIndex="12"
                                        onchange="return GetSelectedItem()" autocomplete="off" CssClass="radio-group">
                                        <asp:ListItem Text="Married" Value="Y"></asp:ListItem>
                                        <asp:ListItem Text="UnMarried" Value="N"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                            </div>

                            <%-- MARRIAGE DATE --%>
                            <div class="fg" id="divMarriageDate" style="display: none;">
                                <label class="fl">Marriage Date <span style="color: var(--red)">*</span></label>
                                <div style="display: flex; gap: 7px; max-width: 360px;">
                                    <asp:DropDownList ID="DDlMDay" runat="server" CssClass="fs" TabIndex="13" Style="flex: 1;"></asp:DropDownList>
                                    <asp:DropDownList ID="DDLMMonth" runat="server" CssClass="fs" TabIndex="14" Style="flex: 1.6;"></asp:DropDownList>
                                    <asp:DropDownList ID="DDLMYear" runat="server" CssClass="fs" TabIndex="15" Style="flex: 1.3;"></asp:DropDownList>
                                </div>
                            </div>

                            <%-- ── SECTION DIVIDER: CONTACT ── --%>
                            <div id="dvpin" runat="server" visible="true">
                                <div class="sec-div"><span>Contact Details</span></div>

                                <div class="fg" id="Div4" visible="false" runat="server">
                                    <label class="fl">Street Address <span style="color: var(--red)">*</span></label>
                                    <asp:TextBox ID="txtAddLn1" CssClass="fi" TabIndex="18" runat="server"
                                        autocomplete="off" placeholder="House No., Street, Colony / Mohalla..."></asp:TextBox>
                                </div>

                                <div class="g3">
                                    <div class="fg">
                                        <label class="fl">Pin Code <span style="color: var(--red)">*</span></label>
                                        <asp:TextBox ID="txtPinCode" CssClass="fi" onkeypress="return isNumberKey(event);"
                                            TabIndex="19" runat="server" MaxLength="6" autocomplete="off"
                                            AutoPostBack="true" placeholder="6-digit pin code"></asp:TextBox>
                                    </div>
                                    <div class="fg">
                                        <label class="fl">State <span style="color: var(--red)">*</span></label>
                                        <asp:DropDownList ID="CmbState" runat="server" CssClass="fs" TabIndex="13">
                                        </asp:DropDownList>
                                        <asp:TextBox ID="txtStateName" runat="server" CssClass="fi" TabIndex="16"
                                            autocomplete="off" Enabled="false" placeholder="Auto-filled" Visible="false"></asp:TextBox>
                                        <asp:HiddenField ID="StateCode" runat="server" />
                                    </div>
                                    <div class="fg" visible="false" runat="server">
                                        <label class="fl">District <span style="color: var(--red)">*</span></label>
                                        <asp:TextBox ID="ddlDistrict" CssClass="fi" TabIndex="17" runat="server"
                                            autocomplete="off" Enabled="false" placeholder="Auto-filled"></asp:TextBox>
                                        <asp:HiddenField ID="HDistrictCode" runat="server" />
                                    </div>
                                    <div class="fg">
                                        <label class="fl">City <span style="color: var(--red)">*</span></label>
                                        <asp:TextBox ID="ddlTehsil" CssClass="fi" TabIndex="18" runat="server"
                                            ValidationGroup="eInformation" autocomplete="off" 
                                           ></asp:TextBox>
                                        <asp:HiddenField ID="HCityCode" runat="server" />
                                    </div>
                                </div>

                                <div class="g2" visible="false" runat="server">

                                    <div class="fg">
                                        <label class="fl">Area <span style="color: var(--red)">*</span></label>
                                        <asp:DropDownList ID="DDlVillage" CssClass="fs" TabIndex="19" runat="server"
                                            ValidationGroup="eInformation" autocomplete="off"
                                            onchange="FnVillageChange(this.value);">
                                        </asp:DropDownList>
                                    </div>
                                </div>

                                <div class="fg" id="divVillage" style="display: none">
                                    <label class="fl">Area Name <span style="color: var(--red)">*</span></label>
                                    <asp:TextBox ID="TxtVillage" CssClass="fi" TabIndex="20" runat="server"
                                        autocomplete="off" placeholder="Enter area / village name"></asp:TextBox>
                                </div>

                                <%-- POSTAL ADDRESS --%>
                                <div id="Dvfld" runat="server" visible="false">
                                    <div style="display: flex; align-items: center; gap: 10px; margin: 16px 0 12px;">
                                        <asp:CheckBox ID="ChkSame" runat="server" onclick="return GetSameAsPostal()" TabIndex="21" />
                                        <label class="fl" style="margin: 0; cursor: pointer;" onclick="document.getElementById('<%=ChkSame.ClientID%>').click()">
                                            Postal address same as above
                                   
                                        </label>
                                    </div>

                                    <div class="sec-div"><span>Postal Address</span></div>

                                    <div class="fg">
                                        <label class="fl">Address <span style="color: var(--red)">*</span></label>
                                        <asp:TextBox ID="TxtPostalAddress" CssClass="fi" TabIndex="22" runat="server"
                                            autocomplete="off" placeholder="Postal address"></asp:TextBox>
                                    </div>
                                    <div class="g3">
                                        <div class="fg">
                                            <label class="fl">Pin Code <span style="color: var(--red)">*</span></label>
                                            <asp:TextBox ID="TxtPostPincode" CssClass="fi" onkeypress="return isNumberKey(event);"
                                                TabIndex="23" runat="server" MaxLength="6" autocomplete="off"
                                                AutoPostBack="true" placeholder="6-digit pin"></asp:TextBox>
                                        </div>
                                        <div class="fg">
                                            <label class="fl">State <span style="color: var(--red)">*</span></label>
                                            <asp:TextBox ID="TxtpostState" runat="server" CssClass="fi" TabIndex="24"
                                                autocomplete="off" Enabled="false" placeholder="Auto-filled"></asp:TextBox>
                                            <asp:HiddenField ID="HPostStateCode" runat="server" />
                                        </div>
                                        <div class="fg">
                                            <label class="fl">District <span style="color: var(--red)">*</span></label>
                                            <asp:TextBox ID="TxtPostDistrict" CssClass="fi" TabIndex="25" runat="server"
                                                autocomplete="off" Enabled="false" placeholder="Auto-filled"></asp:TextBox>
                                            <asp:HiddenField ID="HPostDistrict" runat="server" />
                                        </div>
                                    </div>
                                    <div class="g2">
                                        <div class="fg">
                                            <label class="fl">City <span style="color: var(--red)">*</span></label>
                                            <asp:TextBox ID="TxtPostCity" CssClass="fi" TabIndex="26" runat="server"
                                                ValidationGroup="eInformation" autocomplete="off" Enabled="false"
                                                placeholder="Auto-filled"></asp:TextBox>
                                            <asp:HiddenField ID="HPostCity" runat="server" />
                                        </div>
                                        <div class="fg">
                                            <label class="fl">Area <span style="color: var(--red)">*</span></label>
                                            <asp:DropDownList ID="DDlPostVillage" CssClass="fs" TabIndex="27" runat="server"
                                                ValidationGroup="eInformation" autocomplete="off"
                                                onchange="FnPostVillageChange(this.value);">
                                            </asp:DropDownList>
                                            <asp:HiddenField ID="HPostVillage" runat="server" />
                                        </div>
                                    </div>
                                    <div class="fg" id="divPostVillage" style="display: none">
                                        <label class="fl">Area Name <span style="color: var(--red)">*</span></label>
                                        <asp:TextBox ID="TxtPostVillage" CssClass="fi" TabIndex="28" runat="server"
                                            autocomplete="off" placeholder="Enter area / village name"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <%-- ── SECTION DIVIDER: CONTACT INFO ── --%>
                            <%--  <div class="sec-div"><span>Contact Information</span></div>--%>

                            <%-- COUNTRY --%>


                            <%-- MOBILE --%>
                            <div class="g2">
                                <div id="Div5" class="fg" runat="server" visible="false">
                                    <label class="fl">Country <span style="color: var(--red)">*</span></label>
                                    <asp:DropDownList ID="ddlCountryNAme" runat="server" CssClass="fs"
                                        AutoPostBack="true" OnSelectedIndexChanged="ddlCountryNAme_SelectedIndexChanged"
                                        Style="max-width: 360px;">
                                    </asp:DropDownList>
                                </div>
                                <div class="fg">
                                    <label class="fl">Mobile No. <span style="color: var(--red)">*</span></label>
                                    <div style="display: flex; gap: 8px;">
                                        <asp:TextBox ID="ddlMobileNAme" CssClass="fi" runat="server"
                                            ValidationGroup="eInformation" autocomplete="off" Enabled="false"
                                            Style="width: 90px; flex-shrink: 0;" Visible="false"></asp:TextBox>
                                        <asp:TextBox ID="txtMobileNo" onkeypress="return isNumberKey(event);"
                                            CssClass="fi" runat="server" MaxLength="10"
                                            ValidationGroup="eInformation" autocomplete="off"
                                            placeholder="10-digit mobile number" Style="flex: 1;"></asp:TextBox>
                                    </div>
                                </div>
                                <div id="Div7" class="fg" runat="server">
                                    <label class="fl">E-Mail ID <span style="color: var(--red)">*</span></label>
                                    <asp:TextBox ID="txtEMailId" CssClass="fi" TabIndex="31" runat="server"
                                        autocomplete="off" placeholder="agent@example.com"></asp:TextBox>
                                    <asp:Label ID="LblEmainID" runat="server" CssClass="error" Visible="false"
                                        Style="font-size: 11px; color: var(--red); margin-top: 4px; display: block;"></asp:Label>
                                </div>
                                <div id="Div6" class="fg" visible="false" runat="server">
                                    <label class="fl">Phone No. <span style="color: var(--red)">*</span></label>
                                    <asp:TextBox ID="txtPhNo" onkeypress="return isNumberKey(event);" CssClass="fi"
                                        TabIndex="30" runat="server" MaxLength="10" autocomplete="off"
                                        placeholder="Landline number"></asp:TextBox>
                                </div>
                            </div>

                            <%-- EMAIL --%>


                            <%-- WALLET --%>
                            <div id="Div966" class="fg" runat="server" visible="false">
                                <label class="fl">Wallet Address</label>
                                <asp:TextBox ID="TxtWalletaddress" CssClass="fi" TabIndex="31" runat="server"
                                    autocomplete="off" placeholder="Enter wallet address"></asp:TextBox>
                                <asp:HiddenField ID="HdnWalletAddress" runat="server" />
                                <asp:HiddenField ID="HiddenField4" runat="server" />
                                <asp:HiddenField ID="Hdnhhhgg" runat="server" />
                            </div>

                            <%-- ── SECTION DIVIDER: KYC ── --%>
                            <%-- <div class="sec-div"><span>KYC Details</span></div>--%>

                            <div class="g2">
                                <%-- PAN --%>
                                <div id="Div8" class="fg" runat="server" visible="false">
                                    <label class="fl">PAN No Available <span style="color: var(--red)">*</span></label>
                                    <asp:RadioButtonList ID="RbtPan" runat="server" RepeatColumns="2"
                                        RepeatDirection="Horizontal" RepeatLayout="Flow" TabIndex="41"
                                        CssClass="radio-group">
                                        <asp:ListItem Text="Yes" Value="Y" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <div class="f-hint">
                                        <asp:Label ID="LblPanNoAvail" runat="server" Text="Payout will deduct 20% if PAN not entered."></asp:Label>
                                    </div>
                                </div>

                                <div id="Div9" class="fg" runat="server" visible="false">
                                    <label class="fl">PAN No. <span style="color: var(--red)">*</span></label>
                                    <asp:TextBox ID="txtPanNo" CssClass="fi" TabIndex="42" runat="server"
                                        autocomplete="off" placeholder="ABCDE1234F" MaxLength="10"
                                        oninput="this.value=this.value.toUpperCase()"></asp:TextBox>
                                </div>
                            </div>

                            <%-- AADHAAR --%>
                            <div id="Div10" class="fg" runat="server" visible="false">
                                <label class="fl">Aadhaar No. <span style="color: var(--red)">*</span></label>
                                <div style="display: flex; gap: 8px; align-items: center; max-width: 340px;">
                                    <asp:TextBox ID="TxtAAdhar1" CssClass="fi" TabIndex="43" runat="server"
                                        onkeypress="return isNumberKey(event);" MaxLength="4" autocomplete="off"
                                        placeholder="XXXX" Style="text-align: center; letter-spacing: 2px;"></asp:TextBox>
                                    <span style="color: var(--muted); font-weight: 700; flex-shrink: 0;">—</span>
                                    <asp:TextBox ID="TxtAadhar2" CssClass="fi" TabIndex="44" runat="server"
                                        onkeypress="return isNumberKey(event);" MaxLength="4" autocomplete="off"
                                        placeholder="XXXX" Style="text-align: center; letter-spacing: 2px;"></asp:TextBox>
                                    <span style="color: var(--muted); font-weight: 700; flex-shrink: 0;">—</span>
                                    <asp:TextBox ID="TxtAadhar3" CssClass="fi" TabIndex="45" runat="server"
                                        onkeypress="return isNumberKey(event);" MaxLength="4" autocomplete="off"
                                        placeholder="XXXX" Style="text-align: center; letter-spacing: 2px;"></asp:TextBox>
                                </div>
                            </div>

                            <%-- ── SECTION DIVIDER: BANK ── --%>
                            <%-- <div class="sec-div"><span>Bank Details</span></div>--%>

                            <div class="g2">
                                <div class="fg" runat="server" visible="false">
                                    <label class="fl">Nominee Name <span style="color: var(--red)">*</span></label>
                                    <asp:TextBox ID="txtNominee" CssClass="fi" TabIndex="32" runat="server"
                                        autocomplete="off" placeholder="Nominee full name"></asp:TextBox>
                                </div>
                                <div class="fg" runat="server" visible="false">
                                    <label class="fl">Relation <span style="color: var(--red)">*</span></label>
                                    <asp:TextBox ID="txtRelation" CssClass="fi" TabIndex="33" runat="server"
                                        autocomplete="off" placeholder="e.g. Spouse, Son, Daughter"></asp:TextBox>
                                </div>
                            </div>

                            <div class="g2">
                                <div class="fg" runat="server" visible="false">
                                    <label class="fl">Account No. <span style="color: var(--red)">*</span></label>
                                    <asp:TextBox ID="TxtAccountNo" onkeypress="return isNumberKey(event);" CssClass="fi"
                                        TabIndex="34" runat="server" MaxLength="16" autocomplete="off"
                                        placeholder="Enter account number"></asp:TextBox>
                                </div>
                                <div class="fg" runat="server" visible="false">
                                    <label class="fl">Account Type <span style="color: var(--red)">*</span></label>
                                    <asp:DropDownList ID="DDLAccountType" runat="server" CssClass="fs" TabIndex="21">
                                        <asp:ListItem Text="Choose Account Type" Value="0" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="Saving Account" Value="SAVING ACCOUNT"></asp:ListItem>
                                        <asp:ListItem Text="Current Account" Value="CURRENT ACCOUNT"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <div class="g2">
                                <div class="fg" runat="server" visible="false">
                                    <label class="fl">Bank <span style="color: var(--red)">*</span></label>
                                    <asp:DropDownList ID="CmbBank" runat="server" CssClass="fs" TabIndex="36"
                                        onchange="FnBankChange(this.value);" autocomplete="off">
                                    </asp:DropDownList>
                                </div>
                                <div class="fg" id="divBank" style="display: none">
                                    <label class="fl">Bank Name <span style="color: var(--red)">*</span></label>
                                    <asp:TextBox ID="TxtBank" CssClass="fi" TabIndex="37" runat="server"
                                        autocomplete="off" placeholder="Enter bank name"></asp:TextBox>
                                </div>
                            </div>

                            <div class="g2">
                                <div class="fg" runat="server" visible="false">
                                    <label class="fl">Branch Name <span style="color: var(--red)">*</span></label>
                                    <asp:TextBox ID="TxtBranchName" CssClass="fi" TabIndex="38" runat="server"
                                        autocomplete="off" placeholder="Bank branch name"></asp:TextBox>
                                </div>
                                <div class="fg" runat="server" visible="false">
                                    <label class="fl">IFSC Code <span style="color: var(--red)">*</span></label>
                                    <asp:TextBox ID="txtIfsCode" runat="server" CssClass="fi" TabIndex="39"
                                        autocomplete="off" placeholder="e.g. SBIN0001234"
                                        oninput="this.value=this.value.toUpperCase()"></asp:TextBox>
                                </div>
                            </div>

                            <asp:TextBox ID="TxtMICR" CssClass="fi" Visible="false" TabIndex="40" runat="server" autocomplete="off"></asp:TextBox>

                            <%-- ── SECTION DIVIDER: PAYMENT ── --%>
                            <div class="g3">
                                <div class="fg" runat="server" visible="false">
                                    <label class="fl">Select Paymode <span style="color: var(--red)">*</span></label>
                                    <asp:DropDownList ID="DdlPaymode" runat="server" AutoPostBack="true" CssClass="fs"
                                        TabIndex="46" autocomplete="off">
                                    </asp:DropDownList>
                                </div>
                                <div class="fg" runat="server" visible="false">
                                    <label class="fl">
                                        <asp:Label ID="LblDDNo" runat="server" Text="Draft / Cheque No."></asp:Label>
                                    </label>
                                    <asp:TextBox ID="TxtDDNo" CssClass="fi" TabIndex="47" runat="server"
                                        MaxLength="15" autocomplete="off" placeholder="Cheque / DD number"></asp:TextBox>
                                </div>
                                <div class="fg" runat="server" visible="false">
                                    <label class="fl">
                                        <asp:Label ID="LblDDDate" runat="server" Text="Draft / Cheque Date"></asp:Label>
                                    </label>
                                    <asp:TextBox ID="TxtDDDate" runat="server" TabIndex="48" CssClass="fi"
                                        autocomplete="off" placeholder="dd-MMM-yyyy"></asp:TextBox>
                                    <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server"
                                        TargetControlID="TxtDDDate" Format="dd-MMM-yyyy"></ajaxToolkit:CalendarExtender>
                                </div>
                            </div>

                            <div class="g2">
                                <div class="fg" runat="server" visible="false">
                                    <label class="fl">Issued Bank Name</label>
                                    <asp:TextBox ID="TxtIssueBank" CssClass="fi" TabIndex="49" runat="server"
                                        autocomplete="off" placeholder="Issuing bank name"></asp:TextBox>
                                </div>
                                <div class="fg" runat="server" visible="false">
                                    <label class="fl">Issued Bank Branch</label>
                                    <asp:TextBox ID="TxtIssueBranch" CssClass="fi" TabIndex="50" runat="server"
                                        autocomplete="off" placeholder="Issuing branch name"></asp:TextBox>
                                </div>
                            </div>

                            <%-- ── SECTION DIVIDER: ACCOUNT ── --%>
                            <%--  <div class="sec-div"><span>Account Credentials</span></div>--%>

                            <div id="Div11" class="fg" visible="false" runat="server" style="max-width: 420px;">
                                <label class="fl">Transaction Password <span style="color: var(--red)">*</span></label>
                                <asp:TextBox ID="TxtTransactionPassword" CssClass="fi" TabIndex="52" runat="server"
                                    TextMode="Password" ValidationGroup="eInformation" autocomplete="off"
                                    placeholder="5–10 characters"></asp:TextBox>
                            </div>

                            <div id="divOtp" runat="server" visible="false">
                                <div class="g2">
                                    <div class="fg">
                                        <label class="fl">Password <span style="color: var(--red)">*</span></label>
                                        <asp:TextBox ID="TxtPasswd" CssClass="fi" TabIndex="51" runat="server"
                                            TextMode="Password" autocomplete="off" placeholder="Min. 8 characters"></asp:TextBox>
                                    </div>
                                    <div class="fg">
                                        <label class="fl">Confirm Password <span style="color: var(--red)">*</span></label>
                                        <asp:TextBox ID="pass2" CssClass="fi" runat="server" TextMode="Password"
                                            autocomplete="off" placeholder="Re-enter password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" Display="Dynamic"
                                            ControlToValidate="TxtPasswd" runat="server"
                                            CssClass="f-err show" ErrorMessage="Password cannot be blank"></asp:RequiredFieldValidator>
                                        <asp:CompareValidator ID="CompareValidator1" ControlToValidate="TxtPasswd"
                                            ControlToCompare="pass2" Type="String" Operator="Equal"
                                            Text="Passwords must match!" runat="Server"
                                            Style="font-size: 11px; color: var(--red); margin-top: 4px; display: block;" />
                                    </div>
                                </div>

                                <div class="fg" style="display: none; max-width: 360px;">
                                    <label class="fl">Enter OTP <span style="color: var(--red)">*</span></label>
                                    <div class="f-hint" style="margin-bottom: 6px;">OTP sent to your registered Email ID</div>
                                    <asp:TextBox ID="TxtOtp" CssClass="fi" runat="server" autocomplete="off"
                                        placeholder="Enter OTP" ValidationGroup="eInformation"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" Display="Dynamic"
                                        ControlToValidate="TxtOtp" runat="server" ValidationGroup="eInformation"
                                        CssClass="f-err show">OTP is required</asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <%-- ── TERMS ── --%>
                            <asp:Label ID="lblErrEpin" runat="server" CssClass="f-err show"></asp:Label>

                            <div class="fg" style="margin-top: 8px;">
                                <div style="display: flex; align-items: center; gap: 10px;">
                                    <asp:CheckBox ID="chkterms" runat="server" onclick="DivOnOff();" TabIndex="53" />
                                    <label style="font-size: 13px; color: var(--mid); cursor: pointer;">
                                        I agree with
                                   
                                        <a href="#" data-toggle="modal" data-target="#myModalTerm"
                                            style="color: var(--ocean); font-weight: 600;">Terms &amp; Conditions</a>
                                    </label>
                                </div>
                            </div>

                            <%-- ── SUBMIT BUTTONS ── --%>
                            <asp:Label ID="errMsg" runat="server"
                                Style="font-size: 12px; color: var(--red); display: block; margin-bottom: 12px;"></asp:Label>

                            <div id="DivTerms" runat="server" visible="true"
                                style="display: flex; gap: 10px; flex-wrap: wrap; margin-top: 4px;">
                                <asp:Button ID="CmdSave" runat="server" Text="✓ Submit" CssClass="btn btn-primary"
                                    TabIndex="54" OnClick="CmdSave_Click" />
                                <asp:Button ID="CmdCancel" runat="server" Text="Cancel" CssClass="btn btn-outline"
                                    ValidationGroup="eCancel" TabIndex="55" Visible="true" />
                            </div>

                            <asp:Button ID="BtnOtp" runat="server" Text="Submit OTP" CssClass="btn btn-navy"
                                Visible="false" ValidationGroup="eInformation" OnClick="BtnOtp_Click" />
                            <asp:Button ID="ResendOtp" runat="server" Text="Resend OTP" CssClass="btn btn-outline"
                                Visible="false" ValidationGroup="eInformation" OnClick="ResendOtp_Click" />

                        </div>
                    </div>
                </div>
            </div>
            <%-- /card-body --%>
        </div>
        <%-- /card --%>
    </div>
    <%-- /pc --%>

    <%-- ── EXTRA CSS for sec-div & f-hint (if not in global stylesheet) ── --%>
</asp:Content>

