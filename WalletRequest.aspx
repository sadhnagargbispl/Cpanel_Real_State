<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="WalletRequest.aspx.cs" Inherits="WalletRequest" %>

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
                <div class="ph-title">Wallet Request</div>
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
                    <div class="card-title">Wallet Request</div>
                    <div class="card-subtitle">Update your personal information</div>
                </div>
            </div>

            <div class="card-body">
                <div class="basic-form">

                    <asp:Label ID="errMsg" runat="server" CssClass="f-err show"></asp:Label>

                    <!-- SPONSOR DETAIL -->
                    <%-- <div class="sec-div"><span>Personal Detail</span></div>--%>
                    <div class="g2">
                        <div class="fg">
                            <label class="fl">
                                Enter Amount<span class="red">*</span></label>
                            <asp:HiddenField ID="hdnSessn" runat="server" />
                            <asp:TextBox runat="server" onkeypress="return isNumberKey(event);" MaxLength="8"
                                TabIndex="29" ID="TxtAmount" class="fi validate[required]"></asp:TextBox>
                            <asp:HiddenField ID="HdnCheckTrnns" runat="server" />
                        </div>
                        <div class="fg">
                            <label class="fl">
                                Select Paymode<span class="red">*</span></label>
                            <asp:DropDownList ID="DdlPaymode" runat="server" AutoPostBack="true" CssClass="fi"
                                TabIndex="31" OnSelectedIndexChanged="DdlPaymode_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="g2">
                        <div class="fg" id="divDDno" runat="server" visible="false">
                            <label class="fl">
                                <asp:Label ID="LblDDNo" runat="server" Text="Draft/CHEQUE No. *"></asp:Label>
                            </label>
                            <asp:TextBox ID="TxtDDNo" class="fi validate[required,custom[onlyLetterNumberChar]]"
                                TabIndex="34" runat="server" MaxLength="35" AutoPostBack="true" onkeypress="return AvoidSpace(event)" OnTextChanged="TxtDDNo_TextChanged"></asp:TextBox>
                        </div>
                        <div class="fg" id="divDDDate" runat="server">
                            <label class="fl">
                                <asp:Label ID="LblDDDate" runat="server" Text="Transaction Date *"></asp:Label>
                            </label>
                            <asp:TextBox ID="TxtDDDate" runat="server" class="fi validate[required]"
                                TabIndex="37"></asp:TextBox>
                            <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="TxtDDDate"
                                Format="dd-MMM-yyyy"></ajaxToolkit:CalendarExtender>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TxtDDDate"
                                ErrorMessage="Invalid Date" Font-Names="arial" Font-Size="10px" SetFocusOnError="True" ForeColor="Red"
                                ValidationExpression="^(?:((31-(Jan|Mar|May|Jul|Aug|Oct|Dec))|((([0-2]\d)|30)-(Jan|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec))|(([01]\d|2[0-8])-Feb))|(29-Feb(?=-((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)))))-((1[6-9]|[2-9]\d)\d{2})$"
                                ValidationGroup="Form-submit"></asp:RegularExpressionValidator>
                        </div>
                    </div>
                    <div class="g2">
                        <div class="fg" id="DivBank" runat="server">
                            <label class="fl">
                                Select Your Bank Name
                            </label>
                            <asp:DropDownList ID="DDlBank" runat="server" TabIndex="38" CssClass="fi">
                            </asp:DropDownList>
                        </div>
                        <div class="fg greybt" id="DivBranch" runat="server">
                            <label class="fl">
                                Branch Name</label>
                            <asp:TextBox ID="TxtIssueBranch" class="fi validate[required]" TabIndex="39"
                                runat="server"></asp:TextBox>
                        </div>

                    </div>
                    <div class="g2">

                        <div class="fg" id="divupcopy" runat="server" visible="false">
                            <label class="fl">
                                Upload Copy: <span class="red">*</span></label>
                            <asp:FileUpload runat="server" ID="FlDoc" class="fi validate[required]" />
                            <asp:CustomValidator ID="CustomValidator1" OnServerValidate="ValidateFileSize" ForeColor="Red"
                                runat="server" ValidationGroup="eInformation" />
                            <asp:Label ID="LblImage" runat="server" Visible="false"></asp:Label>
                        </div>
                        <div class="fg greybt" id="divupcopyREm" runat="server" visible="true">
                            <label class="fl">
                                Remarks <span class="red">*</span></label>
                            <asp:TextBox ID="TxtRemarks" class="fi validate[required]" MaxLength="240"
                                TabIndex="41" runat="server"></asp:TextBox>
                        </div>

                    </div>
                    <div class="g2">
                        <div class="fg">
                            <label class="fl">Enter Transaction Password <span class="red">*</span></label>
                            <asp:TextBox ID="TxtPassword" runat="server" TextMode="Password" CssClass="fi"></asp:TextBox>

                        </div>
                        <br />
                        <div class="fg">
                            <asp:Button ID="cmdSave1" runat="server" Text="Submit" TabIndex="45" class="btn btn-primary"
                                ValidationGroup="eInformation" OnClick="cmdSave1_Click" />
                        </div>
                        <br />
                        <div class="fg">

                            <span style="color: Black">Note:- 1. Post 5 P.M. payment will get approved on next working
day.<br />
                                &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;2. There must be a single transaction
against a request.</span>

                            <br />
                            <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True"
                                ShowSummary="False" ValidationGroup="eInformation" />


                        </div>

                    </div>

                </div>
            </div>
        </div>
        <%-- /card --%>
    </div>
    <%-- /pc --%>

    <%-- ── EXTRA CSS for sec-div & f-hint (if not in global stylesheet) ── --%>
</asp:Content>

