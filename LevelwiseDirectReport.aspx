<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="LevelwiseDirectReport.aspx.cs" Inherits="LevelwiseDirectReport" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">
    <link href="css/agent_myagents.css" rel="stylesheet" />
    <script>
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }
    </script>
    <style>
        .pagination-bar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 12px 18px;
            border-top: 1px solid #e8eaf0;
        }

        .pg-summary {
            font-size: 13px;
            color: #6b7280;
        }

        .pg-info {
            font-size: 13px;
            color: #374151;
            min-width: 90px;
            text-align: center;
        }
    </style>


    <div class="pc">

        <!-- PAGE HEADER -->

        <div class="page-header">

            <div class="ph-left">

                <div class="ph-title">Level Wise Direct Report</div>

                <div class="ph-sub">
                    View your direct team members summary
                </div>

            </div>

        </div>


        <!-- SEARCH PANEL -->

        <div class="card">

            <div class="card-header">

                <div>

                    <div class="card-title">
                        Search Filters
                    </div>

                </div>

            </div>


            <div class="card-body">

                <div class="g4">
                    <div class="fg">
                        <label>
                            Search By</label>
                        <asp:DropDownList ID="rbtnsearch" runat="server" class="fs">
                            <asp:ListItem Text="Level Wise" Selected="True" Value="L"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="fg" id="lbllevel" runat="server">
                        <label>
                            Level</label>
                        <asp:DropDownList ID="DdlLevel" CssClass="fs" TabIndex="1" runat="server">
                        </asp:DropDownList>
                    </div>
                    <div class="fg">
                        <label>
                            Search</label>
                        <asp:DropDownList ID="DDlSearchby" CssClass="fs" TabIndex="2" runat="server">
                            <asp:ListItem Text="All" Value="" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="Active" Value="Y"></asp:ListItem>
                            <asp:ListItem Text="Deactive" Value="N"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="fg" style="padding: 5%">
                        <asp:Button ID="BtnSubmit" runat="server" Text="Search" TabIndex="3" class="btn btn-primary " OnClick="BtnSubmit_Click" />
                    </div>
                    <%-- <div class="fg">
                        <label for="inputdefault">
                            Search By</label>
                        <asp:HiddenField ID="hdnSessn" runat="server" />
                        <asp:DropDownList ID="rbtnsearch" runat="server" class="fs">
                            <asp:ListItem Text="Both" Selected="True" Value="L"></asp:ListItem>
                            <asp:ListItem Text="Left" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Right" Value="2"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="fg" id="divSearch" runat="server">
                        <label for="inputdefault">
                            Search</label>
                        <asp:DropDownList ID="DDlSearchby" CssClass="fs" TabIndex="2" runat="server">
                            <asp:ListItem Text="All" Value="" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="Active" Value="Y"></asp:ListItem>
                            <asp:ListItem Text="Deactive" Value="N"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="fg">
                        <asp:Button ID="BtnSubmit" runat="server" Text="Search" TabIndex="3" class="btn btn-primary"
                            Style="margin-top: 4%" OnClick="BtnSubmit_Click" />
                    </div>--%>
                </div>

            </div>

        </div>



        <!-- KPI SUMMARY -->
        <div class="kpi-grid" style="margin-top: 20px;">


            <!-- JOINING -->

            <div class="kpi">

                <div class="kpi-top">
                    <div class="kpi-icon ki-blue">👥</div>
                </div>

                <div class="kpi-val">

                    <span id="TotalDirect" runat="server">0</span>

                </div>

                <div class="kpi-label">
                    Joining

                </div>

                <div style="font-size: 12px; color: #6b7280;">
                    Direct :
            <span id="tdDirectleft" runat="server">0</span>

                    |

            Indirect :
            <span id="tdDirectright" runat="server">0</span>

                </div>

            </div>



            <!-- ACTIVE -->

            <div class="kpi">

                <div class="kpi-top">
                    <div class="kpi-icon ki-green">✅</div>
                </div>

                <div class="kpi-val">

                    <span id="TotalActive" runat="server">0</span>

                </div>

                <div class="kpi-label">
                    Active

                </div>

                <div style="font-size: 12px; color: #6b7280;">
                    Direct :
            <span id="tddirectActive" runat="server">0</span>

                    |

            Indirect :
            <span id="tdindirectActive" runat="server">0</span>

                </div>

            </div>



            <!-- BV -->

            <div id="Tr1" runat="server" visible="false" class="kpi">

                <div class="kpi-top">
                    <div class="kpi-icon ki-purple">💎</div>
                </div>

                <div class="kpi-val">

                    <span id="totalunit" runat="server">0</span>

                </div>

                <div class="kpi-label">
                    BV

                </div>

                <div style="font-size: 12px; color: #6b7280;">
                    Direct :
            <span id="Directunit" runat="server">0</span>

                    |

            Indirect :
            <span id="indirectunit" runat="server">0</span>

                </div>

            </div>


        </div>
        <!-- TABLE SECTION -->


        <div class="card">


            <div class="card-header">


                <div>

                    <div class="card-title">
                       Level Wise Direct Team Summary

                    </div>


                    <div class="card-subtitle">
                        Total Records :

                        <asp:Label
                            ID="lblTotalRecords"
                            runat="server" />

                    </div>


                </div>


            </div>



            <div class="tbl-wrap">

                <table id="customers2" class="tbl">
                    <thead>
                        <tr>
                            <th>SNo
                            </th>
                            <th>Level
                            </th>

                            <th>ID No
                            </th>
                            <th>Member Name
                            </th>
                            <th>Referral ID
                            </th>
                            <th>Referral Name
                            </th>
                            <th>Active Status
                            </th>
                            <th>Activation Date
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="RptDirects" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblRowNumber" Text='<%# Container.ItemIndex + 1 %>' runat="server" />
                                    </td>
                                    <td>
                                        <%#Eval("Level")%>
                                    </td>

                                    <td>
                                        <%#Eval("[Member ID]")%>
                                    </td>
                                    <td>
                                        <div style="display: flex; gap: 8px; align-items: center">


                                            <div class="avatar av-sm"
                                                style="background: linear-gradient(135deg,#0D1B4B,#1E6FBF)">



                                                <%# Eval("[Member Name]").ToString().Substring(0,1) %>
                                            </div>


                                            <div>

                                                <%# Eval("[Member Name]") %>
                                            </div>


                                        </div>
                                        <%--<%#Eval("[Member Name]")%>--%>
                                    </td>
                                    <td>
                                        <%#Eval("[Referral ID]")%>
                                    </td>
                                    <td>
                                        <div style="display: flex; gap: 8px; align-items: center">


                                            <div class="avatar av-sm"
                                                style="background: linear-gradient(135deg,#0D1B4B,#1E6FBF)">



                                                <%# Eval("[Referral Name]").ToString().Substring(0,1) %>
                                            </div>


                                            <div>

                                                <%# Eval("[Referral Name]") %>
                                            </div>


                                        </div>
                                        <%--<%#Eval("[Sponsor Name]")%>--%>
                                    </td>

                                    <td>
                                        <span class='pill
<%# Eval("[Active Status]").ToString()=="Active"
? "pill-green"
: "pill-red" %>'>


                                            <%# Eval("[Active Status]") %>


                                        </span>

                                        <%--  <%#Eval("[Active Status]")%>--%>
                                    </td>
                                    <td>
                                        <%#Eval("[Activation Date]") %>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>



            </div>
            <div class="pagination-bar">
                <asp:HiddenField ID="hdnTotalPages" runat="server" Value="1" />
                <asp:HiddenField ID="hdnCurrentPage" runat="server" Value="1" />



                <div style="display: flex; gap: 8px; align-items: center;">
                    <asp:Button ID="btnPrev" runat="server" Text="← Prev"
                        OnClick="lnkPrev_Click" CssClass="btn btn-outline btn-sm" />

                    <asp:Label ID="lblPageInfo" runat="server"
                        Text="Page 1 of 1" CssClass="pg-info" />

                    <asp:Button ID="btnNext" runat="server" Text="Next →"
                        OnClick="lnkNext_Click" CssClass="btn btn-outline btn-sm" />
                </div>
            </div>
            <!-- PAGINATION -->





        </div>


    </div>


</asp:Content>
