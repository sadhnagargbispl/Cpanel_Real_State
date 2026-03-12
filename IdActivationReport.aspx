<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="IdActivationReport.aspx.cs" Inherits="IdActivationReport" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/agent_customers.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="pc">



        <!-- CUSTOMER STATS -->


        <div class="card">
            <div class="card-header">
                <div>
                    <div class="card-title">My Purchase</div>
                    <div class="card-subtitle">All My Purchase</div>
                </div>
            </div>
            <div class="tbl-wrap">
                <div class="table-responsive">
                    <asp:GridView ID="RptDirects" runat="server" AutoGenerateColumns="true" CssClass="tbl"
                        AllowPaging="true" PageSize="10" OnPageIndexChanging="RptDirects_PageIndexChanging">
                        <Columns>
                            <asp:TemplateField HeaderText="SNo.">
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                        
                        </Columns>
                    </asp:GridView>
                </div>
                <%--<table class="tbl">
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
                                        <div style="display: flex; align-items: center; gap: 9px;">
                                            <div class="avatar av-sm" style="background: linear-gradient(135deg,#0D1B4B,#1E6FBF);"></div>
                                            <div>
                                                <div style="font-weight: 600; color: var(--navy)">
                                                    <%# Eval("memfirstname") %>
                                                </div>

                                            </div>
                                        </div>
                                    </td>



                                    <td><%# Eval("mobl") %></td>
                                    <td><%# Eval("city") %></td>
                                    <td><span class='pill <%# Eval("Status").ToString() == "Active" ? "pill-green" : "pill-red" %>'>
                                        <%# Eval("Status") %>
                                    </span></td>


                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>

                    </tbody>
                </table>--%>
            </div>


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

