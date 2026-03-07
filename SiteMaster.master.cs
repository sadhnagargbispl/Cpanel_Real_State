using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SiteMaster : System.Web.UI.MasterPage
{
    DAL objDal = new DAL();
    DataTable dt = new DataTable();
    SqlConnection DbConnect;
    string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
    string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Application["WebStatus"] != null)
            {
                if (Application["WebStatus"].ToString() == "N")
                {
                    Session.Abandon();
                    Response.Redirect("agent_login.aspx", false);
                }
            }
            if (!Page.IsPostBack)
            {
                DataTable Dt = new DataTable();
                string str = "";
                if (Session["Status"] != null && Session["Status"].ToString() == "OK")
                {
                    LoadProfile();
                }
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", "alert('" + ex.Message + "')", true);
        }
    }
    private void LoadProfile()
    {
        DataTable Dt = new DataTable();

        string Strrank = objDal.Isostart + "Exec Sp_GetProfileUserDetail '" + Session["Formno"] + "' " + objDal.IsoEnd;

        Dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, Strrank).Tables[0];

        if (Dt.Rows.Count > 0)
        {
            string name = Dt.Rows[0]["MemFirstName"].ToString();

            LblMemberName.Text = name;
            LblMemberID.Text = Dt.Rows[0]["IDNo"].ToString();
            Lblstatus.Text = Dt.Rows[0]["status"].ToString();
            LblMemberIDLOGO.Text = GetInitials(name);
            Lblname.Text = name;

            LblID.Text = Dt.Rows[0]["IDNo"].ToString();
            LblNameLogo.Text = GetInitials(name);
            if (Dt.Rows[0]["isblock"].ToString() == "Y")
            {
                Session.Abandon();
                Response.Redirect("agent_login.aspx", false);
            }
        }
    }
    private string GetInitials(string name)
    {
        string initials = "";

        if (!string.IsNullOrEmpty(name))
        {
            string[] parts = name.Split(' ');

            foreach (var part in parts)
            {
                initials += part.Substring(0, 1).ToUpper();
            }
        }

        return initials;
    }
}
