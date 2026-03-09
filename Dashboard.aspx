<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/agent_dashboard.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="pc">

    <div class="page-header">
        <div class="ph-left">
            <div class="ph-title" runat="server" id="phTitle"></div>
            <div class="ph-sub" runat="server" id="phSub"></div>
        </div>
        <div class="ph-actions">
            <a href="agent_customers.aspx" class="btn btn-outline btn-sm">+ Add Customer</a>
            <button class="btn btn-primary btn-sm" onclick="#">+ New Booking</button>
        </div>
    </div>

    <!-- KPI CARDS -->
    <div class="kpi-grid">
        <div class="kpi">
            <div class="kpi-top">
                <div class="kpi-icon ki-blue">📋</div>
                <span class="kpi-trend trend-up">↑ 0%</span>
            </div>
            <div class="kpi-val">0</div>
            <div class="kpi-label">Total Bookings</div>
        </div>
        <div class="kpi">
            <div class="kpi-top">
               <div class="kpi-icon ki-gold ki-lg">₹</div>
                <span class="kpi-trend trend-up">↑ 0%</span>
            </div>
            <div class="kpi-val">INR 0Cr</div>
            <div class="kpi-label">Total Sales Value</div>
        </div>
        <div class="kpi">
    <div class="kpi-top">
        <div class="kpi-icon ki-green">👥</div>
        <span class="kpi-trend trend-up">↑</span>
    </div>
    <div class="kpi-val">
        <asp:Label ID="lblCustomers" runat="server" Text="0"></asp:Label>
    </div>
    <div class="kpi-label">My Customers</div>
</div>

       <%-- <div class="kpi">
            <div class="kpi-top">
                <div class="kpi-icon ki-green">👥</div>
                <span class="kpi-trend trend-up">↑ 0</span>
            </div>
            <div class="kpi-val">0</div>
            <div class="kpi-label">My Customers</div>
        </div>--%>
        <div class="kpi">
            <div class="kpi-top">
                <div class="kpi-icon ki-purple">💎</div>
                <span class="kpi-trend trend-up">↑ 0%</span>
            </div>
            <div class="kpi-val">INR 0L</div>
            <div class="kpi-label">Commission Earned</div>
        </div>
    </div>
    <div class="kpi-grid" style="margin-top: -6px;">
        <div class="kpi">
            <div class="kpi-top">
                <div class="kpi-icon ki-red">🏠</div>
                <span class="kpi-trend trend-up">0</span>
            </div>
            <div class="kpi-val">0</div>
            <div class="kpi-label">Plots (Total)</div>
        </div>
        <div class="kpi">
            <div class="kpi-top">
                <div class="kpi-icon ki-green">✅</div>
                <span class="kpi-trend trend-neu">0</span>
            </div>
            <div class="kpi-val">0</div>
            <div class="kpi-label">Available Plots</div>
        </div>
        <div class="kpi">
    <div class="kpi-top">
        <div class="kpi-icon ki-ocean">🤝</div>
        <span class="kpi-trend trend-up">↑</span>
    </div>
    <div class="kpi-val">
        <asp:Label ID="lblSubAgents" runat="server" Text="0"></asp:Label>
    </div>
    <div class="kpi-label">My Sub-Agents</div>
