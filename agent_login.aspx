<%@ Page Language="C#" AutoEventWireup="true" CodeFile="agent_login.aspx.cs" Inherits="agent_login" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>Agent Login — The Sky Is Your Limit</title>
    <link href="css/agent_login.css" rel="stylesheet" />
    <style>
        /* ── Modal ── */
        #profilePhotoModal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            z-index: 99999;
            background: rgba(0, 0, 0, 0.75);
            display: none;
            align-items: center;
            justify-content: center;
        }

            #profilePhotoModal.show {
                display: flex;
            }

            #profilePhotoModal .modal-dialog {
                margin: 0 auto;
                max-width: 680px;
                width: 92%;
            }

            #profilePhotoModal .modal-content {
                border-radius: 14px;
                overflow: hidden;
                border: none;
                box-shadow: 0 24px 64px rgba(0, 0, 0, 0.45);
                background: #fff;
            }

            #profilePhotoModal .modal-header {
                background: #fff;
                border-bottom: 1px solid #eee;
                padding: 14px 20px;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            #profilePhotoModal .modal-title {
                font-size: 15px;
                font-weight: 600;
                color: #1B2B6B;
                margin: 0;
            }

            #profilePhotoModal .modal-body {
                background: #f4f6fb;
              /*  padding: 20px;*/
                text-align: center;
                min-height: 120px;
            }

            #profilePhotoModal iframe {
                border-radius: 10px;
                border: none;
                background: #fff;
            }

        .modal-close-btn {
            background: #f0f0f0;
            border: none;
            border-radius: 8px;
            width: 32px;
            height: 32px;
            cursor: pointer;
            color: #555;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background 0.2s, color 0.2s;
            flex-shrink: 0;
        }

            .modal-close-btn:hover {
                background: #EF4444;
                color: #fff;
            }
    </style>
