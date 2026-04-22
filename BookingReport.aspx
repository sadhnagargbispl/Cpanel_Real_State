<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="BookingReport.aspx.cs" Inherits="BookingReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/agent_customers.css" rel="stylesheet" />
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

        /* ── MODAL ── */
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
            background: var(--white);
            border-radius: 20px;
            padding: 30px;
            width: 90%;
            max-width: 540px;
            max-height: 90vh;
            overflow-y: auto;
            animation: mIn .28s ease;
        }

        @keyframes mIn {
            from { opacity: 0; transform: scale(.96) translateY(10px) }
            to { opacity: 1; transform: none }
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 22px;
        }

        .modal-title {
            font-family: 'Playfair Display', serif;
            font-size: 19px;
            font-weight: 700;
            color: var(--navy);
        }

        .modal-close {
            background: var(--bg);
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

        .modal-close:hover {
            background: var(--red);
            color: #fff;
        }

        .detail-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
            margin-bottom: 18px;
        }

        .detail-label {
            font-size: 10px;
            color: var(--muted);
            font-weight: 700;
            text-transform: uppercase;
            margin-bottom: 3px;
        }

        .detail-value {
            font-size: 13.5px;
            font-weight: 600;
            color: var(--navy);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="pc">

        <div class="page-header">
            <div class="ph-left">
                <div class="ph-title">Bookings</div>
                <div class="ph-sub">Manage all customer bookings and transactions</div>
            </div>
            <div class="ph-actions">
                <input type="text" class="fi" placeholder="🔍 Search booking, customer…" style="width: 220px; padding: 9px 14px;">
                <select class="fs" style="width: auto; padding: 9px 14px;">
                    <option>All Status</option>
                    <option>Confirmed</option>
                    <option>Pending</option>
                    <option>Installment</option>
                    <option>Overdue</option>
                </select>
                <asp:Button ID="BtnBooking" runat="server" Text="+ New Booking" OnClick="BtnBooking_Click" CssClass="btn btn-primary" />
            </div>
        </div>

        <!-- BOOKING STATS -->
        <div class="kpi-grid" style="margin-bottom: 22px;">
            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-blue">📋</div>
                   <%-- <span class="kpi-trend trend-up">Total</span>--%>
                </div>
                <div class="kpi-val">
                    <asp:Label ID="lblTotal" runat="server" Text="0"></asp:Label>
                </div>
                <div class="kpi-label">All Bookings</div>
            </div>
            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-green">✅</div>
                 <%--   <span class="kpi-trend trend-up">
                        <asp:Label ID="lblTotalAll" runat="server" Text="0"></asp:Label>
                    </span>--%>
                </div>
                <div class="kpi-val">
                    <asp:Label ID="lblTotalConfirmed" runat="server" Text="0"></asp:Label>
                </div>
                <div class="kpi-label">Confirmed</div>
            </div>
            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-gold">💳</div>
                   <%-- <span class="kpi-trend trend-neu">
                        <asp:Label ID="lblTotalConfirmeds" runat="server" Text="0"></asp:Label>
                    </span>--%>
                </div>
                <div class="kpi-val">0</div>
                <div class="kpi-label">On Installment</div>
            </div>
            <div class="kpi">
                <div class="kpi-top">
                    <div class="kpi-icon ki-red">⚠️</div>
                   <%-- <span class="kpi-trend trend-dn">0</span>--%>
                </div>
                <div class="kpi-val">0</div>
                <div class="kpi-label">Overdue</div>
            </div>
        </div>

        <div class="card">
            <div class="card-header">
                <div>
                    <div class="card-title">All Bookings</div>
                    <div class="card-subtitle">
                        <asp:Label ID="lblRecordSummary" runat="server" CssClass="pg-summary" Text="" />
                    </div>
                </div>
            </div>
            <div class="tbl-wrap">
                <table class="tbl">
                    <thead>
                        <tr>
                            <th>Sno.</th>
                            <th>Booking ID</th>
                            <th>Customer ID</th>
                            <th>Customer</th>
                            <th>Project / Plot</th>
                            <th>Total</th>
                            <th>Paid</th>
                            <th>Remaining</th>
                            <th>Booking Date</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptCustomers" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td><%# Container.ItemIndex + 1 %></td>
                                    <td><%# Eval("BookingID") %></td>
                                    <td><%# Eval("CustomerID") %></td>
                                    <td>
                                        <div style="display: flex; align-items: center; gap: 9px;">
                                            <div class="avatar av-sm" style="background: linear-gradient(135deg,#0D1B4B,#1E6FBF);">
                                                <%# Eval("Customername").ToString().Substring(0, 1).ToUpper() %>
                                            </div>
                                            <div>
                                                <div style="font-weight: 600; color: var(--navy)">
                                                    <%# Eval("Customername") %>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td><%# Eval("ProjecPlot") %></td>
                                    <td><%# Eval("Total") %></td>
                                    <td><%# Eval("Paid") %></td>
                                    <td><%# Eval("Remaining") %></td>
                                    <td><%# Eval("BookingDate") %></td>
                                    <td>
                                        <span class='pill <%# Eval("Status").ToString() == "Active" ? "pill-green" : "pill-red" %>'>
                                            <%# Eval("Status") %>
                                        </span>
                                    </td>
                                    <td>
                                        <div style="display: flex; gap: 5px;">
                                            <button type="button" class="btn btn-navy btn-xs"
                                                onclick="openBookingModal(
                                                    '<%# Eval("BookingID") %>',
                                                    '<%# Eval("CustomerID") %>',
                                                    '<%# Eval("Customername") %>',
                                                    '<%# Eval("ProjecPlot") %>',
                                                    '<%# Eval("Total") %>',
                                                    '<%# Eval("Paid") %>',
                                                    '<%# Eval("Remaining") %>',
                                                    '<%# Eval("BookingDate") %>',
                                                    '<%# Eval("Status") %>'
                                                )">👁 View</button>
                                           <%-- <a href="agent_receipts.aspx" class="btn btn-outline btn-xs">🧾</a>--%>
                                        </div>
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
                        OnClick="BtnPrev_Click" CssClass="btn btn-outline btn-sm" />
                    <asp:Label ID="lblPageInfo" runat="server"
                        Text="Page 1 of 1" CssClass="pg-info" />
                    <asp:Button ID="btnNext" runat="server" Text="Next →"
                        OnClick="BtnNext_Click" CssClass="btn btn-outline btn-sm" />
                </div>
            </div>
        </div>

        <!-- BOOKING VIEW MODAL -->
        <div class="modal-bg" id="bookingViewModal">
            <div class="modal" style="max-width: 500px;">
                <div class="modal-header">
                    <div class="modal-title">Booking Details</div>
                    <button type="button" class="modal-close" onclick="closeModal('bookingViewModal')">✕</button>
                </div>

                <!-- Header Banner -->
                <div style="text-align: center; padding: 16px 0 20px; border-bottom: 1px solid var(--border); margin-bottom: 20px;">
                    <div style="width: 54px; height: 54px; border-radius: 14px; background: linear-gradient(135deg,#0D1B4B,#1E6FBF); display: flex; align-items: center; justify-content: center; font-size: 22px; margin: 0 auto 10px;">📋</div>
                    <div style="font-family: 'Playfair Display',serif; font-size: 17px; font-weight: 700; color: var(--navy)">The Sky Is Your Limit</div>
                    <div style="font-size: 10.5px; color: var(--muted); text-transform: uppercase; letter-spacing: 1px; margin-bottom: 6px">Booking Summary</div>
                    <div style="font-family: 'Playfair Display',serif; font-size: 24px; font-weight: 900; color: var(--navy)" id="mdlBookingID">—</div>
                </div>

                <!-- Details Grid -->
                <div class="detail-row">
                    <div>
                        <div class="detail-label">Customer ID</div>
                        <div class="detail-value" id="mdlCustomerID">—</div>
                    </div>
                    <div>
                        <div class="detail-label">Customer Name</div>
                        <div class="detail-value" id="mdlCustomerName">—</div>
                    </div>
                    <div>
                        <div class="detail-label">Project / Plot</div>
                        <div class="detail-value" id="mdlProjectPlot">—</div>
                    </div>
                    <div>
                        <div class="detail-label">Booking Date</div>
                        <div class="detail-value" id="mdlBookingDate">—</div>
                    </div>
                    <div>
                        <div class="detail-label">Total Amount</div>
                        <div class="detail-value" id="mdlTotal">—</div>
                    </div>
                    <div>
                        <div class="detail-label">Status</div>
                        <div class="detail-value" id="mdlStatus">—</div>
                    </div>
                </div>

                <!-- Payment Summary Box -->
                <div style="background: linear-gradient(135deg,var(--bg),rgba(30,111,191,.05)); border-radius: 12px; padding: 16px; margin-bottom: 18px; border: 1px solid var(--border);">
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 12px; text-align: center;">
                        <div>
                            <div style="font-size: 11px; color: var(--muted); text-transform: uppercase; letter-spacing: .8px; margin-bottom: 4px;">Amount Paid</div>
                            <div style="font-family: 'Playfair Display',serif; font-size: 22px; font-weight: 900; color: #166534;" id="mdlPaid">—</div>
                        </div>
                        <div>
                            <div style="font-size: 11px; color: var(--muted); text-transform: uppercase; letter-spacing: .8px; margin-bottom: 4px;">Remaining</div>
                            <div style="font-family: 'Playfair Display',serif; font-size: 22px; font-weight: 900; color: #991b1b;" id="mdlRemaining">—</div>
                        </div>
                    </div>
                </div>

                <!-- Footer Actions -->
                <div style="display: flex; gap: 10px;">
                    <a id="mdlReceiptLink" href="agent_receipts.aspx" class="btn btn-primary" style="flex: 1; justify-content: center;">🧾 View Receipt</a>
                    <button type="button" onclick="closeModal('bookingViewModal')" class="btn btn-outline" style="flex: 1; justify-content: center;">Close</button>
                </div>
            </div>
        </div>

    </div>

    <script>
        function openBookingModal(bookingID, customerID, customerName, projectPlot, total, paid, remaining, bookingDate, status) {
            document.getElementById('mdlBookingID').innerText = bookingID;
            document.getElementById('mdlCustomerID').innerText = customerID;
            document.getElementById('mdlCustomerName').innerText = customerName;
            document.getElementById('mdlProjectPlot').innerText = projectPlot;
            document.getElementById('mdlTotal').innerText = total;
            document.getElementById('mdlPaid').innerText = paid;
            document.getElementById('mdlRemaining').innerText = remaining;
            document.getElementById('mdlBookingDate').innerText = bookingDate;
            document.getElementById('mdlStatus').innerText = status;
            openModal('bookingViewModal');
        }

        function openModal(id) { document.getElementById(id).classList.add('show'); }
        function closeModal(id) { document.getElementById(id).classList.remove('show'); }
        document.addEventListener('click', function (e) {
            if (e.target.classList.contains('modal-bg')) e.target.classList.remove('show');
        });

        function oSB() { document.getElementById('sb').classList.add('open'); document.getElementById('sbOv').classList.add('show'); document.body.style.overflow = 'hidden'; }
        function cSB() { document.getElementById('sb').classList.remove('open'); document.getElementById('sbOv').classList.remove('show'); document.body.style.overflow = ''; }
        function tSub(id, el) {
            const s = document.getElementById(id);
            s.classList.toggle('open');
            if (el) el.classList.toggle('sub-open');
        }

        function loadPlots() {
            const p = { 'Sky Residencia': { 'A-101': 'INR 45 Lac', 'A-102': 'INR 96 Lac', 'B-201': 'INR 2.02 Cr' }, 'Sky Gardens': { 'C-301': 'INR 25.6 Lac', 'C-302': 'INR 27 Lac' }, 'Nova Heights': { 'N-101': 'INR 62 Lac' }, 'Sky Villas': { 'V-12': 'INR 85 Lac' } };
            const sel = document.getElementById('projSel').value;
            const ps = document.getElementById('plotSel');
            ps.innerHTML = '<option>Select Plot</option>';
            if (p[sel]) Object.entries(p[sel]).forEach(([k, v]) => ps.innerHTML += `<option value="${v}">${k}</option>`);
            ps.onchange = () => document.getElementById('plotPrice').value = ps.value;
        }
    </script>
</asp:Content>