</div>
       <%-- <div class="kpi">
            <div class="kpi-top">
                <div class="kpi-icon ki-ocean">🤝</div>
                <span class="kpi-trend trend-up">↑ 0</span>
            </div>
            <div class="kpi-val">0</div>
            <div class="kpi-label">My Sub-Agents</div>
        </div>--%>
        <div class="kpi">
            <div class="kpi-top">
                <div class="kpi-icon ki-red">⚠️</div>
                <span class="kpi-trend trend-dn">0</span>
            </div>
            <div class="kpi-val">0</div>
            <div class="kpi-label">Overdue Payments</div>
        </div>
    </div>

    <!-- CHARTS ROW -->
    <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 20px; margin-bottom: 22px;" class="charts-main">
        <!-- BAR CHART -->
        <div class="card">
            <div class="card-header">
                <div>
                    <div class="card-title">Monthly Bookings & Revenue</div>
                    <div class="card-subtitle">Last 6 months performance</div>
                </div>
                <select style="border: 1.5px solid var(--border); border-radius: 8px; padding: 6px 10px; font-size: 12px; outline: none; color: var(--mid)">
                    <option>2025-26</option>
                </select>
            </div>
            <div class="card-body">
                <div style="height: 190px; display: flex; align-items: flex-end; gap: 10px; padding: 0 4px;" id="barChart"></div>
                <div style="display: flex; gap: 18px; margin-top: 14px; flex-wrap: wrap;">
                    <div style="display: flex; align-items: center; gap: 6px;">
                        <div style="width: 11px; height: 11px; border-radius: 3px; background: var(--navy)"></div>
                        <span style="font-size: 11.5px; color: var(--muted)">Bookings</span>
                    </div>
                    <div style="display: flex; align-items: center; gap: 6px;">
                        <div style="width: 11px; height: 11px; border-radius: 3px; background: var(--gold)"></div>
                        <span style="font-size: 11.5px; color: var(--muted)">Revenue (Lac INR)</span>
                    </div>
                </div>
            </div>
        </div>
        <!-- DONUT -->
        <div class="card">
            <div class="card-header">
                <div>
                    <div class="card-title">Plot Status</div>
                    <div class="card-subtitle">My 67 assigned plots</div>
                </div>
            </div>
            <div class="card-body" style="display: flex; flex-direction: column; align-items: center;">
                <div style="position: relative; width: 150px; height: 150px; margin-bottom: 18px;">
                    <svg viewBox="0 0 100 100" style="width: 100%; height: 100%; transform: rotate(-90deg)">
                        <circle cx="50" cy="50" r="38" fill="none" stroke="#E2EAF4" stroke-width="14" />
                        <circle cx="50" cy="50" r="38" fill="none" stroke="#22C55E" stroke-width="14" stroke-dasharray="90 149" />
                        <circle cx="50" cy="50" r="38" fill="none" stroke="#F5A623" stroke-width="14" stroke-dasharray="45 194" stroke-dashoffset="-90" />
                        <circle cx="50" cy="50" r="38" fill="none" stroke="#3B82F6" stroke-width="14" stroke-dasharray="35 204" stroke-dashoffset="-135" />
                        <circle cx="50" cy="50" r="38" fill="none" stroke="#9CA3AF" stroke-width="14" stroke-dasharray="13 226" stroke-dashoffset="-170" />
                    </svg>
                    <div style="position: absolute; inset: 0; display: flex; flex-direction: column; align-items: center; justify-content: center;">
                        <span style="font-family: 'Playfair Display',serif; font-size: 24px; font-weight: 900; color: var(--navy)">0</span>
                        <span style="font-size: 10px; color: var(--muted)">Total</span>
                    </div>
                </div>
                <div style="width: 100%; display: flex; flex-direction: column; gap: 8px;">
                    <div class="stat-row">
                        <div style="display: flex; align-items: center; gap: 7px;">
                            <div style="width: 10px; height: 10px; border-radius: 50%; background: #22C55E"></div>
                            <span style="font-size: 12px; color: var(--mid)">Available</span>
                        </div>
                        <span style="font-size: 13px; font-weight: 700; color: var(--navy)">0</span>
                    </div>
                    <div class="stat-row">
                        <div style="display: flex; align-items: center; gap: 7px;">
                            <div style="width: 10px; height: 10px; border-radius: 50%; background: #F5A623"></div>
                            <span style="font-size: 12px; color: var(--mid)">On Hold</span>
                        </div>
                        <span style="font-size: 13px; font-weight: 700; color: var(--navy)">0</span>
                    </div>
                    <div class="stat-row">
                        <div style="display: flex; align-items: center; gap: 7px;">
                            <div style="width: 10px; height: 10px; border-radius: 50%; background: #3B82F6"></div>
                            <span style="font-size: 12px; color: var(--mid)">Booked</span>
                        </div>
                        <span style="font-size: 13px; font-weight: 700; color: var(--navy)">0</span>
                    </div>
                    <div class="stat-row">
                        <div style="display: flex; align-items: center; gap: 7px;">
                            <div style="width: 10px; height: 10px; border-radius: 50%; background: #9CA3AF"></div>
                            <span style="font-size: 12px; color: var(--mid)">Sold</span>
                        </div>
                        <span style="font-size: 13px; font-weight: 700; color: var(--navy)">0</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- QUICK ACTIONS -->
    <div style="display: grid; grid-template-columns: repeat(5,1fr); gap: 14px; margin-bottom: 22px;" class="qa-row">
        <a href="#" style="background: var(--white); border-radius: 14px; border: 1.5px solid var(--border); padding: 18px; text-align: center; text-decoration: none; transition: all .25s; display: block;" onmouseover="this.style.borderColor='var(--ocean)';this.style.transform='translateY(-3px)';this.style.boxShadow='var(--sh-md)'" onmouseout="this.style.borderColor='var(--border)';this.style.transform='';this.style.boxShadow=''">
            <div style="font-size: 26px; margin-bottom: 8px">📋</div>
            <div style="font-size: 12.5px; font-weight: 600; color: var(--navy)">New Booking</div>
        </a>

        <a href="agent_customers.aspx" style="background: var(--white); border-radius: 14px; border: 1.5px solid var(--border); padding: 18px; text-align: center; text-decoration: none; transition: all .25s; display: block;" onmouseover="this.style.borderColor='var(--ocean)';this.style.transform='translateY(-3px)';this.style.boxShadow='var(--sh-md)'" onmouseout="this.style.borderColor='var(--border)';this.style.transform='';this.style.boxShadow=''">
            <div style="font-size: 26px; margin-bottom: 8px">👤</div>
            <div style="font-size: 12.5px; font-weight: 600; color: var(--navy)">Add Customer</div>
        </a>
        <a href="#" style="background: var(--white); border-radius: 14px; border: 1.5px solid var(--border); padding: 18px; text-align: center; text-decoration: none; transition: all .25s; display: block;" onmouseover="this.style.borderColor='var(--ocean)';this.style.transform='translateY(-3px)';this.style.boxShadow='var(--sh-md)'" onmouseout="this.style.borderColor='var(--border)';this.style.transform='';this.style.boxShadow=''">
            <div style="font-size: 26px; margin-bottom: 8px">📐</div>
            <div style="font-size: 12.5px; font-weight: 600; color: var(--navy)">Check Plots</div>
        </a>
        <a href="#" style="background: var(--white); border-radius: 14px; border: 1.5px solid var(--border); padding: 18px; text-align: center; text-decoration: none; transition: all .25s; display: block;" onmouseover="this.style.borderColor='var(--ocean)';this.style.transform='translateY(-3px)';this.style.boxShadow='var(--sh-md)'" onmouseout="this.style.borderColor='var(--border)';this.style.transform='';this.style.boxShadow=''">
            <div style="font-size: 26px; margin-bottom: 8px">🧾</div>
            <div style="font-size: 12.5px; font-weight: 600; color: var(--navy)">Receipt</div>
        </a>
        <a href="#" style="background: var(--white); border-radius: 14px; border: 1.5px solid var(--border); padding: 18px; text-align: center; text-decoration: none; transition: all .25s; display: block;" onmouseover="this.style.borderColor='var(--gold)';this.style.transform='translateY(-3px)';this.style.boxShadow='var(--sh-md)'" onmouseout="this.style.borderColor='var(--border)';this.style.transform='';this.style.boxShadow=''">
            <div style="font-size: 26px; margin-bottom: 8px">₹</div>
            <div style="font-size: 12.5px; font-weight: 600; color: var(--navy)">Commission</div>
        </a>
    </div>

    <!-- RECENT BOOKINGS TABLE -->
    <div class="card" style="margin-bottom: 22px;">
        <div class="card-header">
            <div>
                <div class="card-title">Recent Bookings</div>
                <div class="card-subtitle">Latest 5 booking transactions</div>
            </div>
            <a href="#" class="btn btn-outline btn-sm">View All →</a>
        </div>
        <div class="tbl-wrap">
            <table class="tbl">
                <thead>
                    <tr>
                        <th>Booking ID</th>
                        <th>Customer</th>
                        <th>Project / Plot</th>
                        <th>Amount</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><strong></strong></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td><span class="pill pill-green"></span></td>
                        <td><a href="#" style="color: var(--ocean); font-weight: 600; font-size: 12px;"></a></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <!-- OVERDUE ALERTS -->
    <div class="card" style="border-color: #FED7AA;">
        <div class="card-header" style="background: #FFF7ED;">
            <div>
                <div class="card-title" style="color: #92400E;">⚠️ Overdue Payments</div>
                <div class="card-subtitle" style="color: #B45309;">3 customers have missed installments</div>
            </div>
            <a href="#" class="btn btn-xs" style="background: #FEF3C7; color: #92400E; border: 1px solid #FCD34D;">View All</a>
        </div>
        <div class="tbl-wrap">
            <table class="tbl">
                <thead>
                    <tr>
                        <th>Customer</th>
                        <th>Plot</th>
                        <th>Due Amount</th>
                        <th>Due Date</th>
                        <th>Overdue By</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><strong></strong></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td><span style="color: #DC2626; font-weight: 700;"></span></td>
                        <td>
                            <button class="btn btn-xs btn-primary"></button></td>
                    </tr>
                    
                </tbody>
            </table>
        </div>
    </div>

</div>
</asp:Content>

