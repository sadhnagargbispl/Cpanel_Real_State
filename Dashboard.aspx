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
                <a href="booking.aspx" class="btn btn-primary btn-sm">+ New Booking</a>
                <%--<button class="btn btn-primary btn-sm" onclick="#">+ New Booking</button>--%>
            </div>
        </div>

        <!-- KPI CARDS -->
        <div class="kpi-grid">
            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-blue">📋</div>
                  <%--  <span class="kpi-trend trend-up">↑ 0%</span>--%>
                </div>
                <div class="kpi-val">0</div>
                <div class="kpi-label">Total Bookings</div>
            </div>
            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-gold ki-lg">₹</div>
                   <%-- <span class="kpi-trend trend-up">↑ 0%</span>--%>
                </div>
                <div class="kpi-val">
                    INR
                    <asp:Label ID="Lbltotalagentbusiness" runat="server" Text="0"></asp:Label>Cr
                </div>
                <div class="kpi-label">Total Sales Value</div>
            </div>
            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-green">👥</div>
                   <%-- <span class="kpi-trend trend-up">↑</span>--%>
                </div>
                <div class="kpi-val">
                    <asp:Label ID="lblCustomers" runat="server" Text="0"></asp:Label>
                </div>
                <div class="kpi-label">My Customers</div>
            </div>
            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-purple">💎</div>
                    <%--<span class="kpi-trend trend-up">↑ 0%</span>--%>
                </div>
                <div class="kpi-val">
                    INR
                    <asp:Label ID="LblAgentsBusiness" runat="server" Text="0"></asp:Label>L
                </div>
                <div class="kpi-label">Commission Earned</div>
            </div>
        </div>

        <div class="kpi-grid" style="margin-top: -6px;">
            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-red">🏠</div>
                    <%--<span class="kpi-trend trend-up">0</span>--%>
                </div>
                <div class="kpi-val">0</div>
                <div class="kpi-label">Plots (Total)</div>
            </div>
            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-green">✅</div>
                   <%-- <span class="kpi-trend trend-neu">0</span>--%>
                </div>
                <div class="kpi-val">0</div>
                <div class="kpi-label">Available Plots</div>
            </div>
            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-ocean">🤝</div>
                   <%-- <span class="kpi-trend trend-up">↑</span>--%>
                </div>
                <div class="kpi-val">
                    <asp:Label ID="lblSubAgents" runat="server" Text="0"></asp:Label>
                </div>
                <div class="kpi-label">My Sub-Agents</div>
            </div>
            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-red">⚠️</div>
                  <%--  <span class="kpi-trend trend-dn">0</span>--%>
                </div>
                <div class="kpi-val">0</div>
                <div class="kpi-label">Overdue Payments</div>
            </div>
        </div>
        <!-- REFERRAL LINKS -->
        <!-- REFERRAL LINKS -->
        <div class="card" style="margin-bottom: 22px; border: 2px solid #e0e7ff; box-shadow: 0 4px 24px rgba(59,130,246,0.10);">
            <div class="card-header" style="background: linear-gradient(135deg, #1e3a5f 0%, #2563eb 100%); border-bottom: none; border-radius: 10px 10px 0 0;">
                <div>
                    <div class="card-title" style="text-transform: uppercase; letter-spacing: 1.5px; font-size: 13px; color: #fff; font-weight: 700;">
                        🔗 My Referral Links
                    </div>
                    <div style="font-size: 11px; color: #93c5fd; margin-top: 2px;">Share these links to earn commissions</div>
                </div>
            </div>
            <div style="padding: 16px; display: flex; flex-direction: column; gap: 12px; background: #f0f6ff; border-radius: 0 0 10px 10px;">

                <!-- CUSTOMER LINK -->
                <div style="display: flex; align-items: center; background: #fff; border-radius: 10px; box-shadow: 0 2px 10px rgba(220,38,38,0.10); overflow: hidden;">
                    <div style="background: linear-gradient(135deg, #f2a21f, #f2a21f); color: #fff; font-weight: 800; font-size: 11px; padding: 0 18px; min-width: 90px; text-align: center; align-self: stretch; display: flex; align-items: center; justify-content: center; letter-spacing: 1px; flex-direction: column; gap: 4px;">
                        <span style="font-size: 18px;">👤</span>
                        CUSTOMER
                    </div>
                    <div style="flex: 1; padding: 12px 16px; font-size: 12px; color: #1e40af; word-break: break-all; font-family: 'Courier New', monospace; background: #eff6ff; font-weight: 600; border-left: 1px dashed #bfdbfe;">
                        <asp:Label ID="lblCUSTOMERLeftLink" runat="server" Text=""></asp:Label>
                    </div>
                    <div style="padding: 12px 14px; background: #fff; display: flex; gap: 8px;">
                        <button style="background: linear-gradient(135deg, #16a34a, #15803d); color: #fff; border: none; padding: 9px 20px; border-radius: 8px; font-size: 12px; font-weight: 700; cursor: pointer; box-shadow: 0 2px 8px rgba(22,163,74,0.3); transition: all 0.2s;"
                            onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform=''"
                            onclick="copyLink('<%=lblCUSTOMERLeftLink.ClientID%>'); return false;">
                            📋
                        </button>
                        <button style="background: linear-gradient(135deg, #25D366, #128C7E); color: #fff; border: none; padding: 9px 16px; border-radius: 8px; font-size: 13px; font-weight: 700; cursor: pointer; box-shadow: 0 2px 8px rgba(37,211,102,0.35); transition: all 0.2s; display: flex; align-items: center; gap: 6px;"
                            onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform=''"
                            onclick="shareOnWhatsApp('<%=lblCUSTOMERLeftLink.ClientID%>', 'Customer Registration'); return false;">
                            <svg xmlns='http://www.w3.org/2000/svg' width='15' height='15' viewBox='0 0 24 24' fill='white'>
                                <path d='M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z' />
                            </svg>

                        </button>
                    </div>
                </div>

                <!-- AGENT LINK -->
                <div style="display: flex; align-items: center; background: #fff; border-radius: 10px; box-shadow: 0 2px 10px rgba(124,58,237,0.10); overflow: hidden;">
                    <div style="background: linear-gradient(135deg, #7c3aed, #6d28d9); color: #fff; font-weight: 800; font-size: 11px; padding: 0 18px; min-width: 90px; text-align: center; align-self: stretch; display: flex; align-items: center; justify-content: center; letter-spacing: 1px; flex-direction: column; gap: 4px;">
                        <span style="font-size: 18px;">🤝</span>
                        AGENT
                    </div>
                    <div style="flex: 1; padding: 12px 16px; font-size: 12px; color: #6d28d9; word-break: break-all; font-family: 'Courier New', monospace; background: #f5f3ff; font-weight: 600; border-left: 1px dashed #ddd6fe;">
                        <asp:Label ID="lblAGENTRightLink" runat="server" Text=""></asp:Label>
                    </div>
                    <div style="padding: 12px 14px; background: #fff; display: flex; gap: 8px;">
                        <button style="background: linear-gradient(135deg, #16a34a, #15803d); color: #fff; border: none; padding: 9px 20px; border-radius: 8px; font-size: 12px; font-weight: 700; cursor: pointer; box-shadow: 0 2px 8px rgba(22,163,74,0.3); transition: all 0.2s;"
                            onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform=''"
                            onclick="copyLink('<%=lblAGENTRightLink.ClientID%>'); return false;">
                            📋
                        </button>
                        <button style="background: linear-gradient(135deg, #25D366, #128C7E); color: #fff; border: none; padding: 9px 16px; border-radius: 8px; font-size: 13px; font-weight: 700; cursor: pointer; box-shadow: 0 2px 8px rgba(37,211,102,0.35); transition: all 0.2s; display: flex; align-items: center; gap: 6px;"
                            onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform=''"
                            onclick="shareOnWhatsApp('<%=lblAGENTRightLink.ClientID%>', 'Agent Registration'); return false;">
                            <svg xmlns='http://www.w3.org/2000/svg' width='15' height='15' viewBox='0 0 24 24' fill='white'>
                                <path d='M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z' />
                            </svg>

                        </button>
                    </div>
                </div>

            </div>
        </div>
        <!-- CHARTS ROW -->
        <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 20px; margin-bottom: 22px; display: none;" class="charts-main">

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

            <div class="card">
                <div class="card-header">
                    <div>
                        <div class="card-title">Plot Status</div>
                        <div class="card-subtitle">My assigned plots</div>
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
        <div style="display: grid; grid-template-columns: repeat(5,1fr); gap: 14px; margin-bottom: 22px; display: none;" class="qa-row">
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
        <div class="card" style="margin-bottom: 22px; display: none;">
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
        <div class="card" style="border-color: #FED7AA; margin-bottom: 22px; display: none;">
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
                                <button class="btn btn-xs btn-primary"></button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>



    </div>

    <script>
        function shareOnWhatsApp(labelId, linkType) {
            var el = document.getElementById(labelId);
            if (!el) return;
            var link = el.innerText || el.textContent;
            var message = "🏠 *Sky Is Your Limit - Real Estate*\n\n" +
                "Register as a " + linkType + " using my referral link:\n\n" +
                link.trim() + "\n\n" +
                "📞 Contact me for more details!";
            var waUrl = "https://wa.me/?text=" + encodeURIComponent(message);
            window.open(waUrl, '_blank');
        }
        function copyLink(labelId) {
            var el = document.getElementById(labelId);
            if (!el) return;
            var text = el.innerText || el.textContent;
            if (navigator.clipboard && navigator.clipboard.writeText) {
                navigator.clipboard.writeText(text.trim()).then(function () {
                    showCopied();
                }).catch(function () {
                    fallbackCopy(text.trim());
                });
            } else {
                fallbackCopy(text.trim());
            }
        }

        function fallbackCopy(text) {
            var ta = document.createElement('textarea');
            ta.value = text;
            ta.style.position = 'fixed';
            ta.style.opacity = '0';
            document.body.appendChild(ta);
            ta.select();
            document.execCommand('copy');
            document.body.removeChild(ta);
            showCopied();
        }

        function showCopied() {
            var toast = document.createElement('div');
            toast.innerText = '✅ Link Copied!';
            toast.style.cssText = 'position:fixed;bottom:30px;right:30px;background:#22A000;color:#fff;' +
                'padding:12px 24px;border-radius:8px;font-size:14px;font-weight:600;' +
                'z-index:9999;box-shadow:0 4px 15px rgba(0,0,0,0.2);';
            document.body.appendChild(toast);
            setTimeout(function () { document.body.removeChild(toast); }, 2500);
        }
    </script>
</asp:Content>
