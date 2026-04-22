<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="agent_receipts.aspx.cs" Inherits="agent_receipts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/agent_customers.css" rel="stylesheet" />
    <style>
        .modal-bg {
            display: none; position: fixed; inset: 0;
            background: rgba(9,19,58,.55); z-index: 800;
            align-items: center; justify-content: center;
            backdrop-filter: blur(3px);
        }
        .modal-bg.show { display: flex; }
        .modal {
            background: var(--white); border-radius: 20px;
            padding: 30px; width: 90%; max-width: 540px;
            max-height: 90vh; overflow-y: auto; animation: mIn .28s ease;
        }
        @keyframes mIn {
            from { opacity: 0; transform: scale(.96) translateY(10px) }
            to   { opacity: 1; transform: none }
        }
        .modal-header {
            display: flex; justify-content: space-between;
            align-items: center; margin-bottom: 22px;
        }
        .modal-title {
            font-family: 'Playfair Display', serif;
            font-size: 19px; font-weight: 700; color: var(--navy);
        }
        .modal-close {
            background: var(--bg); border: none; width: 32px; height: 32px;
            border-radius: 8px; cursor: pointer; font-size: 16px;
            color: var(--mid); display: flex; align-items: center; justify-content: center;
        }
        .modal-close:hover { background: var(--red); color: #fff; }

        @media print {
            body * { visibility: hidden; }
            #printArea, #printArea * { visibility: visible; }
            #printArea { position: fixed; top: 0; left: 0; width: 100%; padding: 40px; }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="pc">

        <div class="page-header">
            <div class="ph-left">
                <div class="ph-title">Receipts</div>
                <div class="ph-sub">View and download booking receipts</div>
            </div>
        </div>

        <div class="card">
            <div class="card-header">
                <div class="card-title">Receipt History</div>
            </div>
            <div class="tbl-wrap">
                <table class="tbl">
                    <thead>
                        <tr>
                            <th>Receipt No.</th>
                            <th>Booking ID</th>
                            <th>Customer</th>
                            <th>Amount</th>
                            <th>Payment Mode</th>
                            <th>Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptReceipts" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td><strong><%# Eval("ReceiptNo") %></strong></td>
                                    <td><%# Eval("BookingID") %></td>
                                    <td>
                                        <div style="display: flex; align-items: center; gap: 9px;">
                                            <div class="avatar av-sm" style="background: linear-gradient(135deg,#0D1B4B,#1E6FBF);">
                                                <%# Eval("Customername").ToString().Substring(0,1).ToUpper() %>
                                            </div>
                                            <div style="font-weight: 600; color: var(--navy);">
                                                <%# Eval("Customername") %>
                                            </div>
                                        </div>
                                    </td>
                                    <td><%# Eval("Paid") %></td>
                                    <td><%# Eval("PaymentMode") %></td>
                                    <td><%# Eval("BookingDate") %></td>
                                    <td>
                                        <div style="display: flex; gap: 5px;">
                                            <button type="button" class="btn btn-navy btn-xs"
                                                onclick="openReceiptModal(
                                                    '<%# Eval("ReceiptNo") %>',
                                                    '<%# Eval("BookingID") %>',
                                                    '<%# Eval("Customername") %>',
                                                    '<%# Eval("ProjecPlot") %>',
                                                    '<%# Eval("Total") %>',
                                                    '<%# Eval("Paid") %>',
                                                    '<%# Eval("Remaining") %>',
                                                    '<%# Eval("BookingDate") %>',
                                                    '<%# Eval("PaymentMode") %>'
                                                )">👁 View</button>
                                            <button type="button" class="btn btn-outline btn-xs"
                                                onclick="openReceiptModal(
                                                    '<%# Eval("ReceiptNo") %>',
                                                    '<%# Eval("BookingID") %>',
                                                    '<%# Eval("Customername") %>',
                                                    '<%# Eval("ProjecPlot") %>',
                                                    '<%# Eval("Total") %>',
                                                    '<%# Eval("Paid") %>',
                                                    '<%# Eval("Remaining") %>',
                                                    '<%# Eval("BookingDate") %>',
                                                    '<%# Eval("PaymentMode") %>'
                                                ); setTimeout(()=>window.print(),400);">⬇ PDF</button>
                                        </div>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- RECEIPT VIEW MODAL -->
        <div class="modal-bg" id="rcptViewModal">
            <div class="modal" style="max-width: 460px;" id="printArea">
                <div class="modal-header">
                    <div class="modal-title">Booking Receipt</div>
                    <button type="button" class="modal-close" onclick="closeModal('rcptViewModal')">✕</button>
                </div>

                <div style="text-align: center; padding: 16px 0 20px; border-bottom: 1px solid var(--border); margin-bottom: 20px;">
                    <div style="width: 54px; height: 54px; border-radius: 14px; background: linear-gradient(135deg,var(--gold),var(--gd)); display: flex; align-items: center; justify-content: center; font-size: 22px; margin: 0 auto 10px;">🏙️</div>
                    <div style="font-family: 'Playfair Display',serif; font-size: 17px; font-weight: 700; color: var(--navy)">The Sky Is Your Limit</div>
                    <div style="font-size: 10.5px; color: var(--muted); text-transform: uppercase; letter-spacing: 1px; margin-bottom: 6px">Official Booking Receipt</div>
                    <div style="font-family: 'Playfair Display',serif; font-size: 26px; font-weight: 900; color: var(--navy)" id="rcptNo">—</div>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 12px; margin-bottom: 18px;">
                    <div>
                        <div style="font-size: 10px; color: var(--muted); font-weight: 700; text-transform: uppercase; margin-bottom: 3px">Booking ID</div>
                        <div style="font-size: 13.5px; font-weight: 600; color: var(--navy)" id="rcptBookingID">—</div>
                    </div>
                    <div>
                        <div style="font-size: 10px; color: var(--muted); font-weight: 700; text-transform: uppercase; margin-bottom: 3px">Customer</div>
                        <div style="font-size: 13.5px; font-weight: 600; color: var(--navy)" id="rcptCustomer">—</div>
                    </div>
                    <div>
                        <div style="font-size: 10px; color: var(--muted); font-weight: 700; text-transform: uppercase; margin-bottom: 3px">Project / Plot</div>
                        <div style="font-size: 13.5px; font-weight: 600; color: var(--navy)" id="rcptProject">—</div>
                    </div>
                    <div>
                        <div style="font-size: 10px; color: var(--muted); font-weight: 700; text-transform: uppercase; margin-bottom: 3px">Date</div>
                        <div style="font-size: 13.5px; font-weight: 600; color: var(--navy)" id="rcptDate">—</div>
                    </div>
                    <div>
                        <div style="font-size: 10px; color: var(--muted); font-weight: 700; text-transform: uppercase; margin-bottom: 3px">Plot Price</div>
                        <div style="font-size: 13.5px; font-weight: 600; color: var(--navy)" id="rcptTotal">—</div>
                    </div>
                    <div>
                        <div style="font-size: 10px; color: var(--muted); font-weight: 700; text-transform: uppercase; margin-bottom: 3px">Payment Mode</div>
                        <div style="font-size: 13.5px; font-weight: 600; color: var(--navy)" id="rcptPayMode">—</div>
                    </div>
                </div>

                <div style="background: linear-gradient(135deg,var(--bg),rgba(30,111,191,.05)); border-radius: 12px; padding: 16px; text-align: center; margin-bottom: 18px; border: 1px solid var(--border)">
                    <div style="font-size: 11px; color: var(--muted); margin-bottom: 4px; text-transform: uppercase; letter-spacing: .8px">Amount Paid</div>
                    <div style="font-family: 'Playfair Display',serif; font-size: 30px; font-weight: 900; color: #166534" id="rcptPaid">—</div>
                    <div style="font-size: 12px; color: var(--muted); margin-top: 4px">Remaining: <span id="rcptRemaining">—</span></div>
                </div>

                <div style="font-size: 11px; color: var(--muted); text-align: center; margin-bottom: 14px;">
                    <strong>The Sky Is Your Limit</strong>
                </div>

                <button type="button" onclick="window.print()" class="btn btn-primary" style="width: 100%; justify-content: center;">
                    🖨️ Print / Download PDF
                </button>
            </div>
        </div>

    </div>

    <script>
        function openReceiptModal(receiptNo, bookingID, customer, projectPlot, total, paid, remaining, date, payMode) {
            document.getElementById('rcptNo').innerText = receiptNo;
            document.getElementById('rcptBookingID').innerText = bookingID;
            document.getElementById('rcptCustomer').innerText = customer;
            document.getElementById('rcptProject').innerText = projectPlot;
            document.getElementById('rcptTotal').innerText = total;
            document.getElementById('rcptPaid').innerText = paid;
            document.getElementById('rcptRemaining').innerText = remaining;
            document.getElementById('rcptDate').innerText = date;
            document.getElementById('rcptPayMode').innerText = payMode;
            openModal('rcptViewModal');
        }

        function openModal(id) { document.getElementById(id).classList.add('show'); }
        function closeModal(id) { document.getElementById(id).classList.remove('show'); }

        document.addEventListener('click', function (e) {
            if (e.target.classList.contains('modal-bg')) e.target.classList.remove('show');
        });
    </script>
</asp:Content>