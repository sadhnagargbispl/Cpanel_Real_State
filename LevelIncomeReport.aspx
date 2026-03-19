<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="LevelIncomeReport.aspx.cs" Inherits="LevelIncomeReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/agent_customers.css" rel="stylesheet" />
    <style>
        .summary-card {
            display: flex;
            gap: 16px;
            margin-bottom: 16px;
            flex-wrap: wrap;
        }

        .stat-box {
            background: #f0f7ff;
            border: 1px solid #c9e0ff;
            border-radius: 8px;
            padding: 16px 28px;
            min-width: 200px;
        }

            .stat-box .stat-label {
                font-size: 13px;
                color: #666;
                margin-bottom: 4px;
            }

            .stat-box .stat-value {
                font-size: 22px;
                font-weight: 700;
                color: #1a56db;
            }

        .tbl tfoot tr td {
            font-weight: bold;
            background: #f8f9fa;
            border-top: 2px solid #dee2e6;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="pc">
        <!-- SUMMARY STAT CARD -->
        <div class="summary-card">
            <div class="stat-box">
                <div class="stat-label">Total Level Bonus</div>
                <div class="stat-value">
                    <asp:Label ID="lblTotalBonus" runat="server" Text="0"></asp:Label>
                </div>
            </div>
        </div>

        <!-- MAIN CARD -->
        <div class="card">
            <div class="card-header">
                <div>
                    <div class="card-title">Level Bonus Report</div>
                    <div class="card-subtitle">Level Bonus Report</div>
                </div>
            </div>
            <div class="tbl-wrap">
                <div class="table-responsive">
                    <asp:GridView ID="RptDirects" runat="server" AutoGenerateColumns="true" CssClass="tbl"
                        AllowPaging="true" PageSize="10"
                        ShowFooter="true"
                        OnPageIndexChanging="RptDirects_PageIndexChanging">
                        <Columns>
                            <asp:TemplateField HeaderText="SNo.">
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <strong>Total</strong>
                                </FooterTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
