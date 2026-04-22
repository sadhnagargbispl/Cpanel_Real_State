<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="Booking.aspx.cs" Inherits="Booking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/Booking.css" rel="stylesheet" />
    <style>
        /* ── SIDEBAR SCROLL FIX ── */
        #sb {
            overflow-y: auto !important;
            overflow-x: hidden !important;
            max-height: 100vh !important;
            height: 100vh !important;
            position: fixed !important;
            top: 0 !important;
            left: 0 !important;
            -webkit-overflow-scrolling: touch;
            scrollbar-width: thin;
        }
        #sb::-webkit-scrollbar { width: 4px; }
        #sb::-webkit-scrollbar-track { background: transparent; }
        #sb::-webkit-scrollbar-thumb { background: rgba(0,0,0,0.15); border-radius: 4px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="pc">

        <!-- Page Header -->
        <div class="page-header">
            <div class="ph-left">
                <div class="breadcrumb">
                    <a href="BookingReport.aspx">&#128203; Bookings</a>
                    <span>›</span>
                    <span>Create New Booking</span>
                </div>
                <div class="ph-title">Create New Booking</div>
                <div class="ph-sub">Fill in all details to register a new property booking</div>
            </div>
            <div>
                <a href="BookingReport.aspx" class="btn btn-outline">← Back to Bookings</a>
            </div>
        </div>

        <asp:HiddenField ID="hdnIdno" runat="server" />

        <!-- Main Layout -->
        <div class="layout-grid" style="display: grid; grid-template-columns: 1fr 360px; gap: 20px; align-items: start;">

            <!-- LEFT: FORM -->
            <div style="display: flex; flex-direction: column; gap: 20px;">

                <!-- Section 1: Customer & Property -->
                <div class="card">
                    <div class="card-header">
                        <div style="display: flex; align-items: center; gap: 12px;">
                            <div class="section-icon si-blue">&#128100;</div>
                            <div>
                                <div class="card-title">Customer & Property</div>
                                <div class="card-subtitle">Enter customer ID and select property details</div>
                            </div>
                        </div>
                        <span style="font-size: 11px; font-weight: 700; background: #DBEAFE; color: #1D4ED8; padding: 4px 10px; border-radius: 20px;">Step 1 of 3</span>
                    </div>
                    <div class="form-body">

                        <!-- Customer ID + Name -->
                        <div class="g2">
                            <div class="fg" style="position: relative;">
                                <label class="fl">Customer ID <span class="req">*</span></label>
                                <input type="text" class="fi" id="custId" placeholder="e.g. CUST-0041" oninput="onIdInput(this.value)" autocomplete="off">
                                <div id="idDrop" style="display: none; position: absolute; top: 100%; left: 0; right: 0; background: var(--bg); border: 1.5px solid var(--ocean); border-radius: 10px; margin-top: 3px; z-index: 200; box-shadow: 0 6px 20px rgba(0,0,0,0.12); overflow: hidden;"></div>
                                <div class="fi-hint" id="idHint">Type Customer ID to search</div>
                            </div>
                            <div class="fg">
                                <label class="fl">Customer Name</label>
                                <input type="text" class="fi readonly" id="custName" placeholder="— Auto-filled —" readonly>
                            </div>
                        </div>

                        <!-- Phone + Email -->
                        <div class="g2">
                            <div class="fg">
                                <label class="fl">Customer Phone</label>
                                <input type="tel" class="fi readonly" id="custPhone" placeholder="— Auto-filled —" readonly>
                            </div>
                            <div class="fg">
                                <label class="fl">Customer Email</label>
                                <input type="text" class="fi readonly" id="custEmail" placeholder="— Auto-filled —" readonly>
                            </div>
                        </div>

                        <!-- Project + Plot -->
                        <div class="g2">
                            <div class="fg">
                                <label class="fl">Project <span class="req">*</span></label>
                                <select class="fs-el" id="projSel" onchange="loadPlots()">
                                    <option value="">— Select Project —</option>
                                </select>
                            </div>
                            <div class="fg">
                                <label class="fl">Plot / Unit <span class="req">*</span></label>
                                <select class="fs-el" id="plotSel" onchange="selectPlot()" disabled>
                                    <option value="">— Select Project First —</option>
                                </select>
                            </div>
                        </div>

                        <!-- Price Display -->
                        <div class="price-display" id="priceDisplay">
                            <div class="pd-icon">&#127991;</div>
                            <div>
                                <div class="pd-label">Plot Price</div>
                                <div class="pd-val empty" id="priceVal">Select project and plot to see price</div>
                            </div>
                        </div>

                        <div class="fg" style="margin-top: 16px;">
                            <label class="fl">Plot / Property Size</label>
                            <input type="text" class="fi readonly" id="plotSize" placeholder="— Auto-filled on plot selection —" readonly>
                        </div>

                    </div>
                </div>

                <!-- Section 2: Booking Details -->
                <div class="card">
                    <div class="card-header">
                        <div style="display: flex; align-items: center; gap: 12px;">
                            <div class="section-icon si-gold">&#128203;</div>
                            <div>
                                <div class="card-title">Booking Details</div>
                                <div class="card-subtitle">Set booking date and payment mode</div>
                            </div>
                        </div>
                        <span style="font-size: 11px; font-weight: 700; background: #FEF3C7; color: #92400E; padding: 4px 10px; border-radius: 20px;">Step 2 of 3</span>
                    </div>
                    <div class="form-body">
                        <div class="g2">
                            <div class="fg">
                                <label class="fl">Booking Date <span class="req">*</span></label>
                                <input type="date" class="fi" id="bookDate" onchange="updateSummary()">
                            </div>
                            <div class="fg">
                                <label class="fl">Expected Possession Date</label>
                                <input type="date" class="fi" id="possDate">
                            </div>
                        </div>

                        <!-- Payment Mode -->
                        <div class="fg">
                            <label class="fl">Payment Mode <span class="req">*</span></label>
                            <div class="mode-grid">
                                <div class="mode-card selected" onclick="selectMode(this,'Cash')">
                                    <div class="mode-icon">&#128181;</div>
                                    <div>
                                        <div class="mode-name">Cash</div>
                                        <div class="mode-desc">Physical cash payment</div>
                                    </div>
                                </div>
                                <div class="mode-card" onclick="selectMode(this,'Bank Transfer')">
                                    <div class="mode-icon">&#127970;</div>
                                    <div>
                                        <div class="mode-name">Bank Transfer</div>
                                        <div class="mode-desc">IBFT / Wire Transfer</div>
                                    </div>
                                </div>
                                <div class="mode-card" onclick="selectMode(this,'Cheque')">
                                    <div class="mode-icon">&#128221;</div>
                                    <div>
                                        <div class="mode-name">Cheque</div>
                                        <div class="mode-desc">Cheque payment</div>
                                    </div>
                                </div>
                            </div>
                            <input type="hidden" id="selMode" value="Cash">
                        </div>

                    </div>
                </div>

                <!-- Section 3: Payment -->
                <div class="card">
                    <div class="card-header">
                        <div style="display: flex; align-items: center; gap: 12px;">
                            <div class="section-icon si-green">&#128179;</div>
                            <div>
                                <div class="card-title">Payment Information</div>
                                <div class="card-subtitle">Enter down payment and remaining amount</div>
                            </div>
                        </div>
                        <span style="font-size: 11px; font-weight: 700; background: #DCFCE7; color: #166534; padding: 4px 10px; border-radius: 20px;">Step 3 of 3</span>
                    </div>
                    <div class="form-body">
                        <div class="g2">
                            <div class="fg">
                                <label class="fl">Down Payment <span class="req">*</span></label>
                                <div class="fi-prefix">
                                    <span class="prefix-label">INR</span>
                                    <input type="number" class="fi" id="downPayment" placeholder="0" oninput="calcRemaining()">
                                </div>
                                <div class="fi-hint" id="dpHint">Enter down payment amount in INR</div>
                            </div>
                            <div class="fg">
                                <label class="fl">Remaining Amount</label>
                                <div class="fi-prefix">
                                    <span class="prefix-label">INR</span>
                                    <input type="text" class="fi readonly" id="remaining" value="—" readonly>
                                </div>
                            </div>
                        </div>
                        <div class="g2">
                            <div class="fg">
                                <label class="fl">Transaction / Cheque Ref #</label>
                                <input type="text" class="fi" id="txRef" placeholder="Optional reference number">
                            </div>
                        </div>

                        <div class="fg">
                            <label class="fl">Additional Notes</label>
                            <textarea class="fta" id="notes" placeholder="Any special conditions, remarks, or instructions regarding this booking…"></textarea>
                        </div>

                        <!-- Upload Docs -->
                        <div class="fg">
                            <label class="fl">Attach Documents</label>
                            <div style="border: 2px dashed var(--border); border-radius: 12px; padding: 20px; text-align: center; cursor: pointer; transition: border-color .2s;"
                                onmouseenter="this.style.borderColor='var(--ocean)'"
                                onmouseleave="this.style.borderColor='var(--border)'"
                                onclick="document.getElementById('docInput').click()">
                                <div style="font-size: 28px; margin-bottom: 8px;">&#128206;</div>
                                <div style="font-size: 13px; font-weight: 600; color: var(--navy); margin-bottom: 3px;">Click to upload documents</div>
                                <div style="font-size: 11.5px; color: var(--muted);">CNIC, Payment Slip, Cheque Scan — PDF, JPG, PNG (max 5MB each)</div>
                                <input type="file" id="docInput" multiple accept=".pdf,.jpg,.jpeg,.png" style="display: none" onchange="showFiles(this)">
                            </div>
                            <div id="fileList" style="margin-top: 8px; display: flex; flex-wrap: wrap; gap: 8px;"></div>
                        </div>

                    </div>
                </div>

                <!-- Actions -->
                <div style="display: flex; gap: 12px; justify-content: flex-end; padding-bottom: 20px;">
                    <a href="BookingReport.aspx" class="btn btn-outline">✕ Cancel</a>
                    <button type="button" class="btn btn-primary btn-lg" onclick="submitBooking()">✓ Create Booking & Generate Receipt</button>
                </div>

            </div>

            <!-- RIGHT: SUMMARY -->
            <div style="position: sticky; top: calc(var(--th) + 24px);">

                <!-- Booking Summary -->
                <div class="summary-box">
                    <div class="sb-title">&#128203; Booking Summary</div>
                    <div class="sb-row"><span class="sb-row-label">Customer ID</span><span class="sb-row-val" id="sum-cid">—</span></div>
                    <div class="sb-row"><span class="sb-row-label">Customer</span><span class="sb-row-val" id="sum-customer">—</span></div>
                    <div class="sb-row"><span class="sb-row-label">Project</span><span class="sb-row-val" id="sum-project">—</span></div>
                    <div class="sb-row"><span class="sb-row-label">Plot / Unit</span><span class="sb-row-val" id="sum-plot">—</span></div>
                    <div class="sb-row"><span class="sb-row-label">Plot Size</span><span class="sb-row-val" id="sum-size">—</span></div>
                    <div class="sb-row"><span class="sb-row-label">Booking Date</span><span class="sb-row-val" id="sum-date">—</span></div>
                    <div class="sb-row"><span class="sb-row-label">Payment Mode</span><span class="sb-row-val" id="sum-mode">Cash</span></div>
                    <div class="sb-total">
                        <div>
                            <div class="sb-total-label">Total Plot Price</div>
                            <div class="sb-total-val" id="sum-price">INR —</div>
                        </div>
                        <div style="text-align: right;">
                            <div class="sb-total-label">Down Payment</div>
                            <div style="font-family: 'Playfair Display',serif; font-size: 18px; font-weight: 700; color: #fff;" id="sum-down">INR —</div>
                        </div>
                    </div>
                </div>

                <!-- Agent Commission Preview -->
                <div class="card" style="margin-bottom: 16px;">
                    <div class="card-header">
                        <div class="card-title">&#128176; Commission Preview</div>
                    </div>
                    <div style="padding: 16px 18px;">
                        <div class="stat-row">
                            <span style="font-size: 12.5px; color: var(--mid);">Commission Rate</span>
                            <span style="font-size: 13px; font-weight: 700; color: var(--navy);" id="commRate">2%</span>
                        </div>
                        <div class="stat-row">
                            <span style="font-size: 12.5px; color: var(--mid);">Estimated Commission</span>
                            <span style="font-size: 13px; font-weight: 700; color: var(--green);" id="commAmt">INR —</span>
                        </div>
                        <div class="stat-row">
                            <span style="font-size: 12.5px; color: var(--mid);">Status</span>
                            <span style="font-size: 11px; font-weight: 700; background: #FEF3C7; color: #92400E; padding: 3px 9px; border-radius: 20px;">Pending</span>
                        </div>
                    </div>
                </div>

                <!-- Checklist -->
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">&#9989; Booking Checklist</div>
                    </div>
                    <div style="padding: 14px 18px;">
                        <div class="stat-row">
                            <span style="font-size: 12.5px; color: var(--mid);">Customer ID entered</span>
                            <span style="font-size: 16px;" id="chki-custid">&#11036;</span>
                        </div>
                        <div class="stat-row">
                            <span style="font-size: 12.5px; color: var(--mid);">Customer found</span>
                            <span style="font-size: 16px;" id="chki-customer">&#11036;</span>
                        </div>
                        <div class="stat-row">
                            <span style="font-size: 12.5px; color: var(--mid);">Project selected</span>
                            <span style="font-size: 16px;" id="chki-project">&#11036;</span>
                        </div>
                        <div class="stat-row">
                            <span style="font-size: 12.5px; color: var(--mid);">Plot selected</span>
                            <span style="font-size: 16px;" id="chki-plot">&#11036;</span>
                        </div>
                        <div class="stat-row">
                            <span style="font-size: 12.5px; color: var(--mid);">Booking date set</span>
                            <span style="font-size: 16px;" id="chki-date">&#11036;</span>
                        </div>
                        <div class="stat-row">
                            <span style="font-size: 12.5px; color: var(--mid);">Down payment entered</span>
                            <span style="font-size: 16px;" id="chki-payment">&#11036;</span>
                        </div>
                    </div>
                </div>

            </div>
        </div>

    </div>

    <!-- Success Overlay -->
    <div class="success-overlay" id="successOverlay">
        <div class="success-box">
            <div class="success-icon">&#9989;</div>
            <div class="success-title">Booking Created!</div>
            <div class="success-sub">The booking has been successfully registered and a receipt has been generated for the customer.</div>
            <div class="success-id">
                Booking ID <strong id="newBookId">#BK-0090</strong>
            </div>
            <div style="display: flex; flex-direction: column; gap: 10px;">
                <button type="button" class="btn btn-primary" style="width: 100%; justify-content: center;" onclick="window.location.href='agent_receipts.aspx'">&#129534; View & Print Receipt</button>
                <button type="button" class="btn btn-navy" style="width: 100%; justify-content: center;" onclick="window.location.href='BookingReport.aspx'">← Back to Bookings</button>
                <button type="button" class="btn btn-outline" style="width: 100%; justify-content: center;" onclick="resetForm()">+ Create Another Booking</button>
            </div>
        </div>
    </div>

    <style>
        .stat-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 9px 0;
            border-bottom: 1px solid var(--border);
        }
        .stat-row:last-child { border-bottom: none; }
        .fi-hint { font-size: 11.5px; color: var(--muted); margin-top: 4px; }
    </style>

    <script>

        // ── SIDEBAR SCROLL FIX ──
        document.addEventListener('DOMContentLoaded', function () {
            var sb = document.getElementById('sb');
            if (sb) {
                sb.style.overflowY = 'auto';
                sb.style.overflowX = 'hidden';
                sb.style.maxHeight = '100vh';
                sb.style.height = '100vh';
                sb.style.position = 'fixed';
                sb.style.webkitOverflowScrolling = 'touch';
            }
        });

        // ── SIDEBAR FUNCTIONS ──
        function oSB() {
            var sb = document.getElementById('sb');
            var ov = document.getElementById('sbOv');
            if (sb) sb.classList.add('open');
            if (ov) ov.classList.add('show');
            document.body.style.overflow = 'hidden';
        }
        function cSB() {
            var sb = document.getElementById('sb');
            var ov = document.getElementById('sbOv');
            if (sb) sb.classList.remove('open');
            if (ov) ov.classList.remove('show');
            document.body.style.overflow = '';
        }
        function tSub(id, el) {
            var s = document.getElementById(id);
            if (s) s.classList.toggle('open');
            if (el) el.classList.toggle('sub-open');
        }

        // ── STATE ──
        var currentPrice = 0;
        var currentPlotID = 0;
        var selectedMode = 'Cash';
        var searchTimer = null;

        // ── CUSTOMER SEARCH ──
        function onIdInput(val) {
            clearTimeout(searchTimer);
            var drop = document.getElementById('idDrop');
            var hint = document.getElementById('idHint');
            if (val.trim().length < 2) {
                drop.style.display = 'none';
                clearCustomer();
                hint.textContent = 'Type Customer ID to search';
                return;
            }
            searchTimer = setTimeout(function () { searchCustomers(val.trim()); }, 300);
        }

        function searchCustomers(keyword) {
            callWebMethod('SearchCustomers', { keyword: keyword }, function (data) {
                var drop = document.getElementById('idDrop');
                var hint = document.getElementById('idHint');
                if (!data || data.length === 0) {
                    drop.style.display = 'none';
                    hint.textContent = 'No customer found';
                    clearCustomer();
                    return;
                }
                drop.innerHTML = data.map(function (c) {
                    return '<div onclick="selectCustomer(\'' + c.CustomerID + '\',\'' + c.CustomerName + '\',\'' + c.Phone + '\',\'' + c.Email + '\')" '
                        + 'style="padding:10px 14px;font-size:13px;cursor:pointer;border-bottom:1px solid var(--border);color:var(--navy);" '
                        + 'onmouseenter="this.style.background=\'var(--bg)\'" '
                        + 'onmouseleave="this.style.background=\'transparent\'">'
                        + '<span style="font-weight:700;">' + c.CustomerID + '</span>'
                        + '<span style="color:var(--mid);margin-left:8px;">— ' + c.CustomerName + '</span>'
                        + '</div>';
                }).join('');
                drop.style.display = 'block';
            });
        }

        function selectCustomer(id, name, phone, email) {
            document.getElementById('custId').value = id;
            document.getElementById('custName').value = name;
            document.getElementById('custPhone').value = phone;
            document.getElementById('custEmail').value = email;
            document.getElementById('idDrop').style.display = 'none';
            document.getElementById('idHint').textContent = 'Customer found';
            document.getElementById('sum-cid').textContent = id;
            document.getElementById('sum-customer').textContent = name;
            document.getElementById('chki-custid').textContent = '\u2705';
            document.getElementById('chki-customer').textContent = '\u2705';
        }

        function clearCustomer() {
            ['custName', 'custPhone', 'custEmail'].forEach(function (id) {
                document.getElementById(id).value = '';
            });
            document.getElementById('sum-cid').textContent = '—';
            document.getElementById('sum-customer').textContent = '—';
            document.getElementById('chki-custid').innerHTML = '&#11036;';
            document.getElementById('chki-customer').innerHTML = '&#11036;';
        }

        document.addEventListener('click', function (e) {
            if (!e.target.closest('#custId') && !e.target.closest('#idDrop'))
                document.getElementById('idDrop').style.display = 'none';
        });

        // ── PROJECTS (load from DB on page load) ──
        window.addEventListener('DOMContentLoaded', function () {
            callWebMethod('GetProjects', {}, function (data) {
                var sel = document.getElementById('projSel');
                sel.innerHTML = '<option value="">— Select Project —</option>';
                data.forEach(function (p) {
                    sel.innerHTML += '<option value="' + p.ProjectID + '" data-name="' + p.ProjectName + '">' + p.ProjectName + '</option>';
                });
            });
            document.getElementById('bookDate').value = new Date().toISOString().split('T')[0];
            updateSummary();
        });

        // ── PLOTS ──
        function loadPlots() {
            var sel = document.getElementById('projSel');
            var opt = sel.options[sel.selectedIndex];
            var pid = parseInt(sel.value);
            var pname = opt ? opt.dataset.name : '';
            var ps = document.getElementById('plotSel');

            ps.innerHTML = '<option value="">— Loading... —</option>';
            ps.disabled = true;
            currentPrice = 0;
            currentPlotID = 0;

            document.getElementById('priceVal').textContent = 'Select a plot to see price';
            document.getElementById('priceVal').className = 'pd-val empty';
            document.getElementById('plotSize').value = '';
            document.getElementById('sum-project').textContent = pname || '—';
            document.getElementById('chki-project').textContent = pname ? '\u2705' : '&#11036;';
            document.getElementById('chki-plot').innerHTML = '&#11036;';

            if (!pid) {
                ps.innerHTML = '<option value="">— Select Project First —</option>';
                return;
            }

            callWebMethod('GetPlots', { projectID: pid }, function (data) {
                ps.innerHTML = '<option value="">— Select Plot —</option>';
                data.forEach(function (p) {
                    ps.innerHTML += '<option value="' + p.PlotID + '" '
                        + 'data-price="' + p.Price + '" '
                        + 'data-size="' + p.PlotSize + '" '
                        + 'data-num="' + p.PlotNumber + '">'
                        + p.PlotNumber + ' — ' + p.PlotSize + ' (INR ' + fmtPrice(p.Price) + ')'
                        + '</option>';
                });
                ps.disabled = false;
            });

            calcRemaining();
            updateSummary();
        }

        function selectPlot() {
            var ps = document.getElementById('plotSel');
            var opt = ps.options[ps.selectedIndex];
            if (!ps.value || !opt) {
                currentPrice = 0;
                currentPlotID = 0;
                document.getElementById('priceVal').textContent = 'Select project and plot to see price';
                document.getElementById('priceVal').className = 'pd-val empty';
                document.getElementById('plotSize').value = '';
                document.getElementById('chki-plot').innerHTML = '&#11036;';
            } else {
                currentPrice = parseFloat(opt.dataset.price);
                currentPlotID = parseInt(ps.value);
                document.getElementById('priceVal').textContent = 'INR ' + fmtPrice(currentPrice);
                document.getElementById('priceVal').className = 'pd-val';
                document.getElementById('plotSize').value = opt.dataset.size;
                document.getElementById('sum-plot').textContent = opt.dataset.num;
                document.getElementById('sum-size').textContent = opt.dataset.size;
                document.getElementById('chki-plot').textContent = '\u2705';
            }
            calcRemaining();
            updateSummary();
        }

        // ── PRICE FORMAT ──
        function fmtPrice(n) {
            if (n >= 10000000) return (n / 10000000).toFixed(2) + ' Cr';
            if (n >= 100000) return (n / 100000).toFixed(1) + ' Lac';
            return parseFloat(n).toLocaleString();
        }

        // ── REMAINING & COMMISSION ──
        function calcRemaining() {
            var dp = parseFloat(document.getElementById('downPayment').value) || 0;
            var rem = currentPrice - dp;
            document.getElementById('remaining').value = rem > 0 ? fmtPrice(rem) : rem < 0 ? 'Exceeds price' : '0';

            var comm = Math.round(currentPrice * 0.02);
            document.getElementById('commAmt').textContent = currentPrice > 0 ? 'INR ' + fmtPrice(comm) : 'INR —';

            document.getElementById('dpHint').textContent = (currentPrice > 0 && dp > 0)
                ? ((dp / currentPrice) * 100).toFixed(1) + '% of total plot price'
                : 'Enter down payment amount in INR';

            document.getElementById('chki-payment').textContent = dp > 0 ? '\u2705' : '&#11036;';
            updateSummary();
        }

        // ── PAYMENT MODE ──
        function selectMode(el, mode) {
            document.querySelectorAll('.mode-card').forEach(function (c) { c.classList.remove('selected'); });
            el.classList.add('selected');
            selectedMode = mode;
            document.getElementById('selMode').value = mode;
            document.getElementById('sum-mode').textContent = mode;
        }

        // ── SUMMARY UPDATE ──
        function updateSummary() {
            var date = document.getElementById('bookDate').value;
            var dp = parseFloat(document.getElementById('downPayment').value) || 0;
            document.getElementById('sum-date').textContent = date
                ? new Date(date).toLocaleDateString('en-IN', { day: '2-digit', month: 'short', year: 'numeric' })
                : '—';
            document.getElementById('sum-price').textContent = currentPrice > 0 ? 'INR ' + fmtPrice(currentPrice) : 'INR —';
            document.getElementById('sum-down').textContent = dp > 0 ? 'INR ' + fmtPrice(dp) : 'INR —';
            document.getElementById('chki-date').textContent = date ? '\u2705' : '&#11036;';
        }

        document.getElementById('downPayment').addEventListener('input', calcRemaining);
        document.getElementById('bookDate').addEventListener('change', updateSummary);

        // ── FILE UPLOAD DISPLAY ──
        function showFiles(inp) {
            var list = document.getElementById('fileList');
            list.innerHTML = '';
            Array.from(inp.files).forEach(function (f) {
                var tag = document.createElement('div');
                tag.style.cssText = 'background:var(--bg);border:1.5px solid var(--border);border-radius:8px;padding:6px 12px;font-size:12px;color:var(--navy);display:flex;align-items:center;gap:6px;';
                tag.innerHTML = '&#128196; ' + f.name + ' <span style="color:var(--muted);font-size:10px;">(' + (f.size / 1024).toFixed(0) + 'KB)</span>';
                list.appendChild(tag);
            });
        }

        // ── VALIDATE ──
        function validate() {
            var custId = document.getElementById('custId').value.trim();
            var custName = document.getElementById('custName').value.trim();
            var date = document.getElementById('bookDate').value;
            var dp = parseFloat(document.getElementById('downPayment').value) || 0;

            if (!custId) { alert('Please enter a Customer ID.'); return false; }
            if (!custName) { alert('Customer not found. Enter a valid Customer ID.'); return false; }
            if (!currentPlotID) { alert('Please select a plot.'); return false; }
            if (!date) { alert('Please set a booking date.'); return false; }
            if (dp <= 0) { alert('Please enter a down payment amount.'); return false; }
            if (dp > currentPrice) { alert('Down payment cannot exceed the plot price.'); return false; }
            return true;
        }

        // ── SUBMIT BOOKING ──
        function submitBooking() {
            if (!validate()) return;

            var agentID = document.getElementById('<%= hdnIdno.ClientID %>').value;

            var payload = {
                customerID: document.getElementById('custId').value.trim(),
                plotID: currentPlotID,
                bookingDate: document.getElementById('bookDate').value,
                possessionDate: document.getElementById('possDate').value || null,
                totalPrice: currentPrice,
                downPayment: parseFloat(document.getElementById('downPayment').value),
                paymentMode: selectedMode,
                transactionRef: document.getElementById('txRef').value.trim(),
                notes: document.getElementById('notes').value.trim(),
                FromID: agentID,
                isDraft: false
            };

            callWebMethod('SubmitBooking', payload, function (result) {
                if (result.Success) {
                    document.getElementById('newBookId').textContent = result.BookingID;

                    // Auto-generate receipt
                    callWebMethod('GenerateReceipt', {
                        bookingID: result.BookingID,
                        agentID: agentID
                    }, function (rcpt) {
                        if (rcpt.Success) {
                            console.log('Receipt generated: RCP-' + String(rcpt.ReceiptID).padStart(3, '0'));
                        } else {
                            console.error('Receipt failed:', rcpt.Message);
                        }
                    });

                    document.getElementById('successOverlay').classList.add('show');
                    uploadDocuments(result.BookingID);
                } else {
                    alert(result.Message);
                }
            });
        }

        // ── SAVE DRAFT ──
        function saveDraft() {
            if (!document.getElementById('custName').value) {
                alert('Please enter a valid Customer ID first.');
                return;
            }
            var payload = {
                customerID: document.getElementById('custId').value.trim(),
                plotID: currentPlotID || 0,
                bookingDate: document.getElementById('bookDate').value || new Date().toISOString().split('T')[0],
                totalPrice: currentPrice || 0,
                downPayment: parseFloat(document.getElementById('downPayment').value) || 0,
                paymentMode: selectedMode,
                notes: document.getElementById('notes').value.trim()
            };
            callWebMethod('SaveDraft', payload, function (result) {
                if (result.Success) alert('Draft saved! Booking ID: ' + result.BookingID);
                else alert(result.Message);
            });
        }

        // ── UPLOAD DOCUMENTS ──
        function uploadDocuments(bookingID) {
            var files = document.getElementById('docInput').files;
            if (!files.length) return;
            Array.from(files).forEach(function (file) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    var base64 = e.target.result.split(',')[1];
                    var ext = file.name.split('.').pop().toLowerCase();
                    callWebMethod('UploadDocument', {
                        bookingID: bookingID,
                        base64Data: base64,
                        fileName: file.name,
                        fileType: ext
                    }, function () { });
                };
                reader.readAsDataURL(file);
            });
        }

        // ── RESET ──
        function resetForm() {
            document.getElementById('successOverlay').classList.remove('show');
            ['custId', 'custName', 'custPhone', 'custEmail', 'plotSize', 'bookDate', 'possDate', 'downPayment', 'txRef', 'notes']
                .forEach(function (id) { document.getElementById(id).value = ''; });
            document.getElementById('projSel').value = '';
            document.getElementById('plotSel').innerHTML = '<option value="">— Select Project First —</option>';
            document.getElementById('plotSel').disabled = true;
            document.getElementById('priceVal').textContent = 'Select project and plot to see price';
            document.getElementById('priceVal').className = 'pd-val empty';
            document.getElementById('idHint').textContent = 'Type Customer ID to search';
            currentPrice = 0;
            currentPlotID = 0;
            ['custid', 'customer', 'project', 'plot', 'date', 'payment'].forEach(function (k) {
                document.getElementById('chki-' + k).innerHTML = '&#11036;';
            });
            ['cid', 'customer', 'project', 'plot', 'size', 'date', 'price', 'down'].forEach(function (k) {
                document.getElementById('sum-' + k).textContent = '—';
            });
            document.getElementById('sum-mode').textContent = 'Cash';
            document.getElementById('commAmt').textContent = 'INR —';
            document.getElementById('bookDate').value = new Date().toISOString().split('T')[0];
            updateSummary();
        }

        // ── WEBMETHOD UTILITY ──
        function callWebMethod(methodName, params, callback) {
            fetch('Booking.aspx/' + methodName, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json; charset=utf-8' },
                body: JSON.stringify(params)
            })
            .then(function (r) { return r.json(); })
            .then(function (data) {
                callback(typeof data.d === 'string' ? JSON.parse(data.d) : data.d);
            })
            .catch(function (err) {
                console.error('WebMethod error [' + methodName + ']:', err);
            });
        }

    </script>

</asp:Content>
