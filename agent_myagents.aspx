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

        #noResultsMsg {
            display: none;
            text-align: center;
            padding: 40px 20px;
            color: #6b7280;
            font-size: 14px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="pc">

        <div class="page-header">
            <div class="ph-left">
                <div class="ph-title">My Agents</div>
                <div class="ph-sub">
                    <asp:Label ID="lblHeaderSub" runat="server" Text=""></asp:Label>
                </div>
            </div>
            <div class="ph-actions">
                <input type="text" id="txtLiveSearch" class="fi"
                    placeholder="🔍 Search by name, ID, phone…"
                    style="width: 240px; padding: 9px 14px;"
                    oninput="liveSearch(this.value)" />

                <%--   <select class="fs" style="width: auto; padding: 9px 14px;">
                    <option>All Agents</option>
                </select>--%>

                <asp:Button ID="BtnAgent" runat="server" Text="+ Add Agent"
                    OnClick="BtnAgent_Click" CssClass="btn btn-primary" />
            </div>
        </div>

        <!-- TEAM KPIs -->
        <div class="kpi-grid" style="margin-bottom: 22px;">
            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-blue">🤝</div>
                </div>
                <div class="kpi-val">
                    <asp:Label ID="lblTotalAgent" runat="server" Text="0"></asp:Label></div>
                <div class="kpi-label">Total Agents</div>
            </div>
            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-gold">📋</div>
                </div>
                <div class="kpi-val">0</div>
                <div class="kpi-label">Team Bookings</div>
            </div>
            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-green">₹</div>
                </div>
                <div class="kpi-val">INR 0Cr</div>
                <div class="kpi-label">Team Sales</div>
            </div>
            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-purple">💎</div>
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
                    <div class="card-subtitle">
                        <asp:Label ID="lblRecordSummary" runat="server" CssClass="pg-summary" Text="" />
                    </div>
                </div>
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
                        </tr>
                    </thead>
                    <tbody id="agentTbody">
                        <asp:Repeater ID="rptCustomers" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td><%# RowOffset + Container.ItemIndex + 1 %></td>
                                    <td><%# Eval("Level") %></td>
                                    <td><%# Eval("idno") %></td>
                                    <td>
                                        <div style="display: flex; align-items: center; gap: 9px;">
                                            <div class="avatar av-sm" style="background: linear-gradient(135deg,#0D1B4B,#1E6FBF);">
                                                <%# Eval("memfirstname").ToString().Substring(0,1).ToUpper() %>
                                            </div>
                                            <div style="font-weight: 600; color: var(--navy)"><%# Eval("memfirstname") %></div>
                                        </div>
                                    </td>
                                    <td><%# Eval("Sponsorid") %></td>
                                    <td><%# Eval("MemberName") %></td>
                                    <td><%# Eval("mobl") %></td>
                                    <td><%# Eval("city") %></td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
                <div id="noResultsMsg">No agents found matching your search.</div>
            </div>

            <div class="pagination-bar">
                <asp:HiddenField ID="hdnTotalPages" runat="server" Value="1" />
                <asp:HiddenField ID="hdnCurrentPage" runat="server" Value="1" />
                <div style="display: flex; gap: 8px; align-items: center;">
                    <asp:Button ID="btnPrev" runat="server" Text="← Prev"
                        OnClick="BtnPrev_Click" CssClass="btn btn-outline btn-sm" />
                    <asp:Label ID="lblPageInfo" runat="server" Text="Page 1 of 1" CssClass="pg-info" />
                    <asp:Button ID="btnNext" runat="server" Text="Next →"
                        OnClick="BtnNext_Click" CssClass="btn btn-outline btn-sm" />
                </div>
            </div>
        </div>

    </div>

    <script>
        function liveSearch(term) {
            term = term.trim().toLowerCase();
            var rows = document.querySelectorAll('#agentTbody tr');
            var visibleCount = 0;

            rows.forEach(function (row) {
                var text = row.innerText.toLowerCase();
                if (term === '' || text.includes(term)) {
                    row.style.display = '';
                    visibleCount++;
                } else {
                    row.style.display = 'none';
                }
            });

            document.getElementById('noResultsMsg').style.display =
                visibleCount === 0 ? 'block' : 'none';
        }
    </script>
</asp:Content>
