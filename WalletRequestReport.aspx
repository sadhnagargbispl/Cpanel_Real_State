<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="WalletRequestReport.aspx.cs" Inherits="WalletRequestReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/WalletReport.css" rel="stylesheet" />
    <!-- Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />

<!-- Bootstrap 5 JS (page ke end mein, </body> se pehle) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<style>
    #profilePhotoModal {
        position: fixed !important;
        top: 0 !important;
        left: 0 !important;
        width: 100vw !important;
        height: 100vh !important;
        z-index: 99999 !important;
        background: rgba(0,0,0,0.5) !important;
        display: none;
        align-items: center !important;
        justify-content: center !important;
        /* YEH ADD KARO - sidebar ignore karega */
        margin-left: 0 !important;
        padding: 0 !important;
    }
    #profilePhotoModal.show {
        display: flex !important;
    }
    #profilePhotoModal .modal-dialog {
        margin: 0 auto !important;
        max-width: 700px !important;
        width: 90% !important;
        position: relative !important;
        left: auto !important;
        right: auto !important;
        transform: none !important;
        /* YEH ADD KARO */
        top: auto !important;
    }
</style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="pc">
        <div class="card">
            <div class="card-header">
                <div>
                    <div class="card-title">Wallet Request Detail</div>
                    <%--<div class="card-subtitle">Wallet Request Detail</div>--%>
                </div>
            </div>
            <div class="tbl-wrap">
                <asp:Label ID="Label1" runat="server" Text="Total Records" Visible="false"></asp:Label>
                <asp:Label ID="lbltotal" runat="server"></asp:Label>
                <div class="table-responsive">
                    <table id="customers2" class="tbl">
                        <thead>
                            <tr>
                                <th>Req. No</th>
                                <th>Request Date</th>
                                <th>Payment Mode</th>
                                <th>Transaction No</th>
                                <th>Transaction Date</th>
                                <th>Amount</th>
                                <th>Remark</th>
                                <th>Admin Remark</th>
                                <th>Status</th>
                                <th>Image</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="RptDirects" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td><%# Eval("ReqNo") %></td>
                                        <td><%#Eval("ReqDate") %></td>
                                        <td><%#Eval("PayMode") %></td>
                                        <td><%# Eval("ChqNo") %></td>
                                        <td><%#Eval("ChequeDate") %></td>
                                        <td><%# Eval("Amount") %></td>
                                        <td><%# Eval("Remarks") %></td>
                                        <td><%#Eval("ApproveRemark")%></td>
                                        <td><%# Eval("Status") %></td>
                                        <td>
                                            <asp:Image
                                                ID="Image1"
                                                runat="server"
                                                ImageUrl='<%# Eval("ScannedFile") %>'
                                                Height="60px"
                                                Width="60px"
                                                Style="cursor: pointer; border-radius: 4px;"
                                                Visible='<%# Convert.ToBoolean(Eval("ScannedFileStatus")) %>'
                                                onclick='<%# "openPhotoModal(" + Eval("Reqno") + ")" %>' />
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
            <div class="modal fade" id="profilePhotoModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Image Preview</h5>
                <button type="button" class="btn-close"></button>
            </div>
            <div class="modal-body text-center p-4">
                <div id="imgLoader" style="display:none;">
                    <div class="spinner-border text-primary" role="status"></div>
                    <p class="mt-2">Loading...</p>
                </div>
                <img id="photoPreview" class="img-fluid" style="max-height:500px; display:none;" />
                <p id="noImageMsg" style="display:none; color:gray;">No image found.</p>
            </div>
        </div>
    </div>
</div>
    </div>

    <!-- Modal -->
    

    <script>
        function openPhotoModal(reqno) {
            var img = document.getElementById("photoPreview");
            var loader = document.getElementById("imgLoader");
            var noMsg = document.getElementById("noImageMsg");
            var modalEl = document.getElementById('profilePhotoModal');

            // Reset
            img.src = "";
            img.style.display = "none";
            loader.style.display = "block";
            noMsg.style.display = "none";

            // Manual show - Bootstrap use mat karo
            // Sidebar width compensate karo
            modalEl.style.left = '0';
            modalEl.style.width = '100vw';
            // Body ka margin/padding ignore karo
            document.documentElement.style.overflow = 'hidden';
            modalEl.classList.add('show');
            document.body.style.overflow = 'hidden';
            modalEl.classList.add('show');
            document.body.style.overflow = 'hidden';

            fetch("Img.aspx?type=Payment&ID=" + reqno)
                .then(response => response.text())
                .then(html => {
                    loader.style.display = "none";
                    var parser = new DOMParser();
                    var doc = parser.parseFromString(html, "text/html");
                    var imgTag = doc.querySelector("img");
                    if (imgTag && imgTag.getAttribute("src")) {
                        img.src = imgTag.getAttribute("src") + "?t=" + new Date().getTime();
                        img.style.display = "block";
                    } else {
                        noMsg.style.display = "block";
                    }
                })
                .catch(() => {
                    loader.style.display = "none";
                    noMsg.style.display = "block";
                });
        }

        // Close button ke liye
        document.addEventListener('DOMContentLoaded', function () {
            var closeBtn = document.querySelector('#profilePhotoModal .btn-close');
            var modalEl = document.getElementById('profilePhotoModal');

            if (closeBtn) {
                closeBtn.addEventListener('click', function () {
                    modalEl.classList.remove('show');
                    document.body.style.overflow = '';
                });
            }

            // Background click se close
            modalEl.addEventListener('click', function (e) {
                if (e.target === modalEl) {
                    modalEl.classList.remove('show');
                    document.body.style.overflow = '';
                }
            });
        });
    </script>
</asp:Content>