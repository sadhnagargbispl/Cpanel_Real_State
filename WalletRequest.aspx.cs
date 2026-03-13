using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Security.Principal;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

public partial class WalletRequest : System.Web.UI.Page
{
    DAL ObjDAL;
    SqlDataReader ds;
    SqlDataReader ds1;
    SqlConnection Conn;
    SqlCommand Comm;
    private SqlCommand cmd = new SqlCommand();
    private SqlDataReader dRead;
    private cls_DataAccess dbConnect;
    int TransferId;
    DataTable tmpTable = new DataTable();
    DataTable dt1;
    DataTable dt2;
    string strQuery = "";
    SqlDataAdapter Ad;
    string scrname;
    DAL Obj;
    clsGeneral objGen = new clsGeneral();
    string IsoStart;
    string IsoEnd;
    string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
    string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        MasterPage Mst = new MasterPage();
        try
        {
            Obj = new DAL();

            try
            {
                string str = "exec('Create table Trnwalletreqcpanel ([ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,[Transid] [numeric](18, 0) NOT NULL,[Rectimestamp] [datetime] NOT NULL,PRIMARY KEY CLUSTERED ([Transid] ASC)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF," +
                             "ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]) ON [PRIMARY] ALTER TABLE [dbo].[Trnwalletreqcpanel] ADD  DEFAULT (getdate()) FOR [Rectimestamp] ')";

                int i = SqlHelper.ExecuteNonQuery(
                            constr,
                            CommandType.Text,
                            str
                        );
            }
            catch (Exception)
            {
            }

            this.cmdSave1.Attributes.Add("onclick", DisableTheButton(this.Page, this.cmdSave1));
            if (Session["Status"] != null && Session["Status"].ToString() == "OK")
            {
                if (!Page.IsPostBack)
                {
                    HdnCheckTrnns.Value = GenerateRandomStringactive(6);
                    FillPaymode();
                    CheckVisible();

                    hdnSessn.Value = Crypto.Encrypt(Session["IDNo"].ToString());


                }
            }
            else
            {
                Response.Redirect("Logout.aspx");
                Response.End();
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;

            Obj.WriteToFile(text + ex.Message);

            Response.Write("Try later.");
        }

    }
    public string GenerateRandomStringactive(int iLength)
    {
        Random rdm = new Random();
        char[] allowChrs = "123456789".ToCharArray();
        string sResult = "";

        for (int i = 0; i < iLength; i++)
        {
            sResult += allowChrs[rdm.Next(0, allowChrs.Length)];
        }
        return sResult;
    }
    private string DisableTheButton(Control pge, Control btn)
    {
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append("if (typeof(Page_ClientValidate) == 'function') {");
        sb.Append("if (Page_ClientValidate() == false) { return false; }} ");
        sb.Append("if (confirm('Are you sure to proceed?') == false) { return false; } ");
        sb.Append("this.value = 'Please wait...';");
        sb.Append("this.disabled = true;");
        sb.Append(pge.Page.GetPostBackEventReference(btn));
        sb.Append(";");

        return sb.ToString();
    }
    private void FillPaymode()
    {
        try
        {
            strQuery = "SELECT * FROM M_PayModeMaster WHERE ActiveStatus='Y' ORDER BY Pid";

            tmpTable = Obj.GetData(strQuery);

            DdlPaymode.DataSource = tmpTable;
            DdlPaymode.DataValueField = "PID";
            DdlPaymode.DataTextField = "Paymode";
            DdlPaymode.DataBind();

            Session["PaymodeDetail"] = tmpTable;
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;

            Obj.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    private void FillBankMaster(string condition)
    {
        try
        {
            strQuery = "SELECT BankCode, BankName FROM M_BankMaster " +
                       "WHERE ActiveStatus='Y' AND RowStatus='Y' " + condition +
                       " ORDER BY BankCode";

            tmpTable = Obj.GetData(strQuery);

            DDlBank.DataSource = tmpTable;
            DDlBank.DataValueField = "BankCode";
            DDlBank.DataTextField = "BankName";
            DDlBank.DataBind();
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;

            Obj.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    protected void DdlPaymode_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            CheckVisible();
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            Obj.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    public string ClearInject(string StrObj)
    {
        StrObj = StrObj.Replace(";", "").Replace("'", "").Replace("=", "");
        return StrObj;
    }
    protected void CheckVisible()
    {
        DataTable dt;
        string condition = "";
        // Session("PaymodeDetail") = tmpTable
        dt = (DataTable)Session["PaymodeDetail"];
        DataRow[] Dr = dt.Select("PID='" + DdlPaymode.SelectedValue + "'");
        if (Dr.Length > 0)
        {
            if (Dr[0]["IsBankDtl"].ToString() == "Y")
            {
                DivBank.Visible = true;
            }
            else
            {
                DivBank.Visible = false;
            }
            if (Dr[0]["IsBranchDtl"].ToString() == "Y")
            {
                DivBranch.Visible = true;
            }
            else
            {
                DivBranch.Visible = false;
                TxtIssueBranch.Text = "";
            }
            if (Dr[0]["IsTransNo"].ToString() == "Y")
            {
                divDDno.Visible = true;
            }
            else
            {
                divDDno.Visible = false;
                TxtDDNo.Text = "";
            }
            if (Dr[0]["AllBank"].ToString() == " ")
            {
                condition = "";
            }
            else if (Dr[0]["AllBank"].ToString() == "N")
            {
                condition = "and MacAdrs='C' and BranChName<>'N'";
            }
            else
            {
                condition = "and MacAdrs='C'";
            }
            if (Dr[0]["Isimage"].ToString() == "N")
            {
                divupcopy.Visible = false;
            }
            else
            {
                divupcopy.Visible = true;
            }
            // If Dr(0)("Istransdate") = "N" Then
            // divDDDate.Visible = False
            // Else
            // divDDDate.Visible = True
            // End If

            FillBankMaster(condition);
            LblDDNo.Text = Dr[0]["TransNoLbl"].ToString(); LblDDDate.Text = Dr[0]["TransDateLbl"].ToString();
        }
    }
    protected void TxtDDNo_TextChanged(object sender, EventArgs e)
    {
        try
        {
            string s = "";
            DataTable dt = new DataTable();
            Obj = new DAL();

            if (Convert.ToInt32(DdlPaymode.SelectedValue) != 10)
            {
                // COMP 1091 special logic
                if (divDDno.Visible)
                {
                    s = "select * from WalletReq where ChqNo='" + TxtDDNo.Text.Trim() + "' and IsApprove<>'R'";
                    dt = Obj.GetData(s);

                    if (dt.Rows.Count > 0)
                    {
                        scrname = "<script>alert('" + LblDDNo.Text + " already exist');</script>";
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Close", scrname, false);
                        cmdSave1.Enabled = false;
                        TxtDDNo.Text = "";
                    }
                    else
                    {
                        cmdSave1.Enabled = true;
                    }
                }
            }
        }
        catch
        {
        }
    }
    protected bool CheckDDnod()
    {
        string s = "";
        DataTable dt = new DataTable();
        Obj = new DAL();

        s = "select case when fld5='Y' then 8000 else 1 end as minimumreqamount " +
            "from M_MemberMaster where formno='" + Convert.ToInt32(Session["formno"]) + "'";

        dt = Obj.GetData(s);

        if (dt.Rows.Count > 0)
        {
            Session["MinReqAmount"] = dt.Rows[0]["minimumreqamount"];
            return true;
        }

        return true;
    }
    protected bool CheckDDno()
    {
        string s = "";
        DataTable dt = new DataTable();
        Obj = new DAL();

        if (Convert.ToInt32(DdlPaymode.SelectedValue) != 10)
        {
            if (divDDno.Visible && TxtDDNo.Text != "")
            {
                s = "select * from WalletReq where ChqNo='" + TxtDDNo.Text.Trim() + "' and IsApprove<>'R'";
                dt = Obj.GetData(s);

                if (dt.Rows.Count > 0)
                {
                    scrname = "<script>alert('" + LblDDNo.Text + " already exist');</script>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Close", scrname, false);

                    TxtDDNo.Text = "";
                    return false;
                }
                else
                {
                    return true;
                }
            }
            else
            {
                return true;
            }
        }

        return true;
    }
    protected void ValidateFileSize(object sender, ServerValidateEventArgs e)
    {
        try
        {
            if (FlDoc.HasFile)
            {
                string strextension = System.IO.Path.GetExtension(FlDoc.FileName).ToUpper();

                if (strextension == ".JPG" || strextension == ".GIF" || strextension == ".JPEG" || strextension == ".BMP" || strextension == ".PNG")
                {
                    System.Drawing.Image img = System.Drawing.Image.FromStream(FlDoc.PostedFile.InputStream);

                    decimal size = Math.Round((Convert.ToDecimal(FlDoc.PostedFile.ContentLength) / 1024), 2);

                    if (size > 10240)   // 10 MB
                    {
                        CustomValidator1.ErrorMessage = "File size must not exceed 10 MB.";
                        e.IsValid = false;
                        LblImage.Text = "False";
                    }
                    else
                    {
                        LblImage.Text = "True";
                    }
                }
                else
                {
                    CustomValidator1.ErrorMessage = "You can upload only .jpg,.gif,.jpeg,.bmp,.png extension file!!";
                    e.IsValid = false;
                    LblImage.Text = "False";
                }
            }
            else
            {
                LblImage.Text = "True";
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
            Response.End();
        }
    }
    protected void cmdSave1_Click(object sender, EventArgs e)
    {
        string FlNm = "", flnm1 = "";
        string scrname = "";
        Session["CkyPinRequest"] = null;

        if (Convert.ToDecimal(TxtAmount.Text == "" ? "0" : TxtAmount.Text) <= 0)
        {
            scrname = "<script language='javascript'>alert('Please Enter Amount.');</script>";
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Close", scrname, false);
            return;
        }

        if (DdlPaymode.SelectedValue == "0")
        {
            scrname = "<script language='javascript'>alert('Choose Paymode');</script>";
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Close", scrname, false);
            return;
        }

        // File required checks depending on company and paymode
        if (DdlPaymode.SelectedValue != "3")
        {
            if (FlDoc.Enabled)
            {
                if (!FlDoc.HasFile)
                {
                    scrname = "<script language='javascript'>alert('Please upload wallet receipt jpg/jpeg/png/ image of upto 5 mb size only!!');</script>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Close", scrname, false);
                    return;
                }
            }
        }
        if (DdlPaymode.SelectedValue != "6")
        {
            if (FlDoc.Enabled)
            {
                if (!FlDoc.HasFile)
                {
                    scrname = "<script language='javascript'>alert('Please upload wallet receipt jpg/jpeg/png/ image of upto 5 mb size only!!');</script>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Close", scrname, false);
                    return;
                }
            }
        }
        else
        {
            if (FlDoc.Enabled)
            {
                if (!FlDoc.HasFile)
                {
                    scrname = "<script language='javascript'>alert('Please upload wallet receipt jpg/jpeg/png/ image of upto 5 mb size only!!');</script>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Close", scrname, false);
                    return;
                }
            }
        }

        // Remarks mandatory
        if (string.IsNullOrWhiteSpace(TxtRemarks.Text))
        {
            scrname = "<script language='javascript'>alert('Please enter remarks');</script>";
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Close", scrname, false);
            return;
        }


        // Bank selection validation
        if (DivBank.Visible)
        {
            if (DDlBank.SelectedValue == "0" || string.IsNullOrEmpty(DDlBank.SelectedValue))
            {
                scrname = "<script language='javascript'>alert('Choose Bank Name');</script>";
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Close", scrname, false);
                return;
            }
        }

        bool flag = false;
        int paymodeVal = 0;
        int.TryParse(DdlPaymode.SelectedValue, out paymodeVal);

        if (paymodeVal == 1)
        {
            flag = true;
        }
        else
        {
            if (divDDno.Visible && string.IsNullOrWhiteSpace(TxtDDNo.Text))
            {
                scrname = "<script language='javascript'>alert('" + LblDDNo.Text + " can not be blank');</script>";
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Close", scrname, false);
                return;
            }
            else
            {
                if (CheckDDno())
                    flag = true;
                else
                    flag = false;

                if (DivBranch.Visible)
                {
                    if (string.IsNullOrWhiteSpace(TxtIssueBranch.Text))
                    {
                        scrname = "<script language='javascript'>alert('Branch name can not be blank');</script>";
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Close", scrname, false);
                        return;
                    }
                }
            }
        }

        string strextension = "";
        string uploadRoot = Server.MapPath("~/images/UploadImage/");
        if (!Directory.Exists(uploadRoot))
        {
            Directory.CreateDirectory(uploadRoot);
        }
        try
        {
            if (flag)
            {
                if (FlDoc.HasFile)
                {
                    strextension = Path.GetExtension(FlDoc.FileName);
                    string extUpper = strextension.ToUpperInvariant();

                    if (extUpper == ".JPG" || extUpper == ".GIF" || extUpper == ".JPEG" || extUpper == ".BMP" || extUpper == ".PNG")
                    {
                        if (LblImage.Text == "True")
                        {
                            flnm1 = DateTime.Now.ToString("yyMMddhhmmssfff") + Path.GetExtension(FlDoc.PostedFile.FileName);
                            string saveDir = Server.MapPath("~/images/UploadImage/");
                            if (!Directory.Exists(saveDir))
                            {
                                Directory.CreateDirectory(saveDir);
                            }
                            flnm1 = DateTime.Now.ToString("yyMMddhhmmssfff") + Path.GetExtension(FlDoc.PostedFile.FileName);
                            string fullPath = Path.Combine(uploadRoot, flnm1);
                            FlDoc.PostedFile.SaveAs(fullPath);
                            CompressAndSaveImage(FlDoc.PostedFile.InputStream, fullPath, strextension, 50L); // Quality 50%
                            FlNm = flnm1;
                            Session["WalletImage"] = FlNm;
                        }
                        else
                        {
                            scrname = "<script language='javascript'>alert('File size must not exceed 10 mb');</script>";
                            ClientScript.RegisterStartupScript(this.GetType(), "MyAlert", scrname);
                            return;
                        }
                    }
                    else
                    {
                        scrname = "<script language='javascript'>alert('You can upload only .jpg,.gif,.jpeg,.bmp,.png extension file!! ');</script>";
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Close", scrname, false);
                        return;
                    }
                }
                else
                {
                    FlNm = "";
                }
            }

            if (Session["CkyPinRequest"] != null)
            {

            }
            else
            {
                try
                {

                    string TransPassw = TxtPassword.Text.Trim();

                    DataTable Dt1 = new DataTable();
                    DAL objDal = new DAL();

                    string str = "select * from M_MemberMaster where Epassw='" + TransPassw + "' and Formno=" + Session["Formno"];
                    Dt1 = objDal.GetData(str);

                    if (Dt1.Rows.Count > 0)
                    {
                        Session["CkyPinTransfer1"] = Dt1.Rows[0]["EPassw"].ToString();
                    }
                    else
                    {
                        Session["CkyPinTransfer1"] = null;

                        scrname = "<script language='javascript'>alert('Please Enter valid Transaction Password.');</script>";
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
                    }

                    if (Session["CkyPinTransfer1"] != null)
                    {
                        SaveRequest();
                    }
                    else
                    {
                        //feedbackpop1.Visible = true;
                    }
                }
                catch (Exception ex)
                {
                    string path = HttpContext.Current.Request.Url.AbsoluteUri;
                    string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;

                    Obj.WriteToFile(text + ex.Message);
                    Response.Write("Try later.");
                }
                // feedbackpop1.Visible = true;
            }
        }
        catch (Exception ex)
        {
            try
            {
                string path = HttpContext.Current.Request.Url.AbsoluteUri;
                string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
                Obj.WriteToFile(text + ex.Message);
            }
            catch { }
            Response.Write("Try later.");
        }
    }
    private void CompressAndSaveImage(Stream inputStream, string savePath, string extension, long quality = 50L)
    {
        using (System.Drawing.Image img = System.Drawing.Image.FromStream(inputStream))
        {
            ImageCodecInfo codec = null;
            EncoderParameters encoderParams = new EncoderParameters(1);

            switch (extension.ToLower())
            {
                case ".jpg":
                case ".jpeg":
                    codec = ImageCodecInfo.GetImageEncoders()
                            .FirstOrDefault(c => c.MimeType == "image/jpeg");

                    encoderParams.Param[0] = new EncoderParameter(Encoder.Quality, quality);
                    break;

                case ".png":
                    codec = ImageCodecInfo.GetImageEncoders()
                            .FirstOrDefault(c => c.MimeType == "image/png");

                    // PNG does not support quality compression
                    encoderParams = null;
                    break;

                case ".gif":
                    codec = ImageCodecInfo.GetImageEncoders()
                            .FirstOrDefault(c => c.MimeType == "image/gif");

                    encoderParams = null;
                    break;

                default:
                    throw new Exception("Unsupported file type.");
            }

            if (codec != null)
            {
                if (encoderParams != null)
                    img.Save(savePath, codec, encoderParams);
                else
                    img.Save(savePath, codec, null);
            }
        }
    }
    protected void SaveRequest()
    {
        try
        {
            ObjDAL = new DAL();

            int updateeffect = 0;
            string StrSql2 = "Insert into Trnwalletreqcpanel (Transid,Rectimestamp) values(" +
                             HdnCheckTrnns.Value + ", getdate())";

            updateeffect = ObjDAL.SaveData(StrSql2);

            if (updateeffect > 0)
            {

                // ------------------- Data Cleaning -----------------------
                TxtDDNo.Text = ClearInject(TxtDDNo.Text.Trim());
                TxtDDDate.Text = ClearInject(TxtDDDate.Text.Trim());
                TxtIssueBranch.Text = ClearInject(TxtIssueBranch.Text.Trim());
                TxtRemarks.Text = ClearInject(TxtRemarks.Text.Trim());

                string FlNm = "";
                string flnm1 = "";

                DateTime ChqDate;

                try
                {
                    ChqDate = Convert.ToDateTime(TxtDDDate.Text);
                }
                catch
                {
                    ChqDate = DateTime.Now;
                }

                // -------------------- Validate DD fields ------------------------
                bool flag;

                if (Convert.ToInt32(DdlPaymode.SelectedValue) == 1)
                {
                    flag = true;
                }
                else
                {
                    if (divDDno.Visible && TxtDDNo.Text == "")
                    {
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(),
                            "Close", "<script>alert('" + LblDDNo.Text + " can not be blank');</script>", false);
                        return;
                    }
                    else
                    {
                        flag = CheckDDno();

                        if (DivBranch.Visible)
                        {
                            if (TxtIssueBranch.Text == "")
                            {
                                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(),
                                    "Close", "<script>alert('Branch name can not be blank');</script>", false);
                                return;
                            }
                        }
                    }
                }

                // ----------------------- File Upload ------------------------
                string strextension = "";
                // CompID folder root
                string uploadRoot = Server.MapPath("~/images/UploadImage/");
                if (!Directory.Exists(uploadRoot))
                {
                    Directory.CreateDirectory(uploadRoot);
                }
                try
                {
                    if (flag)
                    {
                        if (FlDoc.HasFile)
                        {
                            strextension = Path.GetExtension(FlDoc.FileName);

                            string ext = strextension.ToUpper();

                            if (ext == ".JPG" || ext == ".GIF" || ext == ".JPEG" ||
                                ext == ".BMP" || ext == ".PNG")
                            {
                                if (LblImage.Text == "True")
                                {
                                    flnm1 = DateTime.Now.ToString("yyMMddhhmmssfff") + Path.GetExtension(FlDoc.PostedFile.FileName);
                                    string fullPath = Path.Combine(uploadRoot, flnm1);
                                    FlDoc.PostedFile.SaveAs(fullPath);
                                    CompressAndSaveImage(FlDoc.PostedFile.InputStream, fullPath, strextension, 50L); // Quality 50%
                                    FlNm = flnm1;

                                }
                                else
                                {
                                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(),
                                        "Close", "<script>alert('File size must not exceed 10 mb');</script>", false);
                                    return;
                                }
                            }
                            else
                            {
                                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(),
                                    "Close", "<script>alert('You can upload only .jpg,.gif,.jpeg,.bmp,.png extension file!!');</script>", false);
                                return;
                            }
                        }
                        else
                        {
                            FlNm = "";
                        }

                        // Use previously uploaded image if exists
                        FlNm = Convert.ToString(Session["WalletImage"]);

                        // ---------------------- Insert Request -----------------------
                        string str = "INSERT INTO WalletReq(ReqNo,ReqDate,Formno,PID,Paymode,Amount,ChqNo,ChqDate," +
                                     "BankName,BranchName,ScannedFile,Remarks,BankId,Transno) " +
                                     "Select ISNULL(Max(ReqNo)+1,'1001'),'" +
                                     DateTime.Now.ToString("dd-MMM-yyyy") + "','" +
                                     Convert.ToInt32(Session["Formno"]) + "','" +
                                     Convert.ToInt32(DdlPaymode.SelectedValue) + "','" +
                                     DdlPaymode.SelectedItem.Text.Trim() + "','" +
                                     Convert.ToDecimal(TxtAmount.Text) + "','" +
                                     TxtDDNo.Text.Trim() + "','" +
                                     ChqDate.ToString("dd-MMM-yyyy") + "','" +
                                     DDlBank.SelectedItem.Text.Trim() + "','" +
                                     TxtIssueBranch.Text.Trim() + "','" +
                                     FlNm + "','" +
                                     TxtRemarks.Text.Trim() + "','" +
                                     Convert.ToInt32(DDlBank.SelectedValue) + "','0' FROM WalletReq " +

                                     ";INSERT INTO UserHistory(UserId,UserName,PageName,Activity,ModifiedFlds,RecTimeStamp,MemberId)" +
                                     "VALUES('" + Session["FormNo"] + "','" + Session["MemName"] +
                                     "','Payment Request','Payment Request','Amount: " +
                                     Convert.ToDecimal(TxtAmount.Text) + "',Getdate()," +
                                     Session["FormNo"] + ")";

                        int i = ObjDAL.SaveData(str);

                        // --------------------- Fetch ReqNo ------------------------
                        dt1 = new DataTable();
                        string q2 = " Select Max(ReqNo) as ReqNo FROM WalletReq WHERE Formno='" +
                                    Convert.ToInt32(Session["Formno"]) +
                                    "' AND Amount='" + Convert.ToDecimal(TxtAmount.Text) + "'";

                        dt1 = Obj.GetData(q2);

                        string ReqNo = "";
                        if (dt1.Rows.Count > 0)
                            ReqNo = dt1.Rows[0]["ReqNo"].ToString();

                        // ------ Success Message ------
                        scrname = "<script>alert('Payment Request Sent Successfully.\\nYour Request no. is " +
                                  ReqNo + "');location.replace('WalletRequest.aspx');</script>";

                        Session["ScrName"] = scrname;

                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Close", scrname, false);

                        // Reset UI
                        TxtAmount.Text = "";
                        TxtDDDate.Text = "";
                        TxtDDNo.Text = "";
                        TxtIssueBranch.Text = "";
                        TxtRemarks.Text = "";

                        FillPaymode();
                        CheckVisible();
                    }
                }
                catch (Exception ex2)
                {
                    string path = HttpContext.Current.Request.Url.AbsoluteUri;
                    string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
                    Obj.WriteToFile(text + ex2.Message);
                    Response.Write("Try later.");
                }
            }
            else
            {
                Response.Redirect("WalletRequest.aspx");
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ": " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            Obj.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    public bool SendToMemberMail(string RequestNo)
    {
        try
        {
            string StrMsg = "";

            MailAddress SendFrom = new MailAddress(Session["CompMail"].ToString());
            MailAddress SendTo = new MailAddress(Session["EMail"].ToString());

            MailMessage MyMessage = new MailMessage(SendFrom, SendTo);

            StrMsg =
                "<table style='margin:0; padding:10px; font-size:12px; font-family:Verdana, Arial, Helvetica, sans-serif; line-height:23px; text-align:justify;width:100%'>" +
                "<tr>" +
                "<td>" +
                "<span style='color: #0099CC; font-weight: bold;'><h2>Dear " + Session["MemName"] + ",</h2></span><br />" +
                "<h4>Payment Request Sent Successfully. Your Request no. is " + RequestNo + "</h4><br />" +
                "<br/> For login go to our site : <a href='" + Session["CompWeb"] + "' target='_blank' style='color:#0000FF; text-decoration:underline;'>" + Session["CompWeb"] + "</a><br/>" +
                "Thank you!<br> Regards : <br/><a href='" + Session["CompWeb"] + "' target='_blank' style='color:#0000FF; text-decoration:underline;'>" + Session["CompName"] + "</a><br />" +
                "<br /><br />" +
                "</td>" +
                "</tr>" +
                "</table>";

            MyMessage.Subject = "Wallet Request";
            MyMessage.Body = StrMsg;
            MyMessage.IsBodyHtml = true;

            SmtpClient smtp = new SmtpClient("smtp.gmail.com");
            // SmtpClient smtp = new SmtpClient(Session["MailHost"].ToString());

            smtp.UseDefaultCredentials = false;
            smtp.Port = 587;
            smtp.EnableSsl = true;
            smtp.DeliveryMethod = SmtpDeliveryMethod.Network;

            smtp.Credentials = new NetworkCredential(
                Session["CompMail"].ToString(),
                Session["MailPass"].ToString()
            );

            smtp.Send(MyMessage);

            return true;
        }
        catch (Exception)
        {
            Response.Write("Try later.");
        }

        return false;
    }
}