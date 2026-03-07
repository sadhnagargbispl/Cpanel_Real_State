<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="Welcome.aspx.cs" Inherits="Welcome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/Welcome.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="pc">

        <!-- PAGE HEADER -->
        <div class="page-header">
            <div class="ph-left">
                <div class="ph-title">Welcome Letter</div>
                <%--<div class="ph-sub">Agent registration successful</div>--%>
            </div>
            <div class="ph-actions">
                                    <asp:Button ID="Button1" runat="server" Text="← Go to Dashboard" CssClass="btn btn-navy"
TabIndex="54" OnClick="Button1_Click" />
               <%-- <button class="btn btn-outline btn-sm">← Dashboard</button>--%>
                <button class="btn btn-outline btn-sm" onclick="window.print()">🖨️ Print</button>
                <%--<button class="btn btn-primary btn-sm">+ New Joining</button>--%>
            </div>
        </div>

        <!-- CARD -->
        <div class="card">
            <div class="card-body" style="padding: 0;">
                <div class="wl-wrap">

                    <!-- SUCCESS STRIP -->
                    <%--<div class="wl-success-strip">
                        <div class="wl-success-icon">✓</div>
                        <div>
                            <div class="wl-success-title">Registration Successful!</div>
                             <div class="wl-success-sub">Agent has been added to your team</div>
                        </div>
                    </div>--%>
                    <!-- PRINTABLE -->
                    <div id="PrintableArea">

                        <!-- HEADER -->
                        <div class="wl-header">
                            <div class="wl-logo-row">
                                <div class="wl-logo-icon">🏙️</div>
                                <div>
                                    <div class="wl-company">Sky Is Your Limit</div>
                                    <div class="wl-portal">Agent Portal</div>
                                </div>
                            </div>
                            <div class="wl-title-block">
                                <div class="wl-title-line"></div>
                                <div class="wl-title-txt">Welcome Letter</div>
                                <div class="wl-title-line"></div>
                            </div>
                        </div>

                        <!-- GREETING -->
                        <div class="wl-greeting">
                            <div class="wl-greeting-label">Dear</div>
                            <div class="wl-greeting-name">
                                <asp:Label ID="LblName" runat="server"></asp:Label></div>
                            <div class="wl-greeting-id">ID:
                                <asp:Label ID="LblIdno" runat="server"></asp:Label></div>
                            <div class="wl-greeting-date">Date:
                                <asp:Label ID="lblDoj" runat="server"></asp:Label></div>
                        </div>

                        <!-- MESSAGE -->
                        <div class="wl-message">
                            <p>
                                We are delighted to welcome you to the <strong>Sky Is Your Limit</strong> family.
            Your registration has been successfully completed and your account is now active.
            Below are your account credentials — please keep them safe and confidential.
                            </p>
                        </div>

                        <!-- TABLE -->
                        <div class="wl-details-wrap">
                            <div class="wl-details-title">Account Details</div>
                            <table class="wl-table">
                                <tbody>
                                    <tr>
                                        <td class="wl-td-label"><span class="wl-td-icon">👤</span> Member Name</td>
                                        <td class="wl-td-value">
                                            <asp:Label ID="LblName1" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="wl-td-label"><span class="wl-td-icon">🪪</span> Member ID</td>
                                        <td class="wl-td-value">
                                            <asp:Label ID="LblIdno1" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="wl-td-label"><span class="wl-td-icon">📅</span> Joining Date</td>
                                        <td class="wl-td-value">
                                            <asp:Label ID="lblDoj1" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="wl-td-label"><span class="wl-td-icon">🔒</span> Password</td>
                                        <td class="wl-td-value wl-pass"><span class="wl-pass-val">
                                            <asp:Label ID="lblPassw" runat="server"></asp:Label></span></td>
                                    </tr>
                                    <tr>
                                        <td class="wl-td-label"><span class="wl-td-icon">🔑</span> Transaction Password</td>
                                        <td class="wl-td-value wl-pass"><span class="wl-pass-val">
                                            <asp:Label ID="lblTransPassw" runat="server"></asp:Label></span></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <!-- INFO BOX -->
                        <div class="wl-info-box">
                            <div class="wl-info-icon">⚠️</div>
                            <div>
                                Please change your password immediately after your first login.
            Do not share your credentials with anyone.
                            </div>
                        </div>

                        <!-- FOOTER -->
                        <div class="wl-footer">
                            <div class="wl-footer-msg">
                                Thank you for joining the <strong>ConnectDots</strong> family.<br>
                                We wish you great success in your journey with us.
                            </div>
                            <div class="wl-footer-sig">
                                <div class="wl-sig-line"></div>
                                <div class="wl-sig-name"><%=Session["CompName"]%></div>
                                <div class="wl-sig-title">Authorised Signatory</div>
                            </div>
                        </div>

                    </div>
                    <!-- /PrintableArea -->

                    <!-- ACTIONS -->
                    <div class="wl-actions">
                         <asp:Button ID="CmdDashboard" runat="server" Text="← Go to Dashboard" CssClass="btn btn-navy"
     TabIndex="54" OnClick="CmdDashboard_Click" />

                        <%--<button class="btn btn-navy">← Go to Dashboard</button>--%>
                        <button class="btn btn-outline" onclick="window.print()">🖨️ Print Letter</button>
                       <%-- <button class="btn btn-primary">+ Add Another Agent</button>--%>
                    </div>

                </div>
            </div>
        </div>

    </div>


    <script>
        function PrintDiv() {
            window.print();
        }
</script>

</asp:Content>

