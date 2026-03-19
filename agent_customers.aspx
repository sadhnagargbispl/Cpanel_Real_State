<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="agent_customers.aspx.cs" Inherits="agent_customers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/agent_customers.css" rel="stylesheet" />
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
                <div class="ph-title">My Customers</div>
                <div class="ph-sub">48 customers registered under your account</div>
            </div>
            <div class="ph-actions">
                <input type="text" class="fi" placeholder="🔍 Search by name, CNIC, phone…" style="width: 240px; padding: 9px 14px;">
                <select class="fs" style="width: auto; padding: 9px 14px;">
                    <option>All Customers</option>
                    <option>With Bookings</option>
                    <option>No Booking</option>
                    <option>Overdue</option>
                </select>
                <asp:Button ID="BtnCustomer" runat="server" Text="+ Add Customer" OnClick="BtnCustomer_Click" class="btn btn-primary" />
                <%--<button class="btn btn-primary" onclick="openModal('addCustModal'); return false;">+ Add Customer</button>--%>
            </div>
        </div>

        <!-- CUSTOMER STATS -->
        <div style="display: grid; grid-template-columns: repeat(4,1fr); gap: 16px; margin-bottom: 22px;">
            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-blue">👥</div>
                    <span class="kpi-trend trend-up">↑ 0 this month</span>
                </div>

                <div class="kpi-val">
                    <asp:Label ID="lblTotalCustomers" runat="server" Text="0"></asp:Label>
                </div>

                <div class="kpi-label">Total Customers</div>
            </div>
            <%--<div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-blue">👥</div>
                    <span class="kpi-trend trend-up">↑ 0 this month</span></div>
                <div class="kpi-val">0</div>
                <div class="kpi-label">Total Customers</div>
            </div>--%>
            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-green">✅</div>
                    <span class="kpi-trend trend-up">0</span>
                </div>
                <div class="kpi-val">0</div>
                <div class="kpi-label">With Active Booking</div>
            </div>
            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-gold">⏳</div>
                    <span class="kpi-trend trend-neu">0</span>
                </div>
                <div class="kpi-val">0</div>
                <div class="kpi-label">Prospects (No Booking)</div>
            </div>
            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-red">⚠️</div>
                    <span class="kpi-trend trend-dn">0</span>
                </div>
                <div class="kpi-val">0</div>
                <div class="kpi-label">Overdue Payments</div>
            </div>
        </div>

        <div class="card">
            <div class="card-header">
                <div>
                    <div class="card-title">Customer Directory</div>
                    <div class="card-subtitle">
                        <asp:Label ID="lblRecordSummary" runat="server"
                            CssClass="pg-summary" Text="" />
                    </div>
                </div>
            </div>
            <div class="tbl-wrap">
                <table class="tbl">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Id No</th>
                            <th>Customer Name</th>

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

