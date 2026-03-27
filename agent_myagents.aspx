<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="agent_myagents.aspx.cs" Inherits="agent_myagents" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/agent_myagents.css" rel="stylesheet" />
    <script>
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }
    </script>
    <style>
        .pagination-bar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 12px 18px;
            border-top: 1px solid #e8eaf0;
        }

        .pg-summary {
            font-size: 13px;
            color: #6b7280;
        }

        .pg-info {
            font-size: 13px;
            color: #374151;
            min-width: 90px;
            text-align: center;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="pc">


        <div class="page-header">
            <div class="ph-left">
                <div class="ph-title">My Agents</div>
                <div class="ph-sub">5 sub-agents working under your team</div>
            </div>
            <div class="ph-actions">
                <button class="btn btn-outline btn-sm">📊 Team Report</button>
                <asp:Button ID="BtnAgent" runat="server" Text="+ Add Agent" OnClick="BtnAgent_Click" class="btn btn-primary" />
            </div>
        </div>
        <!-- TEAM KPIs -->
        <div class="kpi-grid" style="margin-bottom: 22px;">
            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-blue">🤝</div>
                    <span class="kpi-trend trend-up">↑ 0</span>
                </div>

                <div class="kpi-val">
                    <asp:Label ID="lblTotalAgent" runat="server" Text="0"></asp:Label>
                </div>

                <div class="kpi-label">Total Agents</div>
            </div>

            <%-- <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-blue">🤝</div>
                    <span class="kpi-trend trend-up">↑ 0</span>
                </div>
                <div class="kpi-val">0</div>
                <div class="kpi-label">Active Sub-Agents</div>
            </div>--%>
            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-gold">📋</div>
                    <span class="kpi-trend trend-up">↑ 0</span>
                </div>
                <div class="kpi-val">0</div>
                <div class="kpi-label">Team Bookings</div>
            </div>
            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-green">₹</div>
                    <span class="kpi-trend trend-up">↑ 0%</span>
                </div>
                <div class="kpi-val">INR 0Cr</div>
                <div class="kpi-label">Team Sales</div>
            </div>
            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-purple">💎</div>
                    <span class="kpi-trend trend-up">↑ 0%</span>
                </div>
                <div class="kpi-val">INR 0K</div>
                <div class="kpi-label">Team Commission</div>
            </div>
        </div>

        <!-- TEAM PERFORMANCE TABLE -->
        <div class="card">
            <div class="card-header">
                <div>
                    <div class="card-title">Team Performance Summary</div>
                    <div class="card-subtitle">   <asp:Label ID="lblRecordSummary" runat="server"
       CssClass="pg-summary" Text="" /></div>
                </div>
                <button class="btn btn-outline btn-sm">⬇ Export</button>
            </div>

            <div class="tbl-wrap">
                <table class="tbl">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Level</th>
                            <th>Customer ID</th>
                            <th>Customer Name</th>
                            <th>Sponsor ID</th>
                            <th>Sponsor Name</th>
                            <th>Phone No</th>
                            <th>City</th>
                            <th>Status</th>
                        </tr>
                    </thead>

                    <tbody>

                        <asp:Repeater ID="rptCustomers" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td><%# Container.ItemIndex + 1 %></td>
                                    <td><%# Eval("Level") %></td>
                                    <td><%# Eval("idno") %></td>
                                    <td>
                                        <div style="display: flex; align-items: center; gap: 9px;">
                                            <div class="avatar av-sm" style="background: linear-gradient(135deg,#0D1B4B,#1E6FBF);"><%# Eval("memfirstname").ToString().Substring(0, 1).ToUpper() %></div>
                                            <div>
                                                <div style="font-weight: 600; color: var(--navy)">
                                                    <%# Eval("memfirstname") %>
                                                </div>

                                            </div>
                                        </div>
                                    </td>
                                    <td><%# Eval("Sponsorid") %></td>
                                    <td><%# Eval("MemberName") %></td>
                                    <td><%# Eval("mobl") %></td>
                                    <td><%# Eval("city") %></td>
                                    <td><span class='pill <%# Eval("Status").ToString() == "Active" ? "pill-green" : "pill-red" %>'>
                                        <%# Eval("Status") %>
                                    </span></td>



                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>

                    </tbody>
                </table>
            </div>
            <div class="pagination-bar">
                <asp:HiddenField ID="hdnTotalPages" runat="server" Value="1" />
                <asp:HiddenField ID="hdnCurrentPage" runat="server" Value="1" />

             

                <div style="display: flex; gap: 8px; align-items: center;">
                    <asp:Button ID="btnPrev" runat="server" Text="← Prev"
                        OnClick="BtnPrev_Click" CssClass="btn btn-outline btn-sm" />

                    <asp:Label ID="lblPageInfo" runat="server"
                        Text="Page 1 of 1" CssClass="pg-info" />

                    <asp:Button ID="btnNext" runat="server" Text="Next →"
                        OnClick="BtnNext_Click" CssClass="btn btn-outline btn-sm" />
                </div>
            </div>
            <%--   <div class="tbl-wrap">
                <table class="tbl">
                    <thead>
                        <tr>
                            <th>Agent</th>
                            <th>Bookings</th>
                            <th>Sales Value</th>
                            <th>Commission</th>
                            <th>Customers</th>
                            <th>Target %</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <div style="display: flex; align-items: center; gap: 8px;">
                                    <div class="avatar av-sm" style="background: linear-gradient(135deg,#0D1B4B,#1E6FBF)"></div>

                                </div>
                            </td>
                            <td></td>
                            <td></td>
                            <td style="font-weight: 700; color: #166534"></td>
                            <td></td>
                            <td>
                                <div class="progress-bar" style="width: 80px; display: inline-block">
                                    <div class="progress-fill" style="width: 0%; background: var(--navy)"></div>
                                </div>
                            </td>
                            <td><span class="pill pill-green"></span></td>
                        </tr>
                    </tbody>
                </table>
            </div>--%>
        </div>

    </div>
    <script>
        function openModal(id) {
            var el = document.getElementById(id);
            console.log('Element found:', el); // Check karein console mein
            if (el) {
                el.style.display = 'flex'; // classList ki jagah direct style
            }
        }
        function closeModal(id) {
            var el = document.getElementById(id);
            if (el) {
                el.style.display = 'none';
            }
        }
        document.addEventListener('click', function (e) {
            if (e.target.classList.contains('modal-bg')) {
                e.target.style.display = 'none';
            }
        });
    </script>
</asp:Content>

