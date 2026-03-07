<%@ Page Language="C#" AutoEventWireup="true" CodeFile="agent_login.aspx.cs" Inherits="agent_login" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>Agent Login — The Sky Is Your Limit</title>
    <link href="css/agent_login.css" rel="stylesheet" />
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
                        <input type="checkbox">
                        Remember me</label>
                    <a href="#" class="forgot">Forgot Password?</a>
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
</body>
    <script>
        function tp() { const i = document.getElementById('Txtpwd');i.type=i.type==='password'?'text':'password';}
</script>
<script data-cfasync="false" src="/cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script>

<script defer src="https://static.cloudflareinsights.com/beacon.min.js/v8c78df7c7c0f484497ecbca7046644da1771523124516" integrity="sha512-8DS7rgIrAmghBFwoOTujcf6D9rXvH8xm8JQ1Ja01h9QX8EzXldiszufYa4IFfKdLUKTTrnSFXLDkUEOTrZQ8Qg==" data-cf-beacon='{"version":"2024.11.0","token":"f4c7240510c342d2be33c8f80ef832f4","r":1,"server_timing":{"name":{"cfCacheStatus":true,"cfEdge":true,"cfExtPri":true,"cfL4":true,"cfOrigin":true,"cfSpeedBrain":true},"location_startswith":null}}' crossorigin="anonymous"></script>

</html>
