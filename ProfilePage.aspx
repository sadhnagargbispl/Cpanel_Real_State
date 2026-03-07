<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="ProfilePage.aspx.cs" Inherits="ProfilePage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/AgentRegistration.css" rel="stylesheet" />
    <script>
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;

            // Allow only numbers (0-9)
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="pc">

        <div class="page-header">
            <div class="ph-left">
                <div class="ph-title">Profile</div>
                <%--<div class="ph-sub">Register a new agent under your team</div>--%>
            </div>
            <div class="ph-actions">
                <a href="Dashboard.aspx" class="btn btn-outline btn-sm">← Back to Dashboard</a>
            </div>
        </div>

        <div class="card">
            <div class="card-header">
                <div style="width: 42px; height: 42px; border-radius: 12px; background: rgba(245,166,35,.1); display: flex; align-items: center; justify-content: center; font-size: 19px;">👤</div>
                <div>
                    <div class="card-title">Profile</div>
                    <div class="card-subtitle">Update your personal information</div>
                </div>
            </div>

            <div class="card-body">
                <div class="basic-form">

                    <asp:Label ID="errMsg" runat="server" CssClass="f-err show"></asp:Label>

                    <!-- SPONSOR DETAIL -->
                    <div class="sec-div"><span>Personal Detail</span></div>
                    <div class="g2">

                        <div class="fg">
                            <label class="fl">Sponsor ID</label>
                            <asp:TextBox ID="txtReferalId"
                                CssClass="fi"
                                runat="server"
                                Enabled="False">
                            </asp:TextBox>
                        </div>

                        <div class="fg" id="DivSponsorName" runat="server" visible="false">
                            <label class="fl">Sponsor Name</label>
                            <asp:TextBox ID="TxtReferalNm"
                                CssClass="fi"
                                runat="server"
                                Enabled="False">
                            </asp:TextBox>
                        </div>

                        <div class="fg" id="DivUplinerId" runat="server" visible="false">
                            <label class="fl">Placement ID</label>
                            <asp:TextBox ID="TxtUplinerid"
                                CssClass="fi"
                                runat="server"
                                Enabled="False">
                            </asp:TextBox>
                        </div>

                        <div class="fg" id="DivUplinerName" runat="server" visible="false">
                            <label class="fl">Placement Name</label>
                            <asp:TextBox ID="TxtUplinerName"
                                CssClass="fi"
                                runat="server"
                                Enabled="False">
                            </asp:TextBox>
                        </div>
                        <div class="fg">
                            <label class="fl">Name *</label>

                            <asp:HiddenField ID="hdnSessn" runat="server" />

                            <div style="display: flex; gap: 8px;">
                                <asp:DropDownList ID="ddlPreFix"
                                    CssClass="fs"
                                    runat="server"
                                    Style="width: 100px;">
                                    <asp:ListItem Value="Mr." Text="Mr."></asp:ListItem>
                                    <asp:ListItem Value="Mrs." Text="Mrs."></asp:ListItem>
                                    <asp:ListItem Value="Miss" Text="Miss"></asp:ListItem>
                                    <asp:ListItem Value="M/S." Text="M/S."></asp:ListItem>
                                </asp:DropDownList>

                                <asp:TextBox ID="txtFrstNm"
                                    CssClass="fi"
                                    runat="server"
                                    ReadOnly="true"
                                    Style="flex: 1;">
                                </asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <div class="g2">
                        <div class="fg">
                            <label class="fl">Father's Name</label>

                            <div style="display: flex; gap: 8px;">
                                <asp:DropDownList ID="CmbType"
                                    CssClass="fs"
                                    runat="server"
                                    Style="width: 90px;">

                                    <asp:ListItem Value="S/O" Text="S/O"></asp:ListItem>
                                    <asp:ListItem Value="D/O" Text="D/O"></asp:ListItem>
                                    <asp:ListItem Value="W/O" Text="W/O"></asp:ListItem>
                                    <asp:ListItem Value="C/O" Text="C/O"></asp:ListItem>

                                </asp:DropDownList>

                                <asp:TextBox ID="txtFNm"
                                    CssClass="fi"
                                    runat="server"
                                    Style="flex: 1;">
                                </asp:TextBox>
                            </div>
                        </div>
                        <div class="fg">
                            <label class="fl">Date of Birth *</label>

                            <asp:TextBox ID="TxtDobDate"
                                CssClass="fi"
                                runat="server">
                            </asp:TextBox>

                            <ajaxToolkit:CalendarExtender
                                ID="CalendarExtender2"
                                runat="server"
                                TargetControlID="TxtDobDate"
                                Format="dd-MM-yyyy"></ajaxToolkit:CalendarExtender>

                        </div>
                    </div>



                    <div class="g2">

                        <div class="fg">
                            <label class="fl">Mobile No *</label>

                            <asp:TextBox ID="txtMobileNo"
                                CssClass="fi"
                                runat="server"
                                MaxLength="10"
                                onkeypress="return isNumberKey(event);">
                            </asp:TextBox>
                        </div>


                        <div class="fg" style="display: none;">
                            <label class="fl">Phone No</label>

                            <asp:TextBox ID="txtPhNo"
                                CssClass="fi"
                                runat="server"
                                MaxLength="10"
                                onkeypress="return isNumberKey(event);">
                            </asp:TextBox>
                        </div>
                        <div class="fg">
                            <label class="fl">E-Mail ID</label>

                            <asp:TextBox ID="txtEMailId"
                                CssClass="fi"
                                runat="server">
                            </asp:TextBox>
                        </div>

                    </div>




                    <!-- NOMINEE -->
                    <div class="sec-div"><span>Nominee Detail</span></div>

                    <div class="g2">

                        <div class="fg">
                            <label class="fl">Nominee Name</label>

                            <asp:TextBox ID="txtNominee"
                                CssClass="fi"
                                runat="server">
                            </asp:TextBox>
                        </div>


                        <div class="fg">
                            <label class="fl">Relation</label>

                            <asp:TextBox ID="txtRelation"
                                CssClass="fi"
                                runat="server">
                            </asp:TextBox>
                        </div>

                    </div>


                    <!-- ADDRESS -->
                    <div class="sec-div"><span>Postal Address</span></div>
                    <div class="g2">
                        <div class="fg">
                            <label class="fl">Address *</label>

                            <asp:TextBox ID="TxtPostalAddress"
                                CssClass="fi"
                                runat="server">
                            </asp:TextBox>
                        </div>

                        <div class="fg">
                            <label class="fl">Pincode *</label>

                            <asp:TextBox ID="TxtPostPincode"
                                CssClass="fi"
                                runat="server"
                                MaxLength="6"
                                onkeypress="return isNumberKey(event);">
                            </asp:TextBox>
                        </div>
                    </div>
                    <div class="g3">

                        <div class="fg">
                            <label class="fl">City *</label>

                            <asp:TextBox ID="TxtPostCity"
                                CssClass="fi"
                                runat="server">
                            </asp:TextBox>
                        </div>

                        <div class="fg">
                            <label class="fl">State *</label>

                            <asp:DropDownList ID="ddlPostSate"
                                runat="server"
                                CssClass="fs">
                            </asp:DropDownList>
                        </div>


                        <div class="fg">
                            <label class="fl">District *</label>

                            <asp:TextBox ID="TxtPostDistrict"
                                CssClass="fi"
                                runat="server">
                            </asp:TextBox>
                        </div>

                    </div>





                    <!-- BUTTON -->
                    <div style="margin-top: 20px; display: flex; gap: 10px;">

                        <asp:Button ID="CmdSave"
                            runat="server"
                            Text="Update Profile"
                            CssClass="btn btn-primary"
                            ValidationGroup="eInformation"
                            OnClick="CmdSave_Click" />

                        <asp:Button ID="CmdCancel"
                            runat="server"
                            Text="Cancel"
                            CssClass="btn btn-outline"
                            Visible="false"
                            OnClick="CmdCancel_Click" />

                    </div>

                </div>
            </div>
        </div>
        <%-- /card --%>
    </div>
    <%-- /pc --%>

    <%-- ── EXTRA CSS for sec-div & f-hint (if not in global stylesheet) ── --%>
</asp:Content>

