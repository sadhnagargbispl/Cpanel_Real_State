using System;
using System.Configuration;
using System.Data;
using System.Net;
using System.Net.Mail;
using System.IO;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Complain : System.Web.UI.Page
{
    private DAL ObjDal = new DAL();
    DataTable Dt = new DataTable();
    private string constr1 = WebConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    private string constr  = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            BtnSubMit.Attributes.Add("onclick", DisableTheButton(this.Page, BtnSubMit));

            if (Session["Status"] != null && Session["Status"].ToString() == "OK")
            {
                if (!Page.IsPostBack)
                {
                    HdnCheckTrnns.Value = GenerateRandomString(6);
                    Bind_ComplaintType();
                    Filldetail();
                }
            }
            else
            {
                Response.Redirect("logout.aspx");
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage",
                "alert('" + ex.Message.Replace("'", "\\'") + "')", true);
        }
    }

    private void Bind_ComplaintType()
    {
        try
        {
            if (Session["CompType"] == null)
            {
                string Sql = ObjDal.Isostart +
                    "Select CType, CTypeID FROM " + ObjDal.dBName +
                    "..M_ComplaintTypeMaster WHERE RowStatus='Y' AND ActiveStatus='Y'" +
                    ObjDal.IsoEnd;
                Dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, Sql).Tables[0];
                Session["CompType"] = Dt;
            }
            else
            {
                Dt = (DataTable)Session["CompType"];
            }

            CmbCmplntType.DataSource     = Dt;
            CmbCmplntType.DataTextField  = "CType";
            CmbCmplntType.DataValueField = "CTypeID";
            CmbCmplntType.DataBind();
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }

    private void Filldetail()
    {
        try
        {
            TxtDirectSeller.Text = Session["IDNo"].ToString();
            TxtName.Text         = Session["MemName"].ToString();
            TxtEmail.Text        = Session["EMail"].ToString();
            TxtMobl.Text         = Session["MobileNo"].ToString();
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }

    protected void BtnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string scrname;

            // Duplicate transaction check
            string StrSql1 = "Insert into TrncomplainUniqe (Transid, Rectimestamp) values("
                + HdnCheckTrnns.Value + ", getdate())";
            int updateEffect = ObjDal.SaveData(StrSql1);

            if (updateEffect > 0)
            {
                // Validations
                if (string.IsNullOrWhiteSpace(TxtName.Text))
                {
                    ShowAlert("Please Enter Name.");
                    return;
                }
                if (string.IsNullOrWhiteSpace(TxtMobl.Text))
                {
                    ShowAlert("Please Enter Mobile No.");
                    return;
                }
                if (Convert.ToInt32(CmbCmplntType.SelectedValue) == 0)
                {
                    ShowAlert("Please Select Nature of Grievance.");
                    return;
                }
                if (string.IsNullOrWhiteSpace(TxtSubject.Text))
                {
                    ShowAlert("Please Enter Subject.");
                    return;
                }
                if (string.IsNullOrWhiteSpace(TxtDesc.Text))
                {
                    ShowAlert("Please Enter Description.");
                    return;
                }

                // Save complaint
                string Sql = "INSERT INTO M_ComplaintMaster(IDNO, CTypeID, CType, Complaint, Subject, MemberName, Mobileno, Email) VALUES ("
                    + "'" + TxtDirectSeller.Text.Trim() + "', "
                    + "'" + Convert.ToInt32(CmbCmplntType.SelectedValue) + "', "
                    + "'" + CmbCmplntType.SelectedItem.Text.Trim() + "', "
                    + "N'" + TxtDesc.Text.Trim() + "', "
                    + "N'" + TxtSubject.Text.Trim() + "', "
                    + "'" + TxtName.Text.Trim() + "', "
                    + "'" + TxtMobl.Text.Trim() + "', "
                    + "'" + TxtEmail.Text.Trim() + "')";

                int updtEffect = ObjDal.SaveData(Sql);

                if (updtEffect == 0)
                {
                    ShowAlert("Complaint not sent. Please try again.");
                }
                else
                {
                    // Fetch complaint number
                    string sql = "select top 1 CId from " + ObjDal.dBName +
                        "..M_ComplaintMaster where IDNO='" + TxtDirectSeller.Text.Trim() +
                        "' order by CId desc";
                    DataTable dtCId = SqlHelper.ExecuteDataset(constr1, CommandType.Text, sql).Tables[0];
                    if (dtCId.Rows.Count > 0)
                        LblCompalin.Text = dtCId.Rows[0]["CId"].ToString();

                    // Show success message
                    spanError.InnerText = "Your complaint has been successfully submitted on "
                        + DateTime.Now.ToString("dd MMMM yyyy, hh:mm tt")
                        + ". Your Complaint No. is " + LblCompalin.Text
                        + ". Our customer service representative will get in touch with you shortly.";
                    DivError.Visible  = true;
                    spanError.Visible = true;

                    // Reset form
                    TxtDesc.Text    = "";
                    TxtSubject.Text = "";
                    CmbCmplntType.SelectedIndex = 0;

                    // Generate new transaction token
                    HdnCheckTrnns.Value = GenerateRandomString(6);
                }
            }
            else
            {
                Response.Redirect("Complain.aspx");
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage",
                "alert('" + ex.Message.Replace("'", "\\'") + "')", true);
        }
    }

    private void ShowAlert(string message)
    {
        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Error",
            "<script language='javascript'>alert('" + message + "');</script>", false);
    }

    public string GenerateRandomString(int iLength)
    {
        try
        {
            string current_datetime = DateTime.Now.ToString("yyyyMMddHHmmssfff");
            int random_number = new Random().Next(0, 999);
            return current_datetime + random_number.ToString().PadLeft(3, '0');
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }

    private string DisableTheButton(Control pge, Control btn)
    {
        try
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("if (typeof(Page_ClientValidate) == 'function') {");
            sb.Append("if (Page_ClientValidate() == false) { return false; }} ");
            sb.Append("if (confirm('Are you sure to proceed?') == false) { return false; } ");
            sb.Append("this.value = 'Please wait...';");
            sb.Append("this.disabled = true;");
            sb.Append(pge.Page.GetPostBackEventReference(btn));
            sb.Append(";");
            return sb.ToString();
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }

    public bool SendToMemberMail()
    {
        try
        {
            if (!string.IsNullOrEmpty(TxtEmail.Text))
            {
                MailAddress SendFrom = new MailAddress(Session["CompMail"].ToString());
                MailAddress SendTo   = new MailAddress(TxtEmail.Text.Trim());
                MailMessage MyMessage = new MailMessage(SendFrom, SendTo);

                string StrMsg = "<table style='font-size:14px;font-family:verdana;line-height:23px;width:100%;padding:10px'>"
                    + "<tr><td><b>Dear " + TxtName.Text.Trim() + ",</b><br/>"
                    + "Your complaint has been registered.<br/><br/>"
                    + "<b>Complaint No:</b> " + LblCompalin.Text + "<br/>"
                    + "<b>Type:</b> " + CmbCmplntType.SelectedItem.Text.Trim() + "<br/>"
                    + "<b>Subject:</b> " + TxtSubject.Text.Trim() + "<br/>"
                    + "<b>Description:</b> " + TxtDesc.Text.Trim() + "<br/>"
                    + "<b>Status:</b> Open<br/><br/>"
                    + "Our team will get in touch shortly.<br/>"
                    + "<a href='" + Session["CompWeb"] + "'>" + Session["CompName"] + "</a>"
                    + "</td></tr></table>";

                MyMessage.Subject    = "Complaint Confirmation";
                MyMessage.Body       = StrMsg;
                MyMessage.IsBodyHtml = true;

                SmtpClient smtp = new SmtpClient(Session["MailHost"].ToString());
                smtp.Credentials = new NetworkCredential(
                    Session["CompMail"].ToString(),
                    Session["MailPass"].ToString());
                smtp.Send(MyMessage);
                return true;
            }
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
        return false;
    }
}
