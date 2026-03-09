using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Dashboard : System.Web.UI.Page
{
    DAL objDal = new DAL();
    DataTable dt = new DataTable();
    SqlConnection DbConnect;
    string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
    string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Session["Status"] != null && Session["Status"].ToString() == "OK")
            {
                LoadProfile();

                LoadCustomerCounts();
            }
            else
            {
                Response.Redirect("agent_login.aspx", false);
            }
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
            SetGreeting(name);
            if (Dt.Rows[0]["isblock"].ToString() == "Y")
            {
                Session.Abandon();
                Response.Redirect("agent_login.aspx", false);
            }
        }
    }
    private void LoadCustomerCounts()
    {
        DataSet ds = new DataSet();

        string str = objDal.Isostart + "Exec sp_GetCustomerSubAgentCount '" + Session["Formno"] + "' " + objDal.IsoEnd;

        ds = SqlHelper.ExecuteDataset(constr1, CommandType.Text, str);

        if (ds.Tables.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                lblCustomers.Text = ds.Tables[0].Rows[0]["MyCustomers"].ToString();
            }

            if (ds.Tables[1].Rows.Count > 0)
            {
                lblSubAgents.Text = ds.Tables[1].Rows[0]["MySubAgents"].ToString();
            }
        }
    }
    private void SetGreeting(string name)
    {
        DateTime now = DateTime.Now;

        string greeting = "";

        if (now.Hour < 12)
            greeting = "Good Morning";
        else if (now.Hour < 17)
            greeting = "Good Afternoon";
        else if (now.Hour < 21)
            greeting = "Good Evening";
        else
            greeting = "Good Night";

        string currentDate = now.ToString("dddd, d MMMM yyyy");

        phTitle.InnerText = greeting + ", " + name + "! 👋";
        phSub.InnerText = currentDate + " · Here's your portfolio summary";
    }
}