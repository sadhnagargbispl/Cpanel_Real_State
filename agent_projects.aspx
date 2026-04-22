<%@ Page Title="My Projects" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="agent_projects.aspx.cs" Inherits="agent_projects" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link href="css/agent_customers.css" rel="stylesheet" />
    <style>

        /* PROJECT CARDS GRID */
        .projects-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill,minmax(300px,1fr));
            gap: 20px;
        }

        .proj-card {
            background: var(--white);
            border-radius: 16px;
            border: 1px solid var(--border);
            box-shadow: var(--sh);
            overflow: hidden;
            transition: transform .25s,box-shadow .25s;
            cursor: default;
        }

            .proj-card:hover {
                transform: translateY(-4px);
                box-shadow: var(--sh-md);
            }

        .proj-banner {
            height: 120px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 44px;
            position: relative;
        }

        .proj-status-badge {
            position: absolute;
            top: 12px;
            left: 12px;
            padding: 3px 10px;
            font-size: 10px;
            font-weight: 700;
            border-radius: 20px;
            color: #fff;
        }

        .status-active {
            background: #22C55E;
        }

        .status-upcoming {
            background: #F5A623;
        }

        .status-closed {
            background: #EF4444;
        }

        .proj-body {
            padding: 18px;
        }

        .proj-type {
            font-size: 10px;
            font-weight: 700;
            color: var(--ocean);
            text-transform: uppercase;
            letter-spacing: .8px;
            margin-bottom: 3px;
        }

        .proj-name {
            font-family: 'Playfair Display',serif;
            font-size: 17px;
            font-weight: 700;
            color: var(--navy);
            margin-bottom: 3px;
        }

        .proj-loc {
            font-size: 12px;
            color: var(--muted);
            margin-bottom: 14px;
        }

        .proj-stats {
            display: flex;
            gap: 16px;
            padding: 11px 0;
            border-top: 1px solid var(--border);
            border-bottom: 1px solid var(--border);
            margin-bottom: 14px;
            flex-wrap: wrap;
        }

        .proj-stat-label {
            font-size: 9px;
            color: var(--muted);
            font-weight: 700;
            text-transform: uppercase;
        }

        .proj-stat-val {
            font-size: 14px;
            font-weight: 700;
            color: var(--navy);
        }

            .proj-stat-val.green {
                color: #22C55E;
            }

        .proj-actions {
            display: flex;
            gap: 8px;
        }

        /* EMPTY STATE */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: var(--muted);
        }

            .empty-state .es-icon {
                font-size: 52px;
                margin-bottom: 16px;
            }

            .empty-state .es-title {
                font-family: 'Playfair Display',serif;
                font-size: 20px;
                color: var(--navy);
                margin-bottom: 8px;
            }

            .empty-state .es-sub {
                font-size: 13px;
                color: var(--muted);
            }

        /* LOADING SKELETON */
        .skeleton {
            background: linear-gradient(90deg,#f0f4fb 25%,#e2eaf4 50%,#f0f4fb 75%);
            background-size: 200% 100%;
            animation: shimmer 1.4s infinite;
            border-radius: 8px;
        }

        @keyframes shimmer {
            0% {
                background-position: 200% 0
            }

            100% {
                background-position: -200% 0
            }
        }

        @media(max-width:640px) {
            .pc {
                padding: 14px;
            }

            .page-header {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:HiddenField ID="hdnAgentID" runat="server" />
    <div class="pc">
        <!-- Page Header -->
        <div class="page-header">
            <div class="ph-left">
                <div class="ph-title">My Projects</div>
                <div class="ph-sub">
                    <asp:Literal ID="litProjectCount" runat="server" Text="Loading..." />
                </div>
            </div>
  <%--          <button class="btn btn-primary" onclick="openRequestModal()">+ Request Project Access</button>--%>
        </div>
        <!-- Projects Grid -->
        <div class="projects-grid" id="projectsGrid">
            <asp:Repeater ID="rptProjects" runat="server" OnItemDataBound="rptProjects_ItemDataBound">
                <ItemTemplate>
                    <div class="proj-card">
                        <div class="proj-banner" style='background: <%# Eval("BannerGradient") %>'>
                            <span><%# Eval("BannerIcon") %></span>
                            <span class='proj-status-badge <%# GetStatusClass(Eval("Status").ToString()) %>'>
                                <%# Eval("Status") %>
                            </span>
                        </div>
                        <div class="proj-body">
                            <div class="proj-type"><%# Eval("ProjectType") %></div>
                            <div class="proj-name"><%# Eval("ProjectName") %></div>
                            <div class="proj-loc">📍 <%# Eval("Location") %></div>
                            <div class="proj-stats">
                                <div>
                                    <div class="proj-stat-label">Total Plots</div>
                                    <div class="proj-stat-val"><%# string.Format("{0:N0}", Eval("TotalPlots")) %></div>
                                </div>
                                <div>
                                    <div class="proj-stat-label">Available</div>
                                    <div class="proj-stat-val green"><%# string.Format("{0:N0}", Eval("AvailablePlots")) %></div>
                                </div>
                                <div>
                                    <div class="proj-stat-label">My Bookings</div>
                                    <div class="proj-stat-val"><%# Eval("MyBookings") %></div>
                                </div>
                            </div>
                            <div class="proj-actions">
                                <a href='agent_plots.aspx?pid=<%# Eval("ProjectID") %>' class="btn btn-navy btn-sm" style="flex: 1; justify-content: center;">View Plots</a>
                                <a href='Booking.aspx?pid=<%# Eval("ProjectID") %>' class="btn btn-primary btn-sm" style="flex: 1; justify-content: center;">New Booking</a>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <!-- Empty State (shown if no projects) -->
        <asp:Panel ID="pnlEmpty" runat="server" Visible="false">
            <div class="empty-state">
                <div class="es-icon">🏘️</div>
                <div class="es-title">No Projects Assigned</div>
                <div class="es-sub">You have no projects assigned to your account yet. Request access to get started.</div>
            </div>
        </asp:Panel>
    </div>
    <!-- Request Access Modal -->
    <div class="modal-bg" id="reqModal">
        <div class="modal">
            <div class="modal-header">
                <div class="modal-title">Request Project Access</div>
                <button class="modal-close" onclick="closeRequestModal()">✕</button>
            </div>
            <div class="fg">
                <label class="fl">Project Name / ID</label>
                <input type="text" class="fi" id="reqProject" placeholder="Enter project name or ID">
            </div>
            <div class="fg" style="margin-top: 14px;">
                <label class="fl">Reason for Request</label>
                <textarea class="fta" id="reqNote" placeholder="Briefly explain why you need access…"></textarea>
            </div>
            <div style="display: flex; gap: 10px; justify-content: flex-end; margin-top: 18px;">
                <button class="btn btn-outline" onclick="closeRequestModal()">Cancel</button>
                <button class="btn btn-primary" onclick="submitRequest()">Submit Request</button>
            </div>
        </div>
    </div>
    <style>
        .modal-bg {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(9,19,58,.55);
            z-index: 800;
            align-items: center;
            justify-content: center;
            backdrop-filter: blur(3px);
        }

            .modal-bg.show {
                display: flex;
            }

        .modal {
            background: #fff;
            border-radius: 20px;
            padding: 30px;
            width: 90%;
            max-width: 480px;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .modal-title {
            font-family: 'Playfair Display',serif;
            font-size: 19px;
            font-weight: 700;
            color: var(--navy);
        }

        .modal-close {
            background: #f0f4fb;
            border: none;
            width: 32px;
            height: 32px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            color: var(--mid);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .fg {
            margin-bottom: 0;
        }

        .fl {
            display: block;
            font-size: 11px;
            font-weight: 700;
            color: var(--navy);
            text-transform: uppercase;
            letter-spacing: .6px;
            margin-bottom: 6px;
        }

        .fi, .fta {
            width: 100%;
            padding: 11px 14px;
            border: 1.5px solid var(--border);
            border-radius: 10px;
            font-size: 13.5px;
            color: var(--text);
            outline: none;
            transition: border-color .2s;
            background: #fff;
            font-family: 'DM Sans',sans-serif;
        }

        .fta {
            resize: vertical;
            min-height: 80px;
        }

        .btn-outline {
            background: #fff;
            border: 1.5px solid var(--border);
            color: var(--mid);
        }
    </style>
    <script>
        function openRequestModal() { document.getElementById('reqModal').classList.add('show'); }
        function closeRequestModal() { document.getElementById('reqModal').classList.remove('show'); }

        function submitRequest() {
            var proj = document.getElementById('reqProject').value.trim();
            var note = document.getElementById('reqNote').value.trim();
            if (!proj) { alert('Please enter a project name or ID.'); return; }

            callWebMethod('SubmitProjectRequest', { projectName: proj, note: note }, function (res) {
                if (res.Success) {
                    alert('Request submitted successfully!');
                    closeRequestModal();
                    document.getElementById('reqProject').value = '';
                    document.getElementById('reqNote').value = '';
                } else {
                    alert('Error: ' + res.Message);
                }
            });
        }

        function callWebMethod(method, params, callback) {
            fetch('agent_projects.aspx/' + method, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json; charset=utf-8' },
                body: JSON.stringify(params)
            })
                .then(function (r) { return r.json(); })
                .then(function (d) { callback(typeof d.d === 'string' ? JSON.parse(d.d) : d.d); })
                .catch(function (e) { console.error(method + ' error:', e); });
        }

        document.addEventListener('click', function (e) {
            if (e.target.id === 'reqModal') closeRequestModal();
        });
    </script>
</asp:Content>
