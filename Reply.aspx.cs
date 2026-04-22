using System;
using System.Configuration;
using System.Data;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class Reply : System.Web.UI.Page
{
    DataTable Dt = new DataTable();
    string scrname;
    DAL objDAL = new DAL();
    string CIdQS;
    string constr  = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
    string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            objDAL = new DAL();

            if (!string.IsNullOrEmpty(Request.QueryString["CId"]))
            {
                CIdQS = Request.QueryString["CId"];

                if (!IsPostBack)
                {
                    if (Session["Status"] != null && Session["Status"].ToString() == "OK")
                    {
                        BindData();
                    }
                    else
                    {
                        scrname = "<SCRIPT language='javascript'> window.top.location.reload();" + "</SCRIPT>";
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Close", scrname, false);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage",
                "alert('" + ex.Message.Replace("'", "\\'") + "')", true);
        }
    }

    private void BindData()
    {
        try
        {
            CIdQS = Request.QueryString["CId"];

            string sql  = "Select M.IDNo,M.MemName,";
            sql += "ISNULL(Replace(CONVERT(varchar,M.RecTimeStamp,106),' ','-'),'') as CDate,";
            sql += "M.CType,M.Complaint,";
            sql += "ISNULL(S.Solution,'') as Solution,";
            sql += "ISNULL(Replace(CONVERT(varchar,S.RecTimeStamp,106),' ','-'),'') as SDate FROM";
            sql += " (Select b.MemFirstName +' '+ b.MemLastName as MemName,a.*";
            sql += " FROM " + objDAL.dBName + "..M_ComplaintMaster as a,";
            sql += objDAL.dBName + "..M_MemberMaster as b";
            sql += " WHERE a.IDNo=b.IDNo AND a.CID='" + CIdQS + "') as M";
            sql += " LEFT JOIN " + objDAL.dBName + "..M_SolutionMaster as S ON M.CID=S.CID";

            Dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, sql).Tables[0];

            if (Dt.Rows.Count > 0)
            {
                // ── KPI fields ──────────────────────────────────────
                LblCType.Text = Dt.Rows[0]["CType"].ToString();
                LblCDate.Text = Dt.Rows[0]["CDate"].ToString();
                TxtComplaint.Text = Dt.Rows[0]["Complaint"].ToString();

                // ── Build styled reply blocks ───────────────────────
                bool hasReply = false;
                PhReplies.Controls.Clear();

                for (int i = 0; i < Dt.Rows.Count; i++)
                {
                    string solution = Dt.Rows[i]["Solution"].ToString().Trim();
                    string sDate    = Dt.Rows[i]["SDate"].ToString().Trim();

                    if (solution == "") continue;

                    hasReply = true;

                    // Outer div — reply-block
                    HtmlGenericControl block = new HtmlGenericControl("div");
                    block.Attributes["class"] = "reply-block";

                    // Date line
                    if (sDate != "")
                    {
                        HtmlGenericControl dateDiv = new HtmlGenericControl("div");
                        dateDiv.Attributes["class"] = "reply-date";
                        dateDiv.InnerText = "Replied on: " + sDate;
                        block.Controls.Add(dateDiv);
                    }

                    // Reply text
                    HtmlGenericControl textDiv = new HtmlGenericControl("div");
                    textDiv.InnerText = solution;
                    block.Controls.Add(textDiv);

                    PhReplies.Controls.Add(block);
                }

                // Show "no reply" label if nothing came
                if (!hasReply)
                {
                    LblNoReply.Visible = true;
                }
            }
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }

    // ── Kept for backward compatibility ──────────────────────
    public string GenerateRandomString(int iLength)
    {
        Random rdm = new Random();
        char[] allowChrs = "123456789".ToCharArray();
        string sResult = "";
        for (int i = 0; i < iLength; i++)
            sResult += allowChrs[rdm.Next(0, allowChrs.Length)];
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

    private void ClearAll()
    {
        try
        {
            LblCType.Text     = "";
            LblCDate.Text     = "";
            TxtComplaint.Text = "";
            TxtPreReply.Text  = "";
            PhReplies.Controls.Clear();
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
}
