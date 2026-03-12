using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Net;
using System.Globalization;
using System.Security.Cryptography;
using System.Net.Mail;
using System.Configuration;
using System.Web;
using System;
using System.Web.UI;
using System.Linq;


public partial class IDactivation : System.Web.UI.Page
{
    string scrName;
    DAL ObjDAL = new DAL();
    string IsoStart;
    string IsoEnd;
    string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
    string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["Status"] != null && Session["Status"].ToString() == "OK")
            {
                this.cmdSave1.Attributes.Add("onclick", DisableTheButton(this.Page, this.cmdSave1));
                this.BtnOtp.Attributes.Add("onclick", DisableTheButton(this.Page, this.BtnOtp));
                this.ResendOtp.Attributes.Add("onclick", DisableTheButton(this.Page, this.ResendOtp));

                if (!Page.IsPostBack)
                {

                    Session["OtpCount"] = 0;
                    Session["OtpTime"] = null;
                    Session["Retry"] = null;
                    Session["OTP_"] = null;
                    HdnCheckTrnns.Value = GenerateRandomStringActive(6);
                    FillStackList();
                    GetBalance();
                    fillkit();
                }
            }
            else
            {
                Response.Redirect("logout.aspx");
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            ObjDAL.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    protected void fillkit(string condition = "")
    {
        try
        {
            string query = "";
            DataTable Dt = new DataTable();
            query = "select * from " + ObjDAL.dBName + "..m_kitmaster where activestatus = 'Y' and ForType = 'S' AND kitid <> 1 " + condition + " Order By KitId ";
            Dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, query).Tables[0];
            Session["KitTable"] = Dt;
            Session["MKit"] = Dt;
            CmbKit.DataSource = Dt;
            CmbKit.DataTextField = "KitName";
            CmbKit.DataValueField = "KitId";
            CmbKit.DataBind();
            if (Dt.Rows.Count > 0)
            {
                hdnMacadrs.Value = Dt.Rows[0]["MacAdrs"].ToString();
                HdnTopupSeq.Value = Dt.Rows[0]["TopupSeq"].ToString();
                txtAmount.Text = Dt.Rows[0]["KitAmount"].ToString();
                txtAmount.ReadOnly = true;
                CheckAmount();
            }
        }
        catch (Exception ex)
        {
        }
    }
    private void FillStackList()
    {
        try
        {
            DataSet ds = SqlHelper.ExecuteDataset(constr, "sp_ddlStackList");
            DDlStackType.DataSource = ds.Tables[0];
            DDlStackType.DataValueField = "Value";
            DDlStackType.DataTextField = "Name";
            DDlStackType.DataBind();
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    public string GetName()
    {
        try
        {
            string str = ObjDAL.Isostart + " Exec Sp_GetMemberName '" + txtMemberId.Text + "'" + ObjDAL.IsoEnd;
            DataTable dt = SqlHelper.ExecuteDataset(ConfigurationManager.ConnectionStrings["constr1"].ConnectionString, CommandType.Text, str).Tables[0];
            if (dt.Rows.Count == 0)
            {
                txtMemberId.Text = "";
                TxtMemberName.Text = "";
                HdnMemberMacAdrs.Value = "";
                HdnMemberTopupseq.Value = "";
                scrName = "<script language='javascript'>alert('Invalid ID Does Not Exist');</script>";
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrName, false);
            }
            else
            {
                if (dt.Rows[0]["Isblock"].ToString() == "Y")
                {
                    txtMemberId.Text = "";
                    TxtMemberName.Text = "";
                    HdnMemberMacAdrs.Value = "";
                    HdnMemberTopupseq.Value = "";
                    scrName = "<script language='javascript'>alert('This ID is blocked. Please contact the Admin.');</script>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrName, false);
                    return "";
                }
                //else if (dt.Rows[0]["ActiveStatus"].ToString() == "Y")
                //{

                //    TxtMemberName.Text = "";
                //    HdnMemberMacAdrs.Value = "";
                //    HdnMemberTopupseq.Value = "";
                //    scrName = "<script language='javascript'>alert('Subscription is active, and you are eligible for monthly activation.!');</script>";
                //    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrName, false);
                //    // ScriptManager.RegisterStartupScript(this, this.GetType(), "Key", "alert('This Id Already Active.!');location.replace('index.aspx');", true);
                //    return "";
                //}
                else if (dt.Rows[0]["ActiveStatus"].ToString() == "N")
                {
                    TxtMemberName.Text = dt.Rows[0]["memname"].ToString();
                    HdnMemberMacAdrs.Value = dt.Rows[0]["MacAdrs"].ToString();
                    HdnMemberTopupseq.Value = dt.Rows[0]["Topupseq"].ToString();
                    MemberStatus.Value = dt.Rows[0]["ActiveStatus"].ToString();
                    hdnFormno.Value = dt.Rows[0]["Formno"].ToString();
                    LblMobile.Text = "";
                    return "OK";
                }
                else
                {
                    TxtMemberName.Text = dt.Rows[0]["memname"].ToString();
                    HdnMemberMacAdrs.Value = dt.Rows[0]["MacAdrs"].ToString();
                    HdnMemberTopupseq.Value = dt.Rows[0]["Topupseq"].ToString();
                    MemberStatus.Value = dt.Rows[0]["ActiveStatus"].ToString();
                    hdnFormno.Value = dt.Rows[0]["Formno"].ToString();
                    LblMobile.Text = "";
                    return "OK";
                }
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            ObjDAL.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
        return null;
    }
    private string Checkid()
    {
        try
        {
            string str = "";
            if (GetName() == "OK")
            {
                if (checkvalidid())
                {
                    str = "";
                }
                else
                {
                    str = "invalid request amount";
                }
            }
            return str;
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            ObjDAL.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
        return null;
    }
    private bool checkvalidid()
    {
        string query = "SELECT TOP 1 Amount FROM MemberKitPurchase WHERE Formno='" + hdnFormno.Value + "' ORDER BY KId DESC";
        DataTable dt = ObjDAL.GetData(query);

        if (dt.Rows.Count > 0)
        {
            if (Convert.ToDecimal(txtAmount.Text) >= Convert.ToDecimal(dt.Rows[0]["Amount"]))
            {
                return true;
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
    //public string GenerateRandomStringActive(ref int iLength)
    public string GenerateRandomStringActive(int iLength)
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
        //var sb = new System.Text.StringBuilder();
        //sb.Append("if (typeof(Page_ClientValidate) == 'function') {");
        //sb.Append("if (Page_ClientValidate() == false) { return false; }} ");
        //sb.Append("if (confirm('Are you sure to proceed?') == false) { return false; } ");
        //sb.Append("this.value = 'Please wait...';");
        //sb.Append("this.disabled = true;");
        //sb.Append(((Page)pge).ClientScript.GetPostBackEventReference(btn));
        //sb.Append(";");
        //return sb.ToString();
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
    protected void GetBalance()
    {
        try
        {
            DataTable dt = new DataTable();
            string str = ObjDAL.Isostart + " SELECT * FROM dbo.ufnGetBalance('" + Convert.ToInt32(Session["Formno"]) + "','S')" + ObjDAL.IsoEnd;
            dt = SqlHelper.ExecuteDataset(ConfigurationManager.ConnectionStrings["constr1"].ConnectionString, CommandType.Text, str).Tables[0];

            if (dt.Rows.Count > 0)
            {
                AvailableBal.InnerText = Convert.ToDecimal(dt.Rows[0]["Balance"]).ToString();
            }
            else
            {
                AvailableBal.InnerText = "0";
            }

            Session["ServiceWallet"] = AvailableBal.InnerText;
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            ObjDAL.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    protected void fillcurrency()
    {
        try
        {
            string strquery = ObjDAL.Isostart + " EXEC Sp_FillCurrencyMaster " + ObjDAL.IsoEnd;
            DataSet ds = new DataSet();
            ds = SqlHelper.ExecuteDataset(ConfigurationManager.ConnectionStrings["constr1"].ConnectionString, CommandType.Text, strquery);

            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlcurrency.DataSource = ds.Tables[0];
                ddlcurrency.DataTextField = "CurrencyName";
                ddlcurrency.DataValueField = "CurrencyType";
                ddlcurrency.DataBind();
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            ObjDAL.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    protected void IdActivation()
    {
        string query = "";
        string sql = "";
        int updateeffect = 0;
        try
        {
            string StrSql = "Insert into Trnactive (Transid, Rectimestamp) values(" + HdnCheckTrnns.Value + ", getdate())";
            // updateeffect = Convert.ToInt32(SqlHelper.ExecuteNonQuery(constr, CommandType.Text, StrSql));
            try
            {
                updateeffect = Convert.ToInt32(SqlHelper.ExecuteNonQuery(constr, CommandType.Text, StrSql));
            }
            catch (Exception)
            {
            }
            if (updateeffect > 0)
            {
                CheckAmount();
                //if (Convert.ToDecimal(txtAmount.Text) >= 69)
                //{
                if (Convert.ToDecimal(Session["ServiceWallet"]) >= Convert.ToDecimal(txtAmount.Text))
                {
                    string Kit = CmbKit.SelectedValue;
                    string strSql1 = "exec Sp_trnAcivate '" + txtMemberId.Text.Trim() + "','" + Kit + "'";
                    DataTable DTCheck = new DataTable();
                    DTCheck = SqlHelper.ExecuteDataset(constr, CommandType.Text, strSql1).Tables[0];
                    if (Convert.ToInt32(DTCheck.Rows[0]["Result"]) == 0)
                    {
                        scrName = "<SCRIPT language='javascript'>alert('Your request is processing, Please try after 10 min.!!');</SCRIPT>";
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Upgraded", scrName, false);
                        return;
                    }
                    string Bill_No = GenerateRandomStringActive(6);
                    sql = "Exec Sp_IDActivation '" + txtMemberId.Text.Trim() + "','" + txtAmount.Text + "','" + Convert.ToInt32(Session["Formno"]) + "'," +
                          "'" + DDlStackType.SelectedValue + "','" + Bill_No + "','" + Kit + "'";
                    DataTable dt = new DataTable();
                    dt = SqlHelper.ExecuteDataset(constr, CommandType.Text, sql).Tables[0];
                    if (dt.Rows[0]["Result"].ToString().ToUpper() == "SUCCESS")
                    {
                        Clear();
                        GetBalance();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Key", "alert('Subscription activated successfully. You can now enjoy all the benefits.!');location.replace('IdActivation.aspx');", true);
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Upgraded", scrName, false);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Key", "alert('Subscription not activated successfully.!');", true);
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Upgraded", scrName, false);
                    }
                    //string SqlStrKit = ObjDAL.Isostart + "select kitid from " + ObjDAL.dBName + "..m_kitmaster " +
                    //                   "where joinamount <= '" + Convert.ToDecimal(txtAmount.Text) + "' And kitamount >= '" + Convert.ToDecimal(txtAmount.Text) + "' " + ObjDAL.IsoEnd;
                    //DataTable DtKit = new DataTable();
                    //DtKit = SqlHelper.ExecuteDataset(constr1, CommandType.Text, SqlStrKit).Tables[0];

                    //if (DtKit.Rows.Count > 0)
                    //{

                    //}
                    //else
                    //{
                    //    ScriptManager.RegisterStartupScript(this, this.GetType(), "Key", "alert('Id Activation/Upgrade Not Successful. Because Your Amount Not Valid For Purchasing.!');location.replace('IdActivation.aspx');", true);
                    //    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Upgraded", scrName, false);
                    //}
                }
                else
                {
                    Clear();
                    scrName = "<SCRIPT language='javascript'>alert('Insufficient Balance!! ');</SCRIPT>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Upgraded", scrName, false);
                    LblError.Text = "Insufficient Balance!!";
                }
                //}
                //else
                //{
                //    scrName = "<SCRIPT language='javascript'>alert('The investment should be more than 70$');</SCRIPT>";
                //    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Upgraded", scrName, false);
                //    txtAmount.Text = "";
                //    return;
                //}
                //if (GetName() == "OK")
                //{

                //}
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Key", "alert('Your request is processing, Please try after 10 min.!');location.replace('IdActivation.aspx');", true);
                return;
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            ObjDAL.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    protected void txtAmount_TextChanged(object sender, EventArgs e)
    {
        try
        {
            //if (Convert.ToDecimal(txtAmount.Text) <= 1179)
            //{
            //    scrName = "<SCRIPT language='javascript'>alert('The investment should be more than 1180 !!');</SCRIPT>";
            //    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Upgraded", scrName, false);
            //    txtAmount.Text = "";
            //    return;
            //}
            CheckAmount();
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            ObjDAL.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    protected bool CheckAmount()
    {
        try
        {
            DataTable dt;
            string str = ObjDAL.Isostart + " Select * From dbo.ufnGetBalance('" + Convert.ToDecimal(Session["Formno"]) + "','S')" + ObjDAL.IsoEnd;
            dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, str).Tables[0];

            if (dt.Rows.Count > 0)
            {
                Session["ServiceWallet"] = Convert.ToDecimal(dt.Rows[0]["Balance"]);
                LblAmount.Text = Convert.ToDecimal(dt.Rows[0]["Balance"]).ToString();

                if (Convert.ToDecimal(Session["ServiceWallet"]) < Convert.ToDecimal(txtAmount.Text))
                {
                    LblAmount.Text = "Insufficient Balance";
                    LblAmount.ForeColor = System.Drawing.Color.Red;
                    LblAmount.Visible = true;
                    cmdSave1.Enabled = false;
                    return false;
                }
                else
                {
                    cmdSave1.Enabled = true;
                    LblAmount.Visible = false;
                    return true;
                }
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            ObjDAL.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
        return false;
    }
    public static string Base64Encode(string plainText)
    {
        var plainTextBytes = System.Text.Encoding.UTF8.GetBytes(plainText);
        return System.Convert.ToBase64String(plainTextBytes);
    }
    protected void Clear()
    {
        try
        {
            txtMemberId.Text = "";
            TxtMemberName.Text = "";
            txtAmount.Text = "";
            LblAmount.Text = "";
            LblAmount.Visible = false;
            LblError.Visible = false;
            GetBalance();
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff " + Environment.NewLine);
            ObjDAL.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    private bool Check_IdNo()
    {
        try
        {
            // 🔒 Session safety
            DataTable dtKit = Session["MKit"] as DataTable;
            if (dtKit == null)
            {
                LblError.Text = "Session expired. Please login again.";
                return false;
            }

            string Sql = ObjDAL.Isostart +
                "SELECT a.Formno,a.Idno," +
                "a.MemFirstName + ' ' + a.MemLastName AS MemName," +
                "ISNULL(c.Idno,'') AS SponsorId," +
                "ISNULL(c.MemFirstName + ' ' + c.MemLastName,'') AS SponsorName," +
                "a.IsTopup,a.KitId,a.LegNo,b.MACAdrs,b.TopUpSeq," +
                "b.KitName,a.BV,b.BV AS KBv," +
                "CASE WHEN a.ActiveStatus='Y' " +
                "THEN REPLACE(CONVERT(VARCHAR,a.UpgradeDate,106),' ','-') ELSE '' END AS UpgradeDate," +
                "a.ActiveStatus,a.Planid,a.IsBlock " +
                "FROM " + ObjDAL.dBName + "..M_MemberMaster a " +
                "INNER JOIN " + ObjDAL.dBName + "..M_KitMaster b ON a.KitId=b.KitId " +
                "LEFT JOIN " + ObjDAL.dBName + "..M_MemberMaster c ON a.RefFormno=c.Formno " +
                "WHERE b.RowStatus='Y' " +
                "AND a.IsBlock='N' " +
                "AND a.IDNo='" + txtMemberId.Text.Trim() + "'" +
                ObjDAL.IsoEnd;

            DataTable Dt_ = SqlHelper.ExecuteDataset(constr1, CommandType.Text, Sql).Tables[0];

            // ❌ Member not found
            if (Dt_.Rows.Count == 0)
            {
                ClearControls();
                return false;
            }

            // ✅ Member found
            DataRow mRow = Dt_.Rows[0];

            kitid.Text = mRow["KitId"].ToString();
            TxtMemberName.Text = mRow["MemName"].ToString();
            lblFormno.Text = mRow["Formno"].ToString();
            LblError.Text = "";

            // 🔥 ACTIVE MEMBER LOGIC
            if (mRow["ActiveStatus"].ToString() == "Y")
            {
                Sql = ObjDAL.Isostart +
                    "SELECT a.KitId,b.ForType,b.TopupSeq " +
                    "FROM " + ObjDAL.dBName + "..RepurchIncome a " +
                    "INNER JOIN " + ObjDAL.dBName + "..M_KitMaster b ON a.KitId=b.KitId " +
                    "WHERE a.FormNo=" + mRow["Formno"] +
                    " AND b.ForType = 'S' AND a.KitId<>0 ORDER BY b.TopupSeq DESC;" +
                    ObjDAL.IsoEnd;

                DataTable Dt__ = SqlHelper.ExecuteDataset(constr1, CommandType.Text, Sql).Tables[0];

                if (Dt__ != null && Dt__.Rows.Count > 0)
                {
                    // ⭐ Priority 1: Subscription (S)
                    DataRow subRow = Dt__.AsEnumerable()
                        .FirstOrDefault(r => r["ForType"].ToString() == "S");

                    if (subRow != null)
                    {
                        LblCondition.Text = " AND TopupSeq > " + subRow["TopupSeq"];
                        return true;
                    }

                    // ⭐ Priority 2: Highest TopupSeq
                    int maxTopupSeq = Dt__.AsEnumerable()
                        .Max(r => Convert.ToInt32(r["TopupSeq"]));

                    LblCondition.Text = " AND TopupSeq > " + maxTopupSeq;
                    return true;
                }

                // No repurchase found → allow
                LblCondition.Text = "";
                return true;
            }
            else
            {
                // 🔥 NON-ACTIVE MEMBER → current kit TopupSeq
                Sql = ObjDAL.Isostart +
                    "SELECT TopupSeq FROM " + ObjDAL.dBName + "..M_KitMaster " +
                    "WHERE KitId=" + mRow["KitId"] +
                    ObjDAL.IsoEnd;

                object seq = SqlHelper.ExecuteScalar(constr1, CommandType.Text, Sql);
                LblCondition.Text = " AND TopupSeq > " + Convert.ToInt32(seq);
                return true;
            }
        }
        catch
        {
            Response.Write("Try later.");
            return false;
        }
    }
    private void ClearControls()
    {
        kitid.Text = "";
        TxtMemberName.Text = "";
        lblFormno.Text = "";
        LblCondition.Text = "";
        LblError.Text = "";
    }
    protected void txtMemberId_TextChanged(object sender, EventArgs e)
    {
        try
        {
            if (Check_IdNo())
            {
                fillkit(LblCondition.Text.Trim());

                if (CmbKit.SelectedValue.ToString() == "0")
                {
                    txtAmount.Text = "0";
                }
                else if (CmbKit.SelectedValue.ToString() == "")
                {
                    txtAmount.Text = "0";
                }
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff " + Environment.NewLine);
            ObjDAL.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    protected void CmbKit_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        dt = (DataTable)Session["KitTable"];
        DataRow[] dr = dt.Select("KitID='" + CmbKit.SelectedValue + "'");

        if (dr.Length > 0)
        {
            txtAmount.Text = dr[0]["KitAmount"].ToString();
            hdnMacadrs.Value = dr[0]["MacAdrs"].ToString();
            HdnTopupSeq.Value = dr[0]["TopupSeq"].ToString();
            Session["HdnTopupSeq"] = HdnTopupSeq.Value;
            CheckAmount();
        }
    }
    protected void DDLPaymode_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (DDLPaymode.SelectedValue == "2")
        {
            ddlcurrency.Visible = true;
        }
        else
        {
            ddlcurrency.Visible = false;
        }
    }
    public bool SendMail(string otp)
    {
        try
        {
            string StrMsg = "";
            string EmailAddress = Session["EMail"].ToString().Trim();
            var SendFrom = new MailAddress(Session["CompMail"].ToString());
            var SendTo = new MailAddress(EmailAddress);
            var MyMessage = new MailMessage(SendFrom, SendTo);

            StrMsg = "<table style=\"margin:0; padding:10px; font-size:12px; font-family:Verdana, Arial, Helvetica, sans-serif; line-height:23px; text-align:justify;width:100%\">" +
                     "<tr>" +
                     "<td>" +
                     "Your OTP for Id Activation is <span style=\"font-weight: bold;\">" + otp + "</span> (valid for 5 minutes)." +
                     "<br />" +
                     "</td>" +
                     "</tr>" +
                     "</table>";

            MyMessage.Subject = "Thanks For Connecting!!!";
            MyMessage.Body = StrMsg;
            MyMessage.IsBodyHtml = true;

            var smtp = new SmtpClient(Session["MailHost"].ToString())
            {
                UseDefaultCredentials = false,
                Port = 587,
                EnableSsl = false,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                Credentials = new NetworkCredential(Session["CompMail"].ToString(), Session["MailPass"].ToString())
            };

            smtp.Send(MyMessage);

            txtAmount.Enabled = false;
            txtMemberId.Enabled = false;
            CmbKit.Enabled = false;
            DDlStackType.Enabled = false;
            int c = 0;

            return true;
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    protected void cmdSave1_Click(object sender, EventArgs e)
    {
        try
        {
            if (txtMemberId.Text.Trim() == "")
            {
                scrName = "<SCRIPT language='javascript'>alert('Enter Id No ');</SCRIPT>";
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Upgraded", scrName, false);
                return;
            }
            if (TxtMemberName.Text.Trim() == "")
            {
                scrName = "<SCRIPT language='javascript'>alert('Enter Id No.');</SCRIPT>";
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Upgraded", scrName, false);
                return;
            }
            else if (Convert.ToDouble(txtAmount.Text) == 0)
            {
                scrName = "<SCRIPT language='javascript'>alert('Invalid Amount ');</SCRIPT>";
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Upgraded", scrName, false);
                return;
            }
            //else if (DDlStackType.SelectedValue == "N")
            //{
            //    scrName = "<SCRIPT language='javascript'>alert('Select Stack Type');</SCRIPT>";
            //    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Upgraded", scrName, false);
            //    return;
            //}
            //int OTP_ = new Random().Next(100001, 999999);

            //if (Session["OTP_"] == null)
            //{
            //    if (SendMail(OTP_.ToString()))
            //    {
            //        Session["OtpTime"] = DateTime.Now.AddMinutes(5);
            //        Session["Retry"] = "1";
            //        Session["OTP_"] = OTP_;

            //        string R = "INSERT INTO AdminLogin(UserID, Username, Passw, MobileNo, OTP, LoginTime, emailotp, EmailID, ForType) " +
            //                   "VALUES ('0', '', '" + TxtOtp.Text + "', '0', '" + OTP_ + "', GETDATE(), '" + OTP_ + "', '" +
            //                   Session["EMail"].ToString().Trim() + "', 'IdActivation')";

            //        int i = Convert.ToInt32(SqlHelper.ExecuteNonQuery(constr, CommandType.Text, R));

            //        if (i > 0)
            //        {
            //            divotp.Visible = true;
            //            cmdSave1.Visible = false;
            //            BtnOtp.Visible = true;
            //            ResendOtp.Visible = true;
            //            scrName = "<script language='javascript'>alert('OTP Sent On Mail');</script>";
            //            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrName, false);
            //            return;
            //        }
            //        else
            //        {
            //            scrName = "<script language='javascript'>alert('Try Later');</script>";
            //            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrName, false);
            //            return;
            //        }
            //    }
            //    else
            //    {
            //        scrName = "<script language='javascript'>alert('OTP Try Later');</script>";
            //        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrName, false);
            //        return;
            //    }
            //}
            //else
            //{
            //    txtAmount.Enabled = false;
            //    txtMemberId.Enabled = false;
            //    DDlStackType.Enabled = false;
            //    CmbKit.Enabled = false;
            //    divotp.Visible = true;
            //    cmdSave1.Visible = false;
            //    BtnOtp.Visible = true;
            //    ResendOtp.Visible = true;
            //}
            DataTable Dt = new DataTable();
            string str = ObjDAL.Isostart + "Exec Sp_CheckTransctionPassword '" + Convert.ToInt32(Session["Formno"]) + "' ,'" + TxtTransPass.Text.Trim() + "'" + ObjDAL.IsoEnd;
            Dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, str).Tables[0];
            if (Dt.Rows.Count > 0)
            {

                if (txtMemberId.Text.Trim() == "")
                {
                    scrName = "<SCRIPT language='javascript'>alert('Enter Id No ');</SCRIPT>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Upgraded", scrName, false);
                }
                else if (Convert.ToDouble(txtAmount.Text) == 0)
                {
                    scrName = "<SCRIPT language='javascript'>alert('Invalid Amount ');</SCRIPT>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Upgraded", scrName, false);
                }

                if (Checkid() == "")
                {
                    if (DDLPaymode.SelectedValue == "1")
                    {
                        if (CheckAmount())
                        {
                            IdActivation();
                        }
                        else
                        {
                            ShowAlert("Invalid Request Amount");
                        }
                    }
                    else
                    {
                        ShowAlert("Invalid Request");
                    }
                }
            }
            else
            {
                ShowAlert("Invalid Transaction Password");
            }
        }
        catch (Exception ex)
        {
            scrName = "<SCRIPT language='javascript'>alert('Try Later');</SCRIPT>";
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Upgraded", scrName, false);
        }
    }
    private void ShowAlert(string message)
    {
        string script = "alert('" + message + "');";
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "AlertScript", script, true);
    }
    protected void BtnOtp_Click(object sender, EventArgs e)
    {
        try
        {
            string scrname = "";
            string email = "";
            DataTable Dt = new DataTable();
            string TransPassw = TxtOtp.Text.Trim();
            DataTable Dt1 = new DataTable();
            ObjDAL = new DAL();

            Session["OtpCount"] = Convert.ToInt32(Session["OtpCount"]) + 1;

            if (Convert.ToInt32(Session["OTP_"]) == Convert.ToInt32(TxtOtp.Text))
            {
                string str = "SELECT TOP 1 * FROM " + ObjDAL.dBName + "..AdminLogin AS a WHERE EmailID = '" + Session["EMail"].ToString().Trim() + "' " +
                             "AND emailotp = '" + Convert.ToInt32(TxtOtp.Text) + "' AND ForType = 'IdActivation' ORDER BY AID DESC";

                Dt1 = SqlHelper.ExecuteDataset(constr1, CommandType.Text, str).Tables[0];

                if (Dt1.Rows.Count > 0)
                {
                    if (Checkid() == "")
                    {
                        if (DDLPaymode.SelectedValue == "1")
                        {
                            if (CheckAmount())
                            {
                                IdActivation();
                            }
                        }
                    }
                }
            }
            else
            {
                TxtOtp.Text = "";
                if (Convert.ToInt32(Session["OtpCount"]) >= 3)
                {
                    Session["OtpCount"] = 0;
                    scrname = "<script language='javascript'>alert('You have tried 3 times with invalid OTP.\\n Please generate OTP again.');</script>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('You have tried 3 times with invalid OTP.\\n Please generate OTP again.');", true);
                    ResendOtp.Visible = true;
                    BtnOtp.Visible = true;
                    divotp.Visible = false;
                }
                else
                {
                    scrname = "<script language='javascript'>alert('Invalid OTP.');</script>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Invalid OTP.');", true);
                }
            }
        }
        catch (Exception ex)
        {
            // Exception handling code (optional, depending on requirements)
        }
    }
    protected void ResendOtp_Click(object sender, EventArgs e)
    {
        try
        {
            Session["OTP_"] = "";
            int OTP_ = 0;
            Random Rs = new Random();
            OTP_ = Rs.Next(100001, 999999);

            if (SendMail(OTP_.ToString()) == true)
            {
                string Emailid = Session["Email"].ToString();
                string membername = "";
                string mobileno = "0";
                string Sms = "";

                //ObjDal = new DAL();
                int i = 0;
                string R = "";

                R = "INSERT AdminLogin(UserID,Username,Passw,MobileNo,OTP,LoginTime,emailotp,EmailID,ForType) " +
                    "VALUES ('0','" + membername + "','" + TxtOtp.Text + "','" + mobileno + "','" + OTP_ + "',getdate(),'" + OTP_ + "'," +
                    "'" + Session["EMail"].ToString().Trim() + "','IdActivation')";

                i = Convert.ToInt32(SqlHelper.ExecuteNonQuery(constr, CommandType.Text, R));

                if (i > 0)
                {
                    Session["OTP_"] = OTP_;
                    divotp.Visible = true;
                    BtnOtp.Visible = true;
                    ResendOtp.Visible = true;

                    string scrname = "<script language='javascript'>alert('OTP Send On Mail');</script>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
                    return;
                }
                else
                {
                    string scrname = "<script language='javascript'>alert('Try Later');</script>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
                    return;
                }
            }
            else
            {
                string scrname = "<script language='javascript'>alert('OTP Try Later');</script>";
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
                return;
            }
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
}
