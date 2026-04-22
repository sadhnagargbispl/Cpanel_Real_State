<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master"
    AutoEventWireup="true"
    CodeFile="MyDirects.aspx.cs"
    Inherits="MyDirects" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">
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
        .pg-summary { font-size: 13px; color: #6b7280; }
        .pg-info { font-size: 13px; color: #374151; min-width: 90px; text-align: center; }
        #noResultsMsg { display:none; text-align:center; padding:40px 20px; color:#6b7280; font-size:14px; }
    </style>

    <div class="pc">

        <!-- PAGE HEADER -->
        <div class="page-header">
            <div class="ph-left">
                <div class="ph-title">My Direct Report</div>
                <div class="ph-sub">View your direct team members summary</div>
            </div>
            <div class="ph-actions">
                <input type="text" id="txtLiveSearch" class="fi"
                    placeholder="🔍 Search by name, ID, phone…"
                    style="width: 240px; padding: 9px 14px;"
                    oninput="liveSearch(this.value)" />

                <asp:Button ID="BtnAgent" runat="server" Text="+ Add Agent"
                    OnClick="BtnAgent_Click" CssClass="btn btn-primary" />
            </div>
        </div>

        <!-- SEARCH PANEL -->
        <div class="card" style="display:none;">
            <div class="card-header">
                <div><div class="card-title">Search Filters</div></div>
            </div>
            <div class="card-body">
                <div class="g4">
                    <div class="fg">
                        <label>Search By</label>
                        <asp:DropDownList ID="rbtnsearch" runat="server" CssClass="fs">
                            <asp:ListItem Text="Level Wise" Selected="True" Value="L"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="fg" id="lbllevel" runat="server">
                        <label>Level</label>
                        <asp:DropDownList ID="DdlLevel" CssClass="fs" TabIndex="1" runat="server"></asp:DropDownList>
                    </div>
                    <div class="fg">
                        <label>Search</label>
                        <asp:DropDownList ID="DDlSearchby" CssClass="fs" TabIndex="2" runat="server">
                            <asp:ListItem Text="All" Value="" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="Active" Value="Y"></asp:ListItem>
                            <asp:ListItem Text="Deactive" Value="N"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="fg" style="padding:5%">
                        <asp:Button ID="BtnSubmit" runat="server" Text="Search" TabIndex="3"
                            CssClass="btn btn-primary" OnClick="BtnSubmit_Click" />
                    </div>
                </div>
            </div>
        </div>

        <!-- KPI SUMMARY -->
        <div class="kpi-grid" style="margin-top:20px;">
            <div class="kpi">
                <div class="kpi-top"><div class="kpi-icon ki-blue">👥</div></div>
                <div class="kpi-val"><span id="TotalDirect" runat="server">0</span></div>
                <div class="kpi-label">Joining</div>
                <div style="font-size:12px;color:#6b7280;">
                    Direct : <span id="tdDirectleft" runat="server">0</span>
                    | Indirect : <span id="tdDirectright" runat="server">0</span>
                </div>
            </div>
            <div class="kpi">
                <div class="kpi-top"><div class="kpi-icon ki-green">✅</div></div>
                <div class="kpi-val"><span id="TotalActive" runat="server">0</span></div>
                <div class="kpi-label">Active</div>
                <div style="font-size:12px;color:#6b7280;">
                    Direct : <span id="tddirectActive" runat="server">0</span>
                    | Indirect : <span id="tdindirectActive" runat="server">0</span>
                </div>
            </div>
            <div id="Tr1" runat="server" visible="false" class="kpi">
                <div class="kpi-top"><div class="kpi-icon ki-purple">💎</div></div>
                <div class="kpi-val"><span id="totalunit" runat="server">0</span></div>
                <div class="kpi-label">BV</div>
                <div style="font-size:12px;color:#6b7280;">
                    Direct : <span id="Directunit" runat="server">0</span>
                    | Indirect : <span id="indirectunit" runat="server">0</span>
                </div>
            </div>
        </div>

        <!-- TABLE SECTION -->
        <div class="card">
            <div class="card-header">
                <div>
                    <div class="card-title">Direct Team Summary</div>
                    <div class="card-subtitle">
                        Total Records : <asp:Label ID="lblTotalRecords" runat="server" />
                    </div>
                </div>
            </div>

            <div class="tbl-wrap">
                <table id="customers2" class="tbl">
                    <thead>
                        <tr>
                            <th>SNo</th>
                            <th>Level</th>
                            <th>ID No</th>
                            <th>Member Name</th>
                            <th>Active Status</th>
                            <th>Activation Date</th>
                        </tr>
                    </thead>
                    <tbody id="directTbody">
                        <asp:Repeater ID="RptDirects" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblRowNumber"
                                            Text='<%# RowOffset + Container.ItemIndex + 1 %>'
                                            runat="server" />
                                    </td>
                                    <td><%# Eval("Level") %></td>
                                    <td><%# Eval("[Member ID]") %></td>
                                    <td>
                                        <div style="display:flex;gap:8px;align-items:center;">
                                            <div class="avatar av-sm"
                                                style="background:linear-gradient(135deg,#0D1B4B,#1E6FBF);">
                                                <%# Eval("[Member Name]").ToString().Substring(0,1) %>
                                            </div>
                                            <div><%# Eval("[Member Name]") %></div>
                                        </div>
                                    </td>
                                    <td>
                                        <span class='pill <%# Eval("[Active Status]").ToString()=="Active" ? "pill-green" : "pill-red" %>'>
                                            <%# Eval("[Active Status]") %>
                                        </span>
                                    </td>
                                    <td><%# Eval("[Activation Date]") %></td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
                <div id="noResultsMsg">No records found matching your search.</div>
            </div>

            <div class="pagination-bar">
                <asp:HiddenField ID="hdnTotalPages" runat="server" Value="1" />
                <asp:HiddenField ID="hdnCurrentPage" runat="server" Value="1" />
                <div style="display:flex;gap:8px;align-items:center;">
                    <asp:Button ID="btnPrev" runat="server" Text="← Prev"
                        OnClick="lnkPrev_Click" CssClass="btn btn-outline btn-sm" />
                    <asp:Label ID="lblPageInfo" runat="server"
                        Text="Page 1 of 1" CssClass="pg-info" />
                    <asp:Button ID="btnNext" runat="server" Text="Next →"
                        OnClick="lnkNext_Click" CssClass="btn btn-outline btn-sm" />
                </div>
            </div>
        </div>

    </div>

    <script>
        function liveSearch(term) {
            term = term.trim().toLowerCase();
            var rows = document.querySelectorAll('#directTbody tr');
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
