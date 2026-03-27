<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Forgot.aspx.cs" Inherits="Forgot" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Agent Login — The Sky Is Your Limit</title>
    <link href="css/agent_login.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager
            ID="ScriptManager1"
            runat="server"
            EnablePageMethods="true">
        </asp:ScriptManager>
        <div class="right">
            <div class="form-box">

                <!-- Steps indicator -->
                <!--<div class="steps">
            <div class="step active" id="s1">
                <div class="step-dot">1</div>
                <div class="step-lbl">User ID</div>
            </div>
            <div class="step" id="s2">
                <div class="step-dot">2</div>
                <div class="step-lbl">OTP</div>
            </div>
            <div class="step" id="s3">
                <div class="step-dot">3</div>
                <div class="step-lbl">New Password</div>
            </div>
        </div>-->

                <!-- Error message -->
                <div class="err-msg" id="errMsg">Invalid User ID. Please check and try again.</div>

                <!-- PANEL 1: Enter User ID -->
                <div class="step-panel active" id="panel1">
                    <div class="fh">
                        <h2>Forgot Password?</h2>
                        <p>Enter your Agent User ID. We'll send an Password to your email address.</p>
                    </div>
                    <div class="fg">
                        <label class="fl">Agent User ID</label>
                        <div class="iw">
                            <span class="iic">👤</span>
                            <input class="inp" id="txtUserId" placeholder="Enter your User ID" autocomplete="off">
                        </div>
                    </div>
                    <div class="fg">
                        <label class="fl">Email ID</label>
                        <div class="iw">
                            <span class="iic">👤</span>
                            <input class="inp" id="txtemail" placeholder="Enter your Email ID" autocomplete="off">
                        </div>
                    </div>
                    <button type="button" class="btn-login" onclick="sendOTP()">Send OTP to Email</button>
                    <%--<div class="back-lnk"><a href="agent_login.aspx">← Back to Sign In</a></div>--%>
                </div>
            </div>
        </div>
    </form>
</body>
<script>

    function sendOTP() {

        var uid = document.getElementById('txtUserId').value.trim();
        var email = document.getElementById('txtemail').value.trim();

        if (!uid) {
            showErr('Please enter User ID');
            return;
        }

        if (!email) {
            showErr('Please enter Email ID');
            return;
        }

        PageMethods.SendOTP(uid, email,

            function (response) {

                if (response == "SUCCESS") {
                    alert("Password sent successfully ✅");
                    window.parent.forgotSuccessCloseModal();
                }
                else if (response == "FILL") {
                    alert("❌ Forgot password option is available only for Agent login. Please contact support.");
                    window.parent.forgotSuccessCloseModal();
                }
                else {

                    showErr(response);

                }

            },

            function () {

                showErr("Server error occurred");

            }

        );
    }
    function showErr(msg) {
        var el = document.getElementById('errMsg');
        el.innerText = msg;
        el.classList.add('show');
    }

</script>
</html>
