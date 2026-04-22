<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Reply.aspx.cs" Inherits="Reply" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Complaint Detail</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f4f6fb;
            color: #333;
            font-size: 13.5px;
        }

        /* ── Wrapper ─────────────────────────────── */
        .pc {
            padding: 18px 20px;
        }

        /* ── Page Header ─────────────────────────── */
        .page-header {
            margin-bottom: 16px;
        }
        .ph-title {
            font-size: 17px;
            font-weight: 700;
            color: #1a1a2e;
        }
        .ph-sub {
            font-size: 12px;
            color: #999;
            margin-top: 2px;
        }

        /* ── KPI Row ─────────────────────────────── */
        .kpi-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
            margin-bottom: 16px;
        }
        .kpi {
            background: #fff;
            border: 1px solid #eee;
            border-radius: 12px;
            padding: 14px 16px;
        }
        .kpi-top {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 8px;
        }
        .kpi-icon {
            width: 30px;
            height: 30px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
        }
        .ki-blue  { background: #e8f0ff; }
        .ki-green { background: #eaf9f1; }

        .kpi-trend {
            font-size: 11px;
            font-weight: 600;
            border-radius: 20px;
            padding: 2px 8px;
        }
        .trend-neu { background: #e8f0ff; color: #2563eb; }
        .trend-up  { background: #eaf9f1; color: #1a8c4e; }

        .kpi-val {
            font-size: 13px;
            font-weight: 600;
            color: #1a1a2e;
            word-break: break-word;
        }
        .kpi-label {
            font-size: 11px;
            color: #bbb;
            margin-top: 3px;
        }

        /* ── Card ────────────────────────────────── */
        .card {
            background: #fff;
            border: 1px solid #eee;
            border-radius: 14px;
            overflow: hidden;
            margin-bottom: 14px;
        }
        .card-header {
            padding: 13px 18px;
            border-bottom: 1px solid #f0f0f0;
        }
        .card-title {
            font-size: 14px;
            font-weight: 700;
            color: #1a1a2e;
        }
        .card-subtitle {
            font-size: 11px;
            color: #bbb;
            margin-top: 2px;
        }
        .card-body {
            padding: 16px 18px;
        }

        /* ── Field Rows ──────────────────────────── */
        .field-row {
            margin-bottom: 14px;
        }
        .field-label {
            font-size: 11px;
            font-weight: 600;
            color: #888;
            text-transform: uppercase;
            letter-spacing: 0.4px;
            margin-bottom: 5px;
        }
        .field-val {
            font-size: 13.5px;
            color: #1a1a2e;
            font-weight: 500;
            padding: 8px 12px;
            background: #f8f9fb;
            border-radius: 8px;
            border: 1px solid #eee;
            min-height: 36px;
            display: block;
            width: 100%;
        }
        .field-textarea {
            width: 100%;
            font-family: 'Segoe UI', sans-serif;
            font-size: 13px;
            color: #333;
            background: #f8f9fb;
            border: 1px solid #eee;
            border-radius: 8px;
            padding: 10px 12px;
            resize: vertical;
            min-height: 80px;
            outline: none;
        }

        /* ── Badge ───────────────────────────────── */
        .badge-type {
            display: inline-block;
            background: #eef2ff;
            color: #3730a3;
            font-size: 11.5px;
            font-weight: 700;
            padding: 4px 12px;
            border-radius: 20px;
        }

        /* ── Reply block ─────────────────────────── */
        .reply-block {
            background: #f0faf4;
            border-left: 3px solid #1a8c4e;
            border-radius: 0 8px 8px 0;
            padding: 10px 14px;
            margin-bottom: 10px;
            font-size: 13px;
            color: #1a2e22;
            line-height: 1.6;
        }
        .reply-block .reply-date {
            font-size: 11px;
            color: #888;
            margin-bottom: 4px;
        }
        .no-reply {
            font-size: 13px;
            color: #bbb;
            text-align: center;
            padding: 20px 0;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="pc">

            <!-- Page Header -->
            <div class="page-header">
                <div class="ph-title">Complaint Detail</div>
                <div class="ph-sub">View complaint and admin reply</div>
            </div>

            <!-- KPI: Type + Date -->
            <div class="kpi-row">
                <div class="kpi">
                    <div class="kpi-top">
                        <div class="kpi-icon ki-blue">📋</div>
                        <span class="kpi-trend trend-neu">Type</span>
                    </div>
                    <div class="kpi-val">
                        <asp:Label ID="LblCType" runat="server" Text="—"></asp:Label>
                    </div>
                    <div class="kpi-label">Complaint Type</div>
                </div>
                <div class="kpi">
                    <div class="kpi-top">
                        <div class="kpi-icon ki-green">📅</div>
                        <span class="kpi-trend trend-up">Date</span>
                    </div>
                    <div class="kpi-val">
                        <asp:Label ID="LblCDate" runat="server" Text="—"></asp:Label>
                    </div>
                    <div class="kpi-label">Complaint Date</div>
                </div>
            </div>

            <!-- Complaint Card -->
            <div class="card">
                <div class="card-header">
                    <div class="card-title">Complaint</div>
                    <div class="card-subtitle">As submitted by you</div>
                </div>
                <div class="card-body">
                    <asp:TextBox ID="TxtComplaint"
                        runat="server"
                        ReadOnly="true"
                        TextMode="MultiLine"
                        CssClass="field-textarea"
                        Rows="4"></asp:TextBox>
                </div>
            </div>

            <!-- Reply Card -->
            <div class="card">
                <div class="card-header">
                    <div class="card-title">Admin Reply</div>
                    <div class="card-subtitle">Response from support team</div>
                </div>
                <div class="card-body">
                    <!-- Reply blocks injected from code-behind -->
                    <asp:PlaceHolder ID="PhReplies" runat="server"></asp:PlaceHolder>

                    <!-- Fallback if no reply (hidden by code-behind when replies exist) -->
                    <asp:Label ID="LblNoReply" runat="server" Visible="false">
                        <div class="no-reply">No reply yet. Please check back later.</div>
                    </asp:Label>

                    <!-- Hidden field kept for backward compatibility -->
                    <asp:TextBox ID="TxtPreReply" runat="server" Visible="false"
                        ReadOnly="true" TextMode="MultiLine"></asp:TextBox>
                </div>
            </div>

        </div>
    </form>
</body>
</html>
