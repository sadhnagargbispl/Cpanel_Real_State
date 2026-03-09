<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="agent_customers.aspx.cs" Inherits="agent_customers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/agent_customers.css" rel="stylesheet" />
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
                    <span class="kpi-trend trend-up">0</span></div>
                <div class="kpi-val">0</div>
                <div class="kpi-label">With Active Booking</div>
            </div>
            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-gold">⏳</div>
                    <span class="kpi-trend trend-neu">0</span></div>
                <div class="kpi-val">0</div>
                <div class="kpi-label">Prospects (No Booking)</div>
            </div>
            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-red">⚠️</div>
                    <span class="kpi-trend trend-dn">0</span></div>
                <div class="kpi-val">0</div>
                <div class="kpi-label">Overdue Payments</div>
            </div>
        </div>

        <div class="card">
            <div class="card-header">
                <div>
                    <div class="card-title">Customer Directory</div>
                    <div class="card-subtitle">All registered customers</div>
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
          <%--   <th>Actions</th>--%>
            </tr>
        </thead>

        <tbody>

            <asp:Repeater ID="rptCustomers" runat="server">
                <ItemTemplate>
                    <tr>
                        <td><%# Container.ItemIndex + 1 %></td>
                            <td><%# Eval("idno") %></td>
                        <td>
                            <div style="display:flex; align-items:center; gap:9px;">
                                <div class="avatar av-sm" style="background:linear-gradient(135deg,#0D1B4B,#1E6FBF);"></div>
                                <div>
                                    <div style="font-weight:600;color:var(--navy)">
                                        <%# Eval("memfirstname") %>
                                    </div>
                                   
                                </div>
                            </div>
                        </td>

                    

                        <td><%# Eval("mobl") %></td>
                        <td><%# Eval("city") %></td>
                         <td> <span class='pill <%# Eval("Status").ToString() == "Active" ? "pill-green" : "pill-red" %>'>
        <%# Eval("Status") %>
    </span></td>
                       

                       <%-- <td>
                            <div style="display:flex;gap:5px;">
                                <button class="btn btn-navy btn-xs">View</button>
                                <button class="btn btn-outline btn-xs">Book</button>
                            </div>
                        </td>--%>

                    </tr>
                </ItemTemplate>
            </asp:Repeater>

        </tbody>
    </table>
</div>
          <%--  <div class="tbl-wrap">
                <table class="tbl">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Customer</th>
                            <th>CNIC</th>
                            <th>Phone</th>
                            <th>City</th>
                            <th>Bookings</th>
                            <th>Registered</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td style="color: var(--muted)"></td>
                            <td>
                                <div style="display: flex; align-items: center; gap: 9px;">
                                    <div class="avatar av-sm" style="background: linear-gradient(135deg,#0D1B4B,#1E6FBF); flex-shrink: 0"></div>
                                    <div>
                                        <div style="font-weight: 600; color: var(--navy)"></div>
                                        <div style="font-size: 11px; color: var(--muted)"></div>
                                    </div>
                                </div>
                            </td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td><span class="pill pill-blue"></span></td>
                            <td style="color: var(--muted)"></td>
                            <td><span class="pill pill-green"></span></td>
                            <td>
                                <div style="display: flex; gap: 5px;">
                                    <button class="btn btn-navy btn-xs">View</button>
                                    <button class="btn btn-outline btn-xs" onclick="location.href='agent_bookings.html'">Book</button></div>
                            </td>
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

