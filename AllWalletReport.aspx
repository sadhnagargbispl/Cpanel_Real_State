<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="AllWalletReport.aspx.cs" Inherits="AllWalletReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/agent_customers.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="pc">

        <!-- Page Header -->
      <!-- Page Header -->
<div class="page-header">
    <div class="ph-left">
        <div class="ph-title">All Wallet Report</div>
        <div class="ph-sub">View deposit, used and balance summary by wallet type</div>
    </div>
    <div class="ph-actions" style="display:flex; align-items:center; gap:10px;">
        <asp:DropDownList ID="Rbtnwallet" CssClass="fs" TabIndex="2" runat="server"
            style="min-width:180px; padding:9px 14px;">
        </asp:DropDownList>
        <asp:Button ID="BtnSubmit" runat="server" Text="🔍 Search" TabIndex="3"
            CssClass="btn btn-primary"
            style="padding:9px 20px; white-space:nowrap;"
            OnClick="BtnSubmit_Click" />
    </div>
</div>

        <!-- KPI Summary Cards -->
        <div style="display: grid; grid-template-columns: repeat(3,1fr); gap: 16px; margin-bottom: 22px;">

            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-green">💰</div>
                    <span class="kpi-trend trend-up">Total Deposited</span>
                </div>
                <div class="kpi-val">
                    <span id="MCredit" runat="server">0.00</span>
                </div>
                <div class="kpi-label">Deposit</div>
            </div>

            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-red">📤</div>
                    <span class="kpi-trend trend-dn">Total Used</span>
                </div>
                <div class="kpi-val">
                    <span id="MDebit" runat="server">0.00</span>
                </div>
                <div class="kpi-label">Used</div>
            </div>

            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-blue">🏦</div>
                    <span class="kpi-trend trend-neu">Available</span>
                </div>
                <div class="kpi-val">
                    <span id="MBal" runat="server">0.00</span>
                </div>
                <div class="kpi-label">Balance</div>
            </div>

        </div>

        <!-- Data Table Card -->
        <div class="card">
            <div class="card-header">
                <div>
                    <div class="card-title">Wallet Transactions</div>
                    <div class="card-subtitle">Detailed wallet report listing</div>
                </div>
            </div>
            <div class="tbl-wrap">
                <asp:GridView ID="RptDirects" runat="server"
                    AutoGenerateColumns="true"
                    CssClass="tbl"
                    AllowPaging="true"
                    PageSize="10"
                    OnPageIndexChanging="RptDirects_PageIndexChanging">
                    <Columns>
                    </Columns>
                </asp:GridView>
            </div>
        </div>

    </div>
</asp:Content>