<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="Complain.aspx.cs" Inherits="Complain" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
      <link href="css/agent_customers.css" rel="stylesheet" />
    <style>
        #noResultsMsg { display:none; text-align:center; padding:40px 20px; color:#6b7280; font-size:14px; }
        .success-box {
            background: #f0fdf4;
            border: 1px solid #86efac;
            border-radius: 10px;
            padding: 16px 20px;
            color: #166534;
            font-size: 14px;
            margin-bottom: 18px;
            display: flex;
            align-items: flex-start;
            gap: 10px;
        }
        .success-box .si { font-size: 20px; flex-shrink: 0; }
        .char-count { font-size: 12px; color: #6b7280; margin-top: 4px; }
    </style>
    <script type="text/javascript">
        function CountChar() {
            var el = document.getElementById('<%=TxtDesc.ClientID%>');
            var remaining = 500 - el.value.length;
            document.getElementById("remainingC").innerText = remaining + " characters remaining";
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="pc">

        <!-- PAGE HEADER -->
        <div class="page-header">
            <div class="ph-left">
                <div class="ph-title">Raise a Complaint</div>
                <div class="ph-sub">Submit your query or grievance</div>
            </div>
            <div class="ph-actions">
                <a href="Dashboard.aspx" class="btn btn-outline btn-sm">← Back to Dashboard</a>
            </div>
        </div>

        <!-- SUCCESS MESSAGE -->
        <div id="DivError" runat="server" visible="false" class="success-box">
            <span class="si">✅</span>
            <span id="spanError" runat="server"></span>
        </div>

        <!-- Hidden labels needed by code-behind -->
        <asp:Label ID="LblCompalin" runat="server" Visible="false"></asp:Label>
        <asp:Label ID="Lblgroup"    runat="server" Visible="false"></asp:Label>
        <asp:Label ID="Label2"      runat="server" Visible="false"></asp:Label>
        <asp:HiddenField ID="HdnCheckTrnns" runat="server" />

        <!-- FORM CARD -->
        <div class="card">
            <div class="card-header">
                <div style="width:42px;height:42px;border-radius:12px;background:rgba(245,166,35,.1);display:flex;align-items:center;justify-content:center;font-size:19px;flex-shrink:0;">📋</div>
                <div>
                    <div class="card-title">Complaint Form</div>
                    <div class="card-subtitle">Fields marked with <span style="color:red">*</span> are required</div>
                </div>
            </div>

            <div class="card-body">

                <!-- ROW 1: Member ID (read-only) + Complaint Type -->
                <div class="g2" style="margin-bottom:16px;">
                    <div class="fg">
                        <label class="fl">Member ID</label>
                        <asp:TextBox ID="TxtDirectSeller" runat="server" CssClass="fi"
                            Enabled="false" PlaceHolder="Member ID"
                            AutoPostBack="true"></asp:TextBox>
                    </div>
                    <div class="fg">
                        <label class="fl">Nature of Grievance <span style="color:red;font-weight:bold">*</span></label>
                        <asp:DropDownList ID="CmbCmplntType" runat="server" CssClass="fs"></asp:DropDownList>
                    </div>
                </div>

                <!-- ROW 2: Subject -->
                <div class="g1" style="margin-bottom:16px;">
                    <div class="fg">
                        <label class="fl">Subject <span style="color:red;font-weight:bold">*</span></label>
                        <asp:TextBox ID="TxtSubject" runat="server" CssClass="fi validate[required]"
                            PlaceHolder="Enter subject" ValidationGroup="Save"></asp:TextBox>
                    </div>
                </div>

                <!-- ROW 3: Description -->
                <div class="g1" style="margin-bottom:16px;">
                    <div class="fg">
                        <label class="fl">Description <span style="color:red;font-weight:bold">*</span></label>
                        <asp:TextBox ID="TxtDesc" runat="server" TextMode="MultiLine"
                            CssClass="fi validate[required]"
                            ValidationGroup="Save"
                            onkeyup="CountChar();"
                            MaxLength="500"
                            Rows="5"
                            PlaceHolder="Describe your issue in detail…"></asp:TextBox>
                        <div class="char-count"><span id="remainingC">500 characters remaining</span></div>
                    </div>
                </div>

                <!-- Hidden fields used internally by code-behind -->
                <asp:TextBox ID="TxtName"    runat="server" Visible="false"></asp:TextBox>
                <asp:TextBox ID="TxtMobl"    runat="server" Visible="false"></asp:TextBox>
                <asp:TextBox ID="TxtEmail"   runat="server" Visible="false"></asp:TextBox>

                <!-- BUTTONS -->
                <div style="display:flex;gap:10px;margin-top:8px;">
                    <asp:Button ID="BtnSubMit" runat="server" Text="✓ Submit Complaint"
                        CssClass="btn btn-primary"
                        ValidationGroup="Save"
                        OnClick="BtnSubmit_Click" />
                    <a href="Dashboard.aspx" class="btn btn-outline">Cancel</a>
                </div>

                <asp:ValidationSummary ID="ValidationSummary1" runat="server"
                    ShowMessageBox="true" ShowSummary="false" ValidationGroup="Save" />

            </div>
        </div>

    </div>
</asp:Content>
