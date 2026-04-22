<%@ Page Title="" Language="C#" MasterPageFile="~/SideMaster.master" AutoEventWireup="true" CodeFile="MainLogin.aspx.cs" Inherits="MainLogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .form-box {
            background: #fff;
            border-radius: 22px;
            padding: 40px;
            width: 100%;
            max-width: 420px;
            box-shadow: 0 20px 60px rgba(27,43,107,.12);
        }

        .fh {
            margin-bottom: 28px;
        }

            .fh h2 {
                font-family: 'Playfair Display',serif;
                font-size: 26px;
                font-weight: 700;
                color: var(--navy);
                margin-bottom: 6px;
            }

            .fh p {
                font-size: 13.5px;
                color: #64748B;
                line-height: 1.6;
            }

        .fg {
            margin-bottom: 16px;
        }

        .fl {
            display: block;
            font-size: 11px;
            font-weight: 700;
            color: var(--navy);
            text-transform: uppercase;
            letter-spacing: .7px;
            margin-bottom: 6px;
        }

        .iw {
            position: relative;
        }

        .iic {
            position: absolute;
            left: 13px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 15px;
            pointer-events: none;
        }

        .inp {
            width: 100%;
            padding: 12px 14px 12px 40px;
            border: 1.5px solid var(--border);
            border-radius: 10px;
            font-size: 14px;
            color: #0F1E3C;
            outline: none;
            transition: border-color .2s,box-shadow .2s;
            font-family: 'DM Sans',sans-serif;
            box-sizing: border-box;
        }

            .inp:focus {
                border-color: var(--ocean);
                box-shadow: 0 0 0 3px rgba(30,111,191,.1);
            }

        .eye-btn {
            position: absolute;
            right: 13px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            cursor: pointer;
            font-size: 15px;
            color: #94A3B8;
        }

        .row-btw {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .cb-lbl {
            display: flex;
            align-items: center;
            gap: 7px;
            font-size: 13px;
            color: #64748B;
            cursor: pointer;
        }

            .cb-lbl input {
                width: 15px;
                height: 15px;
                accent-color: var(--ocean);
            }

        .forgot {
            font-size: 13px;
            color: var(--ocean);
            font-weight: 600;
            text-decoration: none;
        }

            .forgot:hover {
                text-decoration: underline;
            }

        .btn-login {
            width: 100%;
            padding: 13px;
            background: linear-gradient(135deg,var(--navy),var(--ocean));
            border: none;
            border-radius: 10px;
            color: #fff;
            font-size: 14.5px;
            font-weight: 700;
            cursor: pointer;
            font-family: 'DM Sans',sans-serif;
            box-shadow: 0 6px 22px rgba(27,43,107,.25);
            transition: all .25s;
            margin-bottom: 16px;
        }

            .btn-login:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 30px rgba(27,43,107,.32);
            }

        .back-lnk {
            text-align: center;
            margin-top: 18px;
            font-size: 13px;
            color: #94A3B8;
        }

            .back-lnk a {
                color: var(--ocean);
                font-weight: 600;
                text-decoration: none;
            }

        .err-msg {
            background: #FEF2F2;
            border: 1px solid #FECACA;
            border-radius: 9px;
            padding: 10px 14px;
            font-size: 13px;
            color: #DC2626;
            margin-bottom: 14px;
            display: none;
        }

            .err-msg.show {
                display: block;
            }

        .suc-msg {
            background: #F0FDF4;
            border: 1px solid #BBF7D0;
            border-radius: 9px;
            padding: 10px 14px;
            font-size: 13px;
            color: #166534;
            text-align: center;
            margin-bottom: 14px;
            display: none;
        }

            .suc-msg.show {
                display: block;
            }

        @media(max-width:768px) {
            .form-box {
                max-width: 100%;
                padding: 30px 20px;
            }
        }
    </style>
    <style>
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
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <div style="display:flex; justify-content:center; padding:60px 16px; box-sizing:border-box;">
    <div class="form-box">
        <div class="fh">
            <h2>Sign In</h2>
            <p>Enter your credentials to access your portal. Contact admin if you need access.</p>
        </div>
        <div class="err-msg" id="errMsg">❌ Invalid email or password. Please try again.</div>
        <div class="suc-msg" id="sucMsg">✅ Login successful! Taking you to the dashboard…</div>

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
                Remember me
            </label>
            <a href="#" class="forgot" onclick="return openPhotoModal('front')">Forgot Password?</a>
        </div>
        <asp:Button ID="BtnSubmit" runat="server" Text="🔑 Sign In to Dashboard" OnClick="BtnSubmit_Click" class="btn-login" />
        <asp:HiddenField ID="HdnWalletAddress" runat="server" />
        <asp:HiddenField ID="HiddenField1" runat="server" />
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
                            <path d="M1 1l12 12M13 1L1 13" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
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
                    <p id="noImageMsg" style="display: none; color: #999; font-size: 13px; padding: 40px 0;">
                        No image found.
                    </p>
                </div>
            </div>
        </div>
    </div>

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

        function forgotSuccessCloseModal() {
            closePhotoModal();
        }

        function tp() {
            const i = document.getElementById('Txtpwd');
            i.type = i.type === 'password' ? 'text' : 'password';
        }
    </script>
</asp:Content>