</head>
<body>

    <div class="left">
        <div class="orb o1"></div>
        <div class="orb o2"></div>
        <div class="orb o3"></div>
        <div class="lc">
            <div class="l-logo">
                <div class="l-logo-icon">🏙️</div>
                <div>
                    <div class="l-brand">The Sky Is Your Limit</div>
                    <div class="l-sub">Agent Portal v2.0</div>
                </div>
            </div>
            <h2 class="l-title">Welcome to Your<br>
                <em>Agent Dashboard</em></h2>
            <p class="l-desc">Manage projects, plots, customers, bookings & commissions — all in one powerful platform built for top-performing agents.</p>
            <div class="features">
                <div class="fi-item">
                    <div class="fi-icon">📊</div>
                    <div class="fi-text">Live sales & revenue analytics dashboard</div>
                </div>
                <div class="fi-item">
                    <div class="fi-icon">🏠</div>
                    <div class="fi-text">Track all booked properties & availability</div>
                </div>
                <div class="fi-item">
                    <div class="fi-icon">👥</div>
                    <div class="fi-text">Manage customers, agents & team performance</div>
                </div>
                <div class="fi-item">
                    <div class="fi-icon">₹</div>
                    <div class="fi-text">Real-time commission tracker & payouts</div>
                </div>
                <div class="fi-item">
                    <div class="fi-icon">🧾</div>
                    <div class="fi-text">Instant booking receipts & payment records</div>
                </div>
            </div>
        </div>
    </div>
    <div class="right">
        <div class="form-box">
            <div class="fh">
                <h2>Agent Sign In</h2>
                <p>Enter your credentials to access your portal. Contact admin if you need access.</p>
            </div>
            <div class="err-msg" id="errMsg">❌ Invalid email or password. Please try again.</div>
            <div class="suc-msg" id="sucMsg">✅ Login successful! Taking you to the dashboard…</div>
            <%--<form action="agent_dashboard.html"">--%>
            <form runat="server">
                <div class="fg">
                    <label class="fl">User ID</label>
                    <div class="iw">
                        <span class="iic">✉️</span>
                        <input class="inp" runat="server" id="Txtuid" name="uid" placeholder="" required>
                    </div>
                </div>
                <div class="fg">
                    <label class="fl">Password</label>
                    <div class="iw">
                        <span class="iic">🔒</span>
                        <input type="password" class="inp" runat="server" id="Txtpwd" name="pwd" placeholder="Enter your password" required>
                        <button type="button" class="eye-btn" onclick="tp()">👁️</button>
                    </div>
                </div>
                <div class="row-btw">
                    <label class="cb-lbl">
                        <input type="checkbox"> Remember me</label>
                    <a href="#" class="forgot" onclick="return openPhotoModal('front')">Forgot Password?</a>
                </div>
                <asp:Button ID="BtnSubmit" runat="server" Text="🔑 Sign In to Dashboard" OnClick="BtnSubmit_Click" class="btn-login" />
                <asp:HiddenField ID="HdnWalletAddress" runat="server" />
                <asp:HiddenField ID="HiddenField1" runat="server" />
                <%-- <a href="agent_dashboard.html">
                    <button type="submit" class="btn-login" id="lbtn">🔑 Sign In to Dashboard</button>
                </a>--%>
            </form>

            <%-- </form>--%>
            <%--  <div class="demo-card">
                <strong>Demo Login:</strong><br>
                Email: <code><a href="/cdn-cgi/l/email-protection" class="__cf_email__" data-cfemail="147573717a6054677f6d3a647f">[email&#160;protected]</a></code><br>
                Password: <code>agent123</code>
            </div>--%>
            <div class="back-lnk"><a href="Index.aspx">← Back to main website</a></div>
        </div>
    </div>
    <div id="profilePhotoModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Forgot Password?</h5>
                    <button type="button" class="modal-close-btn" onclick="closePhotoModal()">
                        <svg width="14" height="14" viewBox="0 0 14 14" fill="none">
                            <path d="M1 1l12 12M13 1L1 13" stroke="currentColor"
                                stroke-width="2" stroke-linecap="round" />
                        </svg>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="imgLoader" style="display: none; padding: 30px 0;">
                        <div class="spinner-border text-primary" role="status"></div>
                        <p style="color: #888; font-size: 13px; margin-top: 8px;">Loading Page...</p>
                    </div>
                    <iframe id="photoPreviewFrame"
                        style="width: 100%; height: 460px; border: none; border-radius: 10px; display: none;"></iframe>
                    <p id="noImageMsg"
                        style="display: none; color: #999; font-size: 13px; padding: 40px 0;">
                        No image found.
               
                    </p>
                </div>
            </div>
        </div>
    </div>
</body>
<script>
    function openPhotoModal(reqno) {
        var frame = document.getElementById("photoPreviewFrame");
        var loader = document.getElementById("imgLoader");
        var noMsg = document.getElementById("noImageMsg");
        var modalEl = document.getElementById('profilePhotoModal');

        frame.style.display = "none";
        frame.src = "";
        loader.style.display = "block";
        noMsg.style.display = "none";

        modalEl.classList.add('show');
        document.body.style.overflow = 'hidden';

        var allowedTypes = ["front", "back", "bank", "pan"];
        var imgType = allowedTypes.includes(reqno.toLowerCase()) ? reqno.toLowerCase() : "payment";
        var formNo = '<%= Session["FormNo"] ?? "" %>';
        var url = "Forgot.aspx?type=" + imgType + "&ID=" + formNo + "&t=" + new Date().getTime();

        frame.onload = function () {
            loader.style.display = "none";
            frame.style.display = "block";
        };

        frame.src = url;
        return false;
    }

    function closePhotoModal() {
        var modalEl = document.getElementById('profilePhotoModal');
        modalEl.classList.remove('show');
        document.body.style.overflow = '';
        document.getElementById('photoPreviewFrame').src = "";
    }

    document.addEventListener('DOMContentLoaded', function () {
        var modalEl = document.getElementById('profilePhotoModal');

        modalEl.addEventListener('click', function (e) {
            if (e.target === modalEl) closePhotoModal();
        });

        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') closePhotoModal();
        });
    });
   
</script>
    <script>

        function forgotSuccessCloseModal() {

            // Forgot modal close
            closePhotoModal();

            //// Optional success message show
            //document.getElementById("sucMsg").style.display = "block";

            //// Optional auto hide after 2 sec
            //setTimeout(function () {
            //    document.getElementById("sucMsg").style.display = "none";
            //}, 2000);

        }

    </script>
<script>
    function tp() { const i = document.getElementById('Txtpwd'); i.type = i.type === 'password' ? 'text' : 'password'; }
</script>
<script data-cfasync="false" src="/cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script>

<script defer src="https://static.cloudflareinsights.com/beacon.min.js/v8c78df7c7c0f484497ecbca7046644da1771523124516" integrity="sha512-8DS7rgIrAmghBFwoOTujcf6D9rXvH8xm8JQ1Ja01h9QX8EzXldiszufYa4IFfKdLUKTTrnSFXLDkUEOTrZQ8Qg==" data-cf-beacon='{"version":"2024.11.0","token":"f4c7240510c342d2be33c8f80ef832f4","r":1,"server_timing":{"name":{"cfCacheStatus":true,"cfEdge":true,"cfExtPri":true,"cfL4":true,"cfOrigin":true,"cfSpeedBrain":true},"location_startswith":null}}' crossorigin="anonymous"></script>

</html>
