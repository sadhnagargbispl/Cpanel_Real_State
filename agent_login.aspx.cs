using System.Data.SqlClient;
using System.IO;
using System.Net;
using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI;
public partial class agent_login : System.Web.UI.Page
{
    string uid;
    string pwd;
    string memberid;
    string type;
    string scrname;
    SqlConnection conn = new SqlConnection();
    SqlCommand cmm = new SqlCommand();
    int i;
    SqlDataReader dr;
    DAL obj = new DAL();
    ModuleFunction objModuleFun;
    string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
    string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    string IsoStart;
    string IsoEnd;
    protected void Page_Load(object sender, EventArgs e)
    {
        //this.BtnWalletLogin.Attributes.Add("onclick", DisableTheButton(this.Page, this.BtnWalletLogin));
        this.BtnSubmit.Attributes.Add("onclick", DisableTheButton(this.Page, this.BtnSubmit));
        try
        {
            if (Application["WebStatus"] != null)
            {
                if ((string)Application["WebStatus"] == "N")
                {
                    Session.Abandon();
                    Response.Write("<big><b>" + Application["WebMessage"] + "</b></big>");
                    Response.End();
                    return;
                }
            }

            if (Session["Status"] != null && (string)Session["Status"] == "OK")
            {
                Response.Redirect("Index.aspx", false);
                return;
            }

            string strURL = HttpContext.Current.Request.Url.AbsoluteUri;
            string url = "";

            string Str;

            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
            Response.Cache.SetNoStore();

            if (!Page.IsPostBack)
            {
                if (Request["lgnT"] != null)
                {
                    ModuleFunction objModuleFun = new ModuleFunction();

                    Str = Crypto.Decrypt(Request["lgnT"].Replace(" ", "+"));

                    Str = Str.Replace("uid=", "þ").Replace("&pwd=", "þ").Replace("&mobile=", "þ");
                    string[] qrystr = Str.Split(new string[] { "þ" }, StringSplitOptions.None);
                    if ((DateTime.Now.Day.ToString() + DateTime.Now.Hour.ToString() + DateTime.Now.Year.ToString() + (DateTime.Now.Month - 1).ToString() == Request["ID"]) ||
    (DateTime.Now.Day.ToString() + (DateTime.Now.Hour - 1).ToString() + DateTime.Now.Year.ToString() + (DateTime.Now.Month - 1).ToString() == Request["ID"]))

                    {
                        if (Str.Contains("þ"))
                        {
                            int UIdIndx = Str.IndexOf("&pwd");
                            uid = qrystr[1].ToString();
                            pwd = qrystr[2].ToString();
                            try
                            {
                                Session["Adminmob"] = qrystr[3].ToString();
                            }
                            catch (Exception ex)
                            {
                            }
                        }
                    }
                    else
                    {
                        Response.Redirect("logout.aspx", false);
                        return;
                    }
                }
                else if (Request["uid"] != null)
                {
                    uid = Request["uid"];
                    pwd = Request["pwd"];
                    type = Request["ref"];
                    uid = uid.Replace("'", "").Replace("=", "").Replace(";", "");
                    pwd = pwd.Replace("'", "").Replace("=", "").Replace(";", "");
                }

                if (!string.IsNullOrEmpty(uid) && !string.IsNullOrEmpty(pwd))

                {

                    enterHomePgForAdmin();

                }
            }
        }
        catch (Exception ex)
        {
            conn.Close();
        }
    }
    private void enterHomePgForAdmin()
    {
        SqlConnection cnn = new SqlConnection();

        try
        {
            cnn = new SqlConnection(constr1);

            if (uid.Length > 0 && pwd.Length > 0)

            {
                string scrname;

                SqlDataReader Dr;

                string strSql = IsoStart + " Exec sp_Login_New '" + ClearInject((uid == "" ? ClearInject(Txtuid.Value) : ClearInject(uid))) + "',";
                strSql += "'" + (pwd == "" ? ClearInject(Txtpwd.Value) : ClearInject(pwd)) + "'" + IsoEnd;
                DataSet ds = new DataSet();
                DataTable dt = new DataTable();
                ds = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql);
                dt = ds.Tables[0];
                if (dt.Rows.Count == 0)
                {
                    scrname = "<script language='javascript'>alert('Please Enter valid UserName or Password.');</script>";
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Login Error", scrname, false);
                }
                else
                {
                    Session["Run"] = 0;
                    Session["Status"] = "OK";
                    Session["IDNo"] = dt.Rows[0]["IDNo"];
                    Session["FormNo"] = dt.Rows[0]["Formno"];
                    Session["MemName"] = dt.Rows[0]["MemFirstName"] + " " + dt.Rows[0]["MemLastName"];
                    Session["MobileNo"] = dt.Rows[0]["Mobl"];
                    Session["MemKit"] = dt.Rows[0]["KitID"];
                    Session["Package"] = dt.Rows[0]["KitName"];
                    Session["Position"] = dt.Rows[0]["fld3"];
                    Session["Doj"] = ((DateTime)dt.Rows[0]["Doj"]).ToString("dd-MMM-yyyy");
                    Session["DOA"] = ((DateTime)dt.Rows[0]["Upgradedate"]).ToString("dd-MMM-yyyy");
                    Session["Address"] = dt.Rows[0]["Address1"];
                    Session["IsFranchise"] = dt.Rows[0]["Fld5"];
                    Session["ActiveStatus"] = dt.Rows[0]["ActiveStatus"];
                    Session["MemPassw"] = dt.Rows[0]["Passw"];
                    Session["MFormno"] = dt.Rows[0]["MFormNo"];
                    Session["MemUpliner"] = dt.Rows[0]["UplnFormno"];
                    Session["MID"] = dt.Rows[0]["MID"];
                    Session["EMail"] = dt.Rows[0]["Email"];
                    Session["profilepic"] = dt.Rows[0]["profilepic"];
                    Session["Panno"] = dt.Rows[0]["Panno"];
                    Session["ActivationDate"] = dt.Rows[0]["ActivationDate"];
                    Session["MemEPassw"] = dt.Rows[0]["Epassw"];

                    Response.Redirect("index.aspx", false);
                }
                cnn.Close();
            }
            else
            {
                cnn.Close();
            }
        }
        catch (Exception ex)
        {
            if (cnn != null)
            {
                if (cnn.State == ConnectionState.Open)
                {
                    cnn.Close();
                }
            }
            Response.Write(ex.Message);
        }
    }

    private string DisableTheButton(System.Web.UI.Control pge, System.Web.UI.Control btn)
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

    private string ClearInject(string StrObj)
    {
        try
        {
            StrObj = StrObj.Replace(";", "").Replace("'", "").Replace("=", "");
            return StrObj.Trim();
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    //protected void BtnWalletLogin_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("NewJoining.aspx");

    //}
    protected void BtnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (Request["uid"] != null)
            {
                uid = Request["uid"];
                pwd = Request["pwd"];
            }
            else
            {
                uid = Txtuid.Value;
                pwd = Txtpwd.Value;
            }

            type = Request["ref"];
            uid = uid.Replace("'", "").Replace("=", "").Replace(";", "");
            pwd = pwd.Replace("'", "").Replace("=", "").Replace(";", "");
            if (!string.IsNullOrEmpty(uid) && !string.IsNullOrEmpty(pwd))
            {
                enterHomePg();
            }
            else
            {
                Response.Redirect("logout.aspx", false);
            }
        }
        catch (Exception ex)
        {
            // Handle exception (optional logging)
        }

    }
    private void enterHomePg()
    {
        SqlConnection cnn = new SqlConnection();
        try
        {
            if (uid.Length > 0 && pwd.Length > 0)
            {
                string scrname = "";
                DataTable dt = new DataTable();
                string strSql = IsoStart + " Exec sp_Login1 '" + ClearInject(string.IsNullOrEmpty(uid) ? ClearInject(Txtuid.Value) : ClearInject(uid)) + "','" + (string.IsNullOrEmpty(pwd) ? ClearInject(Txtpwd.Value) : ClearInject(pwd)) + "'" + IsoEnd;
                DataSet ds = new DataSet();
                ds = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql);
                dt = ds.Tables[0];

                if (dt.Rows.Count == 0)
                {
                    scrname = "<script language='javascript'>alert('Please Enter valid UserName or Password.');</script>";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
                }
                else
                {
                    Session["Run"] = 0;
                    Session["Status"] = "OK";
                    Session["IDNo"] = dt.Rows[0]["IDNo"];
                    Session["FormNo"] = dt.Rows[0]["Formno"];
                    Session["MemName"] = dt.Rows[0]["MemFirstName"] + " " + dt.Rows[0]["MemLastName"];
                    Session["MobileNo"] = dt.Rows[0]["Mobl"];
                    Session["MemKit"] = dt.Rows[0]["KitID"];
                    Session["Package"] = dt.Rows[0]["KitName"];
                    Session["Position"] = dt.Rows[0]["fld3"];
                    Session["Doj"] = ((DateTime)dt.Rows[0]["Doj"]).ToString("dd-MMM-yyyy");
                    Session["DOA"] = ((DateTime)dt.Rows[0]["Upgradedate"]).ToString("dd-MMM-yyyy");
                    Session["Address"] = dt.Rows[0]["Address1"];
                    Session["IsFranchise"] = dt.Rows[0]["Fld5"];
                    Session["ActiveStatus"] = dt.Rows[0]["ActiveStatus"];
                    Session["MemPassw"] = dt.Rows[0]["Passw"];
                    Session["MFormno"] = dt.Rows[0]["MFormNo"];
                    Session["MemUpliner"] = dt.Rows[0]["UplnFormno"];
                    Session["MID"] = dt.Rows[0]["MID"];
                    Session["EMail"] = dt.Rows[0]["Email"];
                    Session["profilepic"] = dt.Rows[0]["profilepic"];
                    Session["Panno"] = dt.Rows[0]["Panno"];
                    Session["ActivationDate"] = dt.Rows[0]["ActivationDate"];
                    Session["MemEPassw"] = dt.Rows[0]["Epassw"];
                    Response.Redirect("Dashboard.aspx", false);
                }
                cnn.Close();
            }
            else
            {
                cnn.Close();
            }
        }
        catch (Exception ex)
        {
            if (cnn != null && cnn.State == ConnectionState.Open)
            {
                cnn.Close();
            }
            Response.Write(ex.Message);
        }
    }


}
