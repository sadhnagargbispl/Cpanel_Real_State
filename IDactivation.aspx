<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="IDactivation.aspx.cs" Inherits="IDactivation" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/AgentRegistration.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="pc">

        <div class="page-header">
            <div class="ph-left">
                <div class="ph-title">Id Activation</div>
                <%--<div class="ph-sub">Register a new agent under your team</div>--%>
            </div>
            <div class="ph-actions">
                <a href="Dashboard.aspx" class="btn btn-outline btn-sm">← Back to My Dashboard</a>
            </div>
        </div>

        <div class="card">
            <div class="card-header">
                <div style="width: 42px; height: 42px; border-radius: 12px; background: rgba(245,166,35,.1); display: flex; align-items: center; justify-content: center; font-size: 19px; flex-shrink: 0;">📋</div>
                <div>
                    <div class="card-title">Id Activation</div>
                    <div class="card-subtitle">Fill in all required fields marked with *</div>
                </div>
            </div>

            <div class="card-body">
                <div class="basic-form">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="g12" style="margin-bottom: 16px;">
                                                            <h4>Available Balance : <span style="color: Red; font-weight: bold" id="AvailableBal"
    runat="server"></span>
</h4>
                            </div> 
                            
                            <div class="g2" >
                                <div class="fg" id="DiMemberId" runat="server">
                                    <label class="fl">
                                        Member Id <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                    <asp:TextBox ID="txtMemberId" runat="server" CssClass="fi validate[required]" OnTextChanged="txtMemberId_TextChanged"
                                        AutoPostBack="true"></asp:TextBox>
                                    <asp:Label ID="lblFormno" runat="server" Visible="false"></asp:Label>
                                    <asp:HiddenField ID="HdnCheckTrnns" runat="server" />
                                </div>
                                <div class="fg" id="DivMemberName" runat="server">
                                    <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                        <ContentTemplate>
                                            <label class="fl">
                                                Member Name<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                            <asp:Label ID="LblMobile" runat="server" Visible="false"></asp:Label>
                                            <asp:Label ID="lblemail" runat="server" Visible="false"></asp:Label>
                                            <asp:TextBox ID="TxtMemberName" runat="server" CssClass="fi" Enabled="false"></asp:TextBox>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </div>
                                  <asp:Label ID="LblError" runat="server" Visible="false"></asp:Label>
                            <div class="g2">
                                <div class="fg" id="DivUplinerId" runat="server" visible="false">
                                    <label for="inputdefault">
                                        Payment Type</label>
                                    <asp:DropDownList ID="DDLPaymode" runat="server" class="fi" AutoPostBack="true" OnSelectedIndexChanged="DDLPaymode_SelectedIndexChanged">
                                        <asp:ListItem Text="Wallet" Value="1"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <asp:Label ID="LblCondition" runat="server" Visible="false"></asp:Label>
                                <asp:Label ID="kitid" runat="server" Visible="false"></asp:Label>
                            </div>
                            <div class="g2">
                                <div class="fg" id="DivUplinerName" runat="server" visible="true">
                                    <label class="fl">
                                        Select Package : <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                    <asp:DropDownList ID="CmbKit" runat="server" CssClass="fi" AutoPostBack="true" OnSelectedIndexChanged="CmbKit_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                                <div class="fg" id="divstacktype" runat="server" visible="false">
                                    <label class="fl">
                                        Stack Type <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                    <asp:DropDownList ID="DDlStackType" runat="server" class="fi" AutoPostBack="true">
                                    </asp:DropDownList>
                                </div>
                                <div class="fg">
                                    <label class="fl">
                                        Amount <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span>
                                    </label>
                                    <asp:TextBox ID="txtAmount" runat="server" CssClass="fi validate[required]"
                                        onchange="checkWAmt();" onkeypress="return isNumberKey(event);" OnTextChanged="txtAmount_TextChanged" AutoPostBack="true" ReadOnly="true">
                                    </asp:TextBox>
                                    <asp:Label ID="LblAmount" runat="server" Visible="false"></asp:Label>
                                    <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtAmount"
                                        ErrorMessage="Enter numbers Only." ValidationExpression="((\d+)((\.\d{1,2})?))$" />--%>
                                    <asp:HiddenField ID="hdnMacadrs" runat="server" />
                                    <asp:HiddenField ID="HdnTopupSeq" runat="server" />
                                    <asp:HiddenField ID="HdnMemberMacAdrs" runat="server" />
                                    <asp:HiddenField ID="HdnMemberTopupseq" runat="server" />
                                    <asp:HiddenField ID="MemberStatus" runat="server" />
                                    <asp:HiddenField ID="hdnFormno" runat="server" />
                                </div>
                                <div class="fg" id="divpassword" runat="server">
                                    <label class="fl">
                                        Transaction Password :<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span>
                                    </label>
                                    <asp:TextBox ID="TxtTransPass" CssClass="fi" runat="server"
                                        TextMode="Password"></asp:TextBox>
                                </div>
                                <div class="fg" id="divotp" visible="false" runat="server">
                                    <label class="fl">
                                        Enter OTP Sent on your E-mail Id.<span style="color: Red; font-weight: bold; font-size: 1.4em">*</span>
                                    </label>
                                    <asp:TextBox ID="TxtOtp" CssClass="fi validate[required]" runat="server"
                                        autocomplete="off" placeholder="Enter OTP"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" Display="Dynamic" ControlToValidate="TxtOtp"
                                        runat="server" ValidationGroup="Save">Opt Required
                                    </asp:RequiredFieldValidator>
                                </div>
                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                    <ContentTemplate>
                                        <div class="form-group" id="DivCurrency" runat="server" visible="false">
                                            <label for="inputdefault">
                                                Currency <span class="red">*</span></label>
                                            <asp:DropDownList ID="ddlcurrency" runat="server" CssClass="fi">
                                            </asp:DropDownList>
                                        </div>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="DDLPaymode" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </div>


                            <%-- ── REFERRAL & PLACEMENT ── --%>
                            <%--<div class="g2" style="margin-bottom: 16px;">

                                <div id="Div1" class="fg" runat="server" visible="true">
                                    <label class="fl">Available Balance: <span style="color: var(--red)"></span></label>
                                    <asp:TextBox ID="AvailableBal" CssClass="fi" TabIndex="1" runat="server"
                                        ValidationGroup="eInformation" autocomplete="off"
                                        ></asp:TextBox>
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
                            </div>--%>

                            <div>
                                <asp:Button ID="cmdSave1" runat="server" Text="✓ Submit" CssClass="btn btn-primary"
                                    TabIndex="54" OnClick="cmdSave1_Click" />
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

