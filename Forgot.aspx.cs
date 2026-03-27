using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;
using System.Web.Services;
using System.Web.UI;

public partial class Forgot : System.Web.UI.Page
{
    public SqlConnection objSqlConnection;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod(EnableSession = true)]
    public static string SendOTP(string IDNo, string txtemail)
    {
        try
        {
            if (string.IsNullOrEmpty(IDNo))
                return "Please enter User ID";
            string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
            DAL objdal = new DAL();
            string str1 = objdal.Isostart + " select fld4 as Type from " + objdal.dBName + "..m_membermaster where idno = '" + IDNo + "'" + objdal.IsoEnd;
            DataTable Dt1 = SqlHelper.ExecuteDataset(constr1, CommandType.Text, str1).Tables[0];
            if (Dt1.Rows.Count == 0)
                return "Invalid User ID";
            if (Dt1.Rows[0]["Type"].ToString() == "C")
            {
                return "FILL";
            }
            else
            {
                string str = objdal.Isostart + " Exec Sp_MemberForgotPassw '" + IDNo + "'" + objdal.IsoEnd;
                DataTable Dt =
                SqlHelper.ExecuteDataset(constr1,
                CommandType.Text,
                str).Tables[0];

                if (Dt.Rows.Count == 0)
                    return "Invalid User ID";

                string dbEmail = Dt.Rows[0]["Email"].ToString();

                if (txtemail != dbEmail)
                    return "Invalid Email ID";

                string Password = Dt.Rows[0]["Passw"].ToString();

                string TranPassw = Dt.Rows[0]["EPassw"].ToString();

                string MemName = Dt.Rows[0]["MemName"].ToString();

                string CompMail = Dt.Rows[0]["CompMail"].ToString();

                string MailPass = Dt.Rows[0]["mailPass"].ToString();

                string MailHost = Dt.Rows[0]["mailHost"].ToString();

                // Send Email
                MailMessage msg = new MailMessage();

                msg.From = new MailAddress(CompMail);

                msg.To.Add(txtemail);

                msg.Subject = "Forgot Password";

                msg.Body = @"
<table style='width:100%; font-family:Arial, sans-serif; background:#f6f6f6; padding:20px'>
<tr>
<td align='center'>

<table style='width:600px; background:#ffffff; padding:25px; border-radius:8px'>

<tr>
<td style='text-align:center; font-size:22px; font-weight:bold; color:#2c3e50'>
Forgot Password Request
</td>
</tr>

<tr>
<td style='padding-top:20px; font-size:14px; color:#333'>
Dear <b>" + MemName + @"</b>,
</td>
</tr>

<tr>
<td style='padding-top:10px; font-size:14px; color:#333'>
As per your request, here are your login details:
</td>
</tr>

<tr>
<td style='padding-top:15px; font-size:15px'>
<b>Login Password:</b> " + Password + @"<br>
<b>Transaction Password:</b> " + TranPassw + @"
</td>
</tr>

<tr>
<td style='padding-top:20px; font-size:14px'>
You can login using the link below:
<br><br>
<a href='https://skyisyourlimit.com/agent_login.aspx'
style='background:#007bff; color:#ffffff; padding:10px 18px;
text-decoration:none; border-radius:4px'>
Login Now
</a>
</td>
</tr>

<tr>
<td style='padding-top:25px; font-size:13px; color:#777'>
If you did not request this password reset, please contact support immediately.
</td>
</tr>

<tr>
<td style='padding-top:20px; font-size:14px'>
Regards,<br>
<b>Real Estate</b><br>
Support Team
</td>
</tr>

</table>

</td>
</tr>
</table>";
                msg.IsBodyHtml = true;

                SmtpClient smtp = new SmtpClient(MailHost);

                smtp.Port = 587;

                smtp.EnableSsl = true;

                smtp.Credentials =
                new NetworkCredential(CompMail, MailPass);

                smtp.Send(msg);

                return "SUCCESS";
            }
        }
        catch (Exception ex)
        {
            return ex.Message;
        }
    }
    public bool SendToMemberMail(string IdNo, string Email, string MemberName, string Password, string EPassword)
    {
        try
        {
            DataTable dt;
            string sql = "";
            string userEmail = "";

            string StrMsg = "";
            System.Net.Mail.MailAddress SendFrom = new System.Net.Mail.MailAddress(Session["CompMail"].ToString());
            System.Net.Mail.MailAddress SendTo = new System.Net.Mail.MailAddress(Email);
            System.Net.Mail.MailMessage MyMessage = new System.Net.Mail.MailMessage(SendFrom, SendTo);
            StrMsg = "<table style=\"margin:0; padding:10px; font-size:12px; font-family:Verdana, Arial, Helvetica, sans-serif; line-height:23px; text-align:justify;width:100%\">" +
                     "<tr>" +
                     "<td>" +
                     "<span style=\"color: #0099CC; font-weight: bold;\"><h2>Dear " + MemberName + ",</h2></span><br />" +
                     "Your Forgot Login password is <strong>" + Password + "</strong> and Transaction password is <strong>" + EPassword + "</strong> of IDNO <strong>" + IdNo + "</strong>.<br/> For login go to our site : <a href=\"" + Session["CompWeb"] + "\" target=\"_blank\" style=\"color:#0000FF; text-decoration:underline;\">" + Session["CompName"] + "</a><br/>Thank you!<br> Regards : <strong>" + Session["CompName"] + "</strong>" +
                     "<br />" +
                     "<br />" +
                     "</td>" +
                     "</tr>" +
                    "</table>";

            MyMessage.Subject = "Forgot Password";
            MyMessage.Body = StrMsg;
            MyMessage.IsBodyHtml = true;
            System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient(Session["MailHost"].ToString());
            smtp.Port = 587;
            smtp.EnableSsl = false;
            smtp.UseDefaultCredentials = false;
            smtp.Credentials = new System.Net.NetworkCredential(Session["CompMail"].ToString(), Session["MailPass"].ToString());
            smtp.Send(MyMessage);
            return true;

        }
        catch (Exception ex)
        {
            Response.Write("Try later.");
            return false;
        }
    }
    private static string GenerateRandomPassword()
    {
        Random r = new Random();

        return "AG" + r.Next(1000, 9999);
    }
}