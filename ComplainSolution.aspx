<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="ComplainSolution.aspx.cs" Inherits="ComplainSolution" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="css/agent_customers.css" rel="stylesheet" />
    <style>

        /* ── Back Button ────────────────────────── */
        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: #fff;
            border: 1px solid #dde3ff;
            color: #4e6af3;
            font-size: 13px;
            font-weight: 600;
            padding: 7px 16px;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            transition: background 0.2s;
        }
        .btn-back:hover { background: #eef2ff; color: #3a54d8; text-decoration: none; }

        /* ── Custom Modal Overlay ───────────────── */
        .custom-overlay {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 99999;
            justify-content: center;
            align-items: center;
        }
        .custom-overlay.active {
            display: flex;
        }
        .custom-modal-box {
            background: #fff;
            width: 580px;
            max-width: 95vw;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 10px 50px rgba(0,0,0,0.25);
            animation: popIn 0.2s ease;
        }
        @keyframes popIn {
            from { transform: scale(0.92); opacity: 0; }
            to   { transform: scale(1);    opacity: 1; }
        }
        .custom-modal-head {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: #f8f9fb;
            border-bottom: 1px solid #eee;
            padding: 14px 20px;
        }
        .custom-modal-head h5 {
            font-size: 15px;
            font-weight: 700;
            color: #1a1a2e;
            margin: 0;
        }
        .custom-modal-head small {
            font-size: 12px;
            color: #888;
            font-weight: 400;
            margin-left: 6px;
        }
        .custom-modal-close {
            background: none;
            border: none;
            font-size: 22px;
            color: #888;
            cursor: pointer;
            line-height: 1;
            padding: 0 4px;
        }
        .custom-modal-close:hover { color: #333; }
        .custom-modal-body {
            padding: 0;
        }
        .custom-modal-iframe {
            width: 100%;
            height: 480px;
            border: none;
            display: block;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="pc">

        <!-- Page Header -->
        <div class="page-header">
            <div class="ph-left">
                <div class="ph-title">Query Detail</div>
                <div class="ph-sub">View your complaints and their replies</div>
            </div>
            <div class="ph-actions">
                <a href="javascript:history.back();" class="btn-back">&#8592; Back</a>
            </div>
        </div>

        <!-- KPI Cards -->
        <div style="display:grid; grid-template-columns:repeat(3,1fr); gap:16px; margin-bottom:22px;">
            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-blue">📋</div>
                    <span class="kpi-trend trend-neu">Total Queries</span>
                </div>
                <div class="kpi-val"><span id="SpnTotal" runat="server">0</span></div>
                <div class="kpi-label">Complaints</div>
            </div>
            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-green">✅</div>
                    <span class="kpi-trend trend-up">Replied</span>
                </div>
                <div class="kpi-val"><span id="SpnReplied" runat="server">0</span></div>
                <div class="kpi-label">Solved</div>
            </div>
            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-red">⏳</div>
                    <span class="kpi-trend trend-dn">Pending</span>
                </div>
                <div class="kpi-val"><span id="SpnPending" runat="server">0</span></div>
                <div class="kpi-label">Awaiting Reply</div>
            </div>
        </div>

        <!-- Error Label -->
        <asp:Label ID="Label2" runat="server" CssClass="error" Style="display:block; margin-bottom:10px;"></asp:Label>

        <!-- Table Card -->
        <div class="card">
            <div class="card-header">
                <div>
                    <div class="card-title">Complaint Listing</div>
                    <div class="card-subtitle">All your submitted complaints with replies</div>
                </div>
            </div>
            <div class="tbl-wrap">
                <div id="DivSideA" runat="server">
                    <asp:GridView ID="RptDirects" runat="server"
                        AutoGenerateColumns="false"
                        CssClass="tbl"
                        AllowPaging="true"
                        PageSize="10"
                        OnPageIndexChanging="RptDirects_PageIndexChanging">
                        <Columns>

                            <asp:TemplateField HeaderText="SNo">
                                <ItemTemplate><%# Container.DataItemIndex + 1 %></ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Complaint Id">
                                <ItemTemplate><%# Eval("CID") %></ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Complaint Date">
                                <ItemTemplate><%# Eval("CDate") %></ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Complaint">
                                <ItemTemplate><%# Eval("Complaint") %></ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Reply Date">
                                <ItemTemplate><%# Eval("SDate") %></ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Reply">
                                <ItemTemplate><%# Eval("Solution") %></ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <span class='<%# string.IsNullOrEmpty(Eval("Solution").ToString().Trim()) ? "badge-status badge-pending" : "badge-status badge-replied" %>'>
                                        <%# string.IsNullOrEmpty(Eval("Solution").ToString().Trim()) ? "Pending" : "Replied" %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="View">
                                <ItemTemplate>
                                    <button type="button" class="btn-back"
                                        onclick="openReplyModal('<%# Eval("VCid") %>', '<%# Eval("CID") %>')">
                                        View Detail
                                    </button>
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                        <EmptyDataTemplate>
                            <div class="no-data">No complaints found.</div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </div>
        </div>

    </div>

    <!-- ══ Custom Modal (No Bootstrap plugin needed) ══ -->
    <div id="replyOverlay" class="custom-overlay">
        <div class="custom-modal-box">
            <div class="custom-modal-head">
                <h5>
                    Complaint Detail
                    <small id="modalCidBadge"></small>
                </h5>
                <button class="custom-modal-close" onclick="closeReplyModal()">&#x2715;</button>
            </div>
            <div class="custom-modal-body">
                <iframe id="replyIframe" class="custom-modal-iframe" src="about:blank"></iframe>
            </div>
        </div>
    </div>

    <script>
        function openReplyModal(vcid, cid) {
            document.getElementById('replyIframe').src = 'Reply.aspx?CId=' + vcid;
            document.getElementById('modalCidBadge').innerText = '#' + cid;
            document.getElementById('replyOverlay').classList.add('active');
        }

        function closeReplyModal() {
            document.getElementById('replyOverlay').classList.remove('active');
            document.getElementById('replyIframe').src = 'about:blank';
            document.getElementById('modalCidBadge').innerText = '';
        }

        // Close on overlay background click
        document.getElementById('replyOverlay').addEventListener('click', function (e) {
            if (e.target === this) closeReplyModal();
        });

        // Close on Escape key
        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') closeReplyModal();
        });
    </script>

</asp:Content>
