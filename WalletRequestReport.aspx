<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="WalletRequestReport.aspx.cs" Inherits="WalletRequestReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/WalletReport.css" rel="stylesheet" />
    <style>
        /* ══ Custom Modal Overlay ══════════════════════════════
           position:fixed + z-index bahut zyada — sidebar ke upar
        ═══════════════════════════════════════════════════════ */
        #profilePhotoModal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            z-index: 999999;
            background: rgba(0, 0, 0, 0.6);
            align-items: center;
            justify-content: center;
        }
        #profilePhotoModal.active {
            display: flex;
        }

        /* Modal Box */
        .photo-modal-box {
            background: #fff;
            border-radius: 12px;
            overflow: hidden;
            width: 90%;
            max-width: 700px;
            box-shadow: 0 10px 50px rgba(0,0,0,0.3);
            animation: popIn 0.2s ease;
        }
        @keyframes popIn {
            from { transform: scale(0.93); opacity: 0; }
            to   { transform: scale(1);    opacity: 1; }
        }

        /* Modal Header */
        .photo-modal-head {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 14px 20px;
            background: #f8f9fb;
            border-bottom: 1px solid #eee;
        }
        .photo-modal-head h5 {
            margin: 0;
            font-size: 15px;
            font-weight: 700;
            color: #1a1a2e;
        }
        .photo-modal-close {
            background: none;
            border: none;
            font-size: 22px;
            color: #888;
            cursor: pointer;
            line-height: 1;
            padding: 0 4px;
        }
        .photo-modal-close:hover { color: #333; }

        /* Modal Body */
        .photo-modal-body {
            padding: 24px;
            text-align: center;
            min-height: 120px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
        }
        #photoPreview {
            max-height: 500px;
            max-width: 100%;
            border-radius: 8px;
            display: none;
        }
        #imgLoader {
            display: none;
            flex-direction: column;
            align-items: center;
            gap: 10px;
            color: #888;
            font-size: 14px;
        }
        .spinner {
            width: 36px; height: 36px;
            border: 3px solid #eee;
            border-top-color: #4e6af3;
            border-radius: 50%;
            animation: spin 0.7s linear infinite;
        }
        @keyframes spin { to { transform: rotate(360deg); } }

        #noImageMsg {
            display: none;
            color: #aaa;
            font-size: 14px;
        }

        /* ══ Scroll Lock — html, body, AND sidebar ══ */
        body.modal-open,
        html.modal-open {
            overflow: hidden !important;
        }
        /* Common sidebar class names — covers most themes */
        body.modal-open .deznav,
        body.modal-open .sidebar,
        body.modal-open .nav-sidebar,
        body.modal-open aside,
        body.modal-open [class*="sidebar"],
        body.modal-open [class*="deznav"] {
            overflow: hidden !important;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="pc">
        <div class="card">
            <div class="card-header">
                <div>
                    <div class="card-title">Wallet Request Detail</div>
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
                                        <td><%# Eval("ReqDate") %></td>
                                        <td><%# Eval("PayMode") %></td>
                                        <td><%# Eval("ChqNo") %></td>
                                        <td><%# Eval("ChequeDate") %></td>
                                        <td><%# Eval("Amount") %></td>
                                        <td><%# Eval("Remarks") %></td>
                                        <td><%# Eval("ApproveRemark") %></td>
                                        <td><%# Eval("Status") %></td>
                                        <td>
                                            <asp:Image
                                                ID="Image1"
                                                runat="server"
                                                ImageUrl='<%# Eval("ScannedFile") %>'
                                                Height="60px"
                                                Width="60px"
                                                Style="cursor:pointer; border-radius:4px; object-fit:cover;"
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
    </div>

    <!-- ══ Custom Modal — No Bootstrap needed ══ -->
    <div id="profilePhotoModal">
        <div class="photo-modal-box">
            <div class="photo-modal-head">
                <h5>Image Preview</h5>
                <button class="photo-modal-close" onclick="closePhotoModal()">&#x2715;</button>
            </div>
            <div class="photo-modal-body">
                <div id="imgLoader">
                    <div class="spinner"></div>
                    <span>Loading...</span>
                </div>
                <img id="photoPreview" alt="Payment Proof" />
                <p id="noImageMsg">No image found.</p>
            </div>
        </div>
    </div>

    <script>
        function openPhotoModal(reqno) {
            var img    = document.getElementById("photoPreview");
            var loader = document.getElementById("imgLoader");
            var noMsg  = document.getElementById("noImageMsg");
            var modal  = document.getElementById("profilePhotoModal");

            // Reset state
            img.src            = "";
            img.style.display  = "none";
            noMsg.style.display = "none";
            loader.style.display = "flex";

            // Show modal
            modal.classList.add("active");

            // Lock scroll on html + body + sidebar
            document.documentElement.classList.add("modal-open");
            document.body.classList.add("modal-open");

            // Fetch image from server
            fetch("Img.aspx?type=Payment&ID=" + reqno)
                .then(function(r) { return r.text(); })
                .then(function(html) {
                    loader.style.display = "none";
                    var parser = new DOMParser();
                    var doc    = parser.parseFromString(html, "text/html");
                    var imgTag = doc.querySelector("img");
                    if (imgTag && imgTag.getAttribute("src")) {
                        img.src           = imgTag.getAttribute("src") + "?t=" + Date.now();
                        img.style.display = "block";
                    } else {
                        noMsg.style.display = "block";
                    }
                })
                .catch(function() {
                    loader.style.display = "none";
                    noMsg.style.display  = "block";
                });
        }

        function closePhotoModal() {
            document.getElementById("profilePhotoModal").classList.remove("active");
            document.documentElement.classList.remove("modal-open");
            document.body.classList.remove("modal-open");
            // Reset image
            document.getElementById("photoPreview").src = "";
            document.getElementById("photoPreview").style.display = "none";
            document.getElementById("noImageMsg").style.display   = "none";
        }

        // Overlay background click se close
        document.getElementById("profilePhotoModal").addEventListener("click", function(e) {
            if (e.target === this) closePhotoModal();
        });

        // Escape key se close
        document.addEventListener("keydown", function(e) {
            if (e.key === "Escape") closePhotoModal();
        });
    </script>

</asp:Content>
