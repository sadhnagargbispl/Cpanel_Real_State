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

    <div class="kpi-label">Total Customers</div>
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

        <!-- AGENT CARDS -->
        <%--<div style="display: grid; grid-template-columns: repeat(auto-fill,minmax(280px,1fr)); gap: 20px; margin-bottom: 24px;">

            <div class="card" style="padding: 0; overflow: hidden; transition: transform .25s,box-shadow .25s;" onmouseover="this.style.transform='translateY(-4px)';this.style.boxShadow='var(--sh-md)'" onmouseout="this.style.transform='';this.style.boxShadow=''">
                <div style="height: 7px; background: linear-gradient(135deg,#0D1B4B,#1E6FBF)"></div>
                <div style="padding: 20px;">
                    <div style="display: flex; align-items: center; gap: 12px; margin-bottom: 16px;">
                        <div class="avatar av-md" style="background: linear-gradient(135deg,#0D1B4B,#1E6FBF)">T</div>
                        <div>
                            <div style="font-weight: 700; font-size: 14.5px; color: var(--navy)">test</div>
                            <div style="font-size: 11.5px; color: var(--muted)">Senior Agent</div>
                        </div>
                        <span class="pill pill-green" style="margin-left: auto">Active</span>
                    </div>
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px; margin-bottom: 14px;">
                        <div style="background: var(--bg); border-radius: 9px; padding: 10px; text-align: center;">
                            <div style="font-family: 'Playfair Display',serif; font-size: 18px; font-weight: 900; color: var(--navy)">12</div>
                            <div style="font-size: 10px; color: var(--muted); margin-top: 2px">Bookings</div>
                        </div>
                        <div style="background: var(--bg); border-radius: 9px; padding: 10px; text-align: center;">
                            <div style="font-family: 'Playfair Display',serif; font-size: 18px; font-weight: 900; color: var(--navy)">18</div>
                            <div style="font-size: 10px; color: var(--muted); margin-top: 2px">Customers</div>
                        </div>
                    </div>
                    <div style="margin-bottom: 14px;">
                        <div style="display: flex; justify-content: space-between; font-size: 11.5px; margin-bottom: 5px;"><span style="color: var(--mid)">Monthly Target</span><span style="font-weight: 700; color: var(--navy)">82%</span></div>
                        <div class="progress-bar">
                            <div class="progress-fill" style="width: 82%; background: linear-gradient(135deg,#0D1B4B,#1E6FBF)"></div>
                        </div>
                    </div>
                    <div style="border-top: 1px solid var(--border); padding-top: 12px; display: flex; justify-content: space-between; align-items: center;">
                        <div>
                            <div style="font-size: 10px; color: var(--muted)">Commission Earned</div>
                            <div style="font-size: 13px; font-weight: 700; color: var(--navy)">INR 28,000</div>
                        </div>
                        <div style="display: flex; gap: 6px;">
                            <button class="btn btn-outline btn-xs">View</button>
                            <button class="btn btn-navy btn-xs">Report</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card" style="padding: 0; overflow: hidden; transition: transform .25s,box-shadow .25s;" onmouseover="this.style.transform='translateY(-4px)';this.style.boxShadow='var(--sh-md)'" onmouseout="this.style.transform='';this.style.boxShadow=''">
                <div style="height: 7px; background: linear-gradient(135deg,#6B2D8B,#9333EA)"></div>
                <div style="padding: 20px;">
                    <div style="display: flex; align-items: center; gap: 12px; margin-bottom: 16px;">
                        <div class="avatar av-md" style="background: linear-gradient(135deg,#6B2D8B,#9333EA)">A</div>
                        <div>
                            <div style="font-weight: 700; font-size: 14.5px; color: var(--navy)">Amna Butt</div>
                            <div style="font-size: 11.5px; color: var(--muted)">Agent</div>
                        </div>
                        <span class="pill pill-green" style="margin-left: auto">Active</span>
                    </div>
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px; margin-bottom: 14px;">
                        <div style="background: var(--bg); border-radius: 9px; padding: 10px; text-align: center;">
                            <div style="font-family: 'Playfair Display',serif; font-size: 18px; font-weight: 900; color: var(--navy)">8</div>
                            <div style="font-size: 10px; color: var(--muted); margin-top: 2px">Bookings</div>
                        </div>
                        <div style="background: var(--bg); border-radius: 9px; padding: 10px; text-align: center;">
                            <div style="font-family: 'Playfair Display',serif; font-size: 18px; font-weight: 900; color: var(--navy)">14</div>
                            <div style="font-size: 10px; color: var(--muted); margin-top: 2px">Customers</div>
                        </div>
                    </div>
                    <div style="margin-bottom: 14px;">
                        <div style="display: flex; justify-content: space-between; font-size: 11.5px; margin-bottom: 5px;"><span style="color: var(--mid)">Monthly Target</span><span style="font-weight: 700; color: var(--navy)">65%</span></div>
                        <div class="progress-bar">
                            <div class="progress-fill" style="width: 65%; background: linear-gradient(135deg,#6B2D8B,#9333EA)"></div>
                        </div>
                    </div>
                    <div style="border-top: 1px solid var(--border); padding-top: 12px; display: flex; justify-content: space-between; align-items: center;">
                        <div>
                            <div style="font-size: 10px; color: var(--muted)">Commission Earned</div>
                            <div style="font-size: 13px; font-weight: 700; color: var(--navy)">INR 18,400</div>
                        </div>
                        <div style="display: flex; gap: 6px;">
                            <button class="btn btn-outline btn-xs">View</button>
                            <button class="btn btn-navy btn-xs">Report</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card" style="padding: 0; overflow: hidden; transition: transform .25s,box-shadow .25s;" onmouseover="this.style.transform='translateY(-4px)';this.style.boxShadow='var(--sh-md)'" onmouseout="this.style.transform='';this.style.boxShadow=''">
                <div style="height: 7px; background: linear-gradient(135deg,#0F766E,#14B8A6)"></div>
                <div style="padding: 20px;">
                    <div style="display: flex; align-items: center; gap: 12px; margin-bottom: 16px;">
                        <div class="avatar av-md" style="background: linear-gradient(135deg,#0F766E,#14B8A6)">Z</div>
                        <div>
                            <div style="font-weight: 700; font-size: 14.5px; color: var(--navy)">Zubair Ali</div>
                            <div style="font-size: 11.5px; color: var(--muted)">Agent</div>
                        </div>
                        <span class="pill pill-green" style="margin-left: auto">Active</span>
                    </div>
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px; margin-bottom: 14px;">
                        <div style="background: var(--bg); border-radius: 9px; padding: 10px; text-align: center;">
                            <div style="font-family: 'Playfair Display',serif; font-size: 18px; font-weight: 900; color: var(--navy)">6</div>
                            <div style="font-size: 10px; color: var(--muted); margin-top: 2px">Bookings</div>
                        </div>
                        <div style="background: var(--bg); border-radius: 9px; padding: 10px; text-align: center;">
                            <div style="font-family: 'Playfair Display',serif; font-size: 18px; font-weight: 900; color: var(--navy)">10</div>
                            <div style="font-size: 10px; color: var(--muted); margin-top: 2px">Customers</div>
                        </div>
                    </div>
                    <div style="margin-bottom: 14px;">
                        <div style="display: flex; justify-content: space-between; font-size: 11.5px; margin-bottom: 5px;"><span style="color: var(--mid)">Monthly Target</span><span style="font-weight: 700; color: var(--navy)">50%</span></div>
                        <div class="progress-bar">
                            <div class="progress-fill" style="width: 50%; background: linear-gradient(135deg,#0F766E,#14B8A6)"></div>
                        </div>
                    </div>
                    <div style="border-top: 1px solid var(--border); padding-top: 12px; display: flex; justify-content: space-between; align-items: center;">
                        <div>
                            <div style="font-size: 10px; color: var(--muted)">Commission Earned</div>
                            <div style="font-size: 13px; font-weight: 700; color: var(--navy)">INR 13,600</div>
                        </div>
                        <div style="display: flex; gap: 6px;">
                            <button class="btn btn-outline btn-xs">View</button>
                            <button class="btn btn-navy btn-xs">Report</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card" style="padding: 0; overflow: hidden; transition: transform .25s,box-shadow .25s;" onmouseover="this.style.transform='translateY(-4px)';this.style.boxShadow='var(--sh-md)'" onmouseout="this.style.transform='';this.style.boxShadow=''">
                <div style="height: 7px; background: linear-gradient(135deg,#92400E,#D97706)"></div>
                <div style="padding: 20px;">
                    <div style="display: flex; align-items: center; gap: 12px; margin-bottom: 16px;">
                        <div class="avatar av-md" style="background: linear-gradient(135deg,#92400E,#D97706)">H</div>
                        <div>
                            <div style="font-weight: 700; font-size: 14.5px; color: var(--navy)">Hina Qureshi</div>
                            <div style="font-size: 11.5px; color: var(--muted)">Junior Agent</div>
                        </div>
                        <span class="pill pill-yellow" style="margin-left: auto">On Leave</span>
                    </div>
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px; margin-bottom: 14px;">
                        <div style="background: var(--bg); border-radius: 9px; padding: 10px; text-align: center;">
                            <div style="font-family: 'Playfair Display',serif; font-size: 18px; font-weight: 900; color: var(--navy)">7</div>
                            <div style="font-size: 10px; color: var(--muted); margin-top: 2px">Bookings</div>
                        </div>
                        <div style="background: var(--bg); border-radius: 9px; padding: 10px; text-align: center;">
                            <div style="font-family: 'Playfair Display',serif; font-size: 18px; font-weight: 900; color: var(--navy)">11</div>
                            <div style="font-size: 10px; color: var(--muted); margin-top: 2px">Customers</div>
                        </div>
                    </div>
                    <div style="margin-bottom: 14px;">
                        <div style="display: flex; justify-content: space-between; font-size: 11.5px; margin-bottom: 5px;"><span style="color: var(--mid)">Monthly Target</span><span style="font-weight: 700; color: var(--navy)">70%</span></div>
                        <div class="progress-bar">
                            <div class="progress-fill" style="width: 70%; background: linear-gradient(135deg,#92400E,#D97706)"></div>
                        </div>
                    </div>
                    <div style="border-top: 1px solid var(--border); padding-top: 12px; display: flex; justify-content: space-between; align-items: center;">
                        <div>
                            <div style="font-size: 10px; color: var(--muted)">Commission Earned</div>
                            <div style="font-size: 13px; font-weight: 700; color: var(--navy)">INR 15,900</div>
                        </div>
                        <div style="display: flex; gap: 6px;">
                            <button class="btn btn-outline btn-xs">View</button>
                            <button class="btn btn-navy btn-xs">Report</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card" style="padding: 0; overflow: hidden; transition: transform .25s,box-shadow .25s;" onmouseover="this.style.transform='translateY(-4px)';this.style.boxShadow='var(--sh-md)'" onmouseout="this.style.transform='';this.style.boxShadow=''">
                <div style="height: 7px; background: linear-gradient(135deg,#1B4332,#16A34A)"></div>
                <div style="padding: 20px;">
                    <div style="display: flex; align-items: center; gap: 12px; margin-bottom: 16px;">
                        <div class="avatar av-md" style="background: linear-gradient(135deg,#1B4332,#16A34A)">R</div>
                        <div>
                            <div style="font-weight: 700; font-size: 14.5px; color: var(--navy)">Asim Raza</div>
                            <div style="font-size: 11.5px; color: var(--muted)">Junior Agent</div>
                        </div>
                        <span class="pill pill-green" style="margin-left: auto">Active</span>
                    </div>
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px; margin-bottom: 14px;">
                        <div style="background: var(--bg); border-radius: 9px; padding: 10px; text-align: center;">
                            <div style="font-family: 'Playfair Display',serif; font-size: 18px; font-weight: 900; color: var(--navy)">5</div>
                            <div style="font-size: 10px; color: var(--muted); margin-top: 2px">Bookings</div>
                        </div>
                        <div style="background: var(--bg); border-radius: 9px; padding: 10px; text-align: center;">
                            <div style="font-family: 'Playfair Display',serif; font-size: 18px; font-weight: 900; color: var(--navy)">9</div>
                            <div style="font-size: 10px; color: var(--muted); margin-top: 2px">Customers</div>
                        </div>
                    </div>
                    <div style="margin-bottom: 14px;">
                        <div style="display: flex; justify-content: space-between; font-size: 11.5px; margin-bottom: 5px;"><span style="color: var(--mid)">Monthly Target</span><span style="font-weight: 700; color: var(--navy)">45%</span></div>
                        <div class="progress-bar">
                            <div class="progress-fill" style="width: 45%; background: linear-gradient(135deg,#1B4332,#16A34A)"></div>
                        </div>
                    </div>
                    <div style="border-top: 1px solid var(--border); padding-top: 12px; display: flex; justify-content: space-between; align-items: center;">
                        <div>
                            <div style="font-size: 10px; color: var(--muted)">Commission Earned</div>
                            <div style="font-size: 13px; font-weight: 700; color: var(--navy)">INR 11,400</div>
                        </div>
                        <div style="display: flex; gap: 6px;">
                            <button class="btn btn-outline btn-xs">View</button>
                            <button class="btn btn-navy btn-xs">Report</button>
                        </div>
                    </div>
                </div>
            </div>

        </div>--%>

        <!-- TEAM PERFORMANCE TABLE -->
        <div class="card">
            <div class="card-header">
                <div>
                    <div class="card-title">Team Performance Summary</div>
                    <div class="card-subtitle">This month's breakdown</div>
                </div>
                <button class="btn btn-outline btn-sm">⬇ Export</button>
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
                       


                    </tr>
                </ItemTemplate>
            </asp:Repeater>

        </tbody>
    </table>
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

