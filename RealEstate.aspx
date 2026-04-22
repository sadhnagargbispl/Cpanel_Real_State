<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="RealEstate.aspx.cs" Inherits="RealEstate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/agent_realestate.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="pc">

        <!-- Page Header -->
        <div class="page-header">
            <div class="ph-left">
                <div class="ph-title">Real Estate Properties</div>
                <div class="ph-sub">View all listed, sold and available properties</div>
            </div>
            <div class="ph-actions">
                <asp:DropDownList ID="DdlCity" CssClass="fi" TabIndex="1" runat="server" Style="width: 200px; padding: 9px 14px;">
                </asp:DropDownList>
                <asp:DropDownList ID="DdlType" CssClass="fi" TabIndex="2" runat="server" Style="width: 200px; padding: 9px 14px;">
                    <asp:ListItem Value="">-- Property Type --</asp:ListItem>
                    <asp:ListItem Value="Residential">Residential</asp:ListItem>
                    <asp:ListItem Value="Commercial">Commercial</asp:ListItem>
                    <asp:ListItem Value="Plot">Plot / Land</asp:ListItem>
                </asp:DropDownList>
                <asp:Button ID="BtnSearch" runat="server" Text="🔍 Search" TabIndex="3"
                    CssClass="btn btn-primary"
                    OnClick="BtnSearch_Click" />
                <asp:Button ID="BtnExport" runat="server" Text="📥 Export" TabIndex="4"
                    CssClass="btn btn-outline"
                    OnClick="BtnExport_Click" />
            </div>
        </div>

        <!-- KPI Summary Cards -->
        <div class="kpi-grid">
            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-green">🏠</div>
                    <span class="kpi-trend trend-up">Total Listed</span>
                </div>
                <div class="kpi-val">
                    <span id="SpnTotalListed" runat="server">0</span>
                </div>
                <div class="kpi-label">Properties</div>
            </div>
            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-blue">💰</div>
                    <span class="kpi-trend trend-neu">Total Value</span>
                </div>
                <div class="kpi-val">
                    ₹ <span id="SpnTotalValue" runat="server">0.00</span>
                </div>
                <div class="kpi-label">Market Value (Cr)</div>
            </div>
            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-amber">✅</div>
                    <span class="kpi-trend trend-up">Sold</span>
                </div>
                <div class="kpi-val">
                    <span id="SpnSold" runat="server">0</span>
                </div>
                <div class="kpi-label">Properties Sold</div>
            </div>
            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-red">🔑</div>
                    <span class="kpi-trend trend-dn">Available</span>
                </div>
                <div class="kpi-val">
                    <span id="SpnAvailable" runat="server">0</span>
                </div>
                <div class="kpi-label">For Sale / Rent</div>
            </div>
        </div>

        <!-- Error / Info Label -->
        <asp:Label ID="LblMessage" runat="server" CssClass="msg-label" Visible="false"></asp:Label>

        <!-- Data Table Card -->
        <div class="card">
            <div class="card-header">
                <div>
                    <div class="card-title">Property Listings</div>
                    <div class="card-subtitle">Detailed property records</div>
                </div>
                <div class="card-actions">
                    <asp:TextBox ID="TxtSearch" runat="server" CssClass="search-box" placeholder="Search property..." />
                </div>
            </div>
            <div class="tbl-wrap">
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
                        <asp:TemplateField HeaderText="Prop. ID">
                            <ItemTemplate><%# Eval("PropID") %></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Owner Name">
                            <ItemTemplate><%# Eval("OwnerName") %></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Property Type">
                            <ItemTemplate>
                                <span class='badge-type'><%# Eval("PropType") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="City">
                            <ItemTemplate><%# Eval("City") %></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Area (sqft)">
                            <ItemTemplate><%# Eval("AreaSqft") %></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Price (₹)">
                            <ItemTemplate><%# Eval("Price") %></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="List Date">
                            <ItemTemplate><%# Eval("ListDate") %></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <span class='<%# GetStatusClass(Eval("Status").ToString()) %>'>
                                    <%# Eval("Status") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <a class="btn-action" href='<%# "PropertyDetail.aspx?PID=" + Eval("VPropID") %>'>
                                    View Detail
                                </a>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="no-data">No properties found matching your criteria.</div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>

    </div>
</asp:Content